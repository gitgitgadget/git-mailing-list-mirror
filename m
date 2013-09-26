From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Thu, 26 Sep 2013 11:03:24 +0200
Message-ID: <vpqa9j0kl9f.fsf@anie.imag.fr>
References: <1380137471-26972-1-git-send-email-Matthieu.Moy@imag.fr>
	<20130925223334.GB9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jc@sahnwaldt.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 11:05:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP7Va-000280-TX
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 11:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab3IZJFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 05:05:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50652 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755551Ab3IZJFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 05:05:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8Q93OYW031591
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 11:03:24 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VP7Tp-0001uL-8Q; Thu, 26 Sep 2013 11:03:25 +0200
In-Reply-To: <20130925223334.GB9464@google.com> (Jonathan Nieder's message of
	"Wed, 25 Sep 2013 15:33:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Sep 2013 11:03:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8Q93OYW031591
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380791010.09829@s76N+x1QegqMmP9BXNECwg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235407>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 	case 3: git checkout <something> [--]
>
> 	  If <something> is a commit, [...]
>
> 	  If <something> is _not_ a commit, either "--" is present or
> 	  <something> is not a path, no -t nor -b was given, and [...]
>
> 	  Otherwise, if "--" is present, treat it like case (1).
>
> 	  Otherwise behave like case (4).

Actually, no. Below, we have

		/*
		 * Do not complain the most common case
		 *	git checkout branch
		 * even if there happen to be a file called 'branch';
		 * it would be extremely annoying.
		 */

Which is a subcase of (3). The guess done in (3) is permissive, and the
one done with more arguments (4) is strict.

> 	case 4: git checkout <something> <paths>
>
> 	  The first argument must not be ambiguous.

I wasn't very convinced by your version at first, but I gave it a try.
I'm not sure the comment is actually better now, but I think it exposes
the complexity of the guess, and the difficulty to map the code and the
comment more. Other people should take this as an incentive to improve
the situation (but I'm really getting short of Git time budget, sorry).

> Then can come the "invalid reference" check for case (1):
>
> 		} else if (has_dash_dash)	/* case (1) */
> 			die(...);
>
> Then case (4).
>
> 		else	/* case (4) */
> 			return argcount;

Actually, the comments are wrong here. The comment <-> code mapping is
more complex than this. At this point of the code, you know that the
first argument is not a commit, and that dwim has been ruled-out. But
that may be case 3 also:

git checkout --no-guess <non-branch> [--]

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
