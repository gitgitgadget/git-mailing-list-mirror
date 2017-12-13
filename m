Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9191F407
	for <e@80x24.org>; Wed, 13 Dec 2017 13:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdLMNRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 08:17:09 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:49503 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbdLMNRI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 08:17:08 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id P6uIeI73lCbAZP6uIeDJwN; Wed, 13 Dec 2017 13:17:07 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=z-o7bWF98slI6u58lWkA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <2078863B63F54322A0C9455C8BC98C9D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Jeff Hostetler" <git@jeffhostetler.com>, <git@vger.kernel.org>,
        <peff@peff.net>, <jonathantanmy@google.com>,
        "Jeff Hostetler" <jeffhost@microsoft.com>
References: <20171208192636.13678-1-git@jeffhostetler.com><20171208192636.13678-2-git@jeffhostetler.com><46D2661C19CD4ADE81699FE7E99712EE@PhilipOakley> <xmqqlgi7xzwq.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] partial-clone: design doc
Date:   Wed, 13 Dec 2017 13:17:04 -0000
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
X-Antivirus: AVG (VPS 171212-0, 12/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfHscsUbgW/lyOhQtwmWvmeGYqIFyG6laATCMWn9flrAkfjWlKj2HCsGfnXyICPYZvHMC5ZrAUXXXbWfXqJwAe5gN7l5LqTTSOwwUXiYAA2s7DunyS5Uo
 RPAgFACgT6pGFbrRQVnPMFD5Ni8XpcPZAMGVR8zxcFRHR2yhMYDDS0vr6YPNvThJxv/IJaCGbBUcW5wCTJpiEiYGcjsO+ZYNh7/8GVVoHk7SJUK5vHp5xT2A
 /7JRwTMfzvIDPwidFJ/X7GXenlgRcGdbARZeUJMzzWspjrZAQRJviJuwfkl3FdmQMFrHKXUUrd3FLU9UG81zTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> +  These filtered packfiles are incomplete in the traditional sense
>>> because
>>> +  they may contain trees that reference blobs that the client does
>>> not have.
>>
>> Is a comment needed here noting that currently, IIUC, the complete
>> trees are fetched in the packfiles, it's just the un-necessary blobs
>> that are omitted ?
>
> I probably am misreading what you meant to say, but the above
> statement with "currently" taken literally to mean the system
> without JeffH's changes, is false.

I was meaning the current JeffH's V6 series, rather than the last Git 
release.

In one of the previous discussions Jeff had noted that (at that time) his 
partial design would provide a full set of trees for the selected commits 
(excluding the trees already available locally), but only a few of the file 
blobs (based on the filter spec).

So yes, I should have been clearer to avoid talking at cross purposes.

>
> When the receiver says it has commit A and the sender wants to send
> a commit B (because the receiver said it does not have it, and it
> wants it), trees in A are not sent in the pack the sender sends to
> give objects sufficient to complete B, which the receiver wanted to
> have, even if B also has those trees.  If you fetch from me twice
> and between that time Documentation/ directory did not change, the
> second fetch will not have the tree object that corresponds to that
> hierarchy (and of course no blobs and sub trees inside it).

Though, after the fetch has completed (v2.15 Git), the receiver will have 
the 'full set of trees and blobs'. In Jeff's design (V6) the reciever would 
still have a full set of trees, but only a partial set of the blobs. So my 
viewpoint was not of the pack file but of the receiver's object store after 
the fetch.

>
> So "the complete trees are fetched" is not true.  What is true (and
> what matters more in JeffH's document) is that fetching is done in
> such a way that objects resulting in the receiving repository are
> complete in the current system that does not allow promised objects.
> If some objects resulting in the receiving repository are incomplete,
> the current system considers that we corrupted the repository.
>
> The promise mechanism says that it is fine for the receiving end to
> lack blobs, trees or commits, as long as the promisor repository
> tells it that these "missing" objects can be obtained from it later.

True. (though I'm not sure exactly how Jeff decides about commits - I 
thought theye were not part of this optimisation)

> The way the receiving end which notices that it does not have an
> otherwise required blob, tree or commit is one promised by the
> promisor repository is to see if it is referenced by a pack that
> came from such a promisor repository.

.. and marked as such with the ".promisor" extension.
>
>
Thanks. 

