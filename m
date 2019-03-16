Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918DA20248
	for <e@80x24.org>; Sat, 16 Mar 2019 19:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCPTtI (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 15:49:08 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:56128 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPTtI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 15:49:08 -0400
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id E0E34440441;
        Sat, 16 Mar 2019 21:48:48 +0200 (IST)
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il> <8e28e622af4143b13a9bfa5c7a6df33d8baf1b5e.camel@perches.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Joe Perches <joe@perches.com>
Cc:     git@vger.kernel.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
In-reply-to: <8e28e622af4143b13a9bfa5c7a6df33d8baf1b5e.camel@perches.com>
Date:   Sat, 16 Mar 2019 21:49:05 +0200
Message-ID: <87zhpuzjke.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joe,

On Sat, Mar 16 2019, Joe Perches wrote:
> On Sat, 2019-03-16 at 21:26 +0200, Baruch Siach wrote:
>> Since commit ef0cc1df90f6b ("send-email: also pick up cc addresses from
>> -by trailers") in git version 2.20, git send-email adds to cc list
>> addresses from all *-by lines. As a side effect a line with
>> '-Signed-off-by' is now also added to cc. This makes send-email pick
>> lines from patches that remove patch files from the git repo. This is
>> common in the Buildroot project that often removes (and adds) patch
>> files that have 'Signed-off-by' in their patch description part.
>
> Why is such a line used and why shouldn't an author
> of a to-be-removed patch be cc'd?

These lines are currently used because the '^([a-z-]*-by)' regexp
matches.

Buildroot is a tool that build various software packages. The patches
being removed are usually for packages that Buildroot patches to fix the
build. These patches are often pulled from upstream git repo of
respective package. When the package version updates, the patch is
dropped.

We don't cc patch authors when we add the patch in the first place,
because the regexp does not match '+Signed-off-by'. I see not reason to
cc them when we remove the patch.

baruch

>> Consider only *-by lines that start with [a-z] (case insensitive) to
>> avoid unrelated addresses in cc.
>>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>  git-send-email.perl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 8eb63b5a2f8d..5656ba83d9b1 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1693,7 +1693,7 @@ sub process_file {
>>  	# Now parse the message body
>>  	while(<$fh>) {
>>  		$message .=  $_;
>> -		if (/^([a-z-]*-by|Cc): (.*)/i) {
>> +		if (/^([a-z][a-z-]*-by|Cc): (.*)/i) {
>>  			chomp;
>>  			my ($what, $c) = ($1, $2);
>>  			# strip garbage for the address we'll use:


--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
