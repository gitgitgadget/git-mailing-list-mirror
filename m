From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep
 files?
Date: Wed, 14 May 2008 13:36:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805141333050.3019@woody.linux-foundation.org>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local> <alpine.LFD.1.10.0805121527550.23581@xanadu.home> <20080512202414.GA8620@mithlond.arda.local> <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org> <20080513001252.GB29038@spearce.org>
 <alpine.LFD.1.10.0805132005550.23581@xanadu.home> <7vy76dperf.fsf@gitster.siamese.dyndns.org> <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de> <alpine.LFD.1.10.0805141247560.3019@woody.linux-foundation.org> <alpine.LFD.1.10.0805141314440.3019@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805141626070.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Juergen Ruehle <j.ruehle@bmiag.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 14 22:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNkv-0002VS-Sf
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbYENUi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 16:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYENUi0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:38:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57380 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751577AbYENUiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 16:38:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4EKafCr016684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 May 2008 13:36:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4EKadB2019604;
	Wed, 14 May 2008 13:36:40 -0700
In-Reply-To: <alpine.LFD.1.10.0805141626070.23581@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.42 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82147>



On Wed, 14 May 2008, Nicolas Pitre wrote:

> On Wed, 14 May 2008, Linus Torvalds wrote:
> 
> > Of course, the more aggressively we prune, the more we end up having to 
> > depend on the fact that a commit that is in a pack that is marked "keep" 
> > must *always* have everything that leads to it in that pack or others also 
> > marked "keep". We effectively have that already (because we've always 
> > pruned away the commits early), but it's a thing to keep in mind whenever 
> > we prune even more aggressively.
> 
> I wonder if this is a good thing.  Such a rule would effectively put 
> restrictions on how objects like big blobs could be distributed amongst 
> many .keep packs.  I just wish we're not painting ourselves in a corner.

You can distribute big objects arbitrarily among many .keep packs, but 
what you can *NOT* do (and which has _always_ been a bug to do) is to have 
a *.keep pack that refers to objects that are not in a .keep pack!

So keep<->keep you can do anything you want, and distribute objects any 
way.

But a keep pack must only refer to objects in itself or in other keep 
packs.

Because otherwise, if we ever hit an object in a keep pack, we'll stop 
even looking further when we use --unpacked. And that has always been true 
(admittedly only for "commit" objects, but those are the ones that most 
commonly refer to other objects, so ..)

			Linus
