From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revamping the git protocol
Date: Thu, 20 Oct 2005 09:20:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510200910160.3369@g5.osdl.org>
References: <43571DA1.6030907@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 18:22:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESd9O-0001Th-Lg
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 18:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVJTQUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJTQUO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 12:20:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932412AbVJTQUN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 12:20:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9KGKBFC016193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 09:20:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9KGK9Ru028775;
	Thu, 20 Oct 2005 09:20:10 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43571DA1.6030907@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10367>



On Wed, 19 Oct 2005, H. Peter Anvin wrote:
> 
> 1. "Strings" are sequences of bytes prefixed with a length.  The length is
> encoded as four lower-case hexadecimal digits.  [Why not as 2 or 4 bytes of
> network byte order binary?]  When represented in this text as "foo", this
> means the sequence of bytes on the wire is <0003foo>.

As a reason for your "why" - imagine debugging a protocol using telnet..

ASCII really is very nice for things like that.

And no, "foo" is not represented as <0003foo>. It's represented as 
<0007foo>, because the length includes the length of the prefix.

The special sequence <0000> is a flush sequence, and it's designed so that 
it's supposed to be distinguishable from an empty string <0004>. A <0001> 
to <0003> will be rejected as an error. Maximum string length is thus 
65531.

(Actually, right now flush it is _not_ distinguishable from an empty 
string because we return 0 for both cases from packet_read_line(), but the 
point being that the packet protocol _supports_ it being distinguishable 
if we ever need it to).

			Linus
