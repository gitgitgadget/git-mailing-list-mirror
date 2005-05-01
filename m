From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 13:46:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011337070.2296@ppc970.osdl.org>
References: <Pine.LNX.4.21.0505011544120.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 22:38:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSLDE-00019u-Ue
	for gcvg-git@gmane.org; Sun, 01 May 2005 22:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVEAUot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 16:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVEAUot
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 16:44:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:17597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262670AbVEAUop (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 16:44:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41Kics4028745
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 13:44:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41KibEv029492;
	Sun, 1 May 2005 13:44:37 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505011544120.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Daniel Barkalow wrote:
> 
> Right; what I want to make programs able to do is take explicit
> references, instead of only taking the objects they reference. So you
> say heads/master or heads/linus instead of
> "198b0fb635ed8a007bac0c16eab112c5e2c7995c".

That's fine. 

This is really just an issue of havign a function that does "get_sha1()", 
and then making the things that take command line arguments use that 
one instead of "get_sha1_hex()".

Then you can have rules like:
 - if it's a hex number, take it
 - if it's a filename,  look it up
 - if ".git/refs + str is a filename, look it up.

Something like

	int get_sha1(char *str, unsigned char *result)
	{
		static char pathname[PATH_MAX];

		if (get_sha1_hex(str, result) == 0)
			return 0;
		if (get_sha1_file(str, result) == 0)
			return 0;
		snprintf(pathname, sizeof(pathname), ".git/refs/%s", str);
		if (get_sha1_file(pathname, result) == 0)
			return 0;
		...
	}

where you have

	int get_sha1_file(char *path, unsigned char *result)
	{
		char buffer[60];
		int fd = open(path, O_RDONLY);
		int len;

		if (fd < 0)
			return -1;
		len = read(fd, buffer, sizeof(buffer));
		close(fd);
		if (len < 40)
			return -1;
		return get_sha1_hex(buffer, result);
	}
			
or whatever.

The _only_ thing I want to be careful about is that all the _internal_
stuff still have to use the strict "get_sha1_hex()" function, ie we should
never _ever_ accept a tree object where the "sha1" ends up being anything
but the hex thing. So this "generalized get_sha1()" would have to be used 
only on real user input (ie argv[] array and the like).

		Linus
