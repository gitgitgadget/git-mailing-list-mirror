From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Fri, 08 Jul 2011 10:45:51 -0700
Message-ID: <7voc14fyy8.fsf@alter.siamese.dyndns.org>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 19:46:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfF7o-0005oa-Og
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 19:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab1GHRpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 13:45:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1GHRpz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 13:45:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D1346C84;
	Fri,  8 Jul 2011 13:45:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A6vh1xNGhs+ZUrW7RKGAlygov2k=; b=Y6XAxj
	OOzFMTI3pID7/rzxVZKkck5GqAZe4uBKj435Zb360P1JYD0aPgaW4K6CagW9XHKd
	zjh0d1ny+K/m3OgeECIDRNNfDIeShY6pPVy5GSoHhMOQAeC1AflKgrjWeCQKrctv
	pv8UchM24rXlO8VGuYw9wTbtVLkkDMvtRUvnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=syLYQHR/Dha0Umostj3T7rRPePf0w3PI
	J9+0EqevEKqWDMmavRnZzKDqOXyfGiEwhWx5x5/lXKTpK9Sdv++tRQls+5ovcTez
	xz1h/dzKIu0hUjb5gYZVsyPO3aVu2L4dcuJGswhuiiMmeGNv2IPoP36ee8m2oN1W
	dBF4tAlghGU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25E256C83;
	Fri,  8 Jul 2011 13:45:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A7666C82; Fri,  8 Jul 2011
 13:45:53 -0400 (EDT)
In-Reply-To: <1310084657-16790-3-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 7 Jul 2011 17:24:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2045B222-A98A-11E0-B64C-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176801>

I <gitster@pobox.com> wrote:

>  - In the original recency order, trees and blobs are intermixed. Write
>    trees together before blobs, in the hope that this will improve
>    locality when running pathspec-limited revision traversal, i.e.
>    "git log paths...";
>
>  - When writing blob objects out, write the whole family of blobs that use
>    the same delta base object together, by starting from the root of the
>    delta chain, and writing its immediate children in a width-first
>    manner, in the hope that this will again improve locality when reading
>    blobs that belong to the same path, which are likely to be deltified
>    against each other.

An interesting tangent.

With a single-liner change to apply the same "write the entire family as a
group" logic also to tree objects, we get a superb improvement to the
"index-pack" workload, while "log pathspec" becomes measurably worse.

>  * Pathspec-limited log.
>    $ git log drivers/net >/dev/null
>                                   v1.7.6  with patch
> 	 60.0% percentile :        688,671     443,578
> 	 70.0% percentile :    319,574,732 110,370,100
> 	 99.0% percentile :    412,942,470 133,078,115
> 	 99.5% percentile :    413,172,266 133,163,349
> 	 99.9% percentile :    413,354,356 133,240,445
>        Less than 2MiB seek:       61.71%      62.87%

     60.00% percentile :    2,240,841
     70.00% percentile :  115,729,538
     99.00% percentile :  132,912,877
     99.90% percentile :  133,129,574
   Less than 2MiB seek :       59.77%

This of course is because trees tend to delta well against each other and
writing out everything in the same family tends to coalesce ancient and
recent trees close together, while the history traversal wants to see the
trees at the same path in adjacent commits, and the process to jump over
to the "next tree" in the same commit need to seek a lot more.

>  * Blame.
>    $ git blame drivers/net/ne.c >/dev/null
>                                   v1.7.6  with patch
> 	 50.0% percentile :         11,248       7,334
> 	 95.0% percentile :    408,230,673 132,174,308
>        Less than 2MiB seek:       56.47%      56.83%

     50.00% percentile :       79,182
     95.00% percentile :  132,547,959
   Less than 2MiB seek :       56.16%

This also is harmed by trees in adjacent commits being further apart, but
blame needs to read a lot of blobs as well, so the effect is not as grave
as tree-only "log pathspec" case. 

>  * Index pack.
>    $ git index-pack -v .git/objects/pack/pack*.pack
>                                   v1.7.6  with patch
> 	 80.0% percentile :      1,317,862       4,971
> 	 90.0% percentile :     11,926,385     119,398
> 	 99.9% percentile :    382,919,785  33,155,191
>        Less than 2MiB seek:       81.73%      96.92%

     80.00% percentile :      745
     90.00% percentile :    1,891
     99.90% percentile :   80,001
   Less than 2MiB seek :  100.00%

It is so obvious that the in pack object ordering with "the whole family
at once" tweak is extremely tuned for this workload that the result is not
even funny.

The moral of the story is that index-pack is not a workload to optimize
for ;-) and the following is a wrong patch to apply. In general, we have
to be extremely careful not to tune for a particular workload while
unknowingly sacrificing other workloads.

I wonder if we would get a better locality for "blame" by not writing the
whole family at once for blobs, but only a smaller subset.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 27132bb..adcb509 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -553,7 +553,7 @@ static struct object_entry **compute_write_order(void)
 	for (i = 0; i < nr_objects; i++) {
 		if (objects[i].type != OBJ_TREE)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_family_to_write_order(wo, &wo_end, &objects[i]);
 	}
 
 	/*
