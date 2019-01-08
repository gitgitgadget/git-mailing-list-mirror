Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581A51F803
	for <e@80x24.org>; Tue,  8 Jan 2019 19:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfAHTXg (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 14:23:36 -0500
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:42086 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbfAHTXg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Jan 2019 14:23:36 -0500
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id gtnQgLDDQIECAgwyMgnIzv; Tue, 08 Jan 2019 19:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1546975414;
        bh=XiO35aqENTx2eGHU8JGkdjVgp1LBb60+txenEsZZxoI=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=eXQwXdlJ/qQEwwMC1rpFigJ9nHZcEKwYIAZ6/yykmsWyVNPqQEY+z6kIMgkSW84LX
         6mBqwy+0Ncpy0qvS38H3UKRb5fC0M1rX3JFk4ry4I/pVXDEBfB7uZ/TgF3w/PJTK2G
         JSDp5klI1cDRbLnWmh6TAYhcUe2q3IgZfdhCXceaeYK3w8D60pVz9yCdFydt4un/fo
         ZO6tmitU0bjIbHnjCMQkkcaeAgD0LZ4xn6wIe+mVLafk0pYV4Q6h3K4nRdyhY3TLU5
         lKI1RZ7FsPJGv0eMNYe++mnC4C4HnWEjFTqlWGqn95pnUWkYn8ZDDakXWiehfFsIcK
         6jG/jz3+HTksQ==
Received: from maqku.svl.corp.google.com ([IPv6:2620:0:100e:913:d978:5566:abe5:124c])
        by resomta-po-14v.sys.comcast.net with ESMTPSA
        id gwxjg0IkFdigdgwxogAmTP; Tue, 08 Jan 2019 19:23:21 +0000
X-Xfinity-VMeta: sc=??;st=legit
Subject: Re: [PATCH v2 1/2] list-objects-filter: teach tree:# how to handle >0
To:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        pclouds@gmail.com
References: <20181210234030.176178-2-matvore@google.com>
 <20190108015631.22727-1-jonathantanmy@google.com>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <54fba0d3-4b8e-1faf-4b2d-e67c1f5fbf02@comcast.net>
Date:   Tue, 8 Jan 2019 11:22:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108015631.22727-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2019/01/07 17:56, Jonathan Tan wrote:
>>   	case LOFS_END_TREE:
>>   		assert(obj->type == OBJ_TREE);
>> +		filter_data->current_depth--;
>>   		return LOFR_ZERO;
>>   
>> +	case LOFS_BLOB:
>> +		filter_trees_update_omits(obj, filter_data, include_it);
>> +		return include_it ? LOFR_MARK_SEEN | LOFR_DO_SHOW : LOFR_ZERO;
> Any reason for moving "case LOFS_BLOB" (and "case LOFS_BEGIN_TREE"
> below) after LOFS_END_TREE?

I put LOFS_BLOB and after LOFS_END_TREE since that is the order in all 
the other filter logic functions. I put LOFS_BEGIN_TREE at the end 
(which is different from the other filter logic functions) because it's 
usually better to put simpler things before longer or more complex 
things. LOFS_BEGIN_TREE is much more complex and if it were not the last 
switch section, it would tend to hide the sections that come after it.

FWIW, I consider this the coding corollary of the end-weight problem in 
linguistics - see https://www.thoughtco.com/end-weight-grammar-1690594 - 
this is not my original idea, but something from the book Perl Best 
Practices, although that book only mentioned it in the context of 
ordering clauses in single statements rather than ordering entire blocks.

>
> This is drastically different from the previous case, but this makes
> sense - previously, all blobs accessed through traversal were not shown,
> but now they are sometimes shown.
Yes.
> Here, filter_trees_update_omits() is
> only ever used to remove a blob from the omits set, since once this blob
> is encountered with include_it == true, it is marked as LOFR_MARK_SEEN
> and will not be traversed again.
It is possible that include_it can be false and then in a later 
invocation it can be true. In that case, the blob will be added to the 
set and then removed from it.
>
>> +	case LOFS_BEGIN_TREE:
>> +		seen_info = oidmap_get(
>> +			&filter_data->seen_at_depth, &obj->oid);
>> +		if (!seen_info) {
>> +			seen_info = xcalloc(1, sizeof(struct seen_map_entry));
> Use sizeof(*seen_info).
Done.
>
>> +			seen_info->base.oid = obj->oid;
> We have been using oidcpy, but come to think of it, I'm not sure why...
Because the hash algorithm in use may not use the entire structure, 
apparently. Or there are future improvements planned to the function and 
they need to be picked up by all current hash-copying operations. Fixed.
>
>> +			seen_info->depth = filter_data->current_depth;
>> +			oidmap_put(&filter_data->seen_at_depth, seen_info);
>> +			already_seen = 0;
>> +		} else
>> +			already_seen =
>> +				filter_data->current_depth >= seen_info->depth;
> There has been recently some clarification that if one branch of an
> if/else construct requires braces, braces should be put on all of them:
> 1797dc5176 ("CodingGuidelines: clarify multi-line brace style",
> 2017-01-17). Likewise below.
Done, thank you - that's good to know.
>
>> +		if (already_seen)
>> +			filter_res = LOFR_SKIP_TREE;
>> +		else {
>> +			seen_info->depth = filter_data->current_depth;
>> +			filter_trees_update_omits(obj, filter_data, include_it);
>> +
>> +			if (include_it)
>> +				filter_res = LOFR_DO_SHOW;
>> +			else if (filter_data->omits)
>> +				filter_res = LOFR_ZERO;
>> +			else
>> +				filter_res = LOFR_SKIP_TREE;
> Looks straightforward. If we have already seen it at a shallower or
> equal depth, we can skip it (since we have already done the appropriate
> processing). Otherwise, we need to ensure that its "omit" is correctly
> set, and:
>   - show it if include_it
>   - don't do anything special if not include_it and we need the omit set
>   - skip the tree if not include_it and we don't need the omit set
Right.
>
>> +static void filter_trees_free(void *filter_data) {
>> +	struct filter_trees_depth_data* d = filter_data;
>> +	oidmap_free(&d->seen_at_depth, 1);
>> +	free(d);
>> +}
> Check for NULL-ness of filter_data too, to match the usual behavior of
> free functions.
>
Done.
>> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
>> index eb32505a6e..54e7096d40 100755
>> --- a/t/t6112-rev-list-filters-objects.sh
>> +++ b/t/t6112-rev-list-filters-objects.sh
> [snip]
>
> Thanks for the tests that cover quite a wide range of cases. Can you
> also demonstrate the case where a blob would normally be omitted
> (because it is too deep) but it is directly specified, so it is
> included.

I didn't exactly use TDD, but I did try to cover every line of code as 
well as both branches of each ternary operator.

Added such a test.

>
>> +expect_has_with_different_name () {
>> +	repo=$1 &&
>> +	name=$2 &&
>> +
>> +	hash=$(git -C $repo rev-parse HEAD:$name) &&
>> +	! grep "^$hash $name$" actual &&
>> +	grep "^$hash " actual &&
>> +	! grep "~$hash" actual
>> +}
> Should we also check that a "~" entry appears with $name?

I don't believe there is a way to get the object names to appear next to 
~ entries (note that the names are not saved in the omits oidset).

For your reference, here is an interdiff for this particular patch after 
applying your comments:

--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -158,18 +158,19 @@ static enum list_objects_filter_result 
filter_trees_depth(
          seen_info = oidmap_get(
              &filter_data->seen_at_depth, &obj->oid);
          if (!seen_info) {
-            seen_info = xcalloc(1, sizeof(struct seen_map_entry));
-            seen_info->base.oid = obj->oid;
+            seen_info = xcalloc(1, sizeof(*seen_info));
+            oidcpy(&seen_info->base.oid, &obj->oid);
              seen_info->depth = filter_data->current_depth;
              oidmap_put(&filter_data->seen_at_depth, seen_info);
              already_seen = 0;
-        } else
+        } else {
              already_seen =
                  filter_data->current_depth >= seen_info->depth;
+        }

-        if (already_seen)
+        if (already_seen) {
              filter_res = LOFR_SKIP_TREE;
-        else {
+        } else {
              int been_omitted = filter_trees_update_omits(
                  obj, filter_data, include_it);
              seen_info->depth = filter_data->current_depth;
@@ -193,6 +194,8 @@ static enum list_objects_filter_result 
filter_trees_depth(

  static void filter_trees_free(void *filter_data) {
      struct filter_trees_depth_data* d = filter_data;
+    if (!d)
+        return;
      oidmap_free(&d->seen_at_depth, 1);
      free(d);
  }
diff --git a/t/'t6112-rev-list-filters-objects.sh 
b/t/'t6112-rev-list-filters-objects.sh
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/t6112-rev-list-filters-objects.sh 
b/t/t6112-rev-list-filters-objects.sh
index 18b0b14d5a..d6edad6a01 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -407,6 +407,13 @@ test_expect_success 'tree:<depth> where we iterate 
over tree at two levels' '
      expect_has_with_different_name r5 a/subdir/b/foo
  '

+test_expect_success 'tree:<depth> which filters out blob but given as 
arg' '
+    export blob_hash=$(git -C r4 rev-parse HEAD:subdir/bar) &&
+
+    git -C r4 rev-list --objects --filter=tree:1 HEAD $blob_hash >actual &&
+    grep ^$blob_hash actual
+'
+
  # Delete some loose objects and use rev-list, but WITHOUT any filtering.
  # This models previously omitted objects that we did not receive.




