From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Tue, 24 May 2016 10:11:57 +0200
Message-ID: <vpq1t4rri2a.fsf@anie.imag.fr>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7feka8kk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org,
	larsxschneider@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 10:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57UM-0001gE-RA
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbcEXIOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:14:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57513 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbcEXIM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4O8Bu6k004718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 24 May 2016 10:11:56 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4O8BviR013985;
	Tue, 24 May 2016 10:11:57 +0200
In-Reply-To: <xmqq7feka8kk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 May 2016 12:16:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 24 May 2016 10:11:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4O8Bu6k004718
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464682317.50422@NZuPcq4tSCxqg3cRI3vUSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295458>

Junio C Hamano <gitster@pobox.com> writes:

> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>>  static const char *use_message_buffer;
>> -static const char commit_editmsg[] = "COMMIT_EDITMSG";
>> +static const char commit_editmsg_path[] = git_path_commit_editmsg();
>
> The function defined with the macro looks like
>
> 	const char *git_path_commit_editmsg(void)
>         {
> 		static char *ret;
>                 if (!ret)
>                 	ret = git_pathdup("COMMIT_EDITMSG");
> 		return ret;
> 	}
>
> so receiving its result to "const char v[]" looks somewhat
> suspicious.
>
> More importantly, when is this function evaluated and returned value
> used to fill commit_editmsg_path[]?

I may have missed something, but I'd say "never", as the code is not
compilable at least with my gcc:

builtin/commit.c:98:1: error: invalid initializer
 static const char commit_editmsg_path[] = git_path_commit_editmsg();
 ^

AFAIK, initializing a global variable with a function call is allowed in
C++, but not in C.

And indeed, this construct is a huge source of trouble, as it would mean
that git_path_commit_editmsg() is called 1) unconditionnally, and 2)
before entering main().

1) means that the function call is made even when git is called for
another command. This is terrible for the startup time: if all git
commands have a not-totally-immediate initializer, then all commands
would need to run the initializers for all other commands. 2) means it's
a nightmare to debug, as you can hardly predict when the code will be
executed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
