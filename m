From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Subject: [PATCH] git am: Transform and skip patches via new hook
Date: Wed, 8 Jul 2015 17:17:10 -0400
Message-ID: <CAPig+cQx5TKwLk+MjsOJVHriqmwYbEcKUtARJVzef4HyN0thgg@mail.gmail.com>
References: <CAJ3HoZ2YdAFVt1-4dTk04=0cLTUxQocJPNSVupr09Ee01tGCAQ@mail.gmail.com>
	<CAPig+cQy-KHAaK_byw2nMM-S8cNosTpOiyejkHzAL6VavncaOw@mail.gmail.com>
	<CAJ3HoZ317rF_JMiMnei4U8+o2Q9TN34GOHFS-i+GHAvZy9hEvg@mail.gmail.com>
	<20150708194844.GA895@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Robert Collins <robertc@robertcollins.net>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 23:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCwiT-0006ji-2X
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 23:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbbGHVRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 17:17:13 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35719 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933244AbbGHVRL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 17:17:11 -0400
Received: by ykee186 with SMTP id e186so19541762yke.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=t3ENYLfdQIuuzhilm4cuMu7Xqj2UgyOumGwVaZ+t4Hk=;
        b=zDAT4KV9iIuT8cGPdZ4F6PR2NvjmVFPxbYqGpEzNCB2NXb+dngztPDugaydxCi07Kk
         bqFfyK0d1v5F8J44FiFchyvmVhO0fG72vekZJtnuzSS2giN3ObUK5FoUjyoVi1C1JwPQ
         /MnQNPh5pZpp2xH+2OLe6U4Rt0DomS6zDfQdQDTHA2Dv4i35XBNKE7Pk4hVybnG+79N0
         exuaIvlO3zsu9NE6vMoeLAaxi1eC9U9kQ2YU5togMuhtkVsoW+dxSZlji1Q4fLCB81BM
         S50ARDCdG2CiBDVjg4TVlAygJ+ABm1mpKGie6AZsSpoeqllRRQw7+wgnwX+ezyO2pu6X
         JvUQ==
X-Received: by 10.170.97.9 with SMTP id o9mr13742629yka.84.1436390230651; Wed,
 08 Jul 2015 14:17:10 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 8 Jul 2015 14:17:10 -0700 (PDT)
In-Reply-To: <20150708194844.GA895@flurp.local>
X-Google-Sender-Auth: QspPFH6ESoSw0odE7k3Fa5ukX9E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273714>

(resending with 'git' list included; somehow it got dropped accidentally)

On Wed, Jul 8, 2015 at 3:48 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 08, 2015 at 11:26:33AM +1200, Robert Collins wrote:
>> The current git am offers a pre-applypatch that actual runs after
>> applying the patch, and so does not facilitate programmatic fixups of
>> patches. While its possible to manually fixup and apply one patch at
>> a time, this means sacrificing all of the automation present in git am
>> as each patch needs to be applied before the next patch can be applied
>> and tested. Further, being able to pipe git format-patch | git am can
>> be extremely convenient for porting of patches between different local
>> repositories.
>
> This commit message does a much better job of explaining the intent
> of the patch. Thanks.
>
> There are, however, some things which are still unclear. For
> instance, the commit message talks about "automation present in git
> am" but it's not clear as to what automation you are referring or how
> that automation helps your use-case. Likewise, I'm not sure I quite
> understand the bit about "each patch needs to be applied before the
> next patch can be applied and tested".
>
> The statement about "being able to pipe git format-patch | git am"
> helps explain your use-case more concretely, although that use-case
> can likely still be handled as easily (or more so) with a simple
> filter outside of Git, so it's not clear that it's a good
> justification for introducing yet another hook into Git. More about
> that below.
>
>> Git am now calls out to a new hook 'applypatch-transform' to allow
>> programmatic fixups of patches from git format-patch. The possible
>> transforms include skipping a patch, or skipping the patch entirely.
>>
>> Signed-off-by: Robert Collins <rbtcollins@hp.com>
>> ---
>>  Documentation/git-am.txt                     |  6 ++---
>>  Documentation/githooks.txt                   | 15 ++++++++++++
>>  git-am.sh                                    | 15 ++++++++++++
>>  templates/hooks--applypatch-transform.sample | 36 ++++++++++++++++++++++++++++
>>  4 files changed, 69 insertions(+), 3 deletions(-)
>
> I forgot to mention in the previous review that this change probably
> ought to be accompanied by tests. However, before spending more time
> refining the patch, it might be worthwhile to wait to hear from Junio
> whether he's even interested in this new hook. (Based upon previous
> discussions of possible new hooks, he may not be interested in a hook
> which adds no apparent value. Again, more on that below.)
>
>> --- /dev/null
>> +++ b/templates/hooks--applypatch-transform.sample
>> @@ -0,0 +1,36 @@
>> +#!/bin/sh
>> +#
>> +# An example hook script to transform a patch taken from an email
>> +# by git am.
>> +#
>> +# The hook should exit with non-zero status after issuing an
>> +# appropriate message if it wants to stop the commit.  The hook is
>> +# allowed to edit the patch file.
>> +#
>> +# To enable this hook, rename this file to "applypatch-transform".
>> +#
>> +# This example changes the path of Lib/unittest/mock.py to mock.py
>> +# Lib/unittest/tests/testmock to tests and Misc/NEWS to NEWS, and
>> +# finally skips any patches that did not alter mock.py or its tests.
>> +
>> +set -eux
>> +
>> +patch_path=$1
>> +
>> +# Pull out mock.py
>> +filterdiff --clean --strip 3 --addprefix=a/ -i
>> 'a/Lib/unittest/mock.py' $patch_path > $patch_path.mock
>> +# And the tests
>> +filterdiff --clean --strip 5 --addprefix=a/tests/ -i
>> 'a/Lib/unittest/test/testmock/' $patch_path > $patch_path.tests
>> +# Lastly we want to pick up any NEWS entries.
>> +filterdiff --strip 2 --addprefix=a/ -i a/Misc/NEWS $patch_path >
>> $patch_path.NEWS
>> +cat $patch_path.mock $patch_path.tests > $patch_path
>> +filtered=$(cat $patch_path)
>> +if [ -n "${filtered}" ]; then
>> +  cat $patch_path.NEWS >> $patch_path
>> +  exitcode=0
>> +else
>> +  exitcode=1
>> +fi
>> +
>> +rm $patch_path.mock $patch_path.tests $patch_path.NEWS
>> +exit $exitcode
>
> The commit message mentions the use-case "git format-patch | git am",
> with git-am invoking a hook for each patch to transform or reject it,
> however, it's not clear why you need a hook at all when a simple
> pipeline should work just as well. For instance:
>
>     git format-patch | myfilter | git-am
>
> where myfilter is, for instance, a Perl script such as the following:
>
>     #!/usr/bin/perl
>     use strict;
>     use warnings;
>
>     my ($patch, $mock, $test) = '';
>     while (<>) {
>         if (/^From [[:xdigit:]]{40} /) {
>             print $patch if $patch && $mock && $test;
>             ($patch, $mock, $test) = ('', undef, undef);
>         }
>         $mock = 1 if s{^([-+]{3}) ([ab])/Lib/unittest/mock.py$}{$1 $2/mock.py};
>         $test = 1 if s{^([-+]{3}) ([ab])/Lib/unittest/test/testmock/}{$1 $2/tests/};
>         s{^([-+]{3}) ([ab])/Misc/NEWS$}{$1 $2/NEWS};
>         $patch .= $_;
>     }
>     print $patch if $patch && $mock && $test;
>
> This filter performs the exact transformations and rejections
> described by the sample hook's comment block[*1*]. Aside from not
> requiring any modifications to Git, it also is *much* faster since
> it's only invoked once rather than once per patch (and, as a bonus,
> it doesn't need to invoke the 'filterdiff' command three times per
> patch, or create and delete several temporary files per patch).
>
> Consequently, as mentioned in the original review, it's not clear
> that a new applypatch-transform hook is really needed. It's certainly
> possible that your use-case is actually more involved and difficult
> than the one presented in the sample hook, and might indeed benefit
> from a new Git hook, in which case the commit message probably needs
> to do a better job of justifying the change.
>
> Footnotes:
>
> [*1*]: The functionality of the sample myfilter script matches the
> behavior described in the comment block of your sample hook, but not
> the actual behavior. The described behavior just mentions transforms
> and rejections of patches, however, the sample hook itself actually
> drops changes to files not mentioned by the comment, even in
> non-rejected patches, whereas myfilter retains them. It would be very
> easy, however, to modify myfilter to match the hook's implemented
> behavior, as well.
