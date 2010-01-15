From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v2] Test t5560: Fix test when run with dash
Date: Thu, 14 Jan 2010 22:44:02 -0800
Message-ID: <1263537842-5792-1-git-send-email-tarmigan+git@gmail.com>
References: <7vfx69hyd5.fsf@alter.siamese.dyndns.org>
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 07:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVfmA-0007KS-Ii
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 07:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab0AOGfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 01:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823Ab0AOGfG
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 01:35:06 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36449 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab0AOGfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 01:35:05 -0500
Received: by yxe17 with SMTP id 17so285261yxe.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 22:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=MqX4NI5WGGtaZM0r9YVqYNnkkA/99uGeY04aYsp3iEo=;
        b=l8EdFJ9A5M2dq0xxYX60J3GntqGYqWFrlLhiaWApmqmvOl3uPfjeop2SrhJZKmK7gc
         BjevB6UI/yN23JoYcm0uXcg6iqkXWhDGurVMxgylED+3Ovt9bXRBHvkaclYQOhNbit2e
         HLSWBYpO6qKgKhU9sxI+JOAX6kcioc9MNMaC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=hoATA7GQk16/dnU1q43SnNnums8bDSueu2lYR/mE6CRgnU25H09yqftR1vTbYwSTyg
         QPoyfdoPj9K912/jZBLHmszoNwl6LM6QW9gqUvBWKna9+O7l4MCxebEyRlkatoLtk0JD
         r4xyel7Yz8chfDCa4+FM7QWsjjcsAe5hkzDso=
Received: by 10.151.16.22 with SMTP id t22mr105360ybi.138.1263536960410;
        Thu, 14 Jan 2010 22:29:20 -0800 (PST)
Received: from localhost (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 7sm453997yxg.68.2010.01.14.22.29.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 22:29:19 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <7vfx69hyd5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137052>

The dash shell is more finicky than some others.

In particular, it does not seem to like the pattern of setting an
environment variable on the same line as you call a shell function
like this:

        REQUEST_METHOD="GET" some_shell_function

as you might use to set a variable only for one command if that
command were an executable or a shell builtin.

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
Junio, that description matches my understanding of the problem.
I can't tell from my reading of the POSIX spec whether my usage was
wrong or if dash is wrong, which is why I shied away from an
explanation.  As a practical matter though, this patch does fix the
issue.

This version takes a slighty different approach that I think leaves
things clearer and doesn't pass in tons of arguements to the shell
function.  If you prefer the old approach, I can send a patch that way
instead.
---
 t/t5560-http-backend-noserver.sh |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 5f8c88e..44885b8 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -14,8 +14,9 @@ run_backend() {
 }
 
 GET() {
-	REQUEST_METHOD="GET" \
+	export REQUEST_METHOD="GET" &&
 	run_backend "/repo.git/$1" &&
+	unset REQUEST_METHOD &&
 	if ! grep "Status" act.out >act
 	then
 		printf "Status: 200 OK\r\n" >act
@@ -25,9 +26,11 @@ GET() {
 }
 
 POST() {
-	REQUEST_METHOD="POST" \
-	CONTENT_TYPE="application/x-$1-request" \
+	export REQUEST_METHOD="POST" &&
+	export CONTENT_TYPE="application/x-$1-request" &&
 	run_backend "/repo.git/$1" "$2" &&
+	unset REQUEST_METHOD &&
+	unset CONTENT_TYPE &&
 	if ! grep "Status" act.out >act
 	then
 		printf "Status: 200 OK\r\n" >act
@@ -43,13 +46,15 @@ log_div() {
 . "$TEST_DIRECTORY"/t556x_common
 
 expect_aliased() {
+	export REQUEST_METHOD="GET" &&
 	if test $1 = 0; then
-		REQUEST_METHOD=GET run_backend "$2"
+		run_backend "$2"
 	else
-		REQUEST_METHOD=GET run_backend "$2" &&
+		run_backend "$2" &&
 		echo "fatal: '$2': aliased" >exp.err &&
 		test_cmp exp.err act.err
 	fi
+	unset REQUEST_METHOD
 }
 
 test_expect_success 'http-backend blocks bad PATH_INFO' '
-- 
1.6.6
