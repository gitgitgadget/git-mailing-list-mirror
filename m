Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2CC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FD86139A
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFEW3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:29:49 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30448 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEW3s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 18:29:48 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 155MRuEd077472
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 5 Jun 2021 18:27:57 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>
Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set. (correction)
Date:   Sat, 5 Jun 2021 18:27:50 -0400
Message-ID: <011c01d75a5a$0874d570$195e8050$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AddaVyaNvifj7UEbTgO1+atgcitf2g==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 5, 2021 5:57 PM, I wrote a slightly wrong message:
>On June 4, 2021 4:35 PM, I wrote:
>>To: 'Junio C Hamano' <gitster@pobox.com>
>>Cc: 'Git Mailing List' <git@vger.kernel.org>
>>Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
>>
>>On June 4, 2021 3:52 PM, Junio C Hamano wrote:
>>>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>>>> The primary
>>>> problem is supplying -S $ZSSH0 on the command line causes $ZSSH0 to
>>>> be resolved as a shell variable. It is not.
>>>
>>>I think we've heard that one before, and the whole thing sounds like
>>>you are saying that a command line
>>>
>>>    $ cmd $ZSSH0
>>>
>>>expects ZSSH0 to be a variable and tries to interpolate its value
>>>before passing it to "cmd" while you want "cmd" to see a literal string that begins with a dollar sign.
>>>
>>>And the standard solution to that problem obviously is to tell the
>>>shell that the dollar-sign is not a reference to a variable by quoting, by using any variant of e.g.
>>>
>>>    $ cmd \$ZSSH0
>>>    $ cmd '$ZSSH0'
>>>    $ cmd "\$ZSSH0"
>>
>>I'm going to have to retest this, but, when I last tried this,
>>admittedly around git 2.0, what happened was that one level of
>escaping the $
>>worked for ls-remote, but we needed two levels for upload-pack which
>>seemed to have two shells processing the command. I might be wrong
>>about the specifics (been 4 years), but there was an inconsistency with
>>the number of required escapes. The single quote did
>not
>>work for upload-pack at the time. It is entirely possible that the
>>second level indirection happened because the execution of the
>sshoss
>>command itself cross over a platform boundary between the POSIX and non-POSIX file systems (it lives in the non-POSIX side).
>>
>>>As far as I can tell, the code in connect.c that spawns ssh via
>>>GIT_SSH_COMMAND uses the pretty vanilla run_command() interface, and
>>>that ought to be capable of producing such a command line,
>>so I am lost as to where the need to have special case comes from.
>>
>>>"cmd" here may be "ssh" but run_command() should not care what exact
>>>command is being invoked.  I am puzzled why a simple quoting like the
>>>following cannot be adjusted for this particular case, for
>>>example:
>>>
>>>    $ cat >>.git/config <<\EOF
>>>    [alias]
>>>	cmdtest0 = "!echo ..\\$ZSSH0.."
>>>	cmdtest1 = "!echo ..$ZSSH0.."
>>>    EOF
>>>    $ ZSSH0=foo git cmdtest0
>>>    ..$ZSSH0..
>>>    $ ZSSH0=foo git cmdtest1
>>>    ..foo..
>>
>>The multi-level resolution that I experienced is not covered in this
>>situation. Still going to investigate this. I'm working on a
>different
>>approach to extend my wrapper script to parse out the port, to supply
>>to sshoss, which is not complaint with the standard ssh. If I
>have to
>>stick with that script, there's no point going further on this variant.
>
>Without a variant (when simple is used), obviously ports cannot be specified. When using the following URL:
>
>    git clone ssh://git@bitbucket.org:22/myproj/repo.git repo
>
>The arguments appended using the auto-detected ssh variant that end up being passed to the GIT_SSH_COMMAND command string are:
>
>    -o SendEnv=GIT_PROTOCOL -p 22 git@bitbucket.org git-upload-pack '/myproj/repo.git'
>
>which is part of the way there, but the -o SendEnv=GIT_PROTOCOL is OpenSSH specific. There is no such argument for the SSHOSS
>program. This becomes somewhat problematic.
>
>Of course, a sufficiently smart wrapper can detect this and strip off the -o SendEnv, which I have working. This just does not seem
like a
>general solution, leading me back down the nonstopssh variant path.

It is not that -o is an invalid option; rather, the SendEnv=GIT_PROTOCOL is causing an error:

    Invalid option value for 'SENDENV'.

to be reported by SSHOSS. It is the set of options that can be supported by -o that is different, so there's that issue, but I can
work around it using a wrapper.

When using the GIT_SSH_COMMAND form suggested, as follows:

export GIT_SSH_COMMAND='/G/system/zssh/sshoss -Q -t -Z -S $ZSSGT'

the resulting trace is (from git 2.31.0 - repo name changed for security reasons):
$ GIT_TRACE=true git clone ssh://git@bitbucket.org:22/myproj/repo.git repo
17:12:16.542913 /home/git/git/git.c:447 trace: built-in: git clone ssh://git@bitbucket.org:22/myproj/repo.git repo
Cloning into 'repo'...
17:12:21.429849 /home/git/git/run-command.c:667 trace: run_command: unset GIT_DIR; GIT_PROTOCOL=version=2 '/G/system/zssh/sshoss -Q
-t -Z -S $ZSSGT' -o SendEnv=GIT_PROTOCOL -p 22 git@bitbucket.org 'git-upload-pack '\''/myproj/repo.git'\'''
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

This is the same result from back around 2.0. Looking back in the email chain from back then, it seemed that the GIT_SSH_COMMAND had
to be a single program/script with no arguments. Sshoss is not being launched during this failure. The failure is the same if the
simplified form of the URI is used and no port. The result is also the same if I use \$ZSSH0 in a double-quoted form of the export.
execvp() will not accept the above as a program, nor will calling stat on it as in locate_in_path(). So I'm obviously doing
something wrong, but this is where the motivation originates.

-Randall

