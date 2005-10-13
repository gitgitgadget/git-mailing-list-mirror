From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 08:04:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510130756550.15297@g5.osdl.org>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com>
 <7vachd6hdx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 17:08:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ4dP-0002Fz-ER
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 17:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbVJMPEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbVJMPEk
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 11:04:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751571AbVJMPEj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 11:04:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DF4I4s004329
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 08:04:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DF4H1f019436;
	Thu, 13 Oct 2005 08:04:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vachd6hdx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10075>



On Wed, 12 Oct 2005, Junio C Hamano wrote:
> 
> Huh?  isspace is "int isspace(int)".  Presumably standard
> integral promotion rules applies here whether char is signed or
> unsigned, doesn't it?

No.

The input range for the "isxxxxx()" macros is the same as the range for 
the "[f]getc[h]()" family: unsigned char + EOF (the latter usually being 
-1).

So Morten is right - if you have a "char *", it should not be dereferenced 
and used directly, although I think glibc does the right thing (and, in 
fact, I can't understand why the standards haven't been updated to do the 
right thing: it's _not_ that hard. In fact, it should be trivial apart 
from the special case of "255" that looks undistinguishable from EOF in 
signed char representation).

I'm almost goign to suggest that we do our own ctype.h, just to get the 
sane semantics: we want locale-independence, _and_ we want the right 
signed behaviour. Plus we only use a very small subset of ctype.h anyway 
(isspace, isalpha, isdigit and isalnum).

			Linus
