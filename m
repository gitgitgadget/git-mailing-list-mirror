From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] add: allow users to silence Git 2.0 warnings about "add -u"
Date: Fri, 22 Feb 2013 10:32:20 +0100
Message-ID: <vpqd2vssnh7.fsf@grenoble-inp.fr>
References: <1361513224-34550-1-git-send-email-davvid@gmail.com>
	<7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:33:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8p07-0007G8-3I
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 10:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311Ab3BVJci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 04:32:38 -0500
Received: from mx1.imag.fr ([129.88.30.5]:38864 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952Ab3BVJcf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 04:32:35 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1M9WKEF012509
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Feb 2013 10:32:20 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U8ozN-0002LT-25; Fri, 22 Feb 2013 10:32:21 +0100
In-Reply-To: <CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com>
	(David Aguilar's message of "Thu, 21 Feb 2013 23:12:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 22 Feb 2013 10:32:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1M9WKEF012509
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362130343.00084@yshk7VNcP0H/DfXiAPRp3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216827>

David Aguilar <davvid@gmail.com> writes:

> Please enlighten me.
> Are we really getting rid of it and replacing it with ":/"?
> That syntax looks like a meh face.. just sayin'

The current behavior is indeed replaced by "git add -u .", not ":/".

> Unlike push.default, whose warning can be silenced with configuration,
> git 1.x does not have a way to silence this warning without retraining
> existing users.

Yes, but push.default is really different: there is a config variable,
and we want the behavior to be configurable. In the case of "git add",
I don't think adding a configuration option would be the right thing.
That would mean typing "git add -u" on an account which isn't yours will
be unpredictable *forever*.

OTOH, "git add -u :/" and "git add -u ." will behave predictibly on any
version of Git that accepts them, past present or future (:/ was added
in 1.7.6, a year and a half ago).

> Another example...
>
> $ git grep 'stuff' :/
>
> would it be too much to teach it to do:
>
> $ git grep -u 'stuff'

"git grep" is out of the scope of this change. Yes, it is inconsistant
with the rest of Git, but doesn't seem to surprise users as much as "git
add -u" (for which the inconsistancy appears within the "add" command).

I don't understand what you mean by "git grep -u". "git add -u" is a
shortcut for "git add --update", and "git grep --update" wouldn't make
sense to me. Do you mean we should add a "--full-tree" to "git grep"?
That seems really overkill to me since we already have the :/ pathspec.

> but in 2.0 that -u would be a no-op because "grep" will be full tree, no?

No it won't.

> I need to read the old discussions.
> Can someone tell me the magic google search syntax they use to dig them up?

See the discussion here:

http://thread.gmane.org/gmane.comp.version-control.git/213988/focus=214106

(recursively, there's a pointer to an older discussion)

> Would a better way be a method to make "git add -u" behave like 2.0 today?

As I said, I think adding a configuration option that would remain after
2.0 would do more harm than good. But after thinking about it, I'm not
against an option like a boolean add.use2dot0Behavior that would:

* Right now, adopt the future behavior and kill the warning

* From 2.0, kill the warning without changing the bevavior

* When we stop warning, disapear.

This, or the add.silence-pathless-warnings (which BTW should be spelled
add.silencePathlessWarnings) would not harm as long as they are not
advertized in the warning. What we don't want is dumb users reading half
the message and apply the quickest receipe they find to kill the warning
without thinking about the consequences.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
