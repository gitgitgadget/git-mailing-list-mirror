Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7A720C11
	for <e@80x24.org>; Sun,  3 Dec 2017 23:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbdLCXOM (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 18:14:12 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:57095 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdLCXOL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 18:14:11 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LdSaepA5SmITaLdSaeVzUP; Sun, 03 Dec 2017 23:14:09 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=Dx4yW56zAAAA:8
 a=JZQsxJmmSXodm_RELncA:9 a=eWQgC80g4mGystdA:21 a=AgB3QmJ7P7vHaNv3:21
 a=QEXdDO2ut3YA:10 a=X_u8qhY6y2Nm79co_leF:22
Message-ID: <A05AA29AD20041A2B31E7A5CD56BB682@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>, <git@vger.kernel.org>
References: <004201d36ac8$db62b900$92282b00$@nexbridge.com> <bdd01692-198a-f5ec-3c88-7d99e4adced5@jeffhostetler.com> <004701d36ad2$9a7fcea0$cf7f6be0$@nexbridge.com>
Subject: Re: [RFE] Inverted sparseness
Date:   Sun, 3 Dec 2017 23:14:09 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171203-0, 03/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfORYh4r0wvT1CD8fgt/wBt48Yjj4Q+0neTEQ26ZWAlhDF1Zb231/d28gTi7uX4sadpXLbaia8wy5tXOykQxDrYcUnHHgaRdzzG4LCnfXEZBLtpf+6rq3
 auzGRiucbOEWElAkqHCA6ryPyiu/D+2ahy5QNsGnqPTHOBRob0mLmDmHAKTiAdnd8aneQ0wp1Z+G6HZzQHXI5RU+iO68kzYCGUhN1YGgGjIR6R6OXNB7CVMR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>
Sent: Friday, December 01, 2017 6:31 PM
> On December 1, 2017 1:19 PM, Jeff Hostetler wrote:
>>On 12/1/2017 12:21 PM, Randall S. Becker wrote:
>>> I recently encountered a really strange use-case relating to sparse 
>>> clone/fetch that is really backwards from the discussion that has been 
>>> going on, and well, I'm a bit embarrassed to bring it up, but I have no 
>>> good solution including building a separate data store that will end up 
>>> inconsistent with repositories (a bad solution).  The use-case is as 
>>> follows:
>>>
>>> Given a backbone of multiple git repositories spread across an 
>>> organization with a server farm and upstream vendors.
>>> The vendor delivers code by having the client perform git pull into a 
>>> specific branch.
>>> The customer may take the code as is or merge in customizations.
>>> The vendor wants to know exactly what commit of theirs is installed on 
>>> each server, in near real time.
>>> The customer is willing to push the commit-ish to the vendor's upstream 
>>> repo but does not want, by default, to share the actual commit contents 
>>> for security reasons.
>>> Realistically, the vendor needs to know that their own commit id was put 
>>> somewhere (process exists to track this, so not part of the use-case) 
>>> and whether there is a subsequent commit contributed >by the customer, 
>>> but the content is not relevant initially.
>>>
>>> After some time, the vendor may request the commit contents from the 
>>> customer in order to satisfy support requirements - a.k.a. a defect was 
>>> found but has to be resolved.
>>> The customer would then perform a deeper push that looks a lot like a 
>>> "slightly" symmetrical operation of a deep fetch following a prior 
>>> sparse fetch to supply the vendor with the specific commit(s).
>
>>Perhaps I'm not understanding the subtleties of what you're describing, 
>>but could you do this with stock git functionality.
>
>>Let the vendor publish a "well known branch" for the client.
>>Let the client pull that and build.
>>Let the client create a branch set to the same commit that they fetched.
>>Let the client push that branch as a client-specific branch to the vendor 
>>to indicate that that is the official release they are based on.
>
>>Then the vendor would know the official commit that the client was using.
> This is the easy part, and it doesn't require anything sparse to exist.
>
>>If the client makes local changes, does the vendor really need the SHA of 
>>those -- without the actual content?
>>I mean any SHA would do right?  Perhaps let the client create a second 
>>client-specific branch (set to
>> the same commit as the first) to indicate they had mods.
>>Later, when the vendor needs the actual client changes, the client does a 
>>normal push to this 2nd client-specific branch at the vendor.
>>This would send everything that the client has done to the code since the 
>>official release.
>
> What I should have added to the use-case was that there is a strong audit 
> requirement (regulatory, actually) involved that the SHA is exact, 
> immutable, and cannot be substitute or forged (one of the reasons git is 
> in such high regard). So, no I can't arrange a fake SHA to represent a SHA 
> to be named later. It SHA of the installed commit is part of the official 
> record of what happened on the specific server, so I'm stuck with it.
>
>>I'm not sure what you mean about "it is inside a tree".
>
> m---a---b---c---H1
>          `---d---H2
>
> d would be at a head. b would be inside. Determining content of c is 
> problematic if b is sparse, so I'm really unsure that any of this is 
> possible.
>
> Cheers,
> Randall
>
> -- Brief whoami: NonStop&UNIX developer since approximately 
> UNIX(421664400)/NonStop(211288444200000000)
> -- In my real life, I talk too much.

I think I get the jist of your use case. Would I be right that you don't 
have a true working solution yet? i.e. that it's a problem that is almost 
sorted but falls down at the last step.

If one pretended that this was a single development shop, and the various 
vendors, clients and customers as being independent devolopers, each of whom 
is over protective of their code, it may give a better view that maps onto 
classic feature development diagrams. (i.e draw the answer for local devs, 
then mark where the splits happen)

In particular, I think you could use a notional regulator's view that the 
whole code base is part of a large Git heirarchy of branches and merges, and 
that some of the feature loops are only available via the particular 
developer that worked on that feature.

This would mean that from a regulatory overview there is a merge commit in 
the 'main' (master) heirachy that has the main and feature commits listed, 
and the feature commit is probably an --allow-empty commit (that has an 
empty tree if they are that paranoid) that says 'function X released' (and 
probably tagged), and that release commit then has, as its parent, the true 
release commit, with the true code tree. The latter commit isn't actually 
being shown to you!

At this point the potential for using the graft capability comes in (as a 
regulated method!). Locally the graft records the missing line of pearls for 
that paranoid dev/vendor/customer/client. The whole git heirachy still 
works.

The question is how to get that  release commit with its empty tree, and its 
tag, to you from the dev. I'd guess that a fast-export of just that 
tag/commit/empty tree would allow you to bring in that sentinel point to 
your heirachy (initially as a psuedo --root), and then graft it on. (I 
haven't checked if fast-export allows such specificity, but it's a method)

You can now form the merge commit and have regulatory oversight and the full 
git validation and verification capability, as long as your web of trust 
extends to the regulator looking effectively across the air gap. It's a 
fresh way of seeing the web of trust.

Thus you/they have various "shallow clones", but with gaps and islands in 
the shallowness....  and those gaps are spanned by grafts (which are 
audited). The `git-replace` may also be an option, but I don't think it's 
quite right for this case. You just have a temporary gap in the history, and 
with fast export

If using the empty tree part doesn't pass muster (i.e. showing nothing isn't 
sufficient), then the narrow clone could come into play to limit what parts 
of the trees are widely visible, but mainly its using the grafts to cover 
the regulatory gap, and (for the moment) using fast-export to transfer the 
singleton commit / tags

Oh Just remembered, there is the newish capability to fetch random blobs, so 
that may help.

Philip


