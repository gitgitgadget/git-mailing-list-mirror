Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1146B20281
	for <e@80x24.org>; Thu,  2 Nov 2017 21:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964934AbdKBVTr (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 17:19:47 -0400
Received: from marcos.anarc.at ([206.248.172.91]:34952 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964921AbdKBVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 17:19:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id A7CA51A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/7] remote-mediawiki: support fetching from (Main) namespace
In-Reply-To: <CAPig+cTX1kBCk-phodTanU1dmwjM_2TNevKyGvdCWonqhEU5Dg@mail.gmail.com>
Organization: Debian
References: <20171029160857.29460-2-anarcat@debian.org> <20171030025142.19421-1-anarcat@debian.org> <20171030025142.19421-6-anarcat@debian.org> <CAPig+cTX1kBCk-phodTanU1dmwjM_2TNevKyGvdCWonqhEU5Dg@mail.gmail.com>
Date:   Thu, 02 Nov 2017 17:19:42 -0400
Message-ID: <8760as5qfl.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-01 15:56:51, Eric Sunshine wrote:
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -264,9 +264,14 @@ sub get_mw_tracked_categories {
>>  sub get_mw_tracked_namespaces {
>>      my $pages = shift;
>>      foreach my $local_namespace (@tracked_namespaces) {
>> -        my $namespace_id = get_mw_namespace_id($local_namespace);
>> +        my ($namespace_id, $mw_pages);
>> +        if ($local_namespace eq "(Main)") {
>> +            $namespace_id = 0;
>> +        } else {
>> +            $namespace_id = get_mw_namespace_id($local_namespace);
>> +        }
>
> I meant to ask this in the previous round, but with the earlier patch
> mixing several distinct changes into one, I plumb forgot: Would it
> make sense to move this "(Main)" special case into
> get_mw_namespace_id() itself? After all, that function is all about
> determining an ID associated with a name, and "(Main)" is a name.

Right. At first sight, I agree: get_mw_namespace_id should do the right
thing. But then, I look at the code of that function, and it strikes me
as ... well... really hard to actually do this the right way.

In fact, I suspect that passing "" to get_mw_namespace_id would actually
do the right thing. The problem, as I explained before, is that passing
that in the configuration is pretty hard: it would needlessly complicate
the configuration setting, so I think it's a fair shortcut to do it
here.

>>          next if $namespace_id < 0; # virtual namespaces don't support allpages
>> -        my $mw_pages = $mediawiki->list( {
>> +        $mw_pages = $mediawiki->list( {
>
> Why did the "my" of $my_pages get moved up to the top of the foreach
> loop? I can't seem to see any reason for it. Is this an unrelated
> change accidentally included in this patch?

Just a habit of declaring functions at the beginning of a block. Maybe
it's because I'm old? :)

I'll reroll a last patchset with those fixes.

A.

-- 
One of the strongest motives that leads men to art and science is
escape from everyday life with its painful crudity and hopeless
dreariness. Such men make this cosmos and its construction the pivot
of their emotional life, in order to find the peace and security which
they cannot find in the narrow whirlpool of personal experience.
                       - Albert Einstein
