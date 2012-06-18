From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2 RFC] verify_filename: ask the caller to chose the kind of diagnosis
Date: Mon, 18 Jun 2012 08:42:32 +0200
Message-ID: <vpq62apt92f.fsf@bauges.imag.fr>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
	<1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
	<1339958341-22186-2-git-send-email-Matthieu.Moy@imag.fr>
	<7vehpd7kot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 08:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgVfh-0004ep-1A
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 08:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab2FRGmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 02:42:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45248 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab2FRGml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 02:42:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5I6gL3M026520
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 18 Jun 2012 08:42:21 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SgVfV-0005F4-8G; Mon, 18 Jun 2012 08:42:33 +0200
In-Reply-To: <7vehpd7kot.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 17 Jun 2012 13:22:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 18 Jun 2012 08:42:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5I6gL3M026520
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340606543.29153@+vrnNjlpDxCNzQ88zGuXPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200137>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +/*
>> + * Verify that "name" is a filename.
>> + * The "diagnose_rev" is used to provide a user-friendly diagnosis. If
>> + * 0, the diagnosis will try to diagnose "name" as an invalid object
>> + * name (e.g. HEAD:foo). If non-zero, the diagnosis will only complain
>> + * about an inexisting file.
>> + */
>> +extern void verify_filename(const char *prefix, const char *name, int diagnose_rev);
>
> The whole point of verify_filename() is to make sure, because the
> user did not have disambiguating "--" on the command line, that the
> first non-rev argument is a path and also it cannot be interpreted
> as a valid rev.  It somehow feels wrong to make it also responsible,
> for a possibly misspelled rev.

verify_filename will check the same thing in both cases. If the caller
looks like

if (name is not a valid object name) {
        verify_filename(name);
}

then it should ask for a detailed diagnosis. If the caller knows that an
object name would not be accepted anyway, it should not.

> The caller can mistakenly throw 0 or 1 at random but the _only_ right
> value for this parameter is to set it to true only for the first
> non-rev, no?

In general, this is the case, but that's a consequence of "an object
name would not be accepted anyway". I don't think there is any such call
in Git's code source right now, but we could imagine a caller trying to
verify that something is actually a file, and "verify_filename" would be
a correct way to do it, provided you pass diagnose_rev == 0.

>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -927,8 +927,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  	/* The rest are paths */
>>  	if (!seen_dashdash) {
>>  		int j;
>> -		for (j = i; j < argc; j++)
>> -			verify_filename(prefix, argv[j]);
>> +		if (i < argc) {
>> +			verify_filename(prefix, argv[i], 1);
>> +			for (j = i + 1; j < argc; j++)
>> +				verify_filename(prefix, argv[j], 0);
>> +		}
>
> This is exactly
>
> 	verify_filename(prefix, argv[j], j == first_non_rev)

I buy that.

>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 8c2c1d5..4cc34c9 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -285,7 +285,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>  			rev = argv[i++];
>>  		} else {
>>  			/* Otherwise we treat this as a filename */
>> -			verify_filename(prefix, argv[i]);
>> +			verify_filename(prefix, argv[i], 1);
>
> This is also checking the first non-rev, too.  We just saw
> "florbl^{triee}" in "git reset florbl^{triee} hello.c" is not a
> valid rev.  If "florbl^{triee}" is indeed a file, we shouldn't
> complain and die with "This may be a misspelled rev", but take it as
> a path.

Yes, and this is what we are doing already. This verify_filename is only
called for the first argument. We have exactly the right pattern here:

		/*
		 * Otherwise, argv[i] could be either <rev> or <paths> and
		 * has to be unambiguous.
		 */
		else if (!get_sha1(argv[i], sha1)) {
			verify_non_filename(prefix, argv[i]);
		} else {
			/* Otherwise we treat this as a filename */
			verify_filename(prefix, argv[i], 1);
		}

Clearly, if "argv[i]" is a filename, it's OK and we take it as it is,
but if it is not, then the failure is due to both "verify_filename" and
"git_sha1" failures, and we should take that into account in the
diagnosis. To me, the fact that this is called for the first non-rev
argument is a detail, the real reason to pass 1 here is that we wouldn't
have called verify_filename if it was a revision.

>> @@ -81,13 +83,13 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
>>   * it to be preceded by the "--" marker (or we want the user to
>>   * use a format like "./-filename")
>>   */
>> -void verify_filename(const char *prefix, const char *arg)
>> +void verify_filename(const char *prefix, const char *arg, int diagnose_rev)
>>  {
>>  	if (*arg == '-')
>>  		die("bad flag '%s' used after filename", arg);
>>  	if (check_filename(prefix, arg))
>>  		return;
>> -	die_verify_filename(prefix, arg);
>> +	die_verify_filename(prefix, arg, diagnose_rev);
>
> And this implements the "if it is path, don't complain, but
> otherwise diagnose misspelled rev if the caller asked us to".
>
> I think the patch is not wrong per-se, but diagnose_rev is probably
> misnamed.  It tells the callee what to do, but gives little hint to
> the caller when to set it.  s/diagnose_rev/first_non_rev/ or
> something might make it easier to understand for future callers.

I considered "could_have_been_a_rev" or
"would_have_been_ok_if_it_was_a_rev" ;-).

I think it would be better to document that as a comment, like this in
cache.h:

   * In most cases, the caller will want diagnose_rev == 1 when
   * verifying the first non_rev argument, and diagnose_rev == 0 for the
   * next ones (because we already saw a filename, there's not ambiguity
   * anymore).
   */
  extern void verify_filename(const char *prefix, const char *name, int diagnose_rev);
  
but keep a param name that is more general.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
