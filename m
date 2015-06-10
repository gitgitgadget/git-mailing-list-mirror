From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Wed, 10 Jun 2015 09:55:29 +0200
Message-ID: <vpqr3pkatfy.fsf@anie.imag.fr>
References: <1809967391.331411.1433920237669.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2arL-0002W0-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbbFJHzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:55:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34932 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbbFJHzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:55:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5A7tSBR004309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 09:55:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A7tTLa013783;
	Wed, 10 Jun 2015 09:55:29 +0200
In-Reply-To: <1809967391.331411.1433920237669.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Wed, 10 Jun 2015 09:10:37 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 09:55:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5A7tSBR004309
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434527729.7341@40Sw39WdltWaCIugc4Q5hA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271270>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

>>> - 
>>> - fprintf(stderr, "The merge base %s is bad.\n" 
>>> - "This means the bug has been fixed " 
>>> - "between %s and [%s].\n", 
>>> - bad_hex, bad_hex, good_hex); 
>>> - 
>>> + if (!strcmp(name_bad, "bad")) { 
>>> + 	fprintf(stderr, "The merge base %s is bad.\n" 
>>> + 	"This means the bug has been fixed " 
>>> + 	"between %s and [%s].\n", 
>>> + 	bad_hex, bad_hex, good_hex); 
>>> + } 
>> 
>>You need an "else" here. Maybe it comes later, but as a reviewer, I want 
>>to check that you did not forget it now (because I don't trust myself to 
>>remember that it must be added later). 
>
> Should I put an else {} with nothing in beetween? 

What you want to avoid is a senario where the if branch is not taken
silently in the future. Two ways to avoid that:

if (!strcmp(name_bad, "bad")) {
	// special case for good/bad
} else {
	die("BUG: terms %s/%s not managed", name_bad, name_good);
}

Think of someone trying to debug the code later: if you encounter a
die("BUG: ..."), gdb will immediately tell you what's going one.
Debugging the absence of something is much more painful.

Alternatively:

if (!strcmp(name_bad, "bad")) {
	// special case for good/bad
} else {
	fprintf("very generic message not saying \"which means that ...\"");
}

In both cases, adding a new pair of terms should look like

 if (!strcmp(name_bad, "bad")) {
 	// special case for good/bad
+} else if(!strcmp(name_bad, "<new-term>")) {
+	// special case for <new-term>
 } else {
 	die("BUG: terms %s/%s not managed", name_bad, name_good);
 }

I have a slight preference for the "else" with a generic message. It
will be dead code for now, but may turn useful if we ever allow
arbitrary pairs of terms.

>
>>> + name_bad = "bad"; 
>>> + name_good = "good"; 
>>> + } else { 
>>> + strbuf_getline(&str, fp, '\n'); 
>>> + name_bad = strbuf_detach(&str, NULL); 
>>> + strbuf_getline(&str, fp, '\n'); 
>>> + name_good = strbuf_detach(&str, NULL); 
>>> + } 
>> 
>>I would have kept just 
>> 
>> name_bad = "bad"; 
>> name_good = "good"; 
>> 
>>in this patch, and introduce BISECT_TERMS in a separate one. 
>
> Should not I introduce BISECT_TERMS in bisect.c and git-bisect.sh 
> with the same commit?

Make sure you have a bisectable history. If you use two commits, you
should make sure that the intermediate step is consistant. If the change
is small enough, it's probably better to have a single commit. No strong
opinion on that (at least not before I see the code).

> I did some rebase though and now name_bad and name_good appears in the
> first commit, and read_bisect_terms in the second.
>
>>> --- a/git-bisect.sh 
>>> +++ b/git-bisect.sh 
>>> @@ -77,6 +77,7 @@ bisect_start() { 
>>> orig_args=$(git rev-parse --sq-quote "$@") 
>>> bad_seen=0 
>>> eval='' 
>>> + start_bad_good=0 
>>> if test "z$(git rev-parse --is-bare-repository)" != zfalse 
>>> then 
>>> mode=--no-checkout 
>>> @@ -101,6 +102,9 @@ bisect_start() { 
>>> die "$(eval_gettext "'\$arg' does not appear to be a valid revision")" 
>>> break 
>>> } 
>>> + 
>>> + start_bad_good=1 
>>> + 
>> 
>>Why do you need this variable? It seems to me that you are hardcoding 
>>once more that terms can be either "good/bad" or "old/new", which you 
>>tried to eliminate from the previous round. 
>
> I answered to Junio on this too, it is because our function which create 
> the bisect_terms file is not called after 
> 'git bisect start bad_rev good_rev'.

Then the variable name is not good. If the variable is there to mean "we
did not define the terms yet", then bisect_terms_defined={0,1} would be
much better (probably not the best possible name, though).

>>> +bisect_voc () { 
>>> + case "$1" in 
>>> + bad) echo "bad" ;; 
>>> + good) echo "good" ;; 
>>> + esac 
>>> +} 
>> 
>>It's weird to have these hardcoded "bad"/"good" when you already have 
>>BISECT_TERMS in the same patch. 
>
> bisect_voc is used to display what commands the user can do, thus the 
> builtins tags. I did not find a way to not hardcode them.

Well, if you really want to say good/bad, then using just good/bad would
be simpler than $(bisect_voc good)/$(bisect_voc bad), no? bisect_voc is
just the identitity function (or returns the empty string for input
other than good/bad).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
