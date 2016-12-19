Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715E61FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbcLSR41 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:56:27 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36061 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932720AbcLSR4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:56:25 -0500
Received: by mail-qt0-f173.google.com with SMTP id w33so154172356qtc.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 09:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n/7BgvFmox9lN6mEnWNlp4R+b19WBFv/PFepGxOLEds=;
        b=cve8nYrfRZzVHAcbYL3GJj+ypB2yiC383K0NRxZwfGCv9TRkljolOQjNcTfq/EhODi
         9onndEbPRN51d/Mo4oMFt+vKHq/iiv4x+Q7tTV9EsTrCEB3cW1ThaMiJ30div2x6O3AY
         Rq//dZL9q8Syvmc2cQxNu4RnwNsrdcEFjMSZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n/7BgvFmox9lN6mEnWNlp4R+b19WBFv/PFepGxOLEds=;
        b=a7iL8qMCBoX7FXfhL9gOufd8OvnOrqLre2yNZgJKj1iff8KlnsW0HD/ibYOzLEUjyK
         1+ToTf1OekmfNhmcGexMcpf5n1H79TjWyWhqgxoXze8TiudsrHNSbIAbZ8hS3MNAtQ55
         dc06eQM1M+jzm5rZtbeAgA7ET5WGPjUrl8R3VwVB+8otkxymFMFdbQMNb7fxRJS+hC/O
         FA57c5mtogZDsim6FoWYFD3+mO1CVDxV4VmP6/hCTDThToSMnuMOM8Fo3sYzC6c9LSgs
         vY3EEBMAloyDsw3Dy6neHKf4CsRfQYbkf4qP8kES86/PFtRDidAi90U2KHfod72Gd1FV
         IAoQ==
X-Gm-Message-State: AIkVDXLDSzp5MSj286xXRsyswoYEdwn+9b/jb5IXwF+cxXl8Z3/G0ygldw6pklJOtx55EJbRj/ezVmvX9K4mcg==
X-Received: by 10.200.41.9 with SMTP id y9mr18090252qty.26.1482170184845; Mon,
 19 Dec 2016 09:56:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Mon, 19 Dec 2016 09:56:24 -0800 (PST)
In-Reply-To: <xmqqy3zbq05o.fsf@gitster.mtv.corp.google.com>
References: <01020159037a8995-2d1da9d4-4a27-4b98-818b-432fc0ad8a52-000000@eu-west-1.amazonses.com>
 <010201590ed6ecaa-740c2532-827e-4f5a-af46-0f58d0722db6-000000@eu-west-1.amazonses.com>
 <xmqqy3zbq05o.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 19 Dec 2016 17:56:24 +0000
Message-ID: <CAE5ih7_KKLiifY5K6k2u-VJcJvizhgXRLKz5+DLahoudwXhELg@mail.gmail.com>
Subject: Re: [PATCH v2] git-p4: Fix multi-path changelist empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        George Vanburgh <george@vanburgh.me>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 December 2016 at 17:49, Junio C Hamano <gitster@pobox.com> wrote:
> George Vanburgh <george@vanburgh.me> writes:
>
>> From: George Vanburgh <gvanburgh@bloomberg.net>
>>
>> When importing from multiple perforce paths - we may attempt to import
>> a changelist that contains files from two (or more) of these depot
>> paths. Currently, this results in multiple git commits - one
>> containing the changes, and the other(s) as empty commit(s). This
>> behavior was introduced in commit 1f90a64
>> ("git-p4: reduce number of server queries for fetches", 2015-12-19).
>>
>> Reproduction Steps:
>>
>> 1. Have a git repo cloned from a perforce repo using multiple depot
>> paths (e.g. //depot/foo and //depot/bar).
>> 2. Submit a single change to the perforce repo that makes changes in
>> both //depot/foo and //depot/bar.
>> 3. Run "git p4 sync" to sync the change from #2.
>>
>> Change is synced as multiple commits, one for each depot path that was
>> affected.
>>
>> Using a set, instead of a list inside p4ChangesForPaths() ensures that
>> each changelist is unique to the returned list, and therefore only a
>> single commit is generated for each changelist.
>>
>> Reported-by: James Farwell <jfarwell@vmware.com>
>> Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
>> ---
>
> Thanks, George.  Luke, can I add your "Reviewed-by:" here?

Yes, thanks.

Luke
