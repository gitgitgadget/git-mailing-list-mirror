From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 15:00:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com>
 <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419214009.GA25681@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO0fb-00029W-5L
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 23:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVDSV6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 17:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVDSV6N
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 17:58:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:43446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261674AbVDSV6I (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 17:58:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JLw6s4021325
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 14:58:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JLw5Tr002012;
	Tue, 19 Apr 2005 14:58:06 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050419214009.GA25681@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Greg KH wrote:
> 
> It looks like your domain name isn't set up properly for your box (which
> is why it worked for you, but not me before, causing that patch).

No, I think it's a bug in your domainname changes. I don't think you
should do the domainname at all if the hostname has a dot in it.

Most machines I have access to (and that includes machines that are
professionally maintained, not just my own cruddy setup) says "(none)" to
domainname and have the full hostname in hostname.

And even the ones that use domainname tend to not have a fully qualified 
DNS domain there. You need to use dnsdomainname to get that, and I don't 
even know how to do it with standard libc.

So how about something like this?

(Somebody who actually knows how these things should be done - please feel 
free to pipe up).

		Linus

---
commit-tree.c: 54b636ee1edf596dae1cb9a756eaccdfd5127cef
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -317,8 +317,10 @@ int main(int argc, char **argv)
 	memcpy(realemail, pw->pw_name, len);
 	realemail[len] = '@';
 	gethostname(realemail+len+1, sizeof(realemail)-len-1);
-	strcat(realemail, ".");
-	getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
+	if (!strchr(realemail+len+1, '.')) {
+		strcat(realemail, ".");
+		getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
+	}
 	time(&now);
 	tm = localtime(&now);
 
