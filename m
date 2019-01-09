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
	by dcvr.yhbt.net (Postfix) with ESMTP id 012A01F803
	for <e@80x24.org>; Wed,  9 Jan 2019 00:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfAIAaV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 19:30:21 -0500
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:40694 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbfAIAaV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Jan 2019 19:30:21 -0500
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-02v.sys.comcast.net with ESMTP
        id gwLqgFTRx9VLoh1lEgidsl; Wed, 09 Jan 2019 00:30:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1546993820;
        bh=7Yw1GFsRmboNVYtN5iZS89R+5apfijgMIsdaHj+U8mk=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=kRyGG+Urb2cSjkfelLS3m2aLD826zYVA3aNavNYv1cB1boZduLYg7jmgk7MauY0TW
         qYBmfguG1yQvG32oaEOce0BrnCZG0z6RlWImCgF5pf/YAUeiVU23X3lW/WEqjpbGPz
         HuJowJGqa+6g+EtCg1fwQQtE6d8qRN6zcVBhXGzdFG8LL7rbVdpfngCusWwnaDERl9
         QqgV9NFstI87uuaElIIgmeh1CaN5p+5lBjBTvthkBUgj8nbZT6OI8S8ihsvp3AzWdD
         bUv3XQ++Xjxgo2tDPKc5GDz4pZaLrA8wroXEaZfbm8kGT+unxUwBvs0iL4JJ+W3zN2
         A1fDg472sZ0LA==
Received: from maqku.svl.corp.google.com ([IPv6:2620:0:100e:913:10a6:1475:3980:2949])
        by resomta-ch2-17v.sys.comcast.net with ESMTPSA
        id h1kmgZCB9Qhixh1kqgkbZ1; Wed, 09 Jan 2019 00:30:18 +0000
X-Xfinity-VMeta: sc=0;st=legit
Subject: Re: [PATCH v2 2/2] tree:<depth>: skip some trees even when collecting
 omits
To:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        pclouds@gmail.com
References: <20181210234030.176178-3-matvore@google.com>
 <20190108020034.23648-1-jonathantanmy@google.com>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <8cb0dd36-4c49-228e-17ad-538fb377ffe4@comcast.net>
Date:   Tue, 8 Jan 2019 16:29:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108020034.23648-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the review :) See below.

On 2019/01/07 18:00, Jonathan Tan wrote:
>> -static void filter_trees_update_omits(
>> +static int filter_trees_update_omits(
>>   	struct object *obj,
>>   	struct filter_trees_depth_data *filter_data,
>>   	int include_it)
>>   {
>>   	if (!filter_data->omits)
>> -		return;
>> +		return 1;
>>   
>>   	if (include_it)
>> -		oidset_remove(filter_data->omits, &obj->oid);
>> +		return oidset_remove(filter_data->omits, &obj->oid);
>>   	else
>> -		oidset_insert(filter_data->omits, &obj->oid);
>> +		return oidset_insert(filter_data->omits, &obj->oid);
>>   }
> I think this function is getting too magical - if filter_data->omits is
> not set, we pretend that we have omitted the tree, because we want the
> same behavior when not needing omits and when the tree is omitted. Could
> this be done another way?

Yes, returning a manipulative lie when omits is NULL is rather 
confusing. So I changed it to this (interdiff):

+/* Returns 1 if the oid was in the omits set before it was invoked. */
  static int filter_trees_update_omits(
      struct object *obj,
      struct filter_trees_depth_data *filter_data,
      int include_it)
  {
      if (!filter_data->omits)
-        return 1;
+        return 0;

      if (include_it)
          return oidset_remove(filter_data->omits, &obj->oid);
@@ -177,7 +178,7 @@ static enum list_objects_filter_result 
filter_trees_depth(

              if (include_it)
                  filter_res = LOFR_DO_SHOW;
-            else if (!been_omitted)
+            else if (filter_data->omits && !been_omitted)
                  /*
                   * Must update omit information of children
                   * recursively; they have not been omitted yet.

