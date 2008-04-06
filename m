From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] alias.c: use git_config_string() to get alias_val
Date: Sun, 6 Apr 2008 13:02:32 +0200
Message-ID: <20080406110232.GA6965@leksak.fem-net>
References: <20080405121834.GB14565@leksak.fem-net> <200804051819.46904.chriscool@tuxfamily.org> <20080405173956.GD14565@leksak.fem-net> <200804060749.34109.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 06 13:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiSev-0003Ac-7E
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 13:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbYDFLCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 07:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYDFLCt
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 07:02:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:52769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751766AbYDFLCs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 07:02:48 -0400
Received: (qmail invoked by alias); 06 Apr 2008 11:02:46 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp052) with SMTP; 06 Apr 2008 13:02:46 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/+ats1LTj+CvPU3lWM6AC3Y8oJDfdHKKt/e6aJx1
	TQ4tMlnYiShNCp
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1JiSds-0002uB-Fh; Sun, 06 Apr 2008 13:02:32 +0200
Mail-Followup-To: Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200804060749.34109.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78889>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> So you should say in the commit message that you decided to cast to "const 
> char **" despite what is on the Janitor page, and most importantly explain 
> why in the commit message.

Ah, ok.
Didn't knew that such reasoning goes into the commit message,
but, yes, it makes sense.

> > But instead of doing that, the original should be kept, because it is
> > better in code beauty, performance and memory usage. ;-)
> 
> Yes, so perhaps it's not a good idea to convert the original file to 
> git_config_string.

Or to use the cast. ;-)

[...]
> But I don't think it's worth the trouble.

I agree ;-)

So what to do?
Keep it?



And there are still some easy `Janitor tasks', like in builtin-apply.c:
--
diff --git a/builtin-apply.c b/builtin-apply.c
index b5f78ac..ce0a0c3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2978,12 +2978,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 static int git_apply_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "apply.whitespace")) {
-		if (!value)
-			return config_error_nonbool(var);
-		apply_default_whitespace = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "apply.whitespace"))
+		return git_config_string(&apply_default_whitespace, var, value);
 	return git_default_config(var, value);
 }
 
--
(Test case: git-apply a patch with trailing whitespaces and check with
apply.whitespace = nowarn / fix / error)

I have attached the patch because I do not want to drop another 
mail for it.
And now there is nothing to argue about, I hope, because it is as simple as
http://git.kernel.org/?p=git/git.git;a=commitdiff;h=9886ea417b7da9722c95630b5980ac174e04c71c


Regards,
 Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--SLDf9lqlvOQaIe6s
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-builtin-apply.c-use-git_config_string-to-get-appl.patch"

>From 78d1ac0fd19b274853d3c8439d45922c1a0fe82d Mon Sep 17 00:00:00 2001
From: Stephan Beyer <s-beyer@gmx.net>
Date: Sun, 6 Apr 2008 12:37:31 +0200
Subject: [PATCH] builtin-apply.c: use git_config_string() to get apply_default_whitespace

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 builtin-apply.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index b5f78ac..ce0a0c3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2978,12 +2978,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 static int git_apply_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "apply.whitespace")) {
-		if (!value)
-			return config_error_nonbool(var);
-		apply_default_whitespace = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "apply.whitespace"))
+		return git_config_string(&apply_default_whitespace, var, value);
 	return git_default_config(var, value);
 }
 
-- 
1.5.5.rc3.8.g78d1a


--SLDf9lqlvOQaIe6s--
