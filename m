From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Tue, 13 May 2008 23:43:16 -0700
Message-ID: <7vy76dperf.fsf@gitster.siamese.dyndns.org>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
 <20080512202414.GA8620@mithlond.arda.local>
 <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org>
 <20080513001252.GB29038@spearce.org>
 <alpine.LFD.1.10.0805132005550.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 14 08:44:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwAjD-0008JY-1l
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 08:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbYENGn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 02:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbYENGn3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 02:43:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbYENGn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 02:43:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BDF213DF6;
	Wed, 14 May 2008 02:43:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C0D963DF1; Wed, 14 May 2008 02:43:19 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805132005550.23581@xanadu.home> (Nicolas
 Pitre's message of "Tue, 13 May 2008 21:03:31 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E6F3274-2181-11DD-8E96-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82079>

Nicolas Pitre <nico@cam.org> writes:

> Let's see what happens here even before any packing is attempted
>
> |$ git rev-list --objects 492c2e4..9404ef0
> |362
> |
> |$ git rev-list --objects --all \
> |   --unpacked=pack-6a3438b2702be06697023d80b77e67a73a0b0b5c.pack |
> |	wc -l
> |26559
>
> So this --unpacked= argument (which undocumented semantics I still have 
> issues with) is certainly not doing what is expected.

The output from rev-list is not surprising.  --unpacked=$this.pack implies
the usual --unpacked behaviour (i.e. only show unpacked objects by not
traversing into commits that are packed) and at the same time pretends
that objects in $this.pack are loose.

It was meant to be used for a partial incremental repacking.  If you have
a pack to be kept (perhaps a highly packed deep pack that holds the
earlier parts of the history), marked with .keep, and a handful young
packs, you would give these young ones with --unpacked, so that the
resulting single pack contains all that are loose or in these young
packs.  After that, you can remove all the young packs and loose objects.

At least that is the idea.

I am not sure where that rev-list experiment you showed fits in the bigger
picture, but if that is used for repacking the young packs, perhaps the
issue is that after the repacking the code forgets to remove the young
ones whose objects are now moved into the new pack?
