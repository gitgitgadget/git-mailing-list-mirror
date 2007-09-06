From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] git-tag -s must fail if gpg is broken and cannot sign tags
Date: Thu, 6 Sep 2007 00:21:15 -0400
Message-ID: <20070906042115.GA343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 06:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT8ru-000851-Ur
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 06:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbXIFEVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 00:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbXIFEVV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 00:21:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38881 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXIFEVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 00:21:20 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT8rl-0002BZ-KH; Thu, 06 Sep 2007 00:21:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EDEC620FBAE; Thu,  6 Sep 2007 00:21:15 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57812>

If the user has misconfigured `user.signingkey` in their .git/config
or just doesn't have any secret keys on their keyring and they ask
for a signed tag with `git tag -s` we better make sure the resulting
tag was actually signed by gpg.

Prior versions of builtin git-tag allowed this failure to slip
by without error as they were not checking the return value of
the finish_command() so they did not notice when gpg exited with
an error exit status.  They also did not fail if gpg produced an
empty output or if read_in_full received an error from the read
system call while trying to read the pipe back from gpg.

Finally we did not actually honor any return value from the do_sign
function as it returns ssize_t but was being stored into an unsigned
long.  This caused the compiler to optimize out the die condition,
allowing git-tag to continue along and create the tag object.

With these issues fixed `git-tag -s` will now fail to create the
tag and will report a non-zero exit status to its caller, thereby
allowing automated helper scripts to detect (and recover from)
failure if gpg is not working properly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I think this and my prior contrib/workdir patch should both go into
 maint.  This one in particular; it hurt us today when an automated
 tool that runs `git tag -s` didn't notice the GnuPG problems.

 builtin-tag.c  |    8 +++++---
 t/t7004-tag.sh |    7 +++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 348919c..aadf850 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -217,7 +217,8 @@ static ssize_t do_sign(char *buffer, size_t size, size_t max)
 	gpg.close_in = 0;
 	len = read_in_full(gpg.out, buffer + size, max - size);
 
-	finish_command(&gpg);
+	if (finish_command(&gpg) || !len || len < 0)
+		return error("gpg failed to sign the tag");
 
 	if (len == max - size)
 		return error("could not read the entire signature from gpg.");
@@ -310,9 +311,10 @@ static void create_tag(const unsigned char *object, const char *tag,
 	size += header_len;
 
 	if (sign) {
-		size = do_sign(buffer, size, max_size);
-		if (size < 0)
+		ssize_t r = do_sign(buffer, size, max_size);
+		if (r < 0)
 			die("unable to sign the tag");
+		size = r;
 	}
 
 	if (write_sha1_file(buffer, size, tag_type, result) < 0)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 606d4f2..0d07bc3 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -990,6 +990,13 @@ test_expect_success \
 	git diff expect actual
 '
 
+# try to sign with bad user.signingkey
+git config user.signingkey BobTheMouse
+test_expect_failure \
+	'git-tag -s fails if gpg is misconfigured' \
+	'git tag -s -m tail tag-gpg-failure'
+git config --unset user.signingkey
+
 # try to verify without gpg:
 
 rm -rf gpghome
-- 
1.5.3.1.840.g0fedbc
