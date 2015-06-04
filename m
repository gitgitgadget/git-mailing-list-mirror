From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] log: diagnose empty HEAD more clearly
Date: Thu, 4 Jun 2015 09:31:04 +0200
Message-ID: <556FFEB8.4050407@atlas-elektronik.com>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>	<20150603062005.GA20580@peff.net>	<CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>	<20150603081432.GA32000@peff.net> <xmqqpp5cyabx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 09:31:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Pcq-00083k-6M
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 09:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbbFDHbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 03:31:31 -0400
Received: from mail96.atlas.de ([194.156.172.86]:24820 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbbFDHbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 03:31:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 441C710138;
	Thu,  4 Jun 2015 09:31:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzbSwBAaQNC2; Thu,  4 Jun 2015 09:31:05 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu,  4 Jun 2015 09:31:04 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 97B9627169;
	Thu,  4 Jun 2015 09:31:04 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Thu, 4 Jun 2015
 09:31:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqpp5cyabx.fsf@gitster.dls.corp.google.com>
OpenPGP: id=2DF5E01B09C37501BCA99666829B49C5922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270750>

Am 03.06.2015 um 19:24 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> My concern there would be risk of regression. I.e., that we would take
>> some case which used to error out and turn it into a silent noop. So I'd
>> prefer to keep the behavior the same, and just modify the error code
>> path. The end result is pretty similar to the user, because we obviously
>> cannot produce any actual output either way.
> 
> Okay.
> 
>> Something like:
>>
>> -- >8 --
>> Subject: log: diagnose empty HEAD more clearly
>>
>> If you init or clone an empty repository, the initial
>> message from running "git log" is not very friendly:
>>
>>   $ git init
>>   Initialized empty Git repository in /home/peff/foo/.git/
>>   $ git log
>>   fatal: bad default revision 'HEAD'
>>
>> Let's detect this situation and write a more friendly
>> message:
>>
>>   $ git log
>>   fatal: default revision 'HEAD' points to an unborn branch 'master'
>>
>> We also detect the case that 'HEAD' points to a broken ref;
>> this should be even less common, but is easy to see. Note
>> that we do not diagnose all possible cases. We rely on
>> resolve_ref, which means we do not get information about
>> complex cases. E.g., "--default master" would use dwim_ref
>> to find "refs/heads/master", but we notice only that
>> "master" does not exist. Similarly, a complex sha1
>> expression like "--default HEAD^2" will not resolve as a
>> ref.
>>
>> But that's OK. We fall back to the existing error message in
>> those cases, and they are unlikely to be used anyway.
>> Catching an empty or broken "HEAD" improves the common case,
>> and the other cases are not regressed.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I'm not a big fan of the new error message, either, just because the
>> term "unborn" is also likely to be confusing to new users.
>>
>> We can also probably get rid of mentioning "HEAD" completely. It is
>> always the default unless the user has overridden it explicitly.
> 
> I think that still mentioning "HEAD" goes directly against the
> reasoning you made in an earlier part of your message:
> 
>> I think it is one of those cases where the message makes sense when you
>> know how git works. But a new user who does not even know what "HEAD" or
>> a ref actually is may find it a bit confusing. Saying "we can't run
>> git-log, your repository empty!" may seem redundantly obvious even to
>> such a new user. But saying "bad revision 'HEAD'" may leave them saying
>> "eh, what is HEAD and why is it bad?".
> 
> and I agree with that reasoning: the user didn't say anything about
> "HEAD", so why complain about it?
> 
> Which is what led me to say "Why are we defaulting to HEAD before
> checking if it even exists?  Isn't that the root cause of this
> confusion?  What happens if we stopped doing it?"
> 
> And I think the "diagnose after finding that pending is empty and we
> were given 'def'" approach almost gives us the equivalent, which is
> why I said "Okay" above.
> 
> If we can make it possible to tell if that "def" was given by the
> user (i.e. --default parameter) or by the machinery (e.g. "git log"
> and friends), then we can remove "almost" from the above sentence.
> 
>> So we
>> could go with something like:
>>
>>   fatal: your default branch 'master' does not contain any commits
>>
>> or something. I dunno. Bikeshed colors welcome. Adding:
>>
>>   advise("try running 'git commit'");
>>
>> is probably too pedantic. ;)
> 
> ;-)
> 
> I am wondering if the attached is better, if only because it is of
> less impact.  I have die() there to avoid the behaviour change, but
> if we are going to have another future version where we are willing
> to take incompatiblity for better end-user experience like we did at
> 2.0, I suspect turning it to warning() or even removing it might be
> a candidate for such a version.  If you have one commit and ask
> "log", you get one commit back. If you have no commit and ask "log",
> I think it is OK to say that you should get nothing back without
> fuss.
> 
>  builtin/log.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 4c4e6be..3b568a1 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -148,6 +148,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
>  	argc = setup_revisions(argc, argv, rev, opt);
>  
> +	if (!rev->pending.nr && !opt->def)
> +		die("you do not have a commit yet on your branch");

I am not a native english speaker but shouldn't this be:

  "you do not have a commit on your branch yet"

??

> [...]

Stefan
-- 
----------------------------------------------------------------
/dev/random says: I bet you I could stop gambling.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
