Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9504C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7471613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFDUhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:37:21 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31595 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDUhU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 16:37:20 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 154KZUGI061192
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 4 Jun 2021 16:35:30 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>
References: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com>     <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com>    <012601d73ddf$3d0cf660$b726e320$@nexbridge.com> <CABPp-BE_5c1vXuxPWTO82cGmyajXxpxW+-ycZ+-5vy+tsV3bUA@mail.gmail.com>    <012901d73de6$c25a4ff0$470eefd0$@nexbridge.com> <01dd01d745b0$875c6920$96153b60$@nexbridge.com> <00f101d75978$0074c840$015e58c0$@nexbridge.com> <xmqqo8cl1k8s.fsf@gitster.g>
In-Reply-To: <xmqqo8cl1k8s.fsf@gitster.g>
Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
Date:   Fri, 4 Jun 2021 16:35:25 -0400
Message-ID: <00f801d75981$29225c90$7b6715b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWGYGttp5Jdx88vf9L/5ZtrxnlMwG55eaXAXoXgPoC7mL63QI2zlGUAkuPwtwCEzMldQHDJRNoqhL0OYA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 4, 2021 3:52 PM, Junio C Hamano wrote:
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>> The primary
>> problem is supplying -S $ZSSH0 on the command line causes $ZSSH0 to be
>> resolved as a shell variable. It is not.
>
>I think we've heard that one before, and the whole thing sounds like you are saying that a command line
>
>    $ cmd $ZSSH0
>
>expects ZSSH0 to be a variable and tries to interpolate its value before passing it to "cmd" while you want "cmd" to see a literal
string that
>begins with a dollar sign.
>
>And the standard solution to that problem obviously is to tell the shell that the dollar-sign is not a reference to a variable by
quoting, by
>using any variant of e.g.
>
>    $ cmd \$ZSSH0
>    $ cmd '$ZSSH0'
>    $ cmd "\$ZSSH0"

I'm going to have to retest this, but, when I last tried this, admittedly around git 2.0, what happened was that one level of
escaping the $ worked for ls-remote, but we needed two levels for upload-pack which seemed to have two shells processing the
command. I might be wrong about the specifics (been 4 years), but there was an inconsistency with the number of required escapes.
The single quote did not work for upload-pack at the time. It is entirely possible that the second level indirection happened
because the execution of the sshoss command itself cross over a platform boundary between the POSIX and non-POSIX file systems (it
lives in the non-POSIX side).

>As far as I can tell, the code in connect.c that spawns ssh via GIT_SSH_COMMAND uses the pretty vanilla run_command() interface,
and
>that ought to be capable of producing such a command line, so I am lost as to where the need to have special case comes from.

>"cmd" here may be "ssh" but run_command() should not care what exact command is being invoked.  I am puzzled why a simple quoting
>like the following cannot be adjusted for this particular case, for
>example:
>
>    $ cat >>.git/config <<\EOF
>    [alias]
>	cmdtest0 = "!echo ..\\$ZSSH0.."
>	cmdtest1 = "!echo ..$ZSSH0.."
>    EOF
>    $ ZSSH0=foo git cmdtest0
>    ..$ZSSH0..
>    $ ZSSH0=foo git cmdtest1
>    ..foo..

The multi-level resolution that I experienced is not covered in this situation. Still going to investigate this. I'm working on a
different approach to extend my wrapper script to parse out the port, to supply to sshoss, which is not complaint with the standard
ssh. If I have to stick with that script, there's no point going further on this variant.

