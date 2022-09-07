Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021EBC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 22:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIGWXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGWXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 18:23:20 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4505AA0A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 15:23:19 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 287MNHRY066436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Sep 2022 18:23:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>        <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>        <xmqq1qsnugsu.fsf@gitster.g>        <YxkAxutS+B8//0WF@coredump.intra.peff.net>        <001201d8c2fb$3f1c51b0$bd54f510$@nexbridge.com> <xmqqh71isvc8.fsf@gitster.g>
In-Reply-To: <xmqqh71isvc8.fsf@gitster.g>
Subject: RE: [BUG] t1800: Fails for error text comparison
Date:   Wed, 7 Sep 2022 18:23:11 -0400
Organization: Nexbridge Inc.
Message-ID: <001a01d8c308$6d9f70f0$48de52d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDZ0y9ccf99b0ahBjvCTNgUih7ATAMrJszXAnXfeC4CeISKdgDlaxdUAeQqmxSve1BV4A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 7, 2022 5:56 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> I am finding an issue with t1800.16 failing as a result of a text
compare:
>>
>> -fatal: cannot run bad-hooks/test-hook: ...
>> +fatal: cannot exec 'bad-hooks/test-hook': Permission denied
>>
>> I don't think this is actually a failure condition but the message
>> text is platform and shell specific.
>
>Isn't this coming from piece of code in start_command()?
>
>		/*
>		 * Attempt to exec using the command and arguments starting
at
>		 * argv.argv[1].  argv.argv[0] contains SHELL_PATH which
will
>		 * be used in the event exec failed with ENOEXEC at which
point
>		 * we will try to interpret the command using 'sh'.
>		 */
>		execve(argv.v[1], (char *const *) argv.v + 1,
>		       (char *const *) childenv);
>		if (errno == ENOEXEC)
>			execve(argv.v[0], (char *const *) argv.v,
>			       (char *const *) childenv);
>
>		if (errno == ENOENT) {
>			if (cmd->silent_exec_failure)
>				child_die(CHILD_ERR_SILENT);
>			child_die(CHILD_ERR_ENOENT);
>		} else {
>			child_die(CHILD_ERR_ERRNO);
>		}
>
>The test apparently expects CHILD_ERR_NOENT, which comes from
>child_err_spew()
>
>	case CHILD_ERR_ENOENT:
>		error_errno("cannot run %s", cmd->args.v[0]);
>		break;
>	case CHILD_ERR_SILENT:
>		break;
>	case CHILD_ERR_ERRNO:
>		error_errno("cannot exec '%s'", cmd->args.v[0]);
>		break;
>	}
>
>but somehow your system fails the execve() with something other than
ENOENT.

The file exists but could not be executed. EPERM was returned. The reason is
that test-hooks exists and contains:

#!/bad/path/no/spaces

which does not exist. This (correctly IMO) translates to EPERM not ENOENT
because the test-hooks file exists but cannot be executed due to the
underlying failure. The underlying ENOENT is hidden.

