From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Fri, 23 May 2014 23:45:36 +0200
Message-ID: <537FC180.9020503@alum.mit.edu>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com> <1400174999-26786-42-git-send-email-sahlberg@google.com> <537F67DD.5010101@alum.mit.edu> <20140523155353.GA4065@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 23:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnxHc-0002PH-Nw
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 23:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaEWVpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 17:45:40 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45548 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923AbaEWVpj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2014 17:45:39 -0400
X-AuditID: 1207440e-f79026d000000c25-ab-537fc18284d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 58.0A.03109.281CF735; Fri, 23 May 2014 17:45:38 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0E41.dip0.t-ipconnect.de [93.219.14.65])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4NLjaEu031188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 23 May 2014 17:45:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140523155353.GA4065@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqNt0sD7YYNMFMYuuK91MFm9vLmG0
	+DehxoHZY+esu+weCzaVenzeJBfAHMVtk5RYUhacmZ6nb5fAnbF8/3L2gheqFa8Xujcw/pLt
	YuTkkBAwkZj4cBYLhC0mceHeejYQW0jgMqPE+iNZXYxcQPY5Jomvy+6xgyR4BbQlJi+/zwhi
	swioSqzdNg+smU1AV2JRTzNTFyMHh6hAkMSfs4oQ5YISJ2c+ASsREdCQeP7pGxtICbOAncTb
	VwogYWGBPInOD11sEKv2M0p8bG8EG88poC9xZvN0sHoJAXGJnsYgkDCzgI7Eu74HzBC2vMT2
	t3OYJzAKzkKybRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3E
	CAllvh2M7etlDjEKcDAq8fAaHqgPFmJNLCuuzD3EKMnBpCTKm7YbKMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEl3cxUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCarwcEhcOXg
	kdmMUix5+XmpShK8d0F2ChalpqdWpGXmlCCUMnFwgizikhIpTs1LSS1KLC3JiAfFdHwxMKpB
	UjxAN0wFaectLkjMBYpCtJ5iVJQS5321HyghAJLIKM2DGwtLXK8YxYE+FuZ9C9LOA0x6cN2v
	gAYzAQ1+sbAWZHBJIkJKqoFxC3d4ZeC/Q95Rh//pv1Y321+hdmQ5x8t1D9cyPVNO4ONJKNCW
	sDeN/P4isuCer7eYnKwt96Lnq5LVCy8s/pH5mfWBdkn8vvhVKz6J1dZntX+YP3FK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250037>

On 05/23/2014 05:53 PM, Jonathan Nieder wrote:
> Hi,
> 
> Michael Haggerty wrote:
> 
>> The status quo is that we have a single reference back end consisting of
>> loose references sitting on top of packed references.
>>
>> But really, loose references and packed references are two relatively
>> independent reference back ends [1].  We just happen to use them layered
>> on top of each other.
>>
>> This suggests to me that our current structure is best modeled as two
>> independent reference back ends, with a third implementation of the same
>> reference API whose job it is to compose the first two.
> [...]
>> [1] Forget for the sake of this discussion that we can't store symbolic
>> references as packed refs.
> 
> I find it hard to forget that. ;-)  More to the point, the trouble
> with loose refs and packed refs as independent reference backends is
> that neither has very good performance characteristics.  Enumerating
> many loose refs is slow.  Adding a new packed ref to a large list is
> also slow.  Git currently uses both loose and packed refs in a way
> that allows each to overcome the limitations of the other, and the
> fact that it involves two on-disk data structures seems to me like an
> implementation detail of how it achieves that.

I'm not advocating that we use loose refs or packed refs alone.  But I
like the code decoupling that this implementation would (I predict) yield.

My main point was that pack-refs is not an integral part of the
reference API but rather a tuning feature very specific to the
loose/packed reference storage scheme.

> So I believe most git code should not have to know about the
> difference between loose and packed refs (or the upper and lower
> layer) to allow the details of the layering can be tuned in low-level
> ref handling code.
> 
> On the other hand, from a code structure perspective I can easily
> believe that implementing some subset (or maybe even all) of the
> reference backend API for loose refs and packed refs separately and
> providing a separate file describing how to compose them might be the
> cleanest way to write this code.  It's more general layering that
> seems to lie in the direction of madness.
> 
> Maybe I'm wrong and people will find lots of use for combinations like
>  * loose refs shadowing an sqlite database
>  * tdb shadowing mysql
>  * etc
> It's easy to prove a naysayer wrong with code and I don't want to
> discourage that.

I admit that I don't have any other layered storage schemes in mind.

> For the topic at hand it's relevant because packed-refs have
> properties that make some operations (certain deletion/ref creation
> combinations) much less fussy than loose refs, and it would be nice to
> be able to take advantage of that.  In the long term I would like to
> see git taking advantage of that when someone tries to fetch refs with
> names that would conflict on the filesystem (e.g., topic, topic/a,
> topic/b).

A transition to allowing D/F-conflicting reference names has two very
distinct aspects to it:

1. Changing to how references (and reflogs!) are stored to make it
technically possible to store such references.

2. Removing restrictions on actually creating such references.

We can take step 1 any time because it is a purely local decision.
Though I think you would need a repository format bump to allow it.
Even though you could work around the D/F problem for references by
packing problematic ones, it is a kludge with a potentially significant
performance cost.  And we have the same problem with reflogs, with no
analogous kludge.  I'd rather make a clean break, for example mapping
reference names into filenames using some kind of escaping of special
characters and suffixes like ".d" and ".f" to prevent directories and
files from conflicting.  Maybe (depending on the OS and/or filesystem?)
escape all non-ASCII characters or even all non-lower-case ASCII
characters to prevent problems with case sensitivity, internal vs.
filesystem character encodings, and NFC vs NFD.

But we won't want to take step 2 until Git clients that are 1-capable
are widespread; otherwise people with different client versions will
have trouble collaborating.  Maybe step 2 should be governed by a
configuration option with three settings:

    FORBIDDEN - don't allow references with D/F conflicts to exist
        in this repository

    NO_CREATE - don't allow the creation of such references locally,
        but accept them from remote sources via commands like "fetch".
        This setting could be used to avoid creating problems for
        collaborators.

    ALLOWED - no restriction on the creation of references with D/F
        conflicts.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
