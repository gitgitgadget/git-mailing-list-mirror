Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F941F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeCTSjO (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:39:14 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:22510 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTSjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:39:13 -0400
Received: from [192.168.2.201] ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yMAAepNSHC0WbyMAAev4RK; Tue, 20 Mar 2018 18:39:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521571151;
        bh=qVxbgwvTKRIMIjf/C2lDTybiDl2eeU1Tcquf8FL3cSU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=liE2ZkBTa4YF2M8U7IICF2lA2u2/AcLwFRavTpW88+VwnmXwuF8xT3Mv79u0iF4SS
         Bz0Ox6nrjF7Nv+f5/f+gIP7VA7e4AP8q8c2444AujTUua/Ik3Bm/x9fv3jKofxHbwk
         8EtKeuBMto7gmv8STCHfNlkQJ0IwNFBdwYCbwqOo=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=IkcTkHD0fZMA:10 a=sbC5Gchgmdg4zwCR1FcA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] rebase -i --keep-empty: don't prune empty commits
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
References: <20180320100315.15261-1-phillip.wood@talktalk.net>
 <20180320100315.15261-3-phillip.wood@talktalk.net>
 <nycvar.QRO.7.76.6.1803201630380.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqfu4uslar.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <68c15e00-139d-b45c-bc76-cf1c99d2f1e4@talktalk.net>
Date:   Tue, 20 Mar 2018 18:39:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu4uslar.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJJ0n+l4ZdDXXk2Rtw8nmth7argAulkfEwCiJWsV2RNWEqNLRyWfxGt0ZbQSuTBUR6kB0HKJAxn3rWYhLh2DRkkZ0saRFn7Z2n8Hjd8r3SfVeyhYWtup
 VKa9mYnalrL5Q+2IxD+SnC+HzV91iUjb+l+nTssjrFZfm4GRjysWC0AxI1Ox/e4yLXhDujoP/EZYhgiadhnANFLSgiNivJqIjWxiUrlfBl2OqTTqpbhudqxy
 fdkgaIZ1CWUJQ5HDk0mTCwYciIHWPlfc8Q7TO3Dg38JE1YojRI+GH8A+8P7bRi8N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/03/18 17:34, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> +		if (!keep_empty && is_empty)
>>>  			strbuf_addf(&buf, "%c ", comment_line_char);
> 
> We are not trying to preserve an empty one, and have found an empty
> one, so we comment it out, and then...
> 
>>> +		if (is_empty || !(commit->object.flags & PATCHSAME)) {
>>
>> May I suggest inverting the logic here, to make the code more obvious and
>> also to avoid indenting the block even further?
>>
>> 		if (!is_empty && (commit->object.flags & PATCHSAME))
>> 			continue;
> 
> ... if a non-empty one that already appears in the upstream, we do
> not do anything to it.  There is no room for keep-empty or lack of
> it to affect what happens to these commits.
> 
> Otherwise the insn is emitted for the commit.
> 
>>> +			strbuf_addf(&buf, "%s %s ", insn,
>>> +				    oid_to_hex(&commit->object.oid));
>>> +			pretty_print_commit(&pp, commit, &buf);
>>> +			strbuf_addch(&buf, '\n');
>>> +			fputs(buf.buf, out);
>>> +		}
> 
> I tend to agree that the suggested structure is easier to follow
> than Phillip's version.
> 
> But I wonder if this is even easier to follow.  It makes it even
> more clear that patchsame commits that are not empty are discarded
> unconditionally.
> 
> 	while ((commit = get_revision(&revs))) {
> 		int is_empty  = is_original_commit_empty(commit);
> 		if (!is_empty && (commit->object.flags & PATCHSAME))
> 			continue;
> 		strbuf_reset(&buf);
> 		if (!keep_empty && is_empty)
> 			strbuf_addf(&buf, "%c ", comment_line_char);
> 		strbuf_addf(&buf, "%s %s ", insn,
> 			    oid_to_hex(&commit->object.oid));
> 		pretty_print_commit(&pp, commit, &buf);
> 		strbuf_addch(&buf, '\n');
> 		fputs(buf.buf, out);
> 	}
> 
> Or did I screw up the rewrite?
> 
I've not tested it but I think it's OK, I agree that it is clearer than
my version

Best Wishes

Phillip
