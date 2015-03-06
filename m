From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-credential-store: support XDG config dir
Date: Fri, 06 Mar 2015 10:57:13 +0100
Message-ID: <vpqfv9ila86.fsf@anie.imag.fr>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
	<1425414299-24000-2-git-send-email-pyokagan@gmail.com>
	<20150304094505.GA15593@peff.net>
	<CACRoPnTBmqtB+mvx9wFG3EUDRjfrsM==GQsso6V3q9NHH1k-YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 10:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTp0s-0004v6-4J
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 10:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbbCFJ5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 04:57:36 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51696 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbbCFJ5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 04:57:32 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t269vCiV030650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Mar 2015 10:57:12 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t269vDc3018348;
	Fri, 6 Mar 2015 10:57:13 +0100
In-Reply-To: <CACRoPnTBmqtB+mvx9wFG3EUDRjfrsM==GQsso6V3q9NHH1k-YA@mail.gmail.com>
	(Paul Tan's message of "Thu, 5 Mar 2015 14:26:39 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Mar 2015 10:57:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t269vCiV030650
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426240635.6074@arDRK77WercpfqyA4HCrug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264907>

Paul Tan <pyokagan@gmail.com> writes:

> Hi all,
>
> Thanks for the review. I apologize for rushing the patch out as I
> wanted to get feedback on the new behavior before committing to any
> more code changes.

There is no problem sending unfinished versions for discussions. If
unsure, send it as [RFC/PATCH].

>> When writting a commit message, always insist on _why_ [...]
>
> Generally, I would like git to have full support for the XDG base dir
> spec

The point is not only why you implement XDG spec (which is not very
controversial), but also why you did it the way you did.

> In fact, thinking about it again, I think the behavior implemented in
> the patch may not be suitable. Comments below.

Writting more arguments in the commit message helps getting these
thoughts earlier ;-).

>>> Likewise,
>>> lookup_credential() returns 1 if it could find the credential, and 0 if
>>> it could not.
>>
>> Err, you're changing the calling convention, and you're not the only
>> caller (git grep lookup_credential).
>>
>> If you need to change this existing function, best is to start your
>> series with a preparatory patch that does the calling convention change,
>> adapts the other caller, and then write your change on top, as [PATCH 2].
>
> Eh? I thought lookup_credential has static linkage. The only other use
> of lookup_credential is in credential-cache--daemon.c, and that has
> its own function definition with static linkage.

Indeed, it was only me looking at "git grep" too fast. You're right.

>>> -     if (!strcmp(op, "get"))
>>> -             lookup_credential(file, &c);
>>> -     else if (!strcmp(op, "erase"))
>>> -             remove_credential(file, &c);
>>> -     else if (!strcmp(op, "store"))
>>> -             store_credential(file, &c);
>>> -     else
>>> +     if (!strcmp(op, "get")) {
>>> +             if (file) {
>>> +                     lookup_credential(file, &c);
>>> +             } else {
>>> +                     if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
>>> +                             ret = lookup_credential(xdg_file, &c);
>>> +                     if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
>>> +                             lookup_credential(home_file, &c);
>>> +             }
>>> +     } else if (!strcmp(op, "erase")) {
>>> +             if (file) {
>>> +                     remove_credential(file, &c);
>>> +             } else {
>>> +                     if (xdg_file && access(xdg_file, F_OK) == 0)
>>> +                             remove_credential(xdg_file, &c);
>>> +                     if (home_file && access(home_file, F_OK) == 0)
>>> +                             remove_credential(home_file, &c);
>>
>> Why is it somethimes access_or_warn and sometimes just access? (genuine
>> question)
>
> For "get" even though the xdg file cannot be read I believe it should
> not be a fatal error because the credential may be found in the home
> file. We should still warn the user though because it may not be what
> the user wants.

IMHO, this would deserve a short comment in the code, e.g. /* Warn the
user, but we may recover by finding credential in another file */ or so.

It's less sensitive, but there was more subtle breakages with the config
file (should Git do something at all when the config files can't be read
completely?).

> However, I see now that I mistakenly broke compatibility with the old
> behavior, which errors out if the home credential file could not be
> read.

You changed the behavior, but it's not really a compatibility breakage:
I doubt people _rely_ on Git dying in this case.

I have no strong opinion on what behavior is the best, I think yours
makes sense, but if you go for it, it should be documented in the commit
message (or even better: the change could be extracted into a separate
patch)

>> I'm not convinced you need to remove the credential from home_file if
>> the xdg_file takes precedence. Not saying you shouldn't, but you should
>> argue more at least.
>
> Indeed, I committed a reasoning error there. I was thinking about what
> happens if the user runs "store" on the new version of git, then
> switches to an old one. Actually, "store" should write to both, so
> that users will get the updated credentials regardless of whether they
> use the old or new git.

Actually, your version made sense too. Credentials are usually
confidential data that you don't want to replicate too much. One reason
for using "store" can be that you want to overwrite your old password
with something else, and not leave your old password lying around
(because, e.g. it's the same password you use for your bank account and
nuclear launch code, and you haven't changed it there yet).

> In fact, the priority needs to be changed. To summarize, for
> compatibility with older versions, git should read from the home
> credentials file first, then the XDG one (since store will handle
> updating of both). For writing, git should write to both files. For
> erasing, git should erase from both files.

OTOH, if you really want compatibility with old versions, just don't
create .config/git/ and git will still write to ~/.git-credentials,
right? As long as XDG remains an opt-in feature, I wouldn't care too
much about backward compatibility.

At some point, I personnally think XDG should become the default, but we
can wait as much as needed to do that (and not everybody may agree with
me here).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
