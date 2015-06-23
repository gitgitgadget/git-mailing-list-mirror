From: Matthieu Moy <Matthieu.Moy@Grenoble-INP.fr>
Subject: Re: [PATCH v7 0/5] git bisect old/new
Date: Tue, 23 Jun 2015 22:16:34 +0200
Message-ID: <vpqsi9imb8d.fsf@anie.imag.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq381idz59.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:16:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Uci-0000pL-MX
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbbFWUQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:16:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49250 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932538AbbFWUQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:16:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5NKGWvk005173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jun 2015 22:16:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5NKGYds011502;
	Tue, 23 Jun 2015 22:16:34 +0200
In-Reply-To: <xmqq381idz59.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Jun 2015 12:04:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Jun 2015 22:16:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5NKGWvk005173
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435695393.82853@P6joyc8PkmXW1ZbuP+uWXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272494>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> I fixed a few minor issues in v6. Patch between my version and v6 is
>> below. I also pushed my branch here:
>>
>>   https://github.com/moy/git/tree/bisect-terms
>
> It is somewhat confusing to see v3 yesterday and then this v7 next
> day.  How did I miss v4 thru v6?

Oops, I pattern-matched the wrong part when reading [PATCH v3 6/6].
Indeed, this should have been numberred v4, I should have s/v6/v3/ in my
sentence above.

> Regarding the second and third one, the messages they give when the
> user marked one tip of a side branch as old and the other new gave
> me a hiccup while reading them, though.
>
> 	if (!strcmp(name_bad, "bad")) {
> 		fprintf(stderr, "The merge base %s is bad.\n"
> 			"This means the bug has been fixed "
> 			"between %s and [%s].\n",
> 			bad_hex, bad_hex, good_hex);
> 	} else {
> 		fprintf(stderr, "The merge base %s is %s.\n"
> 			"This means the first commit marked %s is "
> 			"between %s and [%s].\n",
> 			bad_hex, name_bad, name_bad, bad_hex, good_hex);
>
> The "bad" side is inherited from the original and not your fault,
> but it was already very hard to understand. The other side is not
> just unreadable, but I think is incorrect and confusing to say
> "first commit marked %(name_bad)s"; you know there are history
> segments whose oldest ends (i.e. merge base that is bad) are marked
> as 'bad', and the other ends are marked as 'good', and you haven't
> marked any of the commits in between yet.  So there is no "first
> commit marked" either as bad or good there between these endpoints
> (yet).

The situation is (the bisection started with bad=branch1 and
good=branch2):

---- base (name_bad) ------ branch1 (name_bad)
        \
         `----------------- branch2 (name_good)

So, the first commit having property name_good is between base and
branch2. So, the message seems wrong in two ways:

* As you say, the wording "marked as" seem to imply that we did mark the
  commit, while we actually did not explore base..branch2
  I'd write "the first '%s' commit" (the important is to remove
  "marked").

* The message uses 'name_bad' where it should use 'name_good'. Indeed,
  the original message talks about "bug fixed", i.e. the first _good_
  commit is in base..branch2.

Is this what you meant?

(Sorry, I need drawings and bullet lists to think properly ;-) ).

Actually, I think it would make sense to include my drawing above in a
comment in the code.

> Also I was somewhat puzzled and disappointed to still see
> name_{bad,good} not name_{new,old} used as variable names even in
> the endgame patch, though.  Is that intended?

I still think that name_old/name_new would have been much better names
if we were to write bisect from scratch, but I got convinced by
Christian that name_bad/name_good made sense too. Even if we adopted
old/new in these variables, we would still have e.g. a variable
"bad_seen" in the code. So, moving the codebase to adopt the old/new
convention internally is more than just chosing the name of variables to
avoid hardcoded "good"/"bad" string litterals. Moving the brain of
developpers to adopt the old/new convention is even another debate.

I don't know if this is the reason why Antoine did not change it, but
that's why I did not insist further and did not do the change myself.

> Yeah, if I may rephrase to make sure we are on the same page, in
> order for 5/5 to be done sanely, 1-4/5 must be giving a good
> foundation to build on.  I agree with that, I agree that including a
> polished 5/5 would be a good thing, and then I further agree that
> 1-4/5 could be delivered before 5/5 is ready.

Yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
