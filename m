Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A1C77B75
	for <git@archiver.kernel.org>; Mon, 22 May 2023 20:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjEVUtb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 22 May 2023 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjEVUta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 16:49:30 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57E93
        for <git@vger.kernel.org>; Mon, 22 May 2023 13:49:28 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34MKm70P3883455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 20:48:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        <git@vger.kernel.org>
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com> <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com> <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com> <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
In-Reply-To: <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
Subject: RE: [BUG] Git 2.38.0-rc1 t1800 message text comparison
Date:   Mon, 22 May 2023 16:49:20 -0400
Organization: Nexbridge Inc.
Message-ID: <013501d98cee$e58dc980$b0a95c80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFwJ678f40H0J9aM+Un1S82qzKFhgIJQNYvAYSG8xkChVcsKrAI9H2g
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, May 22, 2023 4:39 PM, René Scharfe wrote:
>Am 14.12.22 um 06:53 schrieb rsbecker@nexbridge.com:
>> On September 23, 2022 4:43 PM, I wrote:
>>> On September 22, 2022 3:03 PM, I wrote:
>>>> On September 22, 2022 3:02 PM, I wrote:
>>>>> Rc1 is looking good except for this test.
>>>>>
>>>>> We get a diff as follows:
>>>>>
>>>>> -fatal: cannot run bad-hooks/test-hook: ...
>>>>> +fatal: cannot exec 'bad-hooks/test-hook': Permission denied
>>>>>
>>>>> It looks like the pattern
>>>>> sed -e s/test-hook: .*/test-hook: .../
>>>>>
>>>>> needs to be a bit extended. Adding
>>>>>
>>>>> sed -e s/exec/run/ | send -e s/["']//g
>>>>>
>>>>> might help clear off the other noise.
>>>
>>> A patch that might work is as follows:
>>>
>>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh index
>>> 43fcb7c0bf..9a723631a2
>>> 100755
>>> --- a/t/t1800-hook.sh
>>> +++ b/t/t1800-hook.sh
>>> @@ -173,7 +173,10 @@ test_expect_success 'git hook run a hook with a
>>> bad shebang' '
>>>                -c core.hooksPath=bad-hooks \
>>>                hook run test-hook >out 2>err &&
>>>        test_must_be_empty out &&
>>> -       sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
>>> +       quot=`echo "\047"` &&
>>> +       sed -e "s/exec/run/" <err | \
>>> +               sed -e "s/$quot//g" | \
>>> +               sed -e "s/test-hook: .*/test-hook: .../" >actual &&
>>>        test_cmp expect actual
>>> '
>>>
>>> This does not require setting up a prerequisite for NonStop and the
>> technique
>>> might make the MING code easier but adding a change from spawn to run.
>>
>> This is still broken on NonStop. Is there any hope of a resolution?
>
>So trying to execute an executable file consisting only of the line
>"#!/bad/path/no/spaces" causes NonStop to report "Permission denied"?
>That message text belongs to error code EACCES, not to EPERM ("Operation not
>permitted"), right?

That should be correct, although the OS Devs I spoke to about this said "EPERM". I am experimenting.

>POSIX allows execve to return EACCES if the file to execute is not a regular file and
>executing that file type is not supported or if permissions are missing to one of its
>path components.

Part of the OS Dev's response was that POSIX is actually ambiguous on this point. Linux made the decision to use ENOENT. NonStop decided to use EPERM (although it may actually be EACCESS - I will report back.

>Either you have something called /bad that is not a regular file (e.g. a
>directory) -- then it's just a matter of changing the test to use a different supposedly
>non-existing filename, perhaps by creating and deleting a temporary file for just that
>purpose.
>
>Or NonStop correctly returns ENOEXEC on the first execve(2) call in run-command.c
>and returns ENOACCES on the fallback with SHELL_PATH (default value
>/usr/coreutils/bin/bash), because you are not allowed to execute that shell.  Then
>SHELL_PATH needs to be corrected.
>
>Or valid shells need to be placed in some kind of allow list to be accepted in #!-lines,
>lest NonStop returns ENOACCES on them.  Or NonStop is simply reporting a bogus
>error code for some reason.  In those cases you probably need an execve) compat/
>wrapper that corrects the error code.
>
>Or I'm missing something here, which is a relatively safe bet.  Anyway, depending on
>the cause of the "Permission denied" message, loosening the textual comparison in
>the test might not be enough.  There may not be a point for end users to distinguish
>between "exec" vs. "run", but the silent_exec_failure feature of run-command
>depends on the error code being ENOENT.

I will report my debug findings.
--Randall

