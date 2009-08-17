From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "make quick-install-man" broke recently
Date: Sun, 16 Aug 2009 23:53:12 -0700
Message-ID: <7vhbw72ap3.fsf@alter.siamese.dyndns.org>
References: <86my5z8cjd.fsf@blue.stonehenge.com>
 <7vy6pj449g.fsf@alter.siamese.dyndns.org>
 <86iqgn8brv.fsf@blue.stonehenge.com>
 <7vd46v3tp1.fsf@alter.siamese.dyndns.org>
 <8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 08:53:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcw62-00027S-JQ
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 08:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbZHQGxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 02:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbZHQGxZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:53:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZHQGxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:53:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7F7A2C127;
	Mon, 17 Aug 2009 02:53:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 894592C126; Mon, 17 Aug 2009
 02:53:14 -0400 (EDT)
In-Reply-To: <8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com>
 (Jacob Helwig's message of "Sun\, 16 Aug 2009 22\:58\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8DD2EEA-8AFA-11DE-8F39-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126128>

Jacob Helwig <jacob.helwig@gmail.com> writes:

> I was able to reproduce this one one of the machines I have access to,
> and bisecting shows that it was introduced by b6986d8 (git-checkout: be
> careful about untracked symlinks).

Ahh..

-- >8 --
check_path(): allow symlinked directories to checkout-index --prefix

Merlyn noticed that Documentation/install-doc-quick.sh no longer correctly
removes old installed documents when the target directory has a leading
path that is a symlink.  It turns out that "checkout-index --prefix" was
broken by recent b6986d8 (git-checkout: be careful about untracked
symlinks, 2009-07-29).

I suspect has_symlink_leading_path() could learn the third parameter
(prefix that is allowed to be symlinked directories) to allow us to retire
a similar function has_dirs_only_path().

Another avenue of fixing this I considered was to get rid of base_dir and
base_dir_len from "struct checkout", and instead make "git checkout-index"
when run with --prefix mkdir the leading path and chdir in there.  It
might be the best longer term solution to this issue, as the base_dir
feature is used only by that rather obscure codepath as far as I know.

But at least this patch should fix this breakage.

SIgned-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                         |    3 ---
 entry.c                         |   15 ++++++++++++---
 t/t2000-checkout-cache-clash.sh |    9 +++++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 9222774..e6c7f33 100644
--- a/cache.h
+++ b/cache.h
@@ -468,9 +468,6 @@ extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_obje
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
-/* "careful lstat()" */
-extern int check_path(const char *path, int len, struct stat *st);
-
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
diff --git a/entry.c b/entry.c
index f276cf3..6813f8a 100644
--- a/entry.c
+++ b/entry.c
@@ -179,9 +179,18 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
  * This is like 'lstat()', except it refuses to follow symlinks
  * in the path.
  */
-int check_path(const char *path, int len, struct stat *st)
+static int check_path(const char *path, int len, struct stat *st,
+		      const struct checkout *co)
 {
-	if (has_symlink_leading_path(path, len)) {
+	if (co->base_dir_len) {
+		const char *slash = path + len;
+		while (path < slash && *slash != '/')
+			slash--;
+		if (!has_dirs_only_path(path, slash-path, co->base_dir_len)) {
+			errno = ENOENT;
+			return -1;
+		}
+	} else if (has_symlink_leading_path(path, len)) {
 		errno = ENOENT;
 		return -1;
 	}
@@ -201,7 +210,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 	strcpy(path + len, ce->name);
 	len += ce_namelen(ce);
 
-	if (!check_path(path, len, &st)) {
+	if (!check_path(path, len, &st, state)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return 0;
diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
index f7e1a73..3edade0 100755
--- a/t/t2000-checkout-cache-clash.sh
+++ b/t/t2000-checkout-cache-clash.sh
@@ -48,4 +48,13 @@ test_expect_success \
     'git checkout-index conflicting paths.' \
     'test -f path0 && test -d path1 && test -f path1/file1'
 
+test_expect_success 'checkout-index -f twice with --prefix' '
+	mkdir -p tar/get &&
+	ln -s tar/get there &&
+	echo first &&
+	git checkout-index -a -f --prefix=there/ &&
+	echo second &&
+	git checkout-index -a -f --prefix=there/
+'
+
 test_done
