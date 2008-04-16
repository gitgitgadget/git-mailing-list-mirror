From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make core.sharedRepository more generic
Date: Tue, 15 Apr 2008 22:22:10 -0700
Message-ID: <7vk5iytlvh.fsf@gitster.siamese.dyndns.org>
References: <20080415091326.GA18100@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 16 08:11:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm06t-0008Eb-QR
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 07:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYDPFWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 01:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbYDPFWX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 01:22:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbYDPFWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 01:22:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E25C2E09;
	Wed, 16 Apr 2008 01:22:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A7ADA2E02; Wed, 16 Apr 2008 01:22:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79676>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> git init --shared=0xxx, where '0xxx' is an octal number, will create
> a repository with file modes set to '0xxx'. Users with a safe umask
> value (0077) can use this option to force file modes. For example,
> '0640' is a group-readable but not group-writable regardless of
> user's umask value. Values compatible with old Git versions are written
> as they were before, for compatibility reasons. That is, "1" for
> "group" and "2" for "everybody".
>
> "git config core.sharedRepository 0xxx" is also handled.
>
> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
> ---
> This is version 5 of the generic shared mode patch.

Looking better.

> Btw, the current behavior (not introduced by this patch) of
> "config core.sharedRepository group" writes string "group" to the 
> repository, so it creates incompatible repositories.

Yes, but that is what the user explicitly does, so I do not see it as a
grave problem compared to the one you fixed during this iteration.

But the patch breaks t1301.  I would suggest this fix on top of your
version.

---

 path.c                 |    5 ++++-
 t/t1301-shared-repo.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index cfa0529..2ae7cd9 100644
--- a/path.c
+++ b/path.c
@@ -268,7 +268,10 @@ int adjust_shared_perm(const char *path)
 	mode = st.st_mode;
 
 	if (shared_repository) {
-		mode = (mode & ~0777) | shared_repository;
+		int tweak = shared_repository;
+		if (!(mode & S_IWUSR))
+			tweak &= ~0222;
+		mode = (mode & ~0777) | tweak;
 	} else {
 		/* Preserve old PERM_UMASK behaviour */
 		if (mode & S_IWUSR)
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 6bfe19a..586dab1 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -33,4 +33,44 @@ test_expect_success 'update-server-info honors core.sharedRepository' '
 	esac
 '
 
+for u in	0660:rw-rw---- \
+		0640:rw-r----- \
+		0600:rw------- \
+		0666:rw-rw-rw- \
+		0664:rw-rw-r--
+do
+	x=$(expr "$u" : ".*:\([rw-]*\)") &&
+	y=$(echo "$x" | sed -e "s/w/-/g") &&
+	u=$(expr "$u" : "\([0-7]*\)") &&
+	git config core.sharedrepository "$u" &&
+	umask 0277 &&
+
+	test_expect_success "shared = $u ($y) ro" '
+
+		rm -f .git/info/refs &&
+		git update-server-info &&
+		actual="$(ls -l .git/info/refs)" &&
+		actual=${actual%% *} &&
+		test "x$actual" = "x-$y" || {
+			ls -lt .git/info
+			false
+		}
+	'
+
+	umask 077 &&
+	test_expect_success "shared = $u ($x) rw" '
+
+		rm -f .git/info/refs &&
+		git update-server-info &&
+		actual="$(ls -l .git/info/refs)" &&
+		actual=${actual%% *} &&
+		test "x$actual" = "x-$x" || {
+			ls -lt .git/info
+			false
+		}
+
+	'
+
+done
+
 test_done
