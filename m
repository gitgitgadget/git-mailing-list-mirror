From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Define a version of lstat(2) specially for copy
 operation
Date: Wed, 18 Mar 2009 02:30:49 -0700
Message-ID: <7v8wn3i3ee.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
 <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net>
 <20090317202818.GA13458@blimp.localdomain>
 <7v63i7ridk.fsf@gitster.siamese.dyndns.org>
 <20090317213820.GC13458@blimp.localdomain>
 <7vmybjl1l6.fsf@gitster.siamese.dyndns.org> <49C0A919.7070606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljs9P-0005NU-Gc
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 10:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZCRJbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 05:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbZCRJbE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 05:31:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbZCRJbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 05:31:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4506DA291B;
	Wed, 18 Mar 2009 05:30:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3258FA2918; Wed,
 18 Mar 2009 05:30:50 -0400 (EDT)
In-Reply-To: <49C0A919.7070606@viscovery.net> (Johannes Sixt's message of
 "Wed, 18 Mar 2009 08:56:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7CD27698-139F-11DE-8CB5-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113601>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The "underlying system" in this case is Cygwin, and it *does* have an
> executable bit.
>
> But the FS gymnastics that implement it are slow and affect all lstat()
> calls, so we have replaced lstat() with a simpler and faster
> implementation. Only that the replacement doesn't know about the X bit
> anymore; it always returns mode 0666.
>
> Therefore, if a file is created whose mode is influenced by the fast
> lstat(), then it will always be non-X. The access(, X_OK) call on the hook
> script would do the right thing if only the script were created with the
> correct mode. access(, X_OK) fails because the file was created with non-X
> permissions.

OK.  To make sure that I understand the situation better, allow me to
paraphrase what you said.

I've always thought core.filemode was about "On FAT the filesystem does
not have x-bit and Cygwin fakes it by looking at .exe extension and using
other heuristics", but this lstat() "trick" is not about that.  It is "On
Windows you need to issue multiple FS API calls in order to get full
information to fill struct stat, which is expensive.  We omit the one to
learn about the x-bit; it won't make a difference because most people run
with core.filemode."

If that is what is going on, I have a few quick questions:

 (1) How much of "struct stat" information can you get with the easiest
     and quickest FS API call on Windows?  Does it give you big enough
     subset of what we store in the cache entry to detect modification
     reliably?

 (2) When you do an equivalent of "chmod +x path" on Windows, does it
     change one of the fields in your answer to (1)?  In other words, can
     you detect such a change with the fastest and reliable-enough FS API
     call?

If answers to both questions are "yes", then I suspect we might be able to
improve the situation without sacrificing performance too much.

In the generic part, we use lstat(2) for various purposes:

 * To learn existence and type of a FS entity, in order to decide if we
   need to descend into a directory or treat it as a blob;

 * To learn the current "status" that can be compared with what is stored
   in the cache entry, in order to decide if the FS entity hasn't been
   modified;

 * To learn the last-modified timestamp, in order to implement the
   racy-git avoidance logic;

 * To learn x-bit, so that we can update it in the cache entry, and give
   the appropriate x-bit to a file that we create (Alex's
   lstat_for_copy() is about this usage).

If the first three can be learned with a fast-and-reliable-enough FS API
call, and the x-bit and perhaps something else that do not fall into the
first three need a lot more work to figure out, we could split lstat()
into two.  The result from a "fast" variant of lstat() is used for the
first three and allow platform implementation of it to be incomplete
(i.e. the Cygwin "trick" to omit x-bit is OK for that purpose), and add
another "slow" variant to complement it:

	int lstat_fast(const char *path, struct stat *st);
        void lstat_remainder(const char *path, struct stat *st);

On POSIX systems, we implement it as

        #define lstat_fast(path,st) lstat((path),(st))
        #define lstat_remainder(path,st) do { ; /* nothing */ } while (0)
 
but on Windows and Cygwin, we might implement the format to get
good-enough information for comparison purposes and implement latter to
fill the x-bit and some other parts that are expensive to learn.

Most of the callers that are only interested in seeing if a path has
changed can use the lstat_fast(), while the codepath that actually does
use the information for modified path can augment the information a
previous call to "fast" variant obtained with an additional call to the
"slow" lstat_remainder().

The attached patch to convert a part of read-cache.c is only for
illustration purposes.

The refresh_cache_ent() function first calls lstat_fast() to get cheap
information that is good enough, gives it to ie_match_stat(), to see if
anything has changed, and let fill_stat_cache_info() to update the cached
information for later comparison.

We do not have to touch ce_match_stat_basic() that does care about x-bit
but assuming that the answer to question (2) is "yes", we would not miss
MODE_CHANGED report from it; other information such as timestamps would
have changed in such a case as well, and ie_match_stat() that called
ce_match_stat_basic() will still say "changed" for such an entry.

The add_file_to_index() function checks if the path exists with the "fast"
one, gives the result to add_to_index() that wants the full mode bits
hence invokes the "slow" one to fill in the remainder.

If you have to pass information between "fast" and "slow" variant other
than what you can put in "struct stat" in order for "slow" one to take
advantage of what "fast" one already has done, we would need to introduce
something like

	struct gitstat {
        	struct stat st;
		some other info for platform;
	};

and pass that around instead, which would become a larger change, though.
I am hoping it won't be the case.

And if we do not need such an extra "struct gitstat", then there is no
reason for us to introduce lstat_fast().  We can just use lstat(), keep
the "fast and incomplete" Cygwin one as lstat(), but insert calls to
lstat_remainder() at strategic places.  Immediately before copy_file() is
called in builtin-init-db.c::copy_templates_1() would be one of those
strategic places.



diff --git a/read-cache.c b/read-cache.c
index 3f58711..d12d11b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -562,7 +562,7 @@ static void record_intent_to_add(struct cache_entry *ce)
 int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
 {
 	int size, namelen, was_same;
-	mode_t st_mode = st->st_mode;
+	mode_t st_mode;
 	struct cache_entry *ce, *alias;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
@@ -571,6 +571,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 
+	lstat_remainder(path, st);
+	st_mode = st->st_mode;
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		return error("%s: can only add regular files, symbolic links or git-directories", path);
 
@@ -637,7 +639,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
-	if (lstat(path, &st))
+	if (lstat_fast(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
 	return add_to_index(istate, path, &st, flags);
 }
@@ -1013,7 +1015,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		return ce;
 	}
 
-	if (lstat(ce->name, &st) < 0) {
+	if (lstat_fast(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
 		return NULL;
