From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 16:52:32 +0200
Message-ID: <20050417145232.GA5289@elte.hu>
References: <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org> <1113559330.12012.292.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org> <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz> <20050416155536.GX4488@himi.org> <20050416160333.GF19099@pasky.ji.cz> <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 16:49:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNB5k-0000aR-ON
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 16:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVDQOx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 10:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVDQOx2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 10:53:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26290 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261322AbVDQOxU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 10:53:20 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 9076A31E630;
	Sun, 17 Apr 2005 16:51:56 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 30E9C1FC2; Sun, 17 Apr 2005 16:52:36 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Almost all attacks on sha1 will depend on _replacing_ a file with a 
> bogus new one. So guys, instead of using sha256 or going overboard, 
> just make sure that when you synchronize, you NEVER import a file you 
> already have.

here is a bit complex, but still practical attack that doesnt rely on 
replacement and which can only be detected if we check the sha1 
uniqueness assumptions.

If you can generate a duplicate sha1 key for an arbitrary 'target' file, 
and Malice sends you a GIT-generated patch that introduces a new file 
(which doesnt exist in the current tree) which you review (in the email) 
and which looks safe to apply & harmless. Maybe the patch has a bit 
weird formatting and some weird comments (which in reality Malice used 
to generate the proper sha1 key) but otherwise the patch is for some 
seldom used arcane driver that no-one used for quite some time and 
no-one really cares about, so you are happy to apply the patch.

The compromise occurs when you apply the patch: the seemingly harmless 
patch has an sha1 key that Malice manufacured to match that of an 
already existing, 'dangerous' object in your database.

With tens of thousands (or hundreds of thousands) of objects expected in 
the repository sooner or later, there's quite a selection to pick from.  
Once you apply the patch, instead of the expected new file that you 
reviewed and found safe, the attacker has the other object included in 
the official kernel.

A dangerous object can be anything: e.g. a debugging hack that allows 
arbitrary kernel-space writes. Or a known-insecure module (which since 
then got fixed, but the buggy code still exists in the DB). The module 
is in a single file and is self-installing (e.g. it has __init code to 
register itself as some driver.)

Malice might even previously plant a dangerous object as some 'firmware 
module' in another arcane driver, which doesnt get compiled by default, 
but still shows up in the DB. Or Malice might plant a dangerous object 
via an innocent-looking documentation file.  (which contains some sample 
code and is called sample.txt)

this type of 'false sharing attack' can only be prevented if an object 
is only 'shared' with another object if it has been memcmp-ed with the 
object in the repository. I.e. if we trust the sharing decision! Once 
the attack has occured it cannot be detected automatically: only people 
will notice it. (why did that weird unrelated module show up in that old 
driver?)

The compromise relies on you having reviewed something harmless, while 
in reality what happened within the DB was far less harmless. And the DB 
remains self-consistent: neither fsck, nor others importing your tree 
will be able to detect the compromise. This attack can only be detected 
when you apply the patch, after that point all the information (except 
Malice's message in your inbox) is gone.

so unless we actively check for collisions, once an sha1 key can be 
generated at will on near-arbitrary input, it's not a secure system 
anymore. We might be lucky and safe, but we wont be secure.

	Ingo
