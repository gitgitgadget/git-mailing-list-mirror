From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick question
Date: Mon, 13 Feb 2006 08:54:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602130848220.3691@g5.osdl.org>
References: <43F0B577.4070608@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 17:55:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8gyR-0001Zl-SR
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 17:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBMQyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWBMQyt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 11:54:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932120AbWBMQys (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 11:54:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1DGsWDZ010311
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 08:54:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1DGsVVY026558;
	Mon, 13 Feb 2006 08:54:31 -0800
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <43F0B577.4070608@gorzow.mm.pl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16077>



On Mon, 13 Feb 2006, Radoslaw Szkodzinski wrote:
>
> How to display ignored files of the whole project using only core git?
> 
> I've tried:
> 
> git-ls-files -o -i -X .git/info/exclude
> 
> and it only showed me the excluded files in the current directory...

Well, since you're telling it to only show excluded files, it will also 
only show excluded directories.

Which is admittedly insane. You don't want to exclude directories. Or 
maybe you do, but then we should add the "/" to the end before we do the 
exclusion.

This patch (untested) will never exclude directories. Which may or may not 
be the right thing. 

Junio? Others? Comments?

		Linus

---
diff --git a/ls-files.c b/ls-files.c
index 7024cf1..b923f92 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -276,8 +276,6 @@ static void read_directory(const char *p
 				continue;
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
-			if (excluded(fullname) != show_ignored)
-				continue;
 
 			switch (DTYPE(de)) {
 			struct stat st;
@@ -304,6 +302,8 @@ static void read_directory(const char *p
 			case DT_LNK:
 				break;
 			}
+			if (excluded(fullname) != show_ignored)
+				continue;
 			add_name(fullname, baselen + len);
 		}
 		closedir(dir);
