From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 15:05:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901021500530.3179@localhost.localdomain>
References: <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost> <20090102105856.GB14691@localhost>
 <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain> <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain> <20090102193904.GB9129@coredump.intra.peff.net> <20090102195053.GA10876@coredump.intra.peff.net>
 <20090102205208.GA9273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 03 00:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIt6p-0001fr-SQ
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 00:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbZABXFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 18:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbZABXFy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 18:05:54 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51779 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbZABXFx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 18:05:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02N5Fcg008447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Jan 2009 15:05:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02N5CUO014599;
	Fri, 2 Jan 2009 15:05:12 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090102205208.GA9273@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.931 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104443>



On Fri, 2 Jan 2009, Jeff King wrote:
> 
> Here's another interesting one: d592b315. The commit removes dashes
> from git commands in test scripts. Git says:
> 
>         echo "tag-one-line" >expect &&
> -       git-tag -l | grep "^tag-one-line" >actual &&
> +       git tag -l | grep "^tag-one-line" >actual &&
>         test_cmp expect actual &&
> -       git-tag -n0 -l | grep "^tag-one-line" >actual &&
> +       git tag -n0 -l | grep "^tag-one-line" >actual &&
>         test_cmp expect actual &&
> -       git-tag -n0 -l tag-one-line >actual &&
> +       git tag -n0 -l tag-one-line >actual &&
>         test_cmp expect actual &&
> 
> whereas patience says:
> 
>         echo "tag-one-line" >expect &&
> -       git-tag -l | grep "^tag-one-line" >actual &&
> -       test_cmp expect actual &&
> -       git-tag -n0 -l | grep "^tag-one-line" >actual &&
> -       test_cmp expect actual &&
> -       git-tag -n0 -l tag-one-line >actual &&
> +       git tag -l | grep "^tag-one-line" >actual &&
> +       test_cmp expect actual &&
> +       git tag -n0 -l | grep "^tag-one-line" >actual &&
> +       test_cmp expect actual &&
> +       git tag -n0 -l tag-one-line >actual &&
>         test_cmp expect actual &&

Yeah, the bazaar version clearly is inferior here. But again, I don't 
think that's actually a patience diff issue, I think it's because the 
bazaar diff has merged consecutive diff lines too aggressively.

I suspect both patience and the straight Mayers diff (that git uses) 
actually finds exactly the same differences, and then bazaar has a "merge 
closeby -/ pairs together if there is just a single unmodified line in 
between them". 

And _that_ is where it should care whether the unmodified line is complex 
or not. If it's complex, you shouldn't merge it into the -/+ region.

(but yes, it's possible that the bazaar diff uses "uniqueness" as a 
complexity analysis marker, and while that is somewhat valid, it is _not_ 
valid enough to be useful. Unique lines tend to be complex, but complex 
lines are _not_ always unique)

		Linus
