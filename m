From: Elijah Newren <newren@gmail.com>
Subject: [PATCH] upload-pack: Improve error message when bad ref requested
Date: Sat, 31 Jul 2010 14:11:46 -0600
Message-ID: <1280607106-8442-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 22:04:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfIHq-0007xA-Tm
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 22:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab0GaUDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 16:03:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64940 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab0GaUDt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 16:03:49 -0400
Received: by pzk26 with SMTP id 26so928721pzk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qHouyEsptwmUVxMZ8UCQEmWFRl39oXhYZmhf+3S7BG4=;
        b=fm1d2Awuh+eWSnbeK41CXyD4Q/4afLcvtuOSFquoklF+NJgdiMPU9VyQHuTm4vrB71
         XfngvxS455o8qm/G+mIuhoIqXQFTLcfAvBdJRizfnFT4+RRFKzStbozgCz66iKZj8hmT
         HUuj7JyVlszI6Jc+3Zhp2EInrkTC8ji62qKpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=whIKWXWo5i9eJ9THwsb0Ujo0DSXNZX7ilRLPUgIOTrJQtHSf0ejddiOg63fIGBkbwI
         1CB7CyDBsQsr2micMEPdQQg5Z/62uhn/zDQ8UeEMZHfsrsVuhwjlYbQUnChrF5VwhNhs
         lXf08e/sJRv7nXVnk8lDaMadCFwgPYoBCsW6w=
Received: by 10.114.36.4 with SMTP id j4mr4424615waj.176.1280606629079;
        Sat, 31 Jul 2010 13:03:49 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id x9sm6920705waj.15.2010.07.31.13.03.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 13:03:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.2.g25e932.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152336>

When printing an error message saying a ref was requested that we do not
have, only print that ref, rather than the ref and everything sent to us
on the same packet line (e.g. protocol support specifications).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5530-upload-pack-error.sh |    9 +++++++++
 upload-pack.c                |    3 ++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 044603c..6b2a5f4 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -60,6 +60,15 @@ test_expect_success 'upload-pack fails due to error in rev-list' '
 	grep "bad tree object" output.err
 '
 
+test_expect_success 'upload-pack error message when bad ref requested' '
+
+	printf "0045want %s multi_ack_detailed\n00000009done\n0000" \
+		"deadbeefdeadbeefdeadbeefdeadbeefdeadbeef" >input &&
+	test_must_fail git upload-pack . <input >output 2>output.err &&
+	grep -q "not our ref" output.err &&
+	! grep -q multi_ack_detailed output.err
+'
+
 test_expect_success 'upload-pack fails due to error in pack-objects enumeration' '
 
 	printf "0032want %s\n00000009done\n0000" \
diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..fd1ffe1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -554,7 +554,8 @@ static void receive_needs(void)
 		 */
 		o = lookup_object(sha1_buf);
 		if (!o || !(o->flags & OUR_REF))
-			die("git upload-pack: not our ref %s", line+5);
+			die("git upload-pack: not our ref %s",
+			    sha1_to_hex(sha1_buf));
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
 			add_object_array(o, NULL, &want_obj);
-- 
1.7.2.1.2.g25e932.dirty
