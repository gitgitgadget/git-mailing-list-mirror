From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: with reuse-delta patches, fetching with bitmaps segfaults due
 to possibly incomplete bitmap traverse
Date: Sun, 23 Mar 2014 17:01:00 -0700
Message-ID: <532F75BC.7080301@fb.com>
References: <532CFC6F.8000008@fb.com> <20140322125626.GA22890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <bmaurer@fb.com>,
	Aaron Kushner <akushner@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 24 01:01:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRsKo-0002H2-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 01:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbaCXABH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 20:01:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8205 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823AbaCXABF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2014 20:01:05 -0400
Received: from pps.filterd (m0004060 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s2NNovBa024149;
	Sun, 23 Mar 2014 17:01:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=q198JlQbeiIhMWtx6O9n4kkriJ/BqrkW5nUKqrraytg=;
 b=NGaYB059q6243g5yVeeExIvmQybkHDz9hmNK+iyOX9MlyYrUIxVWINoEV9GqndBypu+E
 DclUdA6mALr3KbRp+HtIzIuJzWhOyy83+IROpUK34wvZQkSzQ9Fy4oJkk9CazQHRm0B3
 NBKSjvpAAQkXthVHNUsuMSfcRu3iPeZJHtE= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1jt8ge03ng-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Sun, 23 Mar 2014 17:01:03 -0700
Received: from [172.26.2.4] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.11) with Microsoft SMTP Server (TLS) id 14.3.174.1; Sun, 23 Mar
 2014 17:01:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140322125626.GA22890@sigill.intra.peff.net>
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-03-23_02:2014-03-21,2014-03-23,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=6.62758736780233e-12 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000
 definitions=main-1403230170
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244808>

On 03/22/2014 05:56 AM, Jeff King wrote:
> On Fri, Mar 21, 2014 at 07:58:55PM -0700, Siddharth Agarwal wrote:
>
> Is it also reproducible just with the tip of "next"? Note that the
> patches in jk/bitmap-reuse-delta have not been widely deployed (in
> particular, we are not yet using them at GitHub, and we track segfaults
> on our servers closely and have not seen any related to this).

I cannot reproduce this with the tip of next (tested with 4443bfd). 
That's also --  unsurprisingly -- significantly slower in the 
compression phase and sends much more data (3x for the pair of repos in 
the OP) over the wire than a Git that doesn't use bitmaps.

> Those patches allocate extra "fake" entries in the entry->delta fields,
> which are not accounted for in to_pack.nr_objects. It's entirely
> possible that those entries are related to the bug you are seeing.

That sounds like it could be the problem, yes.

> Hmm, yeah, that confirms my suspicion. In the earlier loops, we call
> add_to_write_order, which only adds the object in question, and can
> never exceed to_pack.nr_objects. In this final loop, we call
> add_family_to_write_order, which is going to add any deltas that were
> not already included.
>
> The patch below may fix your problem, but I have a feeling it is not the
> right thing to do. The point of 81cdec28 is to try to point to a delta
> entry as if it were a "preferred base" (i.e., something we know that the
> other side has already). We perhaps want to add these entries to the
> actual packing list, and skip them as we do with normal preferred_base
> objects.

The patch does stop Git from segfaulting. I know too little to judge its 
correctness, though.

>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 9fc5321..ca1b0f7 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1437,6 +1437,7 @@ static void check_object(struct object_entry *entry)
>   			entry->delta = xcalloc(1, sizeof(*entry->delta));
>   			hashcpy(entry->delta->idx.sha1, base_ref);
>   			entry->delta->preferred_base = 1;
> +			entry->delta->filled = 1;
>   			unuse_pack(&w_curs);
>   			return;
>   		}
>
> -Peff
