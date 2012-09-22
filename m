From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: submodule: if $command was not matched, don't parse other args
Date: Sat, 22 Sep 2012 16:57:59 +0530
Message-ID: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 13:29:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFNto-00082N-Sh
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 13:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab2IVL3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 07:29:09 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:57386 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab2IVL2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 07:28:20 -0400
Received: by qaas11 with SMTP id s11so1889429qaa.19
        for <git@vger.kernel.org>; Sat, 22 Sep 2012 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=922zCZk+NKie3ujaRZq/LapKMLe55by75QZKsTxcWFc=;
        b=Kx2us2vP8fqpgYDilnNps/4pMmk3He4sejuyZ9frvjixWzdRAawD3FoRHo7j+LZYTe
         M+kgQGoJEW+cIR6QP5ECrzS41pZQo6bfWxQqtxf/kOTuY5WoiAELwOB28bpbbh8PrS/d
         rU0jCvvSmlDTAj9UtYOsjPrLl3GJjBKAQNhx+HaPEvUXMdvtpDD1UrAtiYa1+EwPUg7n
         ChMl8Kp8q2GxeDdgOb21gdhWFFNBJO/r1uyNcjpTlBWQvKBn1lbGISx55ldu/H0YUtcv
         TP/iEU4JYSEh3nWJatlmgyqf8z7ufBXyLbrUysiA/Lcz2rkOe4lzN7er33OBVb3XjDmZ
         lRMQ==
Received: by 10.229.136.17 with SMTP id p17mr5145531qct.86.1348313299889; Sat,
 22 Sep 2012 04:28:19 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sat, 22 Sep 2012 04:27:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206202>

When we try to execute 'git submodule' with an invalid subcommand, we
get an error like the following:

    $ git submodule show
    error: pathspec 'show' did not match any file(s) known to git.
    Did you forget to 'git add'?

The cause of the problem: since $command is not matched, it is set to
"status", and "show" is treated as an argument to "status".  Change
this so that usage information is printed when an invalid subcommand
is tried.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This breaks test 41 in t7400-submodule-bash -- does the test cover a
 real-world usecase?

 git-submodule.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a7e933e..dfec45d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1108,7 +1108,15 @@ do
 done

 # No command word defaults to "status"
-test -n "$command" || command=status
+if test -z "$command"
+then
+    if test $# = 0
+    then
+	command=status
+    else
+	usage
+    fi
+fi

 # "-b branch" is accepted only by "add"
 if test -n "$branch" && test "$command" != add
-- 
1.7.12.GIT
