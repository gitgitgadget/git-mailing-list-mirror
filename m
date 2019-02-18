Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3261F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfBRVRa (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:17:30 -0500
Received: from p3plsmtpa09-06.prod.phx3.secureserver.net ([173.201.193.235]:33128
        "EHLO p3plsmtpa09-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729382AbfBRVRa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 16:17:30 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id vqI1gBTKEyW2MvqI4gPxRo; Mon, 18 Feb 2019 14:17:29 -0700
Date:   Mon, 18 Feb 2019 23:17:25 +0200
From:   Max Kirillov <max@max630.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Max Kirillov' <max@max630.net>
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Message-ID: <20190218211725.GD3373@jessie.local>
References: <pull.126.git.gitgitgadget@gmail.com>
 <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com>
 <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com>
 <87pnroolgy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnroolgy.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfLM1MNFK7acZcUqp0GG5Xu61cNWavcpvd4e860FYwotnvkynX0tTyJlA84hd6tuRTgsAIz8qli+7Wxmfid3AbNf0wZCUG80Wi53bLj4IDKJJbYFMJ9Qb
 iLTLt4IvmxUmlcFFKXvY9+lV8XQKHHOb3vABmIadO2rBkXP4cn9V3U6nfOk7AT0+Ogd2rld8ZdKLtXsRL1J+Ie/mmDdHiv2BRSqEL6leGoiHHeIjpTgfltMW
 35LERn69TERuVYdzqcvFONlojoS+NE6o7AftMWPuP6j3sB/R6X8SxfNiS+Gc+7ZuQIKwtx9QnU/0uX9xmySeKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 10:06:21PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> But in our attempt to exit(), we try to "cleanup children" and that
>> is what gets stuck.
> 
> I have not paid enough attention to this thread to say if this is dumb,
> but just in case it's useful. For this class of problem where cleanup
> bites you for whatever reason in Perl, you can sometimes use this:
> 
>     use POSIX ();
>     POSIX::_exit($code);
> 
> This will call "exit" from "stdlib" instead of Perl's "exit". So go away
> *now* and let the OS deal with the mess. Perl's will run around cleaning
> up stuff, freeing memory, running destructors etc, all of which might
> have side effects you don't want/care about, and might (as maybe in this
> case?) cause some hang.

* Perl is running in foreground, so it cannot outlive test
  case and spoil the subsequent ones.
* From the dumps I have an impression that it waits
  legitimately - there are other processes to wait for.
  And anyway the waits happen before perl script comes to
  its exit.

Though I am already convinced that I should have done the
helper in C. Let's see when I have time to fix it.
