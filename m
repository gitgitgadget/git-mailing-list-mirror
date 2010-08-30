From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3?] Add global and system-wide gitattributes
Date: Tue, 31 Aug 2010 00:55:53 +0200
Message-ID: <vpqhbibbthi.fsf@bauges.imag.fr>
References: <vpqy6bqr3ep.fsf@bauges.imag.fr>
	<1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
	<87fwxxhfpp.fsf_-_@gmail.com>
	<7vzkw4edc5.fsf@alter.siamese.dyndns.org>
	<vpqvd6sik0n.fsf@bauges.imag.fr>
	<7voccjesk7.fsf@alter.siamese.dyndns.org>
	<7vbp8jerfq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Petr Onderka <gsvick@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 00:56:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqDH9-0005ym-VL
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 00:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab0H3W4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 18:56:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49868 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab0H3W4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 18:56:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7UMi3cQ006176
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Aug 2010 00:44:03 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OqDGb-0001v5-Eu; Tue, 31 Aug 2010 00:55:53 +0200
In-Reply-To: <7vbp8jerfq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 30 Aug 2010 14\:11\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 31 Aug 2010 00:44:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7UMi3cQ006176
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283813044.88482@7KKlG41FotoOA0QNMd1k7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154868>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> I don't understand why this breaks the test. It seems blame
>>> --encoding=UTF-8 relies on the fact that the i18n section of the
>>> configuration is not loaded.
>>
>> That's interesting; I haven't traced the codepath involved, but I do not
>> think "configuration is not loaded" is the issue. "Reading either before
>> the main codepath is ready, or more likely overwriting/destroying what the
>> main codepath has read it by re-reading the configuration" may be.
>
> I think that hunch is correct.

Confirmed.

> A typical way we default to hardcoded value, overridable by
> configuration file, and then further use command line to override
> that, is for the main codepath to do the following in this order:
>
>  - call git_config(git_appropriate_config); this changes the variables
>    (with possibly hardcoded default) defined in environment.c;
>
>  - parse command line options and override the variable;
>
>  - use the variable at runtime.

Yes, this is the problem, with git_log_output_encoding as you guessed.

> The correct solution would be twofold, but the latter is rather painful:

Not that much in the case of git_log_output_encoding, but other uses
of the same pattern may exist.

>  - The call from the bootstrap_attr_stack should use a callback that reads
>    only the attribute file location configuration and _nothing else_.
[...]
>  - The way programs (this is not limited to blame and other rev-list
>    machinery users) implement the "use configured values but let command
>    line override them" need to be changed.

I think it's reasonable to do both. Having both git_config() and
command-line parsing write to the same variable is fragile and should
be avoided IMHO, but OTOH, arbitrary calls to
git_config(git_default_config) may break other things, so ...

>    One possibility is to copy the values determined by reading the config
>    and the command line to their own variables, so that later random call
>    to git_config() won't stomp on the actual values to be used.  This is
>    painful as environment.c variables are _meant_ to be easily usable as
>    global variables and copying them away (which means they now need to be
>    passed around throughout the callchain in the various APIs) defeats
>    the whole point of having them.

I just keep two global variables instead of two, and implement a
straightforward accessor. Command-line option parsing already used to
write to a global variable, so it doesn't change much.

New patch serie follows,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
