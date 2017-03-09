Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E17202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 17:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932849AbdCIRuY (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 12:50:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbdCIRuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 12:50:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5601E607B5; Thu,  9 Mar 2017 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489081822;
        bh=g+EyCESKMIKlkSpPJjTP9cQ0Y/JgF61bumV6vV0KvqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S6AuOd/zV9cVwKko6GKtsA8XXsv+evFjaMQeExOTNcUvROjK2a4WhH5oTWqwwrWXU
         ny3/ybGFFTcNFopwwrZhgSLjwlTBw0Jl4HZ9ORqCgOknInEZcAz2ywSYl0PQBuYRph
         Te/NkLWs2tTwp6xBHwWvz6yfFhIeQMNzgk8FEgaU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E8EA760713;
        Thu,  9 Mar 2017 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489081822;
        bh=g+EyCESKMIKlkSpPJjTP9cQ0Y/JgF61bumV6vV0KvqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S6AuOd/zV9cVwKko6GKtsA8XXsv+evFjaMQeExOTNcUvROjK2a4WhH5oTWqwwrWXU
         ny3/ybGFFTcNFopwwrZhgSLjwlTBw0Jl4HZ9ORqCgOknInEZcAz2ywSYl0PQBuYRph
         Te/NkLWs2tTwp6xBHwWvz6yfFhIeQMNzgk8FEgaU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Mar 2017 10:50:21 -0700
From:   jmelvin@codeaurora.org
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, nasserg@codeaurora.org, mfick@codeaurora.org,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH] repack: Add options to preserve and prune old pack files
In-Reply-To: <xmqq4lz4968p.fsf@gitster.mtv.corp.google.com>
References: <20170307164035.27866-1-jmelvin@codeaurora.org>
 <xmqq4lz4968p.fsf@gitster.mtv.corp.google.com>
Message-ID: <1d816bbb08b228ece9a74ffcdfb7a5b1@codeaurora.org>
X-Sender: jmelvin@codeaurora.org
User-Agent: Roundcube Webmail/1.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-07 13:33, Junio C Hamano wrote:
> James Melvin <jmelvin@codeaurora.org> writes:
> 
>> These options are designed to prevent stale file handle exceptions
>> during git operations which can happen on users of NFS repos when
>> repacking is done on them. The strategy is to preserve old pack files
>> around until the next repack with the hopes that they will become
>> unreferenced by then and not cause any exceptions to running processes
>> when they are finally deleted (pruned).
> 
> I find it a very sensible strategy to work around NFS, but it does
> not explain why the directory the old ones are moved to need to be
> configurable.  It feels to me that a boolean that causes the old
> ones renamed s/^pack-/^old-&/ in the same directory (instead of
> pruning them right away) would risk less chances of mistakes (e.g.
> making "preserved" subdirectory on a separate device mounted there
> in a hope to reduce disk usage of the primary repository, which
> may defeat the whole point of moving the still-active file around
> instead of removing them).

Moving the preserved pack files to a separate directory only helped make 
the pack directory cleaner, but I agree that having the old* pack files 
in the same directory is a better approach as it would ensure that it's 
still on the same mounted device. I'll update the logic to reflect that.

As for the naming convention of the preserved pack files, there is 
already some logic to remove "old-" files in repack. Currently this is 
the naming convention I have for them:

pack-<sha1>.old-<ext>
pack-7412ee739b8a20941aa1c2fd03abcc7336b330ba.old-pack

One advantage of that is the extension is no longer an expected one, 
differentiating it from current pack files.

That said, if that is not a concern, I could prefix them with 
"preserved" instead of "old" to differentiate them from the other logic 
that cleans up "old-*". What are your thoughts on that?

preserved-<sha1>.<ext>
preserved-7412ee739b8a20941aa1c2fd03abcc7336b330ba.pack


> And if we make "preserve-old" a boolean, perhaps the presence of
> "prune-preserved" would serve as a substitute for it, iow, perhaps
> we may only need --prune-preserved option (and repack.prunePreserved
> configuration variable)?
> 
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index 677bc7c81..f1a0c97f3 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -10,8 +10,10 @@
>> 
>>  static int delta_base_offset = 1;
>>  static int pack_kept_objects = -1;
>> +static int preserve_oldpacks = 0;
>> +static int prune_preserved = 0;
> 
> We avoid initializing statics to 0 or NULL and instead let BSS take
> care of them...

Will do

>>  static int write_bitmaps;
>> -static char *packdir, *packtmp;
>> +static char *packdir, *packtmp, *preservedir;
> 
> ... just like what you did here.
> 
>> @@ -108,6 +110,27 @@ static void get_non_kept_pack_filenames(struct s
>> ...
>> +static void preserve_pack(const char *file_path, const char 
>> *file_name,  const char *file_ext)
>> +{
>> +	char *fname_old;
>> +
>> +	if (mkdir(preservedir, 0700) && errno != EEXIST)
>> +		error(_("failed to create preserve directory"));
> 
> You do not want to do the rest of this function after issuing this
> error, no?  Because ...

Agreed, I'll update.

>> +
>> +	fname_old = mkpathdup("%s/%s.old-%s", preservedir, file_name, 
>> ++file_ext);
>> +	rename(file_path, fname_old);
> 
> ... this rename(2) would fail, whose error return you would catch
> and act on.
> 
>> +	free(fname_old);
>> +}
>> +
>> +static void remove_preserved_dir(void) {
>> +	struct strbuf buf = STRBUF_INIT;
>> +
>> +	strbuf_addstr(&buf, preservedir);
>> +	remove_dir_recursively(&buf, 0);
> 
> This is a wrong helper function to use on files and directories
> inside .git/; the function is about removing paths in the working
> tree.

Will update.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
