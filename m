Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB3B202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 18:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdJ2Sjq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 29 Oct 2017 14:39:46 -0400
Received: from marcos.anarc.at ([206.248.172.91]:53022 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbdJ2Sjo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 14:39:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id C8AB41A00A8
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Kevin <kevin@ki-ai.org>
Subject: Re: [PATCH 1/4] remote-mediawiki: add namespace support
In-Reply-To: <CAPig+cSmfJ2Uv21Q4DgJNoy6Ywj7GWPJa6qq0YL9Kar6Q74a_Q@mail.gmail.com>
Organization: Debian
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-2-anarcat@debian.org> <CAPig+cSmfJ2Uv21Q4DgJNoy6Ywj7GWPJa6qq0YL9Kar6Q74a_Q@mail.gmail.com>
Date:   Sun, 29 Oct 2017 14:29:38 -0400
Message-ID: <87a809959p.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-29 13:24:03, Eric Sunshine wrote:
> On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupré <anarcat@debian.org> wrote:
>> From: Kevin <kevin@ki-ai.org>
>>
>> this introduces a new remote.origin.namespaces argument that is a
>
> s/this/This/

ack.

>> space-separated list of namespaces. the list of pages extract is then
>
> s/the/The/

ack.

>> taken from all the specified namespaces.
>>
>> Reviewed-by: Antoine Beaupré <anarcat@debian.org>
>> Signed-off-by: Antoine Beaupré <anarcat@debian.org>
>> ---
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -1331,7 +1356,12 @@ sub get_mw_namespace_id {
>>  sub get_mw_namespace_id_for_page {
>>         my $namespace = shift;
>>         if ($namespace =~ /^([^:]*):/) {
>
> This is not a new issue, but why capture if $1 is never referenced in
> the code below?

meh, i dunno.

>> -               return get_mw_namespace_id($namespace);
>> +               my ($ns, $id) = split(/:/, $namespace);
>> +               if (Scalar::Util::looks_like_number($id)) {
>> +                       return get_mw_namespace_id($ns);
>
> So, the idea is that if the input has form "something:number", then
> you want to look up "something" as a namespace name. Anything else
> (such as "something:foobar") is not considered a valid page reference.
> Right?

frankly, i have no idea what's going on here.

>> +               } else{
>
> Missing space before open brace.

right.

>> +                       return
>
> Not required, but missing semi-colon.

ok.

>> +               }
>>         } else {
>>                 return;
>>         }
>
> The multiple 'return's are a bit messy. Perhaps collapse the entire
> function to something like this:
>
>     sub get_mw_namespace_id_for_page {
>         my $arg = shift;
>         if ($arg =~ /^([^:]+):\d+$/) {
>             return get_mw_namespace_id($1);
>         }
>         return undef;
>     }
>
> Then, you don't need even need Scalar::Util::looks_like_number()
> (unless, I suppose, the incoming number is expected to be something
> other than simple digits).
>
> In fact, it may be that the intent of the original code *was* meant to
> do exactly the same as shown in my example above, but that the person
> who wrote it accidentally typed:
>
>     return get_mw_namespace_id($namespace);
>
> instead of the intended:
>
>     return get_mw_namespace_id($1);
>
> So, a minimal fix would be simply to change $namespace to $1.
> Tightening the regex as I did in my example would be a bonus (though
> probably ought to be a separate patch).

so while i'm happy to just copy-paste your code in there, that's kind of
a sensitive area of the code, as it was originally used only in the
upload procedure, which I haven't tested at all. so i'm hesitant in just
merging that in as is.

i don't understand why or how this even works, to be honest: page names
don't necessarily look like numbers, in fact, they generally don't. i
don't understand why the patch submitted here even touches that function
at all, considering that the function is only used on uploads. I just
cargo-culted it from the original issue...

sigh.

a.

-- 
C'est trop facile quand les guerres sont finies
D'aller gueuler que c'était la dernière
Amis bourgeois vous me faites envie
Ne voyez vous pas donc point vos cimetières?
                        - Jaques Brel
