Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FFEC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB1E611C9
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFCUJW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 3 Jun 2021 16:09:22 -0400
Received: from elephants.elehost.com ([216.66.27.132]:34034 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUJV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 16:09:21 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 153K7Opt049493
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jun 2021 16:07:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Eric Wong'" <e@80x24.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com> <YLfc2+Te7Y3UY+Sm@nand.local> <YLfgy94sbmStC0mR@coredump.intra.peff.net> <20210602201150.GA29388@dcvr> <YLfmo8kl0URnGgp5@coredump.intra.peff.net> <003c01d757ee$c0664600$4132d200$@nexbridge.com> <YLkt+w9Lxyy8iLS5@coredump.intra.peff.net>
In-Reply-To: <YLkt+w9Lxyy8iLS5@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
Date:   Thu, 3 Jun 2021 16:07:19 -0400
Message-ID: <009901d758b4$12016d80$36044880$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ7fmH3rhE7hkXT/heyzvk47BFclgE1aUB7AUaXbccCdnI+uAIP+0KbAeZJ3jACXy+jC6lgIxtg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 3, 2021 3:31 PM, Peff wrote:
>On Wed, Jun 02, 2021 at 04:34:51PM -0400, Randall S. Becker wrote:
>
>> >> The wrapper should apply to all platforms.  NFS (and presumably
>> >> other network FSes) can be mounted with interrupts enabled.
>> >
>> >I don't mind that, as the wrapper is pretty low-cost (and one less
>> >Makefile knob is nice). If it's widespread, though, I find it curious that nobody has run into it before now.
>>
>> I suspect this is because of the way the file system on NonStop behaves. It is a multi-processor platform, with multi-cores, so anything
>can happen. If the file system is delayed for any reason, like a signal coming from a different core (EINTR has high priority), then fsync()
>will be interrupted. EINTR is allowed on NonStop for fsync(). So it would be really great if the patch included a modification to
>config.mak.uname to include that. This would be a timing-only issue on most other systems, probably something that would hit NFS.
>>
>> The patch for the config is:
>> diff --git a/config.mak.uname b/config.mak.uname index
>> cb443b4e02..ac3e3ca2c5 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -566,6 +566,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>>         NO_REGEX = NeedsStartEnd
>>         NO_PTHREADS = UnfortunatelyYes
>>         FREAD_READS_DIRECTORIES = UnfortunatelyYes
>> +       FSYNC_NEEDS_RESTART = YesPlease
>>
>>         # Not detected (nor checked for) by './configure'.
>
>Yeah, if we don't make it unconditional, then this is the obvious next step. But the more important question is: did you test this out and did
>it fix the test breakage you saw on NonStop?

The fix works for me and t5300 passes. I tested it without the conditional approach. While the test was running, I noticed this:

+ mkdir -p /home/git/git/t/trash directory.t5300-pack-object/prereq-test-dir-FAIL_PREREQS
+ cd /home/git/git/t/trash directory.t5300-pack-object/prereq-test-dir-FAIL_PREREQS
+ test_bool_env GIT_TEST_FAIL_PREREQS false
error: last command exited with $?=1
prerequisite FAIL_PREREQS not satisfied
expecting success of 5300.32 'index-pack --threads=N or pack.threads=N warns when no pthreads':

This may be intended, but the error line showed in red.

Regards,
Randall


