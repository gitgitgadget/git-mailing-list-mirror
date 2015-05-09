From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: t0005-signals.sh fails with ksh
Date: Sat, 09 May 2015 10:20:18 +0200
Message-ID: <m2h9rmupq5.fsf@linux-m68k.org>
References: <31108626.20150508231514@gmail.com>
	<xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
	<20150508205548.GB13457@peff.net> <20150508211453.GA11594@peff.net>
	<xmqqk2wiiwa3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, evgeny <illumsoft.org@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 10:20:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqzzy-0007cn-IS
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 10:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbbEIIUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 04:20:33 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50737 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbbEIIU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 04:20:28 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3lkM0S716cz3hhYS;
	Sat,  9 May 2015 10:20:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3lkM0S64tXzvh2V;
	Sat,  9 May 2015 10:20:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id PUNi3MgWnehN; Sat,  9 May 2015 10:20:22 +0200 (CEST)
X-Auth-Info: aelqPowWBzL5IQ7Ye/g5CaZNMBtV77fwdsjCkj49VRJLFEpInoEp8LRpdv+c67O2
Received: from linux.local (ppp-93-104-92-148.dynamic.mnet-online.de [93.104.92.148])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  9 May 2015 10:20:22 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 420AF1E57DC; Sat,  9 May 2015 10:20:19 +0200 (CEST)
X-Yow: What PROGRAM are they watching?
In-Reply-To: <xmqqk2wiiwa3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 May 2015 14:39:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268699>

Junio C Hamano <gitster@pobox.com> writes:

> That is fun.  And doing
>
>     $ mkdir -p git/objects
>
> just before you create and chdir into subdir does tell me that the
> last "cd ../.git/objects" is turned into "cd ../git/objects".

This has been fixed in ksh93v.  Looking at the diff between openSUSE
13.1 and 13.2 version of ksh, this hunk from
src/cmd/ksh93/bltins/cd_pwd.c is responsible:

@@ -109,34 +155,22 @@
 		if(!oldpwd)
 			oldpwd = path_pwd(shp,1);
 	}
-	if(*dir=='.')
+	if(dirfd==shp->pwdfd && *dir!='/')
 	{
-		/* test for pathname . ./ .. or ../ */
-		int	n=0;
-		char	*sp;
-		for(dp=dir; *dp=='.'; dp++)
-		{
-			if(*++dp=='.' && (*++dp=='/' || *dp==0))
-				n++;
-			else if(*dp && *dp!='/')
-				break;
-			if(*dp==0)
-				break;
-		}
-		if(n)	
-		{
-			cdpath = 0;
-			sp = oldpwd + strlen(oldpwd);
-			while(n--)
-			{
-				while(--sp > oldpwd && *sp!='/');
-				if(sp==oldpwd)
-					break;
-				
-			}
-			sfwrite(shp->strbuf,oldpwd,sp+1-oldpwd);
-			sfputr(shp->strbuf,dp,0);
-			dir = sfstruse(shp->strbuf);
+		/* check for leading .. */
+
+		char *cp;
+
+		j = sfprintf(shp->strbuf,"%s",dir);
+		cp = sfstruse(shp->strbuf);
+		pathcanon(cp, j + 1, 0);
+		if(cp[0]=='.' && cp[1]=='.' && (cp[2]=='/' || cp[2]==0))
+		{
+			if(!shp->strbuf2)
+				shp->strbuf2 = sfstropen();
+			j = sfprintf(shp->strbuf2,"%s/%s",oldpwd,cp);
+			dir = sfstruse(shp->strbuf2);
+			pathcanon(dir, j + 1, 0);
 		}
 	}
 	rval = -1;


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
