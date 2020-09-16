Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF777C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F676208E4
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="R8Tw4kaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgIPT7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:59:38 -0400
Received: from out0-148.mail.aliyun.com ([140.205.0.148]:52655 "EHLO
        out0-148.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgIPRfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1600277706; h=Subject:From:Message-ID:Date:MIME-Version:Content-Type;
        bh=tCViVwE7V8tHH/vANRq+ZxTjZU9jw8Ojm6xLuwsUNyM=;
        b=R8Tw4kaWGJ4VJYCqJwhL5p9hvtJkz7XAqhra2zkQLMkxTI0CS8sdnUgd1QWtffp98/T16Q3UE52a6FkjJju94lwi66WENitxULBUGOkDRiCC4Fq4/NP3dCZDXE8p0L3OySfRD9CkDpVIPc+pQZX6JUrsr9Ntu/q2kEuetbM2Z6o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e02c03294;MF=hanxin.hx@alibaba-inc.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---.IXvQe0L_1600277706;
Received: from chitiandeMacBook-Pro-3.local(mailfrom:hanxin.hx@alibaba-inc.com fp:SMTPD_---.IXvQe0L_1600277706)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Sep 2020 01:35:06 +0800
Subject: Re: [PATCH 2/2] send-pack: check atomic push before running GPG
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
 <20200915095827.52047-2-hanxin.hx@alibaba-inc.com>
 <xmqqmu1qzrbo.fsf@gitster.c.googlers.com>
 <CANYiYbHYi70ZcjDTyQ++_+njuZMF=TksPepH+wP+zNmhBABNAg@mail.gmail.com>
 <xmqqeen2xrok.fsf@gitster.c.googlers.com>
Cc:     Git List <git@vger.kernel.org>
From:   "=?UTF-8?B?6Z+p5qyjKOeCveWkqSk=?=" <hanxin.hx@alibaba-inc.com>
Message-ID: <c1af693a-b861-6b37-96a6-9d121a3a3f99@alibaba-inc.com>
Date:   Thu, 17 Sep 2020 01:35:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqeen2xrok.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


ÔÚ 2020/9/16 ÏÂÎç12:37, Junio C Hamano Ð´µÀ:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>>>> -
>>>> -     if (!args->dry_run && push_cert_nonce)
>>>> -             cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
>>>> -                                            cap_buf.buf, push_cert_nonce);
>>>> -
>>>>        /*
>>>>         * Clear the status for each ref and see if we need to send
>>>>         * the pack data.
>>> This "Clear the status for each ref" worries me.
>>>
>>> The generate_push_cert() function RELIES on ref->status and filters
>>> out the ref that failed to pass the local check from the generated
>>> push certificate.  If you let the loop (post context of this hunk)
>>> run, ref->status will be updated by it, so the net effect of this
>>> patch is that it breaks "non-atomic" case that pushes multiple refs
>>> and one of ref fails to pass the local check.
>>>
>>> IOW, generate_push_cert() MUST be called before this loop "clears
>>> the status for each ref" by assigning to ref->status.
>> The next block ("Finally, tell the other end!") is what we send
>> commands to "receive-pack", right after some of the status are reset
>> to REF_STATUS_OK or REF_STATUS_EXPECTING_REPORT by this chunk of code.
>> So moving the generate_push_cert() part right before the "Finally,
>> tell the other end!" part LGTM.
> Sorry, I do not follow.  The loop in question is the one before
> "Finally tell the other end".  The loop ends like so:
>
> 	for (ref = remote_refs; ref; ref = ref->next) {
> 		...
> 		if (args->dry_run || !status_report)
> 			ref->status = REF_STATUS_OK;
> 		else
> 			ref->status = REF_STATUS_EXPECTING_REPORT;
> 	}
>
> and the patch moves a call to generate_push_cert() that looks at
> remote_refs _after_ this loop, but generate_push_cert() function
> uses a loop over remote_refs that uses check_to_send_update(), which
> looks at ref->status's value to decide what to do.  Its correct
> operation relies on ref->status NOT updated by the above loop.
>
> The loop prepares the status field so that we can then read and
> record the response against each ref updates from the other side.
>
> The ref->status field is set to EXPECTING_REPORT, later to be
> updated to REF_STATUS_OK or REF_STATUS_REMOTE_REJECT.  We can
> clobber the original value of ref->status at this point only because
> the loop depends on the fact that no check_to_send_update() call
> will happen after the loop (because the ref->status field the
> helper's operation depends on is already reset for the next phase of
> operation).  The patch that moves generate_push_cert() call below
> the loop, whether it is before or after the "Finally tell the other
> end" loop, is therefore fundamentally broken, isn't it?
>
> I do not think it would introduce such breakage if we teach
> generate_push_cert() to pay attention to the atomicity, and that can
> be done without reordering the calls in send_pack() to break the
> control flow.

Thank you for your reply. These loops here really confuse me at first.

But I found that the main effect of "Clear the status for each ref and
see if we need to send the pack data" is to help us do a pre-check on
the client side whether the push should be rejected. When the reference
should be pushed, whether the status was changed to REF_STATUS_OK or
REF_STATUS_EXPECTING_REPORT, it does not seem to affect the result of
function generate_push_cert(). check_to_send_update() in
generate_push_cert() only filters out references that needn't to be pushed.

Just like brian m. carlson said, "that would be a nice change; after
all, the user's key may involve a smartcard or a passphrase and avoiding
needless hassle for the user would be desirable". It increase the
perforcemance a little bit for failed atomic push and make it clear that
client side requirements and the other side requirements.

If there is something wrong with my understanding, I am very grateful
\that you can help me point out the problems.
