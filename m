Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF5D1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 15:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfBUPyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 10:54:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:37742 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfBUPyq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 10:54:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1LFsb6X029545
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Feb 2019 10:54:38 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
        "'Duy Nguyen'" <pclouds@gmail.com>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>        <012601d4c8b5$54f1b730$fed52590$@nexbridge.com> <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc2
Date:   Thu, 21 Feb 2019 10:54:31 -0500
Message-ID: <001501d4c9fd$bf80dfb0$3e829f10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQC1VVUPHT7/O/TkZraQz8YJYJGYJwJcqRQXAcGx2NeoCFhCsA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 20, 2019 14:42, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > On February 19, 2019 18:29, Junio C Hamano wrote:
> >> A release candidate Git v2.21.0-rc2 is now available for testing at
> >> the usual places.  It is comprised of 474 non-merge commits since
> >> v2.20.0, contributed by 61 people, 16 of which are new faces.
> >
> > Thanks. t5562 works properly on NonStop (3 tests under various loads).
> > I am starting a full regression test now - see you in two days or so
> > with a full report.
> 
> Thanks.  In the end I ended up doing the following:
> 
>  - kept most of your "feed NULs generated from a helper program via
>    pipe, instead of reading from /dev/zero" patch,
> 
>  - replaced the helper program used in the above with the test-tool
>    one by Dscho,
> 
>  - used Max's "do not reuse the output file---the background writer
>    about to die may still have it open when the next test starts",
> 
>  - used Max's "when testing the program with overly large input
>    declared with content-length, do not have to feed from /dev/zero;
>    /dev/null suffices as a mistaken program attempting to read would
>    die when seeing EOF anyway" patch to reduce one mention of
>    /dev/zero (or one pipe from the helper output) further.
> 
> Hopefully Dscho's Azure thing would also be happy with one less use of
Perl
> script.
> 
> As I said earlier, a few places in t/ still mention /dev/zero and I think
it is a
> real bug on platforms without /dev/zero in t4153:
> 
>     $ git grep -h dev/zero t/
>             test_must_fail test_terminal git am --3way </dev/zero &&
>             test_must_fail test_terminal git am --reject </dev/zero &&
> 
> Curiously, applying the attached patch and running the test on Linux would
> notice that we do not have such a device file, and the use of
test_must_fail
> does *not* make it a-OK [*].  I am not sure why you are not getting hit by
> the same issue.
> 
> 	Side note: test_must_fail is to ensure that the command
> 	exits in a controlled way without segfault, so at the first
> 	glance, replacing /dev/zero with something nonsensical and
> 	nonexistent ought to make the command pass, but that is not
> 	the case.  The shell notices redirection failure and aborts
> 	the &&-chain.  This behaviour matches what we want, so I
> 	won't complain ;-)
> 
> Another mention of /dev/zero appears in t/helper/test-sha1.sh (not to be
> confused with t/helper/test-sha1.c).  This seems to be run only with an
> explicit "make -C t/helper check-sha1" request, so perhaps nobody on your
> platform ran it to get hit by it.  I wonder if anybody runs this on any
platform,
> to be honest, though.  Duy Cc'ed as the last person to touch that
particular
> target---yes, I know I was guilty of introducing it in b65bc21e
("Makefile: add
> framework to verify and bench sha1 implementations.", 2006-06-24).
> 
>  t/t4153-am-resume-override-opts.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-
> override-opts.sh
> index 8ea22d1bcb..29ef22c94f 100755
> --- a/t/t4153-am-resume-override-opts.sh
> +++ b/t/t4153-am-resume-override-opts.sh
> @@ -40,7 +40,7 @@ test_expect_success TTY '--3way overrides --no-3way' '
> 
>  	# Applying side1 with am --3way will succeed due to the threeway-
> merge.
>  	# Applying side2 will fail as --3way does not apply to it.
> -	test_must_fail test_terminal git am --3way </dev/zero &&
> +	test_must_fail test_terminal git am --3way </dev/zarro &&
>  	test_path_is_dir .git/rebase-apply &&
>  	test side1 = "$(cat file2)"
>  '
> @@ -94,7 +94,7 @@ test_expect_success TTY '--reject overrides --no-reject'
> '
>  	test_path_is_dir .git/rebase-apply &&
>  	test_path_is_missing file.rej &&
> 
> -	test_must_fail test_terminal git am --reject </dev/zero &&
> +	test_must_fail test_terminal git am --reject </dev/zarro &&
>  	test_path_is_dir .git/rebase-apply &&
>  	test_path_is_file file.rej
>  '

Here's what we get with this patch (and without it):

/home/git/git/t: sh t4153-am-resume-override-opts.sh
ok 1 - setup
ok 2 # skip --3way overrides --no-3way (missing TTY)
ok 3 - --no-quiet overrides --quiet
ok 4 - --signoff overrides --no-signoff
ok 5 # skip --reject overrides --no-reject (missing TTY)
# passed all 5 test(s)
1..5

Technically, we have TTY, but not that dev. The TTYs are not under
/dev/tty*, however.

Regards,
Randall

