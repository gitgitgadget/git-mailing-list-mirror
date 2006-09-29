From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 22:58:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609282252430.3952@g5.osdl.org>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org> <7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281458420.3952@g5.osdl.org> <7vr6xvp7jm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 07:58:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTBO8-0001Xv-3F
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 07:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWI2F6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 01:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWI2F6Q
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 01:58:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932130AbWI2F6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 01:58:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8T5wBnW031017
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 22:58:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8T5wBN0005592;
	Thu, 28 Sep 2006 22:58:11 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6xvp7jm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28089>



On Thu, 28 Sep 2006, Junio C Hamano wrote:
> 
> This is simply too clever; -pedantic does not like assignment of
> arg to end (constness -- and strtoul takes pointer to non-const
> char *, so making the type of end const char * is not an answer
> either).

The _code_ really is right. The problem is "strtoul()" interfaces and a 
C typing oddity.

> And I do not like casting constness away: end = (char *) arg.

You could fix it by doing something like this:

	static inline unsigned long sane_strtoul(const char *n,
						 const char **p,
						 int base)
	{
		char *end;
		unsigned long res;

		res = strtoul(n, &end, base);
		*p = end;
		return res;
	}

because the only reason strtoul() warns now is that C type-rules don't 
allow the (obviously safe - but pointers migth have strange 
representations) conversion of "char **" into "const char **", even though 
"char *" can be converted into "const char *".

At that point, the cast is probably simpler, but the above should be 
strictly correct pedantic ANSI C.

I didn't even try it, though.

			Linus
