From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for
 external diff
Date: Sat, 21 Mar 2009 17:41:52 -0700
Message-ID: <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
 <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> <7vocvuekjb.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de> <7v8wmybf06.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 01:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlBv0-0002US-Vt
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 01:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbZCVAmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZCVAmF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 20:42:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbZCVAmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 20:42:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3EF9A394B;
	Sat, 21 Mar 2009 20:42:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C2D70A3943; Sat,
 21 Mar 2009 20:41:54 -0400 (EDT)
In-Reply-To: <7v8wmybf06.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 21 Mar 2009 17:03:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4162640A-167A-11DE-89E9-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114106>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Sat, 21 Mar 2009, Junio C Hamano wrote:
>>
>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>> 
>>> > When preparing temporary files for an external diff, the files should 
>>> > be handled as if they were worktree files.
>>> 
>>> I do not think so.  convert_to_working_tree() aka "smudge" means you 
>>> would be feeding crap like $Id$ expansion to the external diff, which we 
>>> chose not to do quite on purpose.
>>
>> You might have missed me mentioning that we often can do without temporary 
>> files, taking the working directory copies right away?
>>
>> And if you think about it, it makes complete sense.
>
> Not "complete".
>
> What is at issue is how consistent the codepath that calls out to an
> external diff should be with the rest of git that solely work with the
> "clean" version of blob contents.  If you value consistency, I would say
> that it is valid to argue that letting it borrow from a work tree is a
> bug.  It should be always feeding a clean version.
>
> But if you think that we do not care really about the correctness of the
> external diff codepath, because it is a mechanism used mostly for giving
> output to humans (as opposed to feeding the output of the external diff
> program back to programs to be processed further) , I can understand why
> you think it is easier to the external programs if "smudged" version is
> fed to them.
>
> Not just I can _understand_, but I think I could be pursuaded to agree
> with that position, iff you try harder.
>
> But the assumption/rationale behind this change needs to be spelled out.
> In essence, we are sacrificing purity and correctness because we consider
> ease of building external diff filter is more important.
>
> Or something like that.

The situation is worse than I thought, and I am surely glad that this was
brought into my attention.  I think diff.c::reuse_worktree_file() should
always say "Don't" when we know convert_to_working_tree() is not a no-op.

I have a suspicion that:

 (1) borrowing from the work tree may not be buying us very much these
     days; the introduction of the logic predates not just "clean/smudge"
     feature but packfiles.  Back then, the tradeoff was between opening a
     loose object file, deflating and writing out a temporary and reusing
     a file in the work tree.  These days, most of the time the former
     would be to reconstruct a blob from the pack data that is already
     mapped, and performance characteristics would be different.

 (2) having to check if convert_to_working_tree() is a no-op or not may be
     a lot more costly than any performance gain we get from borrowing
     from the work tree.

Here is a patch to get rid of the borrowing.

You can work on top of this patch to add the convert_to_working_tree()
call to prep_temp_blob().  Such a change would also affect the "textconv"
codepath and the result will start feeding smudged contents to the
"textconv" filter, and I think the argument "external tools prefer to be
fed smudged contents, not clean ones, because that is the representation
tailored for the platform" would hold even more stronger in that context.

 diff.c |   69 ++-------------------------------------------------------------
 1 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/diff.c b/diff.c
index 75d9fab..4d71ebc 100644
--- a/diff.c
+++ b/diff.c
@@ -1746,67 +1746,6 @@ void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 	}
 }
 
-/*
- * Given a name and sha1 pair, if the index tells us the file in
- * the work tree has that object contents, return true, so that
- * prepare_temp_file() does not have to inflate and extract.
- */
-static int reuse_worktree_file(const char *name, const unsigned char *sha1, int want_file)
-{
-	struct cache_entry *ce;
-	struct stat st;
-	int pos, len;
-
-	/* We do not read the cache ourselves here, because the
-	 * benchmark with my previous version that always reads cache
-	 * shows that it makes things worse for diff-tree comparing
-	 * two linux-2.6 kernel trees in an already checked out work
-	 * tree.  This is because most diff-tree comparisons deal with
-	 * only a small number of files, while reading the cache is
-	 * expensive for a large project, and its cost outweighs the
-	 * savings we get by not inflating the object to a temporary
-	 * file.  Practically, this code only helps when we are used
-	 * by diff-cache --cached, which does read the cache before
-	 * calling us.
-	 */
-	if (!active_cache)
-		return 0;
-
-	/* We want to avoid the working directory if our caller
-	 * doesn't need the data in a normal file, this system
-	 * is rather slow with its stat/open/mmap/close syscalls,
-	 * and the object is contained in a pack file.  The pack
-	 * is probably already open and will be faster to obtain
-	 * the data through than the working directory.  Loose
-	 * objects however would tend to be slower as they need
-	 * to be individually opened and inflated.
-	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
-		return 0;
-
-	len = strlen(name);
-	pos = cache_name_pos(name, len);
-	if (pos < 0)
-		return 0;
-	ce = active_cache[pos];
-
-	/*
-	 * This is not the sha1 we are looking for, or
-	 * unreusable because it is not a regular file.
-	 */
-	if (hashcmp(sha1, ce->sha1) || !S_ISREG(ce->ce_mode))
-		return 0;
-
-	/*
-	 * If ce matches the file in the work tree, we can reuse it.
-	 */
-	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
-		return 1;
-
-	return 0;
-}
-
 static int populate_from_stdin(struct diff_filespec *s)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1861,8 +1800,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	if (S_ISGITLINK(s->mode))
 		return diff_populate_gitlink(s, size_only);
 
-	if (!s->sha1_valid ||
-	    reuse_worktree_file(s->path, s->sha1, 0)) {
+	if (!s->sha1_valid) {
 		struct strbuf buf = STRBUF_INIT;
 		struct stat st;
 		int fd;
@@ -1988,8 +1926,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		remove_tempfile_installed = 1;
 	}
 
-	if (!one->sha1_valid ||
-	    reuse_worktree_file(name, one->sha1, 1)) {
+	if (!one->sha1_valid) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
@@ -2011,7 +1948,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 					one->mode : S_IFLNK));
 		}
 		else {
-			/* we can borrow from the file in the work tree */
+			/* we use the file in the work tree */
 			temp->name = name;
 			if (!one->sha1_valid)
 				strcpy(temp->hex, sha1_to_hex(null_sha1));
