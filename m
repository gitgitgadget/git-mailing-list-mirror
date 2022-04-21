Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B3C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiDUQfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiDUQfl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 12:35:41 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F0548E45
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 09:32:50 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3FF2E3F483B;
        Thu, 21 Apr 2022 12:32:50 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CCE813F4838;
        Thu, 21 Apr 2022 12:32:49 -0400 (EDT)
Subject: Re: [PATCH v2 4/5] bitmap: add trace2 outputs during open "bitmap"
 file
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, gitster@pobox.com
References: <cover.1650547400.git.dyroneteng@gmail.com>
 <2016ef2e342c2ec6517afa8ec3e57035021fb965.1650547400.git.dyroneteng@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8005642d-979f-8e48-7a93-07b8a888bdc7@jeffhostetler.com>
Date:   Thu, 21 Apr 2022 12:32:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2016ef2e342c2ec6517afa8ec3e57035021fb965.1650547400.git.dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/21/22 9:26 AM, Teng Long wrote:
> It's supported for a Git repo to use bitmap in both normal bitmap way
> or a multi-pack-index bitmap.
> 
> Sometimes the debug path is not obvious, for example, when executing:
> 
>   $git rev-list  --test-bitmap  HEAD
>   fatal: failed to load bitmap indexes
> 
> If we see the output like this, we are not sure about what's happened,
> because the cause should be :
> 
>    1. neither normal nor midx bitmap exists
>    2. only midx bitmap exists but core.multipackIndex="false"
>    3. core.multipackIndex="true" but midx bitmap file is currupt
>    4. core.multipackIndex="true" and no midx bitmap exists but
>       normal bitmap file is currupt
>    ....
> 
> These are some of the scenarios I briefly tested, but maybe there are
> others (some scenarios is produced manually like "currupt bitmap file",
> but it's not represent it's an existed bug.).
> 
> Therefore, we added some TRACE2 code so that when we read the bitmap
> we can be more clear about the decision path, such as whether it is
> working on midx bitmap or normal bitmap, or is it simply because the
> related configuration is disabled. This may help with logging, user
> troubleshooting, and development debugging.
> 
> Here are some output examples when executing
> "$GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD" under different
> situations:
> 
> 1. _HAVE_ MIDX bitmap and NORMAL bitmap file, but the
> "core.multipackIndex" configures as "false":
> 
>    19:38:43.007840 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.582.g8e9092487a
>    19:38:43.007874 common-main.c:50             | d0 | main                     | start        |     |  0.000305 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD
>    19:38:43.007950 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
>    19:38:43.008091 git.c:460                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
>    19:38:43.008284 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000720 |  0.000720 | config       | feature.manyfiles:false
>    19:38:43.008297 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000734 |  0.000734 | config       | feature.experimental:false
>    19:38:43.008305 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000742 |  0.000742 | config       | core.commitgraph:true
>    19:38:43.008313 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000749 |  0.000749 | config       | commitgraph.readchangedpaths:true
>    19:38:43.008320 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000756 |  0.000756 | config       | gc.writecommitgraph:true
>    19:38:43.008327 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000764 |  0.000764 | config       | fetch.writecommitgraph:false
>    19:38:43.008334 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000770 |  0.000770 | config       | pack.usesparse:true
>    19:38:43.008341 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000777 |  0.000777 | config       | core.multipackindex:false
>    19:38:43.008348 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000784 |  0.000784 | config       | index.sparse:false
>    19:38:43.008724 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
>    19:38:43.008738 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001173 |  0.000013 | bitmap       | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
>    19:38:43.008754 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001191 |  0.000031 | pack-bitmap  | label:open_bitmap
>    Bitmap v1 test (8 entries loaded)
>    Found bitmap for 0a7df7ae92f8d8ed879c240f8ae9cdd33d18085e. 64 bits / 1801edc6 checksum
>    19:38:43.009099 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001535 |           | progress     | label:Verifying bitmap entries
>    Verifying bitmap entries: 100% (27/27), done.
>    19:38:43.009294 progress.c:339               | d0 | main                     | data         | r0  |  0.001730 |  0.000195 | progress     | ..total_objects:27
>    19:38:43.009302 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001739 |  0.000204 | progress     | label:Verifying bitmap entries
>    OK!
>    19:38:43.009321 git.c:718                    | d0 | main                     | exit         |     |  0.001757 |           |              | code:0
>    19:38:43.009329 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001766 |           |              | code:0
> 
> 2. _HAVE_ MIDX bitmap and NORMAL bitmap file, but the
> "core.multipackIndex" configures as "true":
> 
>    (omit duplicate outputs)
>    ...
>    20:02:31.288797 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000811 |  0.000811 | config       | core.multipackindex:true
>    20:02:31.288806 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000819 |  0.000819 | config       | index.sparse:false
>    20:02:31.288836 midx.c:185                   | d0 | main                     | data         | r0  |  0.000849 |  0.000849 | midx         | load/num_packs:1
>    20:02:31.288843 midx.c:186                   | d0 | main                     | data         | r0  |  0.000857 |  0.000857 | midx         | load/num_objects:27
>    20:02:31.289217 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001229 |           | pack-bitmap  | label:open_bitmap
>    20:02:31.289230 pack-bitmap.c:318            | d0 | main                     | data         | r0  |  0.001242 |  0.000013 | midx         | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/multi-pack-index-b6b04fbe053bd500d9ca13354466d3249dc275ac.bitmap
>    20:02:31.289252 pack-revindex.c:315          | d0 | main                     | data         | r0  |  0.001265 |  0.000036 | load_midx_re | ..source:midx
>    20:02:31.289261 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001274 |  0.000045 | pack-bitmap  | label:open_bitmap
>    Bitmap v1 test (8 entries loaded)
>    Found bitmap for 0a7df7ae92f8d8ed879c240f8ae9cdd33d18085e. 64 bits / 1801edc6 checksum
>    20:02:31.289594 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001607 |           | progress     | label:Verifying bitmap entries
>    Verifying bitmap entries: 100% (27/27), done.
>    20:02:31.289810 progress.c:339               | d0 | main                     | data         | r0  |  0.001823 |  0.000216 | progress     | ..total_objects:27
>    20:02:31.289824 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001837 |  0.000230 | progress     | label:Verifying bitmap entries
>    OK!
>    20:02:31.289843 git.c:718                    | d0 | main                     | exit         |     |  0.001856 |           |              | code:0
>    20:02:31.289860 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001873 |           |              | code:0
> 
> 3. _HAVE_ MIDX bitmap and a corrupt NORMAL bitmap file, but the
> "core.multipackIndex" configures as "false" :
> 
>    (omit duplicate outputs)
>    ...
>    20:14:06.539305 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000794 |  0.000794 | config       | core.multipackindex:false
>    20:14:06.539310 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000799 |  0.000799 | config       | index.sparse:false
>    20:14:06.539658 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001146 |           | pack-bitmap  | label:open_bitmap
>    20:14:06.539671 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001160 |  0.000014 | bitmap       | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
>    20:14:06.539686 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..Corrupted bitmap index file (wrong header)
>    error: Corrupted bitmap index file (wrong header)
>    20:14:06.539696 pack-bitmap.c:426            | d0 | main                     | data         | r0  |  0.001185 |  0.000039 | bitmap       | ..load bitmap header:failed
>    20:14:06.539709 usage.c:79                   | d0 | main                     | error        |     |           |           |              | ..bitmap header is invalid
>    error: bitmap header is invalid
>    20:14:06.539719 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001208 |  0.000062 | pack-bitmap  | label:open_bitmap
>    20:14:06.539726 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
>    fatal: failed to load bitmap indexes
>    20:14:06.539735 usage.c:74                   | d0 | main                     | exit         |     |  0.001224 |           |              | code:128
>    20:14:06.539744 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001233 |           |              | code:128
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>   pack-bitmap.c           | 40 +++++++++++++++++++++++++++++++++-------
>   repo-settings.c         |  1 +
>   t/t5310-pack-bitmaps.sh |  4 ++--
>   3 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 1b268f655e..a1d06c4252 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -312,9 +312,12 @@ char *pack_bitmap_filename(struct packed_git *p)
>   static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>   			      struct multi_pack_index *midx)
>   {
> +	int fd;
>   	struct stat st;
>   	char *bitmap_name = midx_bitmap_filename(midx);
> -	int fd = git_open(bitmap_name);
> +	trace2_data_string("midx", the_repository, "try to open bitmap",
> +			   bitmap_name);
> +	fd = git_open(bitmap_name);

This might just be a style thing, but rather than logging the pathname
in a separate data_string message, you can use the _printf version of
region_enter and region_leave to also print the name of the
path -- like I did in read-cache.c for the "do_read_index"
calls.

... | region_enter | ... | index | label:do_read_index .git/index
...
... | region_leave | ... | index | label:do_read_index .git/index

As AEvar suggests in another message in this thread, I'm not sure if
you need the region timing here for reading the bitmap, but all of
the error and any other data messages will be bounded between the
region_enter and region_leave events and that might (or might not)
be helpful.


Also, I agree with AEvar's statements about using error() and getting
the trace2 error messages for free and not needing some of the
trace2_data_string() messages that you have later in this file.

I wonder if it would be worth adding the pathname of the invalid
file to those new error messages.  Granted you'll have it in the
trace2 log, but then you'll also get it on stderr if that would
be helpful.


Jeff




