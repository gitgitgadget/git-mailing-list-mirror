From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Wed, 8 Aug 2012 00:31:10 +0200
Message-ID: <87393yz64x.fsf@thomas.inf.ethz.ch>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
	<1344263760-31191-1-git-send-email-pclouds@gmail.com>
	<7vehnjzzfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Thomas Gummerer" <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>, <mhagger@alum.mit.edu>,
	<robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 00:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SysL6-0004aE-AY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 00:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828Ab2HGWbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 18:31:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:58091 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932818Ab2HGWbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 18:31:20 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 8 Aug
 2012 00:31:16 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.208.44) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 8 Aug
 2012 00:31:16 +0200
In-Reply-To: <7vehnjzzfd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 Aug 2012 10:46:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.208.44]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203054>

Junio C Hamano <gitster@pobox.com> writes:

>> Then of course you need to split the second patch into several logical
>> patches again. We can drop _v5 suffix in read-cache-v5.c (I haven't
>> done that). When we add partial read/write for v5, we can add more
>> func pointers to index_ops and implement them in v2 (probably as no-op
>> or assertion)
>
> The index_ops abstraction is a right way to go, and I like it, but I
> think the split illustrated in this patch might turn out to be at
> wrong levels (and it is OK, as I understand this is a illustration
> of concept patch).
>
> For example, add_to_index() interface may be a good candidate to
> have in index_ops.  Because your in-core index may not be holding
> everything in a flat array, "find the location in the flat array the
> entry would sit, replace the existing one if there is any, otherwise
> insert" cannot be a generic way to add a new entry.  If you make the
> whole thing an abstract API entry point, a sparse implementation of
> the in-core index could still implement it without bringing the
> untouched and irrelevant parts of the index to core.
[...]
> I wish that the development of this topic was done more in a
> top-down direction, instead of bottom-up, so that it identified the
> necessary access patterns to the in-core index early and come up
> with a good set of abstract API first, and then only after that is
> done, came up with in-core and on-disk format to support the
> necessary operations.

I like the general idea, too, but I think there is a long way ahead, and
we shouldn't hold up v5 on this.

Thomas and me -- it was mostly my bad idea -- spent some time going
through all the loops that iterate over the index.  You can get some
taste of it with 'git grep ce_stage', mostly because many of them either
skip unmerged entries or specifically look for them.  There are subtle
differences between the loops on many points: what do they do when they
hit an unmerged entry?  Or a CE_REMOVED or CE_VALID one?

I gave up after treating half of them and horribly breaking the test
suite.  I suppose eventually we will have to classify these loops by
properties like how they treat unmerged entries, and replace them by
some clever for_each_cache_entry macro.

It would open some interesting possibilities.  For example, for v5 it
would be far better if conflicted and resolve-undo entries were a
property of the normal index entry, instead of something that so happens
to be consecutive entries and in a completely different place,
respectively.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
