From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 11:41:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161138140.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610161100070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 20:42:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZXPe-0004FY-9d
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWJPSmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWJPSmG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:42:06 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:22755 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422794AbWJPSmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 14:42:03 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F52F9> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 11:41:55 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161100070.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28983>

On Mon, 16 Oct 2006, Linus Torvalds wrote:

> On Mon, 16 Oct 2006, Linus Torvalds wrote:
> > 
> > So just making GR_PRIME be a bigger value on a 64-bit architecture would 
> > not have fixed it.
> 
> Side note: in _practice_ I think it would have fixed it. The "not mixing 
> in high bits" is not a real problem if the original hash-value has a good 
> distribution of bits, which I think we do have. So it's unclear whether we 
> even need any mixing in of bits at all, and it's possible that it would be 
> fine to just have
> 
> 	#define XDL_HASHLONG(v,b) ((unsigned long)(v) & ((1ul << (b))-1))
> 
> which is simpler than my patch.
> 
> I prefer the mixing in of high bits just because it can help if the 
> original hash was bad (or had a tendency to have patterns in the low bits, 
> which could be the case). But I'm not sure xdiff actually needs it in this 
> case.

ATM, I added AC_CHECK_SIZEOF(long) inside libxdiff's configure.in, and I 
have (inside xmacros.h):

#if SIZEOF_LONG == 4
#define GR_PRIME 0x9e370001UL
#else
#define GR_PRIME 0x9e37fffffffc0001UL
#endif

I'm also looking into streamlining the discard loop to reuse information 
collected during the context-setup phase ...




- Davide
