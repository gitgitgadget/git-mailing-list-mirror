From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: minor problems in git.c
Date: Thu, 1 Dec 2005 13:48:35 +0100
Message-ID: <81b0412b0512010448u7fcdddacnd7de5df217ab3ca@mail.gmail.com>
References: <72499e3b0512010400i1de76ed2la22cd745f811007f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_54024_23064588.1133441315264"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 13:49:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehnrc-00061V-1u
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 13:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVLAMsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 07:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVLAMsh
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 07:48:37 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:50339 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932191AbVLAMsg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 07:48:36 -0500
Received: by nproxy.gmail.com with SMTP id x4so82220nfb
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 04:48:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=fLJjSfONbCKxYHDNJzWBrLuhcoASnHKRRYhLX3HM/6vy6Qrm/rTNFdjcM1sh6BxXgJwCCkC4VSE7j+evlZUHctFqZmfewKpORqX7gmoq1t4YVJx89oNpMorXJ/f4Lr7agx6z1x49SbRDCV+W409fIEKyLhap6ycL/EqP9gGjrnc=
Received: by 10.49.1.16 with SMTP id d16mr257447nfi;
        Thu, 01 Dec 2005 04:48:35 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 1 Dec 2005 04:48:35 -0800 (PST)
To: Robert Watson <robert.oo.watson@gmail.com>
In-Reply-To: <72499e3b0512010400i1de76ed2la22cd745f811007f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13052>

------=_Part_54024_23064588.1133441315264
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/1/05, Robert Watson <robert.oo.watson@gmail.com> wrote:
> There are some minor problems in git.c:

I had the following patches in my tree for some time. Even forgot
about them, sorry.
The second on top of the first.

- Use stderr for error output
- Build git_command more careful
- ENOENT is good enough for check of failed exec to show usage, no
access() check needed

------=_Part_54024_23064588.1133441315264
Content-Type: text/plain; 
	name=0001-used-stderr-for-error-output-and-build-git_command-more-careful.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-used-stderr-for-error-output-and-build-git_command-more-careful.txt"

Use stderr for error output and build git_command more careful

---

 git.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

081fc78a8c8e640420ac7e44d93a2a45246f5c2f
diff --git a/git.c b/git.c
index bdd3f8d..9468b58 100644
--- a/git.c
+++ b/git.c
@@ -283,16 +283,15 @@ int main(int argc, char **argv, char **e
 	len = strlen(git_command);
 	prepend_to_path(git_command, len);
 
-	strncat(&git_command[len], "/git-", sizeof(git_command) - len);
-	len += 5;
-	strncat(&git_command[len], argv[i], sizeof(git_command) - len);
+	snprintf(git_command + len, sizeof(git_command) - len, "/git-%s",
+		 argv[i]);
 
 	if (access(git_command, X_OK))
 		usage(exec_path, "'%s' is not a git-command", argv[i]);
 
 	/* execve() can only ever return if it fails */
 	execve(git_command, &argv[i], envp);
-	printf("Failed to run command '%s': %s\n", git_command, strerror(errno));
+	fprintf(stderr, "git: '%s': %s\n", git_command, strerror(errno));
 
 	return 1;
 }
-- 
0.99.9.GIT



------=_Part_54024_23064588.1133441315264
Content-Type: text/plain; 
	name=0002-ENOENT-is-good-enough-no-access-check-needed.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0002-ENOENT-is-good-enough-no-access-check-needed.txt"

ENOENT is good enough, no access() check needed

---

 git.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

ac97adc8152a1e5ac78a03f218a3dab012bf8ba9
diff --git a/git.c b/git.c
index 9468b58..c8c2b4a 100644
--- a/git.c
+++ b/git.c
@@ -286,12 +286,12 @@ int main(int argc, char **argv, char **e
 	snprintf(git_command + len, sizeof(git_command) - len, "/git-%s",
 		 argv[i]);
 
-	if (access(git_command, X_OK))
-		usage(exec_path, "'%s' is not a git-command", argv[i]);
-
 	/* execve() can only ever return if it fails */
 	execve(git_command, &argv[i], envp);
-	fprintf(stderr, "git: '%s': %s\n", git_command, strerror(errno));
+        if ( ENOENT == errno )
+		usage(exec_path, "'%s' is not a git-command", argv[i]);
+        else
+		fprintf(stderr, "git: '%s': %s\n", git_command, strerror(errno));
 
 	return 1;
 }
-- 
0.99.9.GIT


------=_Part_54024_23064588.1133441315264--
