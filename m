From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 15:58:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 01:00:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96dR-0005IZ-NI
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbYFRW7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYFRW7K
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:59:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54742 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810AbYFRW7J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 18:59:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMwERs019222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 15:58:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMwDYE025185;
	Wed, 18 Jun 2008 15:58:13 -0700
In-Reply-To: <20080618224919.GA22599@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.853 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85421>



On Wed, 18 Jun 2008, Jeff King wrote:
> 
> Maybe it would be easier still to read (and unmeasurably more efficient)
> to actually do it like:
> 
>         if (!prefixcmp(var, "core."))
>                 return git_default_core_config(var+5, value);

I considered it, but I think that screws up error reporting (ie if some 
value is unparseable, it would then print out the wrong variable name).

It would also have made the patches much less obvious. So it's a "future 
enhancement" thing.

> I was curious a while ago and instrumented git_config to write the PID
> to a tempfile each time it was called. Most git programs parse the
> config files (.git/config, ~/.gitconfig, /etc/gitconfig) three times
> each, with some doing it as many as five times.

Yeah, I know. I love the config file format (quite frankly, anybody who 
thinks XML and friends are sane is a total moron and should be shot before 
they reproduce), but the whole parsing code was a really quick hack. 

I've several times wanted to rewrite it so that it does something smarter 
(parse it once, save it in a nice data structure), but let's face it, the 
upside is rather small. So I've never really ended up having the energy.

> Then we could do useful things like say "you specified core.foobar, but
> there is no such variable."

No. We could already do that (just add it to the end of 
git_default_core_config - it should be called last even if there was a 
chain), but avoid doing that very much on purpose.

Why? Because it's really irritating to have a parser that complains about 
newer values (or old deprecated ones) that don't matter for that version 
of the program. 

			Linus
