From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] rm: loosen safety valve for empty files
Date: Tue, 21 Oct 2008 09:54:19 -0400
Message-ID: <20081021135419.GA17999@coredump.intra.peff.net>
References: <20081021003712.GB32569@coredump.intra.peff.net> <7v4p361x1f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 15:57:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsHhx-0004k4-A1
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 15:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYJUNyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 09:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYJUNyX
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 09:54:23 -0400
Received: from peff.net ([208.65.91.99]:1878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbYJUNyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 09:54:22 -0400
Received: (qmail 21142 invoked by uid 111); 21 Oct 2008 13:54:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Oct 2008 09:54:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Oct 2008 09:54:19 -0400
Content-Disposition: inline
In-Reply-To: <7v4p361x1f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98786>

On Mon, Oct 20, 2008 at 07:50:36PM -0700, Junio C Hamano wrote:

> in addition to what you are trying to fix here with "git rm".  With such a
> change, your "git rm empty" code can also distinguish between an empty
> blob the user wanted to add _as the final contents_, and a path that has
> been marked with "add -N", and behave differently (the former would not
> require -f while the latter would).

Your reasoning makes sense.

> As an interim measure, I suspect your patch is an improvement from the
> current state of affairs, but the above test will then break when an
> improvement to "git add -N" implementation outlined above materializes.

Yeah, I actually considered writing it as "git add -N", but I thought it
better that the person who changes the behavior breaks the test, reads
the commit message, and decides then what the best behavior is.

But if you are comfortable saying now "this is what the behavior
_should_ be", then I think the test modifications you proposed make
sense (and after reading your discussion above, I think the behavior you
propose is reasonable).

> So how about changing the test to explicitly check that a path that was
> added by "git add -N" can be removed, and either (1) not check about an
> empty blob that was explicitly added by the user, or (2) check that an
> empty blob that was explicitly added by the user cannot be "git rm"'ed
> without -f, with expect_failure?

Patch below. I tried to expand the commit message to explain the
situation to the future developer who extends intent-to-add, but please
mark up if anything seems unclear.

-- >8 --
rm: loosen safety valve for empty files

If a file is different between the working tree copy, the
index, and the HEAD, then we do not allow it to be deleted
without --force.

However, this is overly tight in the face of "git add
--intent-to-add":

  $ git add --intent-to-add file
  $ : oops, I don't actually want to stage that yet
  $ git rm --cached file
  error: 'empty' has staged content different from both the
  file and the HEAD (use -f to force removal)
  $ git rm -f --cached file

Unfortunately, there is currently no way to distinguish
between an empty file that has been added and an "intent to
add" file. The ideal behavior would be to disallow the
former while allowing the latter.

This patch loosens the safety valve to allow the deletion
only if we are deleting the cached entry and the cached
content is empty.  This covers the intent-to-add situation,
and assumes there is little harm in not protecting users who
have legitimately added an empty file.  In many cases,
the file will still be empty, in which case the safety valve
does not trigger anyway (since the content remains untouched
in the working tree). Otherwise, we do remove the fact that
no content was staged, but given that the content is by
definition empty, it is not terribly difficult for a user to
recreate it.

However, we still document the desired behavior in the form
of two tests. One checks the correct removal of an
intent-to-add file. The other checks that we still disallow
removal of empty files, but is marked as expect_failure to
indicate this compromise. If the intent-to-add feature is
ever extended to differentiate between normal empty files
and intent-to-add files, then the safety valve can be
re-tightened.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-rm.c  |    3 ++-
 cache.h       |    1 +
 read-cache.c  |    2 +-
 t/t3600-rm.sh |   13 +++++++++++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index e06640c..b7126e3 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -79,7 +79,8 @@ static int check_local_mod(unsigned char *head, int index_only)
 		     || hashcmp(ce->sha1, sha1))
 			staged_changes = 1;
 
-		if (local_changes && staged_changes)
+		if (local_changes && staged_changes &&
+		    !(index_only && is_empty_blob_sha1(ce->sha1)))
 			errs = error("'%s' has staged content different "
 				     "from both the file and the HEAD\n"
 				     "(use -f to force removal)", name);
diff --git a/cache.h b/cache.h
index cdbeb48..b0edbf9 100644
--- a/cache.h
+++ b/cache.h
@@ -519,6 +519,7 @@ static inline void hashclr(unsigned char *hash)
 {
 	memset(hash, 0, 20);
 }
+extern int is_empty_blob_sha1(const unsigned char *sha1);
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
diff --git a/read-cache.c b/read-cache.c
index fdb41b8..2c45086 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -160,7 +160,7 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int is_empty_blob_sha1(const unsigned char *sha1)
+int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	static const unsigned char empty_blob_sha1[20] = {
 		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 66aca99..5b4d6f7 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -187,6 +187,19 @@ test_expect_success 'but with -f it should work.' '
 	test_must_fail git ls-files --error-unmatch baz
 '
 
+test_expect_failure 'refuse to remove cached empty file with modifications' '
+	touch empty &&
+	git add empty &&
+	echo content >empty &&
+	test_must_fail git rm --cached empty
+'
+
+test_expect_success 'remove intent-to-add file without --force' '
+	echo content >intent-to-add &&
+	git add -N intent-to-add
+	git rm --cached intent-to-add
+'
+
 test_expect_success 'Recursive test setup' '
 	mkdir -p frotz &&
 	echo qfwfq >frotz/nitfol &&
-- 
1.6.0.2.808.gf6cf2
