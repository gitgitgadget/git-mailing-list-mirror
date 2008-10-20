From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 20 Oct 2008 18:35:33 +0200
Message-ID: <4ac8254d0810200935sf7ad873tea53c0fb53bbe1c0@mail.gmail.com>
References: <1224445691-1366-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vy70k5las.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:15:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrxkO-00070A-Rh
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbYJTQfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbYJTQfg
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:35:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:42925 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYJTQff (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:35:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so309391ywe.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GeERUzZI3H15dzapyN4i8hDmghTf9yRNV/aSbVaOwdE=;
        b=RY+vLNFgUZko0ZrAE69jxDDfoEGAir6pTnggjSmdZoUxFQpdlEVHE7UgpfKWwCfqv6
         jE20u/GYUPH0Cpg4Nt/uayeUleE1fSy2sP7IDFeKrM9yPbvbiTHo4qi7sSVHj16x+mDp
         LRshcKjKWRKMtDsQfkewjG4Y7rLkHz7+4kD+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=W9OMB2tT/2kmJVUASLOET62dn1rv1BNMao9Pu9YFmO0HudU72hIrPXBwfKqwg02FTb
         yHgeYTdLloAv2b7TpBjPwl1h8kz5GYeO9AK0cBSKfLOjw9hWZYwMyfWS5MWANUbOgGi6
         pVmfP1pQLDv93XqYKyiVTw8xKzZXFYGbFc2V0=
Received: by 10.64.183.1 with SMTP id g1mr5093531qbf.72.1224520533187;
        Mon, 20 Oct 2008 09:35:33 -0700 (PDT)
Received: by 10.65.114.10 with HTTP; Mon, 20 Oct 2008 09:35:33 -0700 (PDT)
In-Reply-To: <7vy70k5las.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98709>

On Sun, Oct 19, 2008 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>
>> 2) my adaption of the following two lines from
>> builtin-fetch.c to the new verbosity option:
>>     if (verbosity == VERBOSE)
>>         transport->verbose = 1;
>>     if (verbosity == QUIET)
>>         transport->verbose = -1;
>
> Hmm, what's wrong with it?  Looks Ok to me...

Just wanted to be sure it's correct, that's all.

Actually I think the old code:
if (verbose >= 2)
    transport->verbose = 1;
is wrong and probably a leftover from old days
as Shawn confirmed.

>>  static struct option builtin_fetch_options[] = {
>> -     OPT__QUIET(&quiet),
>> -     OPT__VERBOSE(&verbose),
>> +     { OPTION_CALLBACK, 'q', "quiet", NULL, NULL,
>> +             "operate quietly",
>> +             PARSE_OPT_NOARG, option_parse_quiet },
>> +     { OPTION_CALLBACK, 'v', "verbose", NULL, NULL,
>> +             "be verbose",
>> +             PARSE_OPT_NOARG, option_parse_verbose },
>
> Isn't there a OPTION_FOO that assigns a constant to the given variable?

Yes, there is - OPT_SET_INT and I've used that in my next patch.

>> @@ -192,7 +211,6 @@ static int s_update_ref(const char *action,
>>
>>  static int update_local_ref(struct ref *ref,
>>                           const char *remote,
>> -                         int verbose,
>>                           char *display)
>>  {
>>       struct commit *current = NULL, *updated;
>> ...
>> @@ -366,18 +384,19 @@ static int store_updated_refs(const char *url, const char
>> *remote_name,
>>                       note);
>>
>>               if (ref)
>> -                     rc |= update_local_ref(ref, what, verbose, note);
>> +                     rc |= update_local_ref(ref, what, note);
>
> Hmph, in the existing code, do_fetch()->fetch_refs()->store_updated_refs()
> callchain relies on the "verbose" to be global anyway, so losing the
> ability to call update_local_ref() with verbosity as parameter is not a
> huge deal.

OK, I've kept the removal of the verbose param in the next patch.

> I however think it would be more beneficial in the longer term to keep
> "verbosity" as parameter so the caller can tweak what the callee does, and
> making large part of what cmd_fetch() does callable from outside.  That
> would involve making the builtin_fetch_options[] on-stack, and passing
> verbosity (and possibly other variables currently used as file-scope
> global) as parameters, which is outside of the scope of your patch, but it
> is something to keep in mind.
>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 75c3610..dc613db 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -16,6 +16,7 @@ cd_to_toplevel
>>  test -z "$(git ls-files -u)" ||
>>       die "You are in the middle of a conflicted merge."
>>
>> +verbosity=
>>  strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
>>  curr_branch=$(git symbolic-ref -q HEAD)
>>  curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
>
> It would fit at the end of the next line just fine, wouldn't it?
>
>> @@ -23,6 +24,10 @@ rebase=$(git config --bool branch.$curr_branch_short.rebase)
>>  while :
>>  do
>>       case "$1" in
>> +     -q|--quiet)
>> +             verbosity="$verbosity -q" ;;
>> +     -v|--verbose)
>> +             verbosity="$verbosity -v" ;;
>
> You know verbosity flags (-q and -v) are "the last one wins", so I do not
> see much point in this concatenation.

Without concatenation I would need to analyze the content
of the variable each time the option is passed to the shell
script. Do you know of a simpler/better way still keeping the
functionality that
$ git pull -q -v --quiet --verbose --quiet gives verbosity=QUIET
and
$ git pull -q -v --quiet --verbose --quiet -v yields verbosity=VERBOSE
?
