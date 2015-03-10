From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Adding - shorthand for @{-1} in RESET command
Date: Tue, 10 Mar 2015 10:43:57 -0700
Message-ID: <xmqqbnk021eq.fsf@gitster.dls.corp.google.com>
References: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
	<CAPig+cRAB-LQctj6UOKUXps-MEh2C_EbSp_3=wfgxtWx6xCbhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sundararajan R <dyoucme@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:44:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVOCO-0004Fp-8j
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbbCJRoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 13:44:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752718AbbCJRoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 13:44:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E29443C5AF;
	Tue, 10 Mar 2015 13:44:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MwQwOL44RibbbPATTfjt79fgXlo=; b=TsEsWL
	0aHccAOif3sirrRlPhnZXSwIryUvrlHIRqnxl8Jb0kCDDXxlzLhWNi/0jPmcaVX8
	N38x8ZK+oXtPdvmM+F1MZrI05kxcnuTcZrc8A420CQ1FHplsj/0hmmolWLny1mOa
	oSJ/NFJfqW0dyJoAkUJ0/F+JNok6heMTCiTPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e4i81/hlP98/CGvz5XpnWYv7Cbajt+Dm
	fn6H42osudlFTmR2eDLV8DNnqw7rP3KPR8jJP+WshGir8yBusqBjnbgZ2PIeYL3M
	Xm4LJAAbRJ2acIxa+ECVUgsybR9kHUdNuhiHalwDDE9FYHjogNcZJ2SZzYcqOkpR
	iqI1APygGbA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60AC23C5AD;
	Tue, 10 Mar 2015 13:44:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A06853C5AA;
	Tue, 10 Mar 2015 13:43:59 -0400 (EDT)
In-Reply-To: <CAPig+cRAB-LQctj6UOKUXps-MEh2C_EbSp_3=wfgxtWx6xCbhw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 Mar 2015 02:54:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 087BA8CE-C74D-11E4-9D4D-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265249>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -226,7 +233,14 @@ static void parse_args(struct pathspec *pathspec,
>>                         rev = *argv++;
>>                 } else {
>>                         /* Otherwise we treat this as a filename */
>> -                       verify_filename(prefix, argv[0], 1);
>> +                       if(file_named_minus) {
>> +                               die(_("ambiguous argument '-': both revision and filename\n"
>> +                                       "Use ./- for file named -\n"
>> +                                       "Use '--' to separate paths from revisions, like this:\n"
>> +                                       "'git <command> [<revision>...] -- [<file>...]'"));
>
> This seems odd. If arguments following '--' are unconditionally
> treated as paths, why is it be necessary to tell the user to spell out
> file '-' as './-'? Shouldn't "git reset -- -" be sufficient?

I find that the presense of the if statement itself even odder.

 - verify_filename() and verify_non_filename() are designed to check
   that the string "-" given by the end-user is or is not a filename
   on the filesystem.  Why isn't this caller letting the callee do
   the job it was designed to do and doing that itself instead?

 - we know "-" aka "@{-1}" does not resolve to a committish at this
   point, so it must be a filename.  If "-" exists, then why should
   the user even need to differenciate it as ./- (or with "-- -")?

   After all, if there is no branch whose name is 'foo' and a file
   'foo' exists on the filesystem, the user can say "git reset foo"
   without disambiguation to reset that path, no?
