Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31831F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 23:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKOXiq (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 18:38:46 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:53204 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbfKOXiq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Nov 2019 18:38:46 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1iVlAo-0001jA-SE; Sat, 16 Nov 2019 00:38:42 +0100
Subject: Re: rev-list and "ambiguous" IDs
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
 <20191114055906.GA10643@sigill.intra.peff.net>
 <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
 <20191115034941.GB20863@sigill.intra.peff.net>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <917e2664-6059-c190-30fd-02f3cf7aa5dc@virtuell-zuhause.de>
Date:   Sat, 16 Nov 2019 00:38:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191115034941.GB20863@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1573861125;0bfe3d07;
X-HE-SMSGID: 1iVlAo-0001jA-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.11.2019 um 04:49 schrieb Jeff King:
> On Fri, Nov 15, 2019 at 01:12:47AM +0100, Thomas Braun wrote:
> 
>>> That would probably help in a lot of cases, but the argument
>>> against it is that when it goes wrong, it may be quite confusing (so
>>> we're better off with the current message, which punts back to the
>>> user).
>>
>> Just out of curiosity: Is there a use case for inspecting non-commit
>> objects with git log?
> 
> Not that I can think of. You can't even say "--objects" there.
> 
> And indeed, "git log" already prefers commits for disambiguation, since
> d5f6b1d756 (revision.c: the "log" family, except for "show", takes
> committish, 2012-07-02).
> 
> But...
> 
>> If I do (in the git repo)
>>
>> $ git log 1231
>>
>> I get
>>
>> error: short SHA1 1231 is ambiguous
>> hint: The candidates are:
>> hint:   123139fc89 tree
>> hint:   12316a1673 tree
>> hint:   123144fe8a blob
>> fatal: ambiguous argument '1231': unknown revision or path not in the
>> working tree.
>> Use '--' to separate paths from revisions, like this:
>> 'git <command> [<revision>...] -- [<file>...]'
>>
>> with
>> $ git --version
>> git version 2.24.0.windows.2
>>
>> and all of these candidates are no commits.
> 
> ...remember that the disambiguation code is just about preferring one
> object to the other. If the rule in effect doesn't have a preference,
> it's still ambiguous. On my system, "1231" actually _does_ have a
> commit:
> 
>   $ git show 1231
>   error: short SHA1 1231 is ambiguous
>   hint: The candidates are:
>   hint:   12319e3bf2 commit 2017-03-25 - Merge 'git-gui-add-2nd-line' into HEAD
>   hint:   123139fc89 tree
>   hint:   12315b58b8 tree
>   hint:   12316a1673 tree
>   hint:   12317ab2d9 tree
>   hint:   123193f802 tree
>   hint:   123144fe8a blob
>   fatal: ambiguous argument '1231': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
> 
> That's ambiguous because git-show can handle trees and blobs, too. But
> if I feed that sha1 to git-log:
> 
>   $ git log --oneline -1 1231
>   12319e3bf2 Merge 'git-gui-add-2nd-line' into HEAD
> 
> it's perfectly fine, because git-log knows to disambiguate the commit.
> But if I choose another prefix that has no commits at all, it's
> ambiguous under either, because the "committish" rule has no way to
> decide:
> 
>   $ git show abcd2
>   error: short SHA1 abcd2 is ambiguous
>   hint: The candidates are:
>   hint:   abcd22f55e tree
>   hint:   abcd238df0 tree
>   hint:   abcd2b1cc8 blob
>   
>   $ git log abcd2
>   error: short SHA1 abcd2 is ambiguous
>   hint: The candidates are:
>   hint:   abcd22f55e tree
>   hint:   abcd238df0 tree
>   hint:   abcd2b1cc8 blob

I would have expected that git log did just tell me that it could not
find something commitish, instead it told me that there are multiple
candidates, all of them being no commit.

