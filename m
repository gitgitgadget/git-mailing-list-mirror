From: Jeff King <peff@peff.net>
Subject: Re: expanding pack idx fanout table
Date: Tue, 9 Jul 2013 00:19:13 -0400
Message-ID: <20130709041913.GB27903@sigill.intra.peff.net>
References: <CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 06:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwPOb-0007ad-I8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 06:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab3GIETR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 00:19:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:35220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725Ab3GIETQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 00:19:16 -0400
Received: (qmail 1309 invoked by uid 102); 9 Jul 2013 04:20:32 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 23:20:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 00:19:13 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229905>

On Mon, Jul 08, 2013 at 08:54:24AM -0700, Shawn O. Pearce wrote:

> Has anyone studied the impact of converting the pack idx fanout table
> from 256 entries to 65536 entries?
> 
> Back of the envelope estimates for 3.1M objects in linux.git suggests
> a 2^16 fanout table would decrease the number of binary search
> iterations from ~14 to ~6. The increased table costs an extra 255 KiB
> of disk. On a 70M idx file this is noise.

No, I hadn't considered it, but I think your analysis is correct that it
would decrease the lookup cost. Having run "perf" on git a lot of times,
I do see find_pack_entry_one turn up as a noticeable hot spot, but
usually not more than a few percent.

Which kind of makes sense, because of the way we cache objects in
memory. If you are doing something like `rev-list --objects`, you are
going to do O(n) packfile lookups, but you end up doing _way_ more
lookups in the object hash. Not just one per tree entry, but one per
tree entry for each commit in which the entry was untouched.

I tried (maybe a year or so ago) to make the object hash faster using a
similar fan-out trick, but I don't remember it having any real impact
(because we keep our hash tables relatively collision free already). I
think I also tried a full prefix-trie, with no luck.

Obviously the exact results would depend on your workload, but in
general I'd expect the object hash to take the brunt of the load for
repeated lookups, and for non-repeated lookups to be dominated by the
time to actually access the object, as opposed to saving a few hashcmps.
That may change as we start using the pack .idx for more clever things
than simply accessing the objects, though (e.g., it might make a
difference when coupled with my commit cache patches).

-Peff
