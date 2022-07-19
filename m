Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B99C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 06:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiGSG12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiGSG11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 02:27:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37302872D
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 23:27:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 353E61B74D1;
        Tue, 19 Jul 2022 02:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hDMCnh9ZmgJKQY1O+lRcva02NrIZIvQbwUey0w
        gtDHo=; b=TTkwR0xZF0ASryiPHwnPmYkVWAysaHfHagik2WpHz7kYobaO5a/QcZ
        b7H4AF19ep0OBo5pRE1XDMP8Wcj0DruiWbdiTfyz9Kp6JryrB5CZrSTizAfZI11O
        lmftu9XmGbvd8YcGxtCuEzWf4T5L6ITrJ5Nixm3ufbsaLHRf87pcE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E3081B74D0;
        Tue, 19 Jul 2022 02:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D13C01B74CF;
        Tue, 19 Jul 2022 02:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Britton Leo Kerin <britton.kerin@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: BUG: git-check-ignore documentation doesn't come close to
 describing what it really does
References: <xmqqtu7lc587.fsf@gitster.g>
        <20220718232843.151392-1-britton.kerin@gmail.com>
Date:   Mon, 18 Jul 2022 23:27:21 -0700
In-Reply-To: <20220718232843.151392-1-britton.kerin@gmail.com> (Britton Leo
        Kerin's message of "Mon, 18 Jul 2022 15:28:43 -0800")
Message-ID: <xmqqa695ehx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9483546-072B-11ED-A82C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Britton Leo Kerin <britton.kerin@gmail.com> writes:

>> "Is excluded" is perfectly fine, I think.  The first use of that
>> verb in the documentation should be a bit more careful, e.g. "is
>> excluded (aka ignored)" or something.
>
> I think replacing with "matches an ignore/exclude rule" is prefereable since
> that's what's actually going on.

Unfortunately, it is only half of what's actually going on, isn't
it?  If the last match is with a positive entry, then it is excluded
(aka ignored).  If the last match is with a negative entry, then it
is not excluded (and not shown without "-v").  That is demonstrated
by the example:

>> It does return *the* matching entry that decided the path's fate.
>>
>>     $ (echo '/no-such-*'; echo '!/no-such-*') >>.git/info/exclude
>>     $ git check-ignore -v no-such-directory; echo $?
>>     .git/info/exclude:14:!/no-such-*	no-such-directory
>>     0

and

    $ git check-ignore no-such-directory; echo $?
    1

i.e. with "-v", the output can give enough clue to the user if the
match was with positive or negative entry, but without "-v", the
exit status reports if the given path is "excluded (aka ignored)".
In the above case, the last entry that matches the path
"no-such-directory" is a negative entry, so the path is not
excluded, hence there is no output (as documented, excluded paths
are output).

If we remove the last line from .git/info/exclude, then the
transcript would become:

    $ git check-ignore no-such-directory; echo $?
    no-such-directory
    0
    $ git check-ignore -v no-such-directory; echo $?
    .git/info/exclude:13:/no-such-* no-such-directory
    0

As the last entry that matches the path is a positive entry in this
case, the path is excluded and it is shown in the output without
"-v" and the command exits with success (i.e. is excluded).

Here is a rough attempt to clarify what I found was unclear in the
current documentation.

Thanks.

 Documentation/git-check-ignore.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git c/Documentation/git-check-ignore.txt w/Documentation/git-check-ignore.txt
index 2892799e32..a5491386cf 100644
--- c/Documentation/git-check-ignore.txt
+++ w/Documentation/git-check-ignore.txt
@@ -16,7 +16,8 @@ DESCRIPTION
 -----------
 
 For each pathname given via the command-line or from a file via
-`--stdin`, check whether the file is excluded by .gitignore (or other
+`--stdin`, check whether the file is excluded (aka "ignored"---these
+words are used interchangeably) by .gitignore (or other
 input files to the exclude mechanism) and output the path if it is
 excluded.
 
@@ -31,11 +32,12 @@ OPTIONS
 
 -v, --verbose::
 	Instead of printing the paths that are excluded, for each path
-	that matches an exclude pattern, print the exclude pattern
-	together with the path.  (Matching an exclude pattern usually
+	that matches an exclude pattern (or more), print the exclude
+	pattern that decides if the path is excluded or not excluded,
+	together with the path.  Matching an exclude pattern usually
 	means the path is excluded, but if the pattern begins with "`!`"
 	then it is a negated pattern and matching it means the path is
-	NOT excluded.)
+	NOT excluded.
 +
 For precedence rules within and between exclude sources, see
 linkgit:gitignore[5].
@@ -65,10 +67,12 @@ linkgit:gitignore[5].
 OUTPUT
 ------
 
-By default, any of the given pathnames which match an ignore pattern
+By default, any of the given pathnames which are excluded (aka ignored)
 will be output, one per line.  If no pattern matches a given path,
 nothing will be output for that path; this means that path will not be
-ignored.
+ignored.  If the pattern that matched the path is a negative one (i.e.
+prefixed with "`!`"), the path is not excluded and nothing is output
+for the path.
 
 If `--verbose` is specified, the output is a series of lines of the form:
 
