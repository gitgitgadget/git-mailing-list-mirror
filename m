Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A12CCA47F
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiGHQif (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbiGHQic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:38:32 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96F55AA
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:38:30 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1o9qzs-0005ov-EY;
        Fri, 08 Jul 2022 17:38:28 +0100
Message-ID: <ac52cfea-edb0-b68b-36e2-ab45d2959727@iee.email>
Date:   Fri, 8 Jul 2022 17:38:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/6] Documentation/technical: describe bitmap lookup
 table extension
Content-Language: en-GB
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <f72bf11e6efb4690ae808c0b56c3991c2b1ef266.1656924376.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <f72bf11e6efb4690ae808c0b56c3991c2b1ef266.1656924376.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On 04/07/2022 09:46, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> When reading bitmap file, Git loads each and every bitmap one by one
> even if all the bitmaps are not required. A "bitmap lookup table"
> extension to the bitmap format can reduce the overhead of loading
> bitmaps which stores a list of bitmapped commit id pos (in the midx
> or pack, along with their offset and xor offset. This way git can
> load only the necessary bitmaps without loading the previous bitmaps.
>
> Older versions of Git ignore the lookup table extension and don't
> throw any kind of warning or error while parsing the bitmap file.
>
> Add some information for the new "bitmap lookup table" extension in the
> bitmap-format documentation.

Not sure if this is new in this extension, but should there be a link or
two to the basics of XOR compression and some of the bitmap look up
techniques?

It's not always obvious if these techniques are 'heuristic' and only
have partial commit data, or they have all the commits listed, Nor
how/why they work. My point is more about giving new readers a hand-up
in their understanding, rather than simple implementation details for
those who already know what is going on. For example, are there any
external articles that you found helpful in getting started that could
be referenced somewhere in the docs?

Separately I'm preparing a short series on adding 'reachability bitmap'
and 'commit graph' (among other stuff) to the glossary as part of giving
folks [0] stepping stones to cross the chasm of understanding

Philip

[0] me included;-)
>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Co-Authored-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/technical/bitmap-format.txt | 39 +++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> index 04b3ec21785..c30dc177643 100644
> --- a/Documentation/technical/bitmap-format.txt
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -67,6 +67,17 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>  			pack/MIDX. The format and meaning of the name-hash is
>  			described below.
>  
> +			** {empty}
> +			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
> +			If present, the end of the bitmap file contains a table
> +			containing a list of `N` <commit_pos, offset, xor_row>
> +			triplets. The format and meaning of the table is described
> +			below.
> ++
> +NOTE: Unlike the xor_offset used to compress an individual bitmap,
> +`xor_row` stores an *absolute* index into the lookup table, not a location
> +relative to the current entry.
> +
>  		4-byte entry count (network byte order)
>  
>  			The total count of entries (bitmapped commits) in this bitmap index.
> @@ -205,3 +216,31 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
>  If implementations want to choose a different hashing scheme, they are
>  free to do so, but MUST allocate a new header flag (because comparing
>  hashes made under two different schemes would be pointless).
> +
> +Commit lookup table
> +-------------------
> +
> +If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
> +bytes (preceding the name-hash cache and trailing hash) of the `.bitmap`
> +file contains a lookup table specifying the information needed to get
> +the desired bitmap from the entries without parsing previous unnecessary
> +bitmaps.
> +
> +For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
> +contains a list of `nr_entries` <commit_pos, offset, xor_row> triplets
> +(sorted in the ascending order of `commit_pos`). The content of i'th
> +triplet is -
> +
> +	* {empty}
> +	commit_pos (4 byte integer, network byte order): ::
> +	It stores the object position of a commit (in the midx or pack
> +	index).
> +
> +	* {empty}
> +	offset (8 byte integer, network byte order): ::
> +	The offset from which that commit's bitmap can be read.
> +
> +	* {empty}
> +	xor_row (4 byte integer, network byte order): ::
> +	The position of the triplet whose bitmap is used to compress
> +	this one, or `0xffffffff` if no such bitmap exists.

