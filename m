From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Fri, 31 Aug 2007 23:20:17 +0200
Message-ID: <85lkbrbdv2.fsf@lola.goethe.zz>
References: <20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
	<20070831160335.GA17761@coredump.intra.peff.net>
	<7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
	<20070831203250.GA19340@coredump.intra.peff.net>
	<Pine.LNX.4.64.0708312154530.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDuj-00023e-Le
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761489AbXHaVUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761554AbXHaVUW
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:20:22 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:43854 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751750AbXHaVUV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 17:20:21 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 92A6D302A56;
	Fri, 31 Aug 2007 23:20:20 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 806DA23D338;
	Fri, 31 Aug 2007 23:20:20 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-032.pools.arcor-ip.net [84.61.17.32])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 465968C469;
	Fri, 31 Aug 2007 23:20:20 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5AADD1D3DB8A; Fri, 31 Aug 2007 23:20:18 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0708312154530.28586@racer.site> (Johannes Schindelin's message of "Fri\, 31 Aug 2007 21\:57\:29 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4111/Fri Aug 31 17:25:39 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57214>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Aug 2007, Jeff King wrote:
>
>> On Fri, Aug 31, 2007 at 01:13:42PM -0700, Junio C Hamano wrote:
>> 
>> > If you set diff.autorefreshindex configuration variable, it
>> > squelches the empty "diff --git" output, and at the end of the
>> > command, it automatically runs "update-index --refresh" without
>> > even bothering the user.  In other words, with the configuration
>> > variable set, people who do not care about the cache-dirtyness
>> > do not even have to see the warning.
>> 
>> Nice. This is much more sane behavior, IMHO, and I think it should make 
>> everyone happy.
>
> I could even imagine that this will eventually become the standard 
> behaviour.
>
>> >  Same here.  This patch saw only very light testing, but I
>> >  personally think is a sane thing to do before 1.5.3 final.
>> 
>> Passes my light testing as well, but I have a feeling we just tested the
>> same things...;)
>> 
>> One question on the implementation (and remember that I am somewhat
>> ignorant of the structure of this part of the code, so the answer may be
>> "it's too ugly"): is there a good reason to refresh _after_ the diff?
>
> We do not need to do it always.  After the diff, we know if the
> index needs refreshing.  Before, we don't.

Hm.  At the moment where it is first noticed, it should be still
possible to start a refresh.  Is there a particular gain to be
expected?  One thing I could think of is that when using a pager, the
diff might often die of SIGPIPE before being able to refresh.

>> It seems like when we are looking through the working tree and
>> index the first time, we notice that the stat information doesn't
>> match; why can't we update it then? That would save an extra
>> working tree traversal.
>
> But that would be intrusive in the diff machinery IMHO.  It should
> stay as read-only as possible.

Hm.  Not sure where the gain is in that, if a refresh is done, anyway.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
