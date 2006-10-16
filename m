From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 09:36:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610160932100.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVRm-0005x9-Gl
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWJPQgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWJPQgK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:36:10 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17123 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1161016AbWJPQgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 12:36:08 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F5294> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 09:36:06 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28968>

On Mon, 16 Oct 2006, Linus Torvalds wrote:

> On Mon, 16 Oct 2006, Linus Torvalds wrote:
> > 
> > But it could certainly also be that you just broke the diffs entirely, so 
> > I would like to wait for Davide to comment on your diff before Junio 
> > should apply it. 
> 
> I think you broke it. 
> 
> If the "&& vs ||" makes a difference (and it clearly does), that implies 
> that you have lots of different hash values on the same hash chain, and 
> you end up considering those _different_ hash values to be all equivalent 
> for the counting, even though they obviously aren't.
> 
> I think the real problem is that with big input, the hash tables are too 
> small, making the hash chains too long - even though the values on the 
> chains are different (ie we're not hashing different records with the same 
> hash value over and over again - if that was true, the "&& vs ||" change 
> wouldn't make any difference).
> 
> So I think xdiff has chosen too small a hash. Can you try what happens if 
> you change xdl_hashbits() (in xdiff/xutil.c) instead? Try making it return 
> a bigger value (for example, by initializing "bits" to 2 instead of 0), 
> and see if that makes a difference.

I think the xdl_hashbits() picks up the hash table size "almost" 
correctly. I think we're looking at some bad hash *collisions* (not 
records with same hash value, that'd be stopped by the mlim check). 
Send me the files and I'll take a look ...




> But again, I'm not actually all _that_ familiar with the libxdiff 
> algorithms, _especially_ the line-based ones (I can follow the regular 
> binary delta code, but the line-based one just makes my head hurt). So 
> take anything I say with a pinch of salt.

That's my revenge on myself having to follow your code in the kernel  :D




- Davide
