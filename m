Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7733C20248
	for <e@80x24.org>; Tue, 12 Mar 2019 14:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCLOUG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 10:20:06 -0400
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:44742 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLOUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 10:20:05 -0400
X-Greylist: delayed 1009 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 10:20:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk;
         s=20180806.ppsw; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date
        :Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mkKkKf39fk4QeVkBB6SPzq2We1TsICIztbqd6lS0TNs=; b=RXEnNwKl7XSc0EdfMLzKu7odjQ
        8mPwWJLoyz7zm8WhhCZrEcUxpk+8gWWNtFRdSpO1/2XM+ChGKVSUdbFn25UHqkm1lorR3+/3nxIR4
        YUYh+7zclD/R68lcbsFvFGWfwbPaVbzwih9FUf39eqWOG6aslSAVDE4dV9lpUD1Opbc8=;
X-Cam-AntiVirus: not scanned (internal relaying)
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from webmail-1b.csi.cam.ac.uk ([131.111.9.33]:54876)
        by ppsw-31.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.137]:25)
        with esmtp id 1h3hzw-000Zbs-Jb (Exim 4.91)
        (return-path <nwf20@cam.ac.uk>); Tue, 12 Mar 2019 14:03:16 +0000
Received: from [127.0.0.1] (helo=webmail-2.hermes.cam.ac.uk)
        by webmail-1b.csi.cam.ac.uk with esmtp id 1h3hzw-00065y-2J (Exim 4.91)
        (return-path <nwf20@cam.ac.uk>); Tue, 12 Mar 2019 14:03:16 +0000
Received: from dhcp-10-248-124-118.eduroam.wireless.private.cam.ac.uk
 ([10.248.124.118])
 by webmail-2.hermes.cam.ac.uk
 with HTTP (HTTP/1.1 POST); Tue, 12 Mar 2019 14:03:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-User: nwf20
Date:   Tue, 12 Mar 2019 14:03:16 +0000
From:   "Dr N.W. Filardo" <nwf20@cam.ac.uk>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] repack: add --sparse and pass to pack-objects
In-Reply-To: <f26c68df-8895-2a2d-0175-5fa3581ab45a@gmail.com>
References: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
 <20190312131858.26115-4-nwf20@cl.cam.ac.uk>
 <f26c68df-8895-2a2d-0175-5fa3581ab45a@gmail.com>
Message-ID: <ad762ef2fbe9f268068b9a406070591b@cam.ac.uk>
X-Sender: nwf20@cam.ac.uk
User-Agent: Roundcube Webmail/1.0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-03-12 13:47, Derrick Stolee wrote:
> On 3/12/2019 9:18 AM, Nathaniel Filardo wrote:
>> The sparse connectivity algorithm saves a whole lot of time when there
>> are UNINTERESTING trees around.
> 
> Interesting! Do you have some performance numbers to include with
> this statement?

Not UNINTERESTING? ;)

Not directly, no, but the performance numbers reported for the next 
patch in
the series hinge on using sparse reachability.  It seemed like a good 
idea to
expose this knob through repack even if one isn't going to use the
--assume-pack-keep-transitive flag introduced in the next patch.

>> @@ -48,6 +49,10 @@ static int repack_config(const char *var, const 
>> char *value, void *cb)
>>  		use_delta_islands = git_config_bool(var, value);
>>  		return 0;
>>  	}
>> +	if (!strcmp(var, "pack.usesparse")) {
>> +		sparse = git_config_bool(var, value);
>> +		return 0;
>> +	}
> 
> This part is not handled inside of `pack-objects`. Since you are not
> sending '--no-sparse' when the variable 'sparse' is zero, the config
> setting will automatically be picked up by the pack-objects builtin.

OK, I will drop this hunk.

> Now, a question of whether you _should_ allow the '--no-sparse' option
> in the 'repack' command, and send it along to the inner command (when
> it is present) is another question.

I'm inclined to say yes, but am open to suggestions. :)

>> @@ -366,6 +374,8 @@ int cmd_repack(int argc, const char **argv, const 
>> char *prefix)
>>  	argv_array_push(&cmd.args, "--all");
>>  	argv_array_push(&cmd.args, "--reflog");
>>  	argv_array_push(&cmd.args, "--indexed-objects");
>> +	if (sparse)
>> +		argv_array_push(&cmd.args, "--sparse");
>>  	if (repository_format_partial_clone)
>>  		argv_array_push(&cmd.args, "--exclude-promisor-objects");
>>  	if (write_bitmaps)
>> 
> 
> How about a test with this new option? You can probably just add to
> t5322-pack-objects-sparse.sh.

Can do.

Cheers,
--nwf;

