From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Thu, 26 Sep 2013 10:03:49 +0200
Message-ID: <vpq38osm2l6.fsf@anie.imag.fr>
References: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
	<20130925223334.GB9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jc@sahnwaldt.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 10:07:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP6ba-00070R-Le
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 10:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab3IZIHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 04:07:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36876 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab3IZIHI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 04:07:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8Q83ng8011253
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 10:03:49 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VP6YA-0001H9-6y; Thu, 26 Sep 2013 10:03:50 +0200
In-Reply-To: <20130925223334.GB9464@google.com> (Jonathan Nieder's message of
	"Wed, 25 Sep 2013 15:33:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Sep 2013 10:03:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8Q83ng8011253
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380787430.83709@1+Cwz0PE/GAaoyPV1A2bPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235403>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Matthieu Moy wrote:
>
>> The "--" notation disambiguates files and branches, but as a side-effect
>> of the previous implementation, also disabled the branch auto-creation
>> when $branch does not exist.
>
> Hm.  I am not sure that was just an implementation side-effect.
>
> Normally 'git checkout <branch> --' means "Check out that branch,
> and I mean it!".  'git checkout -- <pattern>' means "Check out
> these paths from the index, and I mean it!"  'git checkout <blah>'
> means "Do what I mean".

I'm not sure what was the intent, but I to me 'git checkout <branch> --'
means "I know <branch> is a ref, so don't try to interpret it
otherwise".

> On the other hand, if I want to do 'git checkout <branch> --'
> while disabling the "set up master to track origin/master" magic,
> I can use 'git checkout --no-track <branch> --'.  So I think this
> is a good change.

There's also --no-guess for that (purposely undocumented according to
the commit message of 46148dd7ea).

> More importantly, what's the contract behind this function?  Is there
> a simpler explanation than "If argument #2 is true, print a certain
> message depending on argument #1; otherwise, return argument #3?".
> If not, it might be clearer to inline it.

I made a function just because I needed the same pattern twice, and
having a function avoided overly nested if statements.

>> -	if (get_sha1_mb(arg, rev)) {
>> +	if (get_sha1_mb(arg, rev)) { /* case (1)? */
>
> The check means that we are most likely not in case (1), since arg isn't
> a commit name, right?

Not really. We're likely in an incorrect use of case 1, and want to give
an accurate error message (like "invalid reference").

>> +		int try_dwim = dwim_new_local_branch_ok;
>> +
>> +		if (check_filename(NULL, arg) && !has_dash_dash)
>> +			try_dwim = 0;
>> +		/*
>> +		 * Accept "git checkout foo" and "git checkout foo --"
>> +		 * as candidates for dwim.
>> +		 */
>> +		if (!(argc == 1 && !has_dash_dash) &&
>> +		    !(argc == 2 && has_dash_dash))
>> +			try_dwim = 0;
>> +
>> +		if (try_dwim) {
>> +			const char *remote = unique_tracking_name(arg, rev);
>> +			if (!remote)
>> +				return error_invalid_ref(arg, has_dash_dash, argcount);
>
> This could be simplified by eliminating try_dwim local.
>
> We are trying case (3) first:
>
> 		if (dwim_new_local_branch_ok &&
> 		    (argc == 1 || (argc == 2 && has_dash_dash)) &&
> 		    (has_dash_dash || !check_filename(NULL, arg))) {

I disagree that this is simpler. I introduced try_dwim precisely to
avoid this kind of monster boolean expression, and to leave room for
comments in the code.

You'd also need a "if (has_dash_dash)" inside this branch of the if to
give an accurate error message for "git checkout <non-branch> --".

> [...]
>> --- a/t/t2024-checkout-dwim.sh
>> +++ b/t/t2024-checkout-dwim.sh
>> @@ -164,4 +164,26 @@ test_expect_success 'checkout of branch from a single remote succeeds #4' '
>>  	test_branch_upstream eggs repo_d eggs
>>  '
>>  
>> +test_expect_success 'checkout of branch with a file having the same name fails' '
>> +	git checkout -B master &&
>> +	test_might_fail git branch -D spam &&
>> +
>> +	>spam &&
>> +	test_must_fail git checkout spam &&
>> +	test_must_fail git checkout spam &&
>
> Why twice?

Oops, fixed.

> Do we check that "git checkout --no-track spam --" avoids Dscho's
> DWIM?

Could be done in addition, but I have no time for this, sorry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
