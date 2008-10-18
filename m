From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: [PATCH] git-fetch should not strip off ".git" extension
Date: Sat, 18 Oct 2008 07:59:41 -0400
Message-ID: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 14:00:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrAUJ-0006g1-Vw
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 14:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbYJRL7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 07:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYJRL7o
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 07:59:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:56466 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYJRL7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 07:59:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so729107fgg.17
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=hvcVXs5XfQH54BWUEsGyRIe/jQ+EjGvYRTBrnY1SUY8=;
        b=pHkZYrc9DeS1B5/1rEfkJNO/y7QkvhaKHFlUTT15z2w86PMmwKld5D22SwM1z9415A
         DsEB6+hY15zHVjXG0hvwhWw8posZSrO1tOdAGBWE0P/Lj1VDbgSE/FZSrhkhi93eNwm0
         iYnjQaA4F29K+RS9WteIEfG+5HDwN4nrg13Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=p3P0Yvt7dQG7OUz49nxvJrPs37jBwHNutE9wLmU3fAwauwJMswDgDBIHV5z+caaEnW
         ifRXXstDP0fPfhv9/+YMuu4Bi8b8av1spsTVBAX4XggtT2AxFC/zMcm6MceL+4rQWHL0
         EToUGV8sVLJKrka6+sqYBqI7cGkkbV3oLGBe4=
Received: by 10.187.251.11 with SMTP id d11mr793377fas.31.1224331181389;
        Sat, 18 Oct 2008 04:59:41 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sat, 18 Oct 2008 04:59:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98538>

When source git repository has extension ".git" like in "MyRepo.git"
"git fetch" will drop ".git" extension and refer to it as "MyRepo".

Example:

sh$ git fetch -v ../MyRepo.git master
From ../MyRepo
 * branch            master     -> FETCH_HEAD

sh$ cat .git/FETCH_HEAD
6eb10bd105f2ef7f64c595100c0a850c5b3cfeb9           branch 'master' of ../MyRepo

Please, note that "git fetch" writes "../MyRepo" instead of "../MyRepo.git"

My workflow makes it convenient to have two distinct repositories
(1) "MyRepo"      => where I work daily (WIP)
(2) "MyRepo.git" => --bare repository accessible to others. "MyRepo"
pushes ready changes to "MyRepo.git"
Dropping ".git" extension causes confusion between these two quite
similarly named repositories.

This problem can be easily solved by the patch below that removes the
code that strips off ".git" extension.

--Leo--

----8<-------------------

 builtin-fetch--tool.c |    2 --
 builtin-fetch.c       |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 7460ab7..5d0b95f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -160,8 +160,6 @@ static int append_fetch_head(FILE *fp,
 	for (i = remote_len - 1; remote[i] == '/' && 0 <= i; i--)
 		;
 	remote_len = i + 1;
-	if (4 < i && !strncmp(".git", remote + i - 3, 4))
-		remote_len = i - 3;

 	note_len = 0;
 	if (*what) {
diff --git a/builtin-fetch.c b/builtin-fetch.c
index ee93d3a..28123a5 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -348,8 +348,6 @@ static int store_updated_refs(const char *url,
const char *remote_name,
 		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
 			;
 		url_len = i + 1;
-		if (4 < i && !strncmp(".git", url + i - 3, 4))
-			url_len = i - 3;

 		note_len = 0;
 		if (*what) {
