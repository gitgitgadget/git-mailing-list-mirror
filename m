From: Jim Meyering <meyering@redhat.com>
Subject: [PATCH] mailinfo: remove [PATCH...] prefix from Subject regardless of length
Date: Tue, 24 Nov 2009 11:58:07 +0100
Message-ID: <874ookp4u8.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 11:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCt6E-0001io-6k
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 11:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbZKXK6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 05:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbZKXK6J
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 05:58:09 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:57852 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932208AbZKXK6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 05:58:08 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BCECC81819B
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 11:58:10 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DAB928180B8
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 11:58:07 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 6383521452; Tue, 24 Nov 2009 11:58:07 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133573>


Before this change, a [...] prefix would be removed only as long as
its length did not exceed 2/3 of the subject length.  Now, when the
bracketed quantity starts with PATCH, it is removed unconditionally.
Otherwise, the existing behavior remains unchanged.

While with a bare "PATCH M/N" prefix, this inconsistency shows up only
on a subject of length 2 or 1 (assuming one-digit M and N), if you set
format.subjectprefix to the name of a project or sub-project, the
minimum affected length may be substantially larger.

Contrast the behavior before:

  for i in 1234 123 12 1 ''; do echo 'Subject: [PATCH 1/1] '$i \
    | git mailinfo m p | head -1; done
  Subject: 1234
  Subject: 123
  Subject: [PATCH 1/1] 12
  Subject: [PATCH 1/1] 1
  Subject: [PATCH 1/1]

and after this change:

  for i in 1234 123 12 1 ''; do echo 'Subject: [PATCH 1/1] '$i \
    | ./git mailinfo m p | head -1; done
  Subject: 1234
  Subject: 123
  Subject: 12
  Subject: 1
  Subject:

Along the way, I added a "const" to indicate that the "header"
array itself is constant.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin-mailinfo.c  |   10 ++++++++--
 t/t5100-mailinfo.sh |    9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 3c4f075..f07bca6 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -237,9 +237,15 @@ static void cleanup_subject(struct strbuf *subject)
 			strbuf_remove(subject, 0, 1);
 			continue;
 		case '[':
+			/* If there's a [...] enclosed prefix, always remove
+			   it when it starts with "PATCH".  If it does not
+			   start with PATCH, remove the bracketed quantity
+			   only as long as that removes no more than 2/3 of
+			   the length.  */
 			if ((pos = strchr(subject->buf, ']'))) {
 				remove = pos - subject->buf;
-				if (remove <= (subject->len - remove) * 2) {
+				if (remove <= (subject->len - remove) * 2
+				    || !prefixcmp (subject->buf + 1, "PATCH")) {
 					strbuf_remove(subject, 0, remove + 1);
 					continue;
 				}
@@ -265,7 +271,7 @@ static void cleanup_space(struct strbuf *sb)
 }

 static void decode_header(struct strbuf *line);
-static const char *header[MAX_HDR_PARSED] = {
+static const char *const header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index ebc36c1..86fb116 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -89,4 +89,13 @@ test_expect_success 'mailinfo on from header without name works' '

 '

+test_expect_success 'mailinfo strips [PATCH... even on very short Subject' '
+
+	printf "Subject: [PATCH 1/1] ..\n" > in &&
+	printf "Subject: ..\n\n" > expect &&
+	git mailinfo /dev/null /dev/null < in > out &&
+	test_cmp expect out
+
+'
+
 test_done
--
1.6.6.rc0.236.ge0b94
