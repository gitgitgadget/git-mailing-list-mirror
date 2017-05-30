Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AD72027C
	for <e@80x24.org>; Tue, 30 May 2017 23:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdE3XEx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:04:53 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:29231 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdE3XEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:04:51 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id FqC1d3bmYcpskFqC1d2fjx; Wed, 31 May 2017 00:04:49 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=oCcaPWc0AAAA:8 a=ggGe_nQQzwVECPAcrYEA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <E0D5AC60DB0F48DEBF865597910D9531@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley>        <xmqq37bpbx5t.fsf@gitster.mtv.corp.google.com>        <D689F4F80DA24C78B5E0FB025B9548E6@PhilipOakley>        <xmqqpoet9lms.fsf@gitster.mtv.corp.google.com>        <DE497A69E68043DABF9C3A7D9198B277@PhilipOakley> <xmqq1sr7f9nb.fsf@gitster.mtv.corp.google.com>
Subject: Re: mergetool: what to do about deleting precious files?
Date:   Wed, 31 May 2017 00:04:46 +0100
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
X-Antivirus: AVG (VPS 170530-4, 30/05/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfPHhAxRidCA8ULxDLOwMJ+fU6W2nJDz4bLbesu+zvBZV9rZ5g7ZdcsSV8oltIOE35pM5o9oODh0sSyG4IlXPzxlTbW5dSmzox7tK1buOw8s1bwOUAJ0v
 QE+h7nRixKWkPdz4SSivW/s3KsDI3wotewDIa/Q/Hb/RleRKszGtXD2EXNhJi9xCual8cwkL3NjeUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>

Thanks for the replies. Let's see if I've got it...

> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> If I now understand correctly, the merge process flow is:
>>
>> * canonicalise content (eol, smudge-clean, $id, renormalise, etc)
>> * diff the content (internal, or GIT_EXTERNAL_DIFF)
>> * apply the diff
>> * if conflicts, only then use merge-driver/tool
>>
>> Would that be a correct interpretation?
>
> Not quite.  There are a lot more going on before any of those steps:
>
> * Find the common ancestor commit (which could be many).

IIUC Git selects one of them, rather than all if there are many (which then 
may not be the optimum)

>
> * Walk the three trees (the common ancestor's, ours and theirs) in
>   parallel, noticing what happened to each path.  Depending on what
>   happened to the path in each branch, the merge may or may not
>   "conflict" (e.g. when both sides added exactly the same contents
>   to the same path, they are not counted as conflicting.  when we
>   removed while they modified, they show as conflicting).

I'm assuming here that this is the sha-oid comparison, and then checking the 
tree/blob names that match them. (the top tree not having a name). So here 
"conflict free" is that the sha-oids match.

Also, I thnk this is saying that added or removed trees or blobs are in some 
sense are 'conflict free' (though still subject to rename/move detection 
etc). An added file/blob would be conflict free for merging into it's tree, 
yes?

IIUC, the comparison is therefore using the in-repo sha-oids; 
unless --renormalise was given which will do a smudge-clean washing cycle 
and recomute fresh canonical sha-oids for the comparison (rather than doing 
it later).

>
> * For paths that are conflicting, feed the canonicalized content of
>   the versions from common, ours and theirs to the file-level merge
>   driver.

So this is where any .gitattibutes settings come in, or is the merge driver 
after the diff step? (which could also be a user diff?)

>        The builtin file-level merge driver takes two xdiff (one
>   between ancestor and ours, the other between ancestore and
>   theirs) and reconciles them to produce the result.  But that is
>   irrelevant in the context of "custom merge driver"; the builtin
>   one is skipped altogether and the custom contents merge driver
>   the user specified via the attributes is used instead.
>
> Notice that the second step above has no customization knobs.  Any
> path the second step deems not to conflict is "merged cleanly"
> without even triggering the "oops, ours and theirs did conflicting
> changes, to the content; let's see how the final content should look
> like" (aka the third step).  This is *not* because "Git knows the
> best"; it is merely that nobody felt the need for a mechanism to
> allow customizing the second step.
>
> And that is why I said you need a new customization mechanism if you
> want to affect the outcome of the scenario that started this thread.

Ok, I think I can see how I was confused between the "tree merge" (oid 
conflict detection) and the more usual (to users) "file merge" (line by 
line, etc.). I wasn't sure where to find that as someone relatively new to 
Git.

Thanks for the explanations.
--
Philip 


---
This email has been checked for viruses by AVG.
http://www.avg.com

