Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3087820D0A
	for <e@80x24.org>; Mon, 29 May 2017 12:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdE2M5T (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 08:57:19 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:45087 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdE2M5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 08:57:18 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id FKEQdzM7rxR4bFKERdJ9aE; Mon, 29 May 2017 13:57:11 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=_Pvd7nfZ6kD8Oj-kfqIA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <DE497A69E68043DABF9C3A7D9198B277@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley>        <xmqq37bpbx5t.fsf@gitster.mtv.corp.google.com>        <D689F4F80DA24C78B5E0FB025B9548E6@PhilipOakley> <xmqqpoet9lms.fsf@gitster.mtv.corp.google.com>
Subject: Re: mergetool: what to do about deleting precious files?
Date:   Mon, 29 May 2017 13:57:08 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFDKod1bgg2ig1ijlDRUsiS0i4RLg6kr0HcZlZBHOSx8x45BhCXHD2DRMhHsSFPYPBEoac+ggbm2aR21mGoakXDHgA5yBY3Gs7WmS3qx0XrcKaR7dWCM
 fTaNZk+wgOSBaUE1dP/6C1FTZMuvKib2ZhaV2A//CjCVJD1Crv2jk8qtfJkHpPz6Bhf6LIxaQitYnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> So I do not think this is not limited to "new file".  Anything that
>>> a tree-level three-way merge would resolve cleanly without having to
>>> consult the content-level three-way merge will complete without
>>> consulting the merge.ours.driver; per-file content-level three-way
>>> merge driver (which is what merge=<drivername> mechanism lets you
>>> specify via the attributes mechanism) is not something you would
>>> want to use for this kind of thing.  It is purely for resolving the
>>> actual content-level conflicts.
>>>
>> That (that Git knows best) sounds just wrong.
>
> Don't twist my words.  I never said Git knows best.

The part I was responding to was "would resolve cleanly without having to
consult the content-level three-way merge will complete without
consulting the merge.ours.driver".

It was that lack of consultation (by git) of the putative merge-driver that 
was being noted.

The general misunderstanding, as I now see it, is the (false) expectation 
that a merge-driver would do the whole merge process.

It took a bit of digging through the documentation for me to find out just 
what the merge process appears to be. I'm sure that it obvious to those who 
have worked with git from the beginning and the previous patch flow process, 
but the merge process wasn't obvious to me, and various blogs and SO Q&A on 
the issue suggest the same for many others.

If I now understand correctly, the merge process flow is:

* canonicalise content (eol, smudge-clean, $id, renormalise, etc)
* diff the content (internal, or GIT_EXTERNAL_DIFF)
* apply the diff
* if conflicts, only then use merge-driver/tool

Would that be a correct interpretation?



>
> The user-level merge driver is a mechanism to affect conflict level
> three-way merges.  The interface to the content level three-way
> merge driver feeds three versions of blobs and the driver is
> expected to give a merged result.  The interface as designed is
> incapable of passing "here is the common ancestor", "our side is
> missing" and "their side is this content".
>
> So if we want a mechanism that can affect the outcome of tree-level
> three-way merge, we need a _new_ mechanism.  The existing merge
> drivers that are written by end users (at least the ones written
> correctly to the spec, anyway) are not expecting to be called with
> "in our tree, there is no blob here", and trying to piggyback on it
> will break existing users.

Is an alternative to use the GIT_EXTERNAL_DIFF to create a nul diff, so no 
changes are applied (precious/sensitive file is left behind)? This would 
have no conflicts and no requirement for a merge-conflict driver.

--

Philip 

