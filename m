Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35592C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBF561A14
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFTmV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 6 Jul 2021 15:42:21 -0400
Received: from elephants.elehost.com ([216.66.27.132]:65433 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhGFTmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:42:20 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 166JdW7s045737
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Jul 2021 15:39:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Fabian Stelzer'" <fs@gigacodes.de>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Fabian Stelzer via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com> <xmqqzguzlc03.fsf@gitster.g> <fffd8c26-f3a7-b074-f4ba-e8552ca1d7cc@gigacodes.de>
In-Reply-To: <fffd8c26-f3a7-b074-f4ba-e8552ca1d7cc@gigacodes.de>
Subject: RE: [PATCH] Add commit & tag signing/verification via SSH keys using ssh-keygen
Date:   Tue, 6 Jul 2021 15:39:27 -0400
Message-ID: <04d901d7729e$a51a9160$ef4fb420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGQchAJjmD2iUL5bDzddDRhqmGgNAK3GgPfAbfAA4mroN/7wA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 6, 2021 11:46 AM, Fabian Stelzer wrote:
>> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Fabian Stelzer <fs@gigacodes.de>
>>>
>>> set gpg.format = ssh and user.signingkey to a ssh public key string
>>> (like from an authorized_keys file) and commits/tags can be signed
>>> using the private key from your ssh-agent.
>>>
>>> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
>>> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners A
>>> possible gpg.ssh.revocationfile is also passed to ssh-keygen on
>>> verification.
>> There are probably style and coding-guideline nit people will pick in
>> the patch, but first of all I have to say that I am uncomfortably
>> excited to see this addition.
>>
>> One thing that is unclear is how the 'allowed-signers' is expected to
>> be maintained in the larger picture.  Who decides which keys (belong
>> to whom) are trustworthy?  Does a contributor has to agree with the
>> decision that certain keys are trustworthy made by somebody else in
>> the project and use the same 'allowed-signers' collection of keys to
>> effectively participate in the project?  How do revoking and rotating
>> keys work?
>>
>> It was a deliberate design decision to let PGP infrastructure that is
>> used to sign and verify signatures when we use PGP for signing without
>> tying any of these decisions to the tracked contents, as that would
>> reduce the attack surface for a malicious tree contents to affect the
>> signing and verification (in other words, "we punted"
>> ;-).  Even though I am not sure exactly what you meant by "defaults to
>> .gitsigners", I am assuming that you meant a file with the name at the
>> top-level of the working tree, which makes me worried, as it opens us
>> to the risk of reading from and blindly trusting whatever somebody
>> else placed in the tree contents immediately after we "git pull" (or
>> "git clone").
>>
>> Thanks for working on it.
>Glad to hear that :)
>I tried to keep the style with the existing code but the IDE sometimes has its own idea.
>
>I think there are two basic options for maintaining the allowed signers
>file:
>1. Every developer has their own stored outside of the repo and adds/revokes trust manually like with gpg.
>     A central repo would probably verify against a list managed by the tool (e.g. gitolite) 2. Store it in a .gitsigners file in the repo. This
>would only work if you only allow signed commits/pushes from this point onwards. But this way a shared understading of trusted users can
>be maintained easily.
>     Only already trusted committers can add new users or change their own keys. The signers file is basically a ssh_authorized_keys file
>with an additional principal identifier added at the front like:
>     fs@gigacodes.de ssh-rsa XXXKEYXXX Comment
>     a@b.com ssh-ed25519 XXXKEYXXX Comment
>
>Where are commits usually verified at the moment? On every devs checkout or only centrally on pushes?
>
>The signers file also supports SSH CA keys and wildcard identifiers. At the moment i look up the principal dynamically via the public key so
>it's just a text info of who's key is it at the moment.
>The SSH CA Stuff is probably a niche use case but could be cool in a corporate setting. Thats also what the revocation file is used for. The
>SSH CA can generate a KRL (like crl) which you put into it or you can specify explicit public keys in it to deny them.

Just musing here... If adding SSH CA, would not adding support for a self-signed SSL CA make sense? In such a situation, a self-signed certificate can be created at an organizational level, or even from an official root CA. Per-user self-signed certificates, or organizationally defined CAs and certificates, could be created that are more stable than SSH CAs. Then something like OpenSSL (via libcurl) could handle the signature and validation management. Signed content could propagate to Cloud-based git servers and retain their ability to be property verified. Although I can see a drawback here, which relates to expiring certificates - although the concept of an expired signed content is somewhat compelling. Imaging the use case where a company has an employee who signs a tag/commit. The employee departs/retires/terminated/etc., and with it the published certificate is also revoked - an extreme case perhaps, but if the code can no longer be trusted by virtue of the termination, maybe t
 his is semantically interesting. This could be a core git function with no additional dependencies.

Regards,
Randall

