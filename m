Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30600C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 22:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGJWJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJWJF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 18:09:05 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4BA9FCA
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 15:09:04 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oAf6s-0006Se-8p;
        Sun, 10 Jul 2022 23:09:03 +0100
Message-ID: <1b90edd0-3d9d-a741-8865-3968826da315@iee.email>
Date:   Sun, 10 Jul 2022 23:09:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
Content-Language: en-GB
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
 <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tortsen,
Thanks for the reply and comments.

On 10/07/2022 08:48, Torsten Bögershausen wrote:
> On Sat, Jul 09, 2022 at 04:56:21PM +0000, Philip Oakley via GitGitGadget wrote:
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> Bug report
>>  https://lore.kernel.org/git/AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com/
>> noted that a file containing /r/r/n needed renormalising twice.
>>
>> This is by design. Lone CR characters, not paired with an LF, are left
>> unchanged.
> This is all fine.
>
>> Note the lack of idempotentness of the "clean" filter in the
>> documentation.
> The clean filter is idempotent, I would claim, see below.

I'd disagree, on the basis that any second 'idempotent' cleaning should
not change the file content at all. The need for a second clean was the
surprise the user had.
> You can run it, and re-run, and re-run, there will no other changes.
> CRLF in the worktree will become LF in the repo,
> 'lone CR' stay as they are.
> In that sense, CRCRLF in the worktree will become CRLF in the repo.
So  the output isn't normalised, and warning messages ensue (if enabled,
etc)
> You can the renormalize again and again.
>
> The "trick" is that the user has to decide what CRCRLF mean and what
> should happen in the repo
.. for which they should be forewarned of the issue.
In this case it was a large repository transfer of legacy data, so
little knowledge of how the double CRs occured, but it was a real issue
for them.


> :
> CRCRLF in the worktree becomes one line ending (one LF in the repo)
> or
> CRCRLF in the worktree becomes two line endings ( LFLF in the repo)
>
> For a) you can use dos2unix twice.
> Or run `git add --renormalize` followed by
> `rm git.bdf`
> `git restore .`
>
> The thing is that we used a combination of different commands
> $ git add --renormalize .
> $ git commit -m "Renormalize bdf.txt"
> $ rm git.bdf
> $ git restore .
> $ git add --renormalize .
> $ git commit -m "Renormalize a second time bdf.txt"
>
> ... to clean up this very situation.
>
> And, if CRCRLF should have become LFLF instead ?
> Probably a python script is needed to fix this.
> (or some other script/program in the language of your choice)
>
> We could argue that
> `git add --renormalize` is idempotent, but a series of carefully crafted
> commands is not.

> In short, what is missing is the documentation how CRCRLF is handled by
> Git.
*nod*
>
>> Renormalize was introduced at 9472935d81e (add: introduce "--renormalize",
>> Torsten Bögershausen, 2017-11-16)
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  Documentation/git-add.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
>> index 11eb70f16c7..c4a5ad11a6b 100644
>> --- a/Documentation/git-add.txt
>> +++ b/Documentation/git-add.txt
>> @@ -188,7 +188,8 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>>  	forcibly add them again to the index.  This is useful after
>>  	changing `core.autocrlf` configuration or the `text` attribute
>>  	in order to correct files added with wrong CRLF/LF line endings.
>> -	This option implies `-u`.
>> +	This option implies `-u`. Lone CR characters are untouched, so
>> +	cleaning not idempotent. A CRCRLF sequence cleans to CRLF.
> How about this:
>
> This option implies `-u`. Lone CR characters are untouched. CRCRLF cleans to CRLF.
That is probably sufficient. It drops the awkward 'idempotent'. And
indicates this edge case, though doesn't highlight that the resultant
CRLF still leaves the file only partially renormalised.

I'll reword.
>

