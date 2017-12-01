Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7976B20954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdLASTD (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:19:03 -0500
Received: from siwi.pair.com ([209.68.5.199]:11468 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbdLASTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:19:03 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B42358456B;
        Fri,  1 Dec 2017 13:19:02 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 89A4084569;
        Fri,  1 Dec 2017 13:19:02 -0500 (EST)
Subject: Re: [RFE] Inverted sparseness
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <004201d36ac8$db62b900$92282b00$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bdd01692-198a-f5ec-3c88-7d99e4adced5@jeffhostetler.com>
Date:   Fri, 1 Dec 2017 13:19:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <004201d36ac8$db62b900$92282b00$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/1/2017 12:21 PM, Randall S. Becker wrote:
> I recently encountered a really strange use-case relating to sparse clone/fetch that is really backwards from the discussion that has been going on, and well, I'm a bit embarrassed to bring it up, but I have no good solution including building a separate data store that will end up inconsistent with repositories (a bad solution).  The use-case is as follows:
> 
> Given a backbone of multiple git repositories spread across an organization with a server farm and upstream vendors.
> The vendor delivers code by having the client perform git pull into a specific branch.
> The customer may take the code as is or merge in customizations.
> The vendor wants to know exactly what commit of theirs is installed on each server, in near real time.
> The customer is willing to push the commit-ish to the vendor's upstream repo but does not want, by default, to share the actual commit contents for security reasons.
> 	Realistically, the vendor needs to know that their own commit id was put somewhere (process exists to track this, so not part of the use-case) and whether there is a subsequent commit contributed by the customer, but the content is not relevant initially.
> 
> After some time, the vendor may request the commit contents from the customer in order to satisfy support requirements - a.k.a. a defect was found but has to be resolved.
> The customer would then perform a deeper push that looks a lot like a "slightly" symmetrical operation of a deep fetch following a prior sparse fetch to supply the vendor with the specific commit(s).
> 
> This is not hard to realize if the sparse commit is HEAD on a branch, but if its inside a tree, well, I don't even know where to start. To self-deprecate, this is likely a bad idea, but it has come up a few times.
> 
> Thoughts? Nasty Remarks?
> 
> Randall

Perhaps I'm not understanding the subtleties of what you're describing,
but could you do this with stock git functionality.

Let the vendor publish a "well known branch" for the client.
Let the client pull that and build.
Let the client create a branch set to the same commit that they fetched.
Let the client push that branch as a client-specific branch to
the vendor to indicate that that is the official release they
are based on.

Then the vendor would know the official commit that the client was
using.

If the client makes local changes, does the vendor really need the
SHA of those -- without the actual content?  I mean any SHA would
do right?  Perhaps let the client create a second client-specific
branch (set to the same commit as the first) to indicate they had
mods.

Later, when the vendor needs the actual client changes, the client
does a normal push to this 2nd client-specific branch at the vendor.
This would send everything that the client has done to the code
since the official release.

I'm not sure what you mean about "it is inside a tree".

Hope this helps,
Jeff

