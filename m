From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 17:47:58 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>  <alpine.LSU.1.00.0802202221130.17164@racer.site>  <7v4pc316gq.fsf@gitster.siamese.dyndns.org> <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 02:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS0Yj-0002lX-Nm
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 02:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbYBUBsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 20:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbYBUBsj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 20:48:39 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52890 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752060AbYBUBsi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2008 20:48:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1L1lwvW021487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Feb 2008 17:48:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1L1lwJv032757;
	Wed, 20 Feb 2008 17:47:58 -0800
In-Reply-To: <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.238 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74586>



On Wed, 20 Feb 2008, Jay Soffian wrote:

> On Wed, Feb 20, 2008 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >  In either case, I think a good approach to take is to find a
> >  wording that conveys the notion "I will use A to mean what some
> >  other people might call B or C" unambiguously.
> 
> [url A]
>   other_people_call_it = B
>   other_people_call_it = C
> 
> [local_url A]
>   external_url = B
>   external_url = C

Well, realistically, what's really the use of this?

The only really sane use of this is the one that Daniel started out with: 
you may have a "external" representation of a name, but for your own 
purely local configuration reasons, you may want to map that name into 
another one that works for you.

The reason may be some local protocol issue: let's say that you see all 
these pointers to git://git.kernel.org/ flying around, because that is the 
official home of the git repository itself, but you work at a company that 
has a firewall that doesn't let git through. So you want to still *use* 
those names that other people use, but you want to remap them through some 
proxy server (or a local cache), or just to use ssh instead.

So it's generally *not* that it's an "alias" for another site, since it 
isn't that in general - it may just be a very local configuration thing. 
It's also not really that you would call it one thing and others would 
call it another thing: you want to call it the *same* thing as others call 
it, but you want to work around some specific site issue (or just use a 
cache that is closer without having to think about it).

So I think it really boils down to the fact that you want to "rewrite" the 
thing. Not aliases, not "also known as", but you're logically really 
looking for something like 

	[access "git://git.kernel.org/*"]
		proxy = proxy-program
		url = "ssh://master.kernel.org/*"

which admittedly looks rather strange too, but at the same time it does 
make sense from a "what do we really want to do?" standpoint.

Of course, in this case Daniel didn't actually do that "proxy" part, but I 
think the argument that we should try to make the config file syntax 
describe what the user wants to do is still very true. So skip that 
"proxy" part (maybe somebody wants to do that too some day), and leave the 

	[access "original"]
		url = "rewritten"

kind of syntax.

(And no, I'm not at all married to the "access" and "url" parts - I don't 
care. I'm just saying that syntax should be tied to what people want to 
do, not anything else.

				Linus
