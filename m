From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 14:41:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231428230.2926@woody.linux-foundation.org>
References: <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:43:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtp3-00011j-RZ
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbYFWVmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYFWVmm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:42:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40965 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224AbYFWVml (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 17:42:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NLffch009097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 14:41:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NLfeBb017696;
	Mon, 23 Jun 2008 14:41:41 -0700
In-Reply-To: <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.844 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85939>



On Mon, 23 Jun 2008, Linus Torvalds wrote:
> 
> Trust me, you need what I wrote. Something that parses all the options in 
> one go, and ignores the ones it cannot parse, because a TOTALLY DIFFERENT 
> function than the caller will call it!

Side note: of course you can always just queue them up yourself, and then 
pass those off to the later stage. But where do you queue them? Can you 
re-use argv[]? If so, what's the difference with the simpler patch that I 
already posted? (simpler both from a usage standpoint _and_ from a patch 
size standpoint).

That said, I *really* don't care what the end result is, but I would 
strongly urge people to actually look at what existing code does. That 
includes at a minimum builtin-blame.c, but also all the existing users 
where _most_ of the arguments are just trivial. builtin-apply.c is a great 
example of something where it's almost all trivial, but a lot of the 
options set more than one value.

The guiding light here should not be how pretty or clean option-parse.c 
is, but how easy it is to convert the hundreds of existing options that 
haven't been converted yet. And a lot of them haven't been converted 
because it's currently very painful to do multi-valued things, even if 
most of those values really are pretty simple.

In that vein - maybe it would be a good idea to allow multiples of the 
same option, so that things like builtin-apply.c can handle the "-p" 
option (to give an example of this behaviour) as a set of TWO options that 
do

	OPT_INTEGER('p', NULL, &p_value, "Patch depth"),
	OPT_BOOLEAN('p', NULL, &p_value_known),

where "-p3" would then trigger on both, once setting "p_value" to 3, and 
once setting p_value_known to 1.

I dunno. But _this_ is the real problem with parse-options.c. It's hard to 
convert existing really simple parsers. Whether the problem is writing a 
sane set of rules for it without using callbacks (callbacks are neither 
easy nor clean), or whether the problem is that the parsing is done in 
multiple different places..

			Linus
