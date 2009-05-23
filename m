From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: patch for git-daemon base-path trailing '/' problem
Date: Sat, 23 May 2009 21:03:18 +0530
Message-ID: <f662f0210905230833p781d8e7ck77a40b4cd58a799d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 17:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7tFJ-0006zx-95
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 17:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbZEWPei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 11:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZEWPeh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 11:34:37 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:58745 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbZEWPeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 11:34:37 -0400
Received: by gxk10 with SMTP id 10so4210797gxk.13
        for <git@vger.kernel.org>; Sat, 23 May 2009 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=YdABNYktZeeeoud8eRvIQ6jvOSuzLycoaZxleM7QDdg=;
        b=a5j1q8UC239Axv2W1J3HAQMvrndSsB9ClfD0H9tVxzVTrBtApE1dVNMhtcGS3OD23M
         l6Hu5gjdo07gdgfXQMIxhh+fe2cUivqFTJtA2u7v0gjL564GUkXY1h0sJnRCgypuSjZ6
         xv1EumqA1s5/uzDty6iLZ54jPFpRDm6+GQ1Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=fNtP18KNkNORgyg+aX5byINjbNYGTtTG26FprV7wrfBRpybVln2Ivo+iN8+4n6WyvD
         q8hIPnfMtS8rXmOtApKHR35JxC2pVHGndMWY235c3juD/f/41a68UayFIak1Hnl3iT1J
         x9hNJe22si2XM7N+p/CbDexfKkyKB4QkgoRho=
Received: by 10.151.74.4 with SMTP id b4mr10048428ybl.161.1243092878008; Sat, 
	23 May 2009 08:34:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119778>

Hi All,

I was trying to setup git-daemon on our server with the following args :

git-daemon --base-path=/git_repo/ --export-all --syslog --inetd
--verbose /git_repo/external_repos/

There are two git repos in /git_repo/external_repos/ :-
linux-test/.git and linux-release/.git

When I try to clone the linux-test/.git repo using :
git clone 192.168.1.100/external_repos/linux-test

I get an error at the server side from git-daemon saying that
"/git_repo//external/repos/linux-test/.git not in whitelist".

The problem is because fo the trailing '/' in base-path in git-daemon
args. I think it might be fairly common that a person might add a '/'
at the end of base-path. The following patch takes care of this
trailing patch :


diff --git a/daemon.c b/daemon.c
index daa4c8e..cd4dfed 100644
--- a/daemon.c
+++ b/daemon.c
@@ -209,11 +209,15 @@ static char *path_ok(char *directory)
                dir = interp_path;
        }
        else if (base_path) {
+    int base_pathlen;
                if (*dir != '/') {
                        /* Allow only absolute */
                        logerror("'%s': Non-absolute path denied (base-path acti
                        return NULL;
                }
+    base_pathlen = strlen(base_path);
+    if(base_path[base_pathlen-1]=='/')
+      base_path[base_pathlen-1]='\0';
                snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
                dir = rpath;
        }
@@ -229,7 +233,7 @@ static char *path_ok(char *directory)
        }


---------------------------------------
Regards,
Aneesh Bhasin
