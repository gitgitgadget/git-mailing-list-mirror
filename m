Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E583C202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdJ3CLD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 29 Oct 2017 22:11:03 -0400
Received: from marcos.anarc.at ([206.248.172.91]:59760 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbdJ3CLD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:11:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 051BA1A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] remote-mediawiki: allow using (Main) as a namespace and skip special namespaces
In-Reply-To: <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com>
Organization: Debian
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-5-anarcat@debian.org> <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com>
Date:   Sun, 29 Oct 2017 22:11:00 -0400
Message-ID: <874lqh8jwr.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-29 15:49:28, Eric Sunshine wrote:
> On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupré <anarcat@debian.org> wrote:
>> Subject: remote-mediawiki: allow using (Main) as a namespace and skip special namespaces
>
> This patch is more difficult to review than it perhaps ought to be
> since it is making multiple unrelated changes.
>
> It's not clear from the description what special namespaces are and
> why they need to be skipped. It's also not clear why (Main) is
> special. Perhaps the commit message(s) could explain these issues in
> more detail.
>
> To simplify review and make it easier to gauge what it going on, it
> might make sense to split this patch into at least two: one which
> skips "special namespaces", and one which gives special treatment to
> (Main).

Agreed, I'll try to do that.

> More below...
>
>> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
>> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
>> ---
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -264,16 +264,27 @@ sub get_mw_tracked_categories {
>>  sub get_mw_tracked_namespaces {
>>      my $pages = shift;
>> -    foreach my $local_namespace (@tracked_namespaces) {
>> -        my $mw_pages = $mediawiki->list( {
>> -            action => 'query',
>> -            list => 'allpages',
>> -            apnamespace => get_mw_namespace_id($local_namespace),
>> -            aplimit => 'max' } )
>> -            || die $mediawiki->{error}->{code} . ': '
>> -                . $mediawiki->{error}->{details} . "\n";
>> -        foreach my $page (@{$mw_pages}) {
>> -            $pages->{$page->{title}} = $page;
>> +    foreach my $local_namespace (sort @tracked_namespaces) {
>> +        my ($mw_pages, $namespace_id);
>> +        if ($local_namespace eq "(Main)") {
>> +            $namespace_id = 0;
>> +        } else {
>> +            $namespace_id = get_mw_namespace_id($local_namespace);
>> +        }
>> +        if ($namespace_id >= 0) {
>
> This may be problematic since get_mw_namespace_id() may return undef
> rather than a number, in which case Perl will complain. Since the code
> skips the $mediawiki query altogether when it encounters "(Main)", you
> could fix this problem and simplify the code overall by simply
> skipping the bulk of the foreach loop body instead of mucking around
> with $namespace_id. For instance:
>
>     foreach my $local_namespace (sort @tracked_namespaces) {
>         next if ($local_namespace eq "(Main)");
>         ...normal processing...
>     }

Ah yes. I see your point but it doesn't actually skip the query when it
encouters main ($namespace_id >= 0).

>> +            if ($mw_pages = $mediawiki->list( {
>> +                action => 'query',
>> +                list => 'allpages',
>> +                apnamespace => $namespace_id,
>> +                aplimit => 'max' } )) {
>> +                print {*STDERR} "$#{$mw_pages} found in namespace $local_namespace ($namespace_id)\n";
>
> The original code did not emit this diagnostic but the new code does
> so unconditionally. Is this just leftover debugging code or is
> intended that all users should see this information all the time?

This is a known issue that permeates the whole remote at this point, and
it is quite annoying.

https://github.com/Git-Mediawiki/Git-Mediawiki/issues/30

I have, however, considered it useful to include this to show progress
as it can take a while to fetch all namespace information...

Obviously, once we figure out how to silence this stuff (ie. how to
recognize -q), it should be silenced like everything else, but until
then I think it's quite useful.

>> +                foreach my $page (@{$mw_pages}) {
>> +                    $pages->{$page->{title}} = $page;
>> +                }
>> +            } else {
>> +                warn $mediawiki->{error}->{code} . ': '
>> +                    . $mediawiki->{error}->{details} . "\n";
>
> I guess this is the part which "skips special namespaces". The
> original code die()'d but this merely warns. Aside from these "special
> namespaces", are there genuine cases when the $mediawiki query would
> return an error, and which should indeed die(), or is warning
> appropriate for all $mediawiki query error cases?

Maybe I didn't get the indentation right, but this } else { is for query
failures, *not* the if ($namespace_id < 0). So < 0 is just silently
skipped.

The original code was die()'ing on failures, but I think that's a
mistake: we should fetch what we can and warn on the failures. That
allows the user to fix multiple problems at once instead of having to
rerun the script repeatedly.

A.

-- 
Le féminisme n'a jamais tué personne
Le machisme tue tous les jours.
                        - Benoîte Groulx
