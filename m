Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA8C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2684B60F0F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 15:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhG3PGI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 30 Jul 2021 11:06:08 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54974 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbhG3PGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 11:06:08 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16UF60gR032795
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jul 2021 11:06:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Fabian Stelzer'" <fs@gigacodes.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Jonathan Tan'" <jonathantanmy@google.com>,
        <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        <hanwen@google.com>, <sandals@crustytoothpaste.net>,
        <bagasdotme@gmail.com>, <hji@dyntopia.com>, <avarab@gmail.com>,
        <felipe.contreras@gmail.com>, <sunshine@sunshineco.com>,
        <gwymor@tilde.club>
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com> <20210728230452.2719333-1-jonathantanmy@google.com> <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de> <xmqq8s1o4zn8.fsf@gitster.g> <039a01d784bc$e92568a0$bb7039e0$@nexbridge.com> <8b8fafad-0c49-0d17-b8f4-3e797a3fc9b6@gigacodes.de> <039b01d784c0$518b7440$f4a25cc0$@nexbridge.com> <ef39f1f8-9da1-25e9-ec30-b7023705b58a@gigacodes.de> <03a101d784c9$0cb413a0$261c3ae0$@nexbridge.com> <30489b9f-8bbb-22c3-bd36-95f430a45ba9@gigacodes.de> <001601d7854e$e0d24960$a276dc20$@nexbridge.com> <6f5f654c-fd5f-a8a5-acdc-14e24f6843c6@gigacodes.de>
In-Reply-To: <6f5f654c-fd5f-a8a5-acdc-14e24f6843c6@gigacodes.de>
Subject: RE: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify signatures
Date:   Fri, 30 Jul 2021 11:05:54 -0400
Message-ID: <001a01d78554$688e1cd0$39aa5670$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
thread-index: AQKDCFfzyN3R5qbWeAOurSL0iTEETgJUwDMMAWiTjqoCKdmprwGGogTJAa8E9FUCtq61mQKrihMfAig7+M8BLRyVugILgkoOAg1jB6GpVSqS8A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 30, 2021 10:32 AM, Fabian Stelzer wrote:
>On 30.07.21 16:26, Randall S. Becker wrote:
>> On July 30, 2021 4:17 AM, Fabian Stelzer wrote:
>>> Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and
>>> verify signatures
>>>
>>> On 30.07.21 00:28, Randall S. Becker wrote:
>>>> On July 29, 2021 5:29 PM, Fabian Stelzer wrote:
>>>>> On 29.07.21 23:25, Randall S. Becker wrote:
>>>>>> On July 29, 2021 5:13 PM, Fabian Stelzer wrote:
>>>>>>> Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output
>>>>>>> and verify signatures
>>>>>>>
>>>>>>> On 29.07.21 23:01, Randall S. Becker wrote:
>>>>>>>> On July 29, 2021 4:46 PM, Junio wrote:
>>>>>>>>> Fabian Stelzer <fs@gigacodes.de> writes:
>>>>>>>>>
>>>>>>>>>> On 29.07.21 01:04, Jonathan Tan wrote:
>>>>>>>>>>
>>>>>>>>>>> Also, is this output documented to be stable even across locales?
>>>>>>>>>> Not really :/ (it currently is not locale specific)
>>>>>>>>>
>>>>>>>>> We probably want to defeat l10n of the message by spawning it in the C locale regardless.
>>>>>>>>>
>>>>>>>>>> The documentation states to only check the commands exit code.
>>>>>>>>>> Do we trust the exit code enough to rely on it for verification?
>>>>>>>>>
>>>>>>>>> Is the exit code sufficient to learn who signed it?  Without
>>>>>>>>> knowing that, we cannot see if the principal is in or not in
>>>>>>>>> our
>>>>>>>> keychain, no?
>>>>>>>>
>>>>>>>> Have we not had issues in the past depending on exit code? I'm not sure this can be made entirely portable.
>>>>>>>>
>>>>>>>
>>>>>>> To find the principal (who signed it) we don't have to parse the output.
>>>>>>> Since verification is first a call to look up the principals
>>>>>>> matching the signatures public key from the allowedSignersFile
>>>>>>> and then trying verification with each one we already know which
>>>>>>> one matched (usually there is only one. I think multiples is only
>>>>>>> possible with an SSH
>>>>> CA).
>>>>>>> Of course this even more relies on the exit code of ssh-keygen.
>>>>>>>
>>>>>>> Not sure which is more portable and reliable. Parsing the textual output or the exit code. At the moment my patch does both.
>>>>>>
>>>>>> What about a configurable exit code for this? See the comment below about that.
>>>>>>
>>>>>
>>>>> I'm not sure what you mean. Something like "treat exit(123) as success"?
>>>>
>>>> How about gpg.ssh.successExit=123 or something like that.
>>>>
>>>
>>> I don't quite understand what the benefit would be. Do you have any
>>> specific portability problems/concerns where the ssh-keygen format is different or exit codes differ?
>>> I think using a script that provides exit(0) on success and the
>>> correct output to wrap ssh-keygen and setting it in gpg.ssh.command can already cover edge cases when needed.
>>>
>>>>
>>>> Is there documentation on the possible arguments the patch series
>>>> will use for this so one can create a wrapper script? I had to look
>>>> into
>>> the code to find out what GIT_SSH_COMMAND actually required when the ssh variant was "ssh". I'd rather not have to do that in this
>case.
>>>>
>>>
>>> The documentation in ssh-keygen(1) is quite good and straight forward
>>> for verification and signing. Again if you have any specific portability concerns i'd be glad to help.
>>
>> I do know the ssh-keygen interface and that does not really answer my doubts.
>>
>> My point here is that ssh-keygen is not always available in the same form on all platforms. Providing a full emulation of all arguments is
>not effective or likely even possible, and a waste of time. I'm asking for documentation on what specific options you are using for each
>function. OpenSSL is not available everywhere, and even where it is, the latest versions are not always available. It is important to know
>what the specific interface is being used.
>>
>>
>
>Fair enough. Where would you expect to look for such documentation?
>I'm not sure sth like config/gpg.txt is the right place for this.

My suggestion is wherever gpg.ssh.command is documented. So really, I think config/gpg.txt is the place. It's that or we create some common location for compatibility layer documentation (what I would really prefer). If there is a good place to put that, I might be willing to take on the documentation task, but my $DAYJOB is keeping me from anything heavy at this point.

With my thanks,
Randall

