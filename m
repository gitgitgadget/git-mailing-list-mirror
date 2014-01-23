From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Thu, 23 Jan 2014 15:45:33 -0800
Message-ID: <52E1A99D.6010809@fb.com>
References: <52E080C1.4030402@fb.com> <20140123225238.GB2567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Txs-0005bv-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbaAWXph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:45:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59114 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbaAWXpg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 18:45:36 -0500
Received: from pps.filterd (m0044008 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0NNfPPD029324;
	Thu, 23 Jan 2014 15:45:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=ifZ4qWMy+hbErNZKBTDSDkq9nqS6Gx1EzJzhhTN17Ao=;
 b=cm1FypA2D1a9XeaikOKL698mNyQU6q960N+JhA3HfOujnYP5XzVZc1m+ohcYIsvU/qsY
 oe47DK8Ctqn/H2CAVSPOb0IwCpktqWadN0F39ONt6NQPFOCh5xNoJdKLVi0nlu4SwcF1
 56DmeRVw28fOOQ5OeIX/lVh4LwHtGRV5kik= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1hk34123b1-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 23 Jan 2014 15:45:35 -0800
Received: from [172.25.68.250] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.14) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 23 Jan
 2014 15:45:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140123225238.GB2567@sigill.intra.peff.net>
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-23_05:2014-01-23,2014-01-23,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=5.10702591327572e-15 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401230172
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240975>

On 01/23/2014 02:52 PM, Jeff King wrote:
> Right, that's expected.
>
> The bitmap format cannot represent objects that are not present in the
> pack. So we cannot write a bitmap index if any object reachable from a
> packed commit is omitted from the pack.
>
> We could be nicer and downgrade it to a warning, though. The patch below
> does that.

This makes sense.

>> In our case we have .keep files lying around from ages ago (possibly
>> due to kill -9s run on the server).
> We ran into that problem at GitHub, too. We just turn off
> `--honor-pack-keep` during our repacks, as we never want them on anyway
> (and we would prefer to ignore the .keep than to abort the bitmap).

Yes, we'd prefer to do that too. How do you actually do this, though? I 
don't see a way to pass `--honor-pack-keep` (shouldn't I pass in its 
inverse?) down to `git-pack-objects`.

>> It also means that running repack -a with bitmap writing enabled on a
>> repo becomes problematic if a fetch is run concurrently.
> For the most part, no. The .keep file should generally only be set
> during the period between indexing the pack and updating the refs (so
> while checking connectivity and running hooks). But pack-objects starts
> from the ref tips and walks backwards. Until they are updated, it will
> not try to pack the objects in the .keep files, as nobody references
> them.

The worry is less certain objects not being packed and more the old 
packs being deleted by git repack, isn't it? From the man page for 
git-index-pack:

--keep
Before moving the index into its final destination create an empty .keep 
file for the associated pack file. This option is usually necessary with
--stdin to prevent a simultaneous git repack process from deleting the 
newly constructed pack and index before refs can be updated to use 
objects contained in the pack.

I could be misunderstanding things here, though. From the description in 
the man page it's not clear what the actual failure mode here is.

> There are two loopholes, though:
>
>    1. In some instances, a remote may send an object we already have
>       (e.g., because it is a blob referenced in an old commit, but newly
>       referenced again due to a revert; we do not do a full object
>       difference during the protocol negotiation, for reasons of
>       efficiency). If that is the case, we may omit it if pack-objects
>       starts during the period that the .pack and .keep files exist.
>
>    2. Once the fetch updates the refs, it removes the .keep file. But
>       this isn't atomic. A repack which starts between the two may pick
>       up the new ref values, but also see the .keep file.
>
> These are both unlikely, but possible on a very busy repository. The
> patch below will downgrade each to a warning, rather than aborting the
> repack.
>
> So this should just work out of the box with this patch.  But if bitmaps
> are important to you (say, you are running a very busy site and want
> to make sure you always have bitmaps turned on) and you do not otherwise
> care about .keep files, you may want to disable them, too.

We need to make sure bitmaps are always turned on, but we need to be 
even more certain that pushes don't fail due to races.

> -Peff
>
> -- >8 --
> Subject: pack-objects: turn off bitmaps when skipping objects
>
> The pack bitmap format requires that we have a single bit
> for each object in the pack, and that each object's bitmap
> represents its complete set of reachable objects. Therefore
> we have no way to represent the bitmap of an object which
> references objects outside the pack.
>
> We notice this problem while generating the bitmaps, as we
> try to find the offset of a particular object and realize
> that we do not have it. In this case we die, and neither the
> bitmap nor the pack is generated. This is correct, but
> perhaps a little unfriendly. If you have bitmaps turned on
> in the config, many repacks will fail which would otherwise
> succeed. E.g., incremental repacks, repacks with "-l" when
> you have alternates, ".keep" files.
>
> Instead, this patch notices early that we are omitting some
> objects from the pack and turns off bitmaps (with a
> warning). Note that this is not strictly correct, as it's
> possible that the object being omitted is not reachable from
> any other object in the pack. In practice, this is almost
> never the case, and there are two advantages to doing it
> this way:
>
>    1. The code is much simpler, as we do not have to cleanly
>       abort the bitmap-generation process midway through.
>
>    2. We do not waste time partially generating bitmaps only
>       to find out that some object deep in the history is not
>       being packed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I tried to keep the warning to an 80-character line without making it
> too confusing. Suggestions welcome if it doesn't make sense to people.
>
>   builtin/pack-objects.c  | 12 +++++++++++-
>   t/t5310-pack-bitmaps.sh |  5 ++++-
>   2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 8364fbd..76831d9 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1000,6 +1000,10 @@ static void create_object_entry(const unsigned char *sha1,
>   	entry->no_try_delta = no_try_delta;
>   }
>   
> +static const char no_closure_warning[] = N_(
> +"disabling bitmap writing, as some objects are not being packed"
> +);
> +
>   static int add_object_entry(const unsigned char *sha1, enum object_type type,
>   			    const char *name, int exclude)
>   {
> @@ -1010,8 +1014,14 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>   	if (have_duplicate_entry(sha1, exclude, &index_pos))
>   		return 0;
>   
> -	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset))
> +	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
> +		/* The pack is missing an object, so it will not have closure */
> +		if (write_bitmap_index) {
> +			warning(_(no_closure_warning));
> +			write_bitmap_index = 0;
> +		}
>   		return 0;
> +	}
>   
>   	create_object_entry(sha1, type, pack_name_hash(name),
>   			    exclude, name && no_try_delta(name),
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index d3a3afa..f13525c 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -91,7 +91,10 @@ test_expect_success 'fetch (partial bitmap)' '
>   
>   test_expect_success 'incremental repack cannot create bitmaps' '
>   	test_commit more-1 &&
> -	test_must_fail git repack -d
> +	find .git/objects/pack -name "*.bitmap" >expect &&
> +	git repack -d &&
> +	find .git/objects/pack -name "*.bitmap" >actual &&
> +	test_cmp expect actual
>   '
>   
>   test_expect_success 'incremental repack can disable bitmaps' '
