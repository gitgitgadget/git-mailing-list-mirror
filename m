From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 09:12:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:13:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZV5H-0000pL-UF
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWJPQMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbWJPQMw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:12:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422711AbWJPQMu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 12:12:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GGCeaX005175
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 09:12:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GGCabL018434;
	Mon, 16 Oct 2006 09:12:38 -0700
To: Jim Meyering <jim@meyering.net>,
	Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28965>



On Mon, 16 Oct 2006, Linus Torvalds wrote:
> 
> But it could certainly also be that you just broke the diffs entirely, so 
> I would like to wait for Davide to comment on your diff before Junio 
> should apply it. 

I think you broke it. 

If the "&& vs ||" makes a difference (and it clearly does), that implies 
that you have lots of different hash values on the same hash chain, and 
you end up considering those _different_ hash values to be all equivalent 
for the counting, even though they obviously aren't.

I think the real problem is that with big input, the hash tables are too 
small, making the hash chains too long - even though the values on the 
chains are different (ie we're not hashing different records with the same 
hash value over and over again - if that was true, the "&& vs ||" change 
wouldn't make any difference).

So I think xdiff has chosen too small a hash. Can you try what happens if 
you change xdl_hashbits() (in xdiff/xutil.c) instead? Try making it return 
a bigger value (for example, by initializing "bits" to 2 instead of 0), 
and see if that makes a difference.

But again, I'm not actually all _that_ familiar with the libxdiff 
algorithms, _especially_ the line-based ones (I can follow the regular 
binary delta code, but the line-based one just makes my head hurt). So 
take anything I say with a pinch of salt.

		Linus
