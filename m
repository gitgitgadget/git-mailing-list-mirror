From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sun, 20 Mar 2016 14:24:40 +0100
Message-ID: <vpq4mc1e0yv.fsf@anie.imag.fr>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 14:28:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahdP3-0006dS-8z
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 14:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbcCTN2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 09:28:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43098 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451AbcCTN2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 09:28:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2KDOeRR026208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Mar 2016 14:24:40 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2KDOeYw012288;
	Sun, 20 Mar 2016 14:24:40 +0100
In-Reply-To: <CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
	(Pranit Bauva's message of "Sun, 20 Mar 2016 17:05:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 20 Mar 2016 14:24:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2KDOeRR026208
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459085082.95992@7r9Jl/7y/o3AH7f9qO0A5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289352>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> The project Idea: Incremental Rewrite from shell to C of git-bisect.sh
>
> The plan:
>
>  - Place bisect.c in builtin/
>  - Implement a skeletal cmd_bisect() which will redirect to
> git-bisect.sh (1e1ea69f)
>  - Introduce a structure for parsing the command line flags.
>  - Start converting individual functions and place it in bisect.c

The most important question is missing from this: how do you ensure that
you periodically fall back to a consistant state (i.e. a state where
your code is used and the whole testsuite passes)?

Without this, the timeline may look like:

- day 1: the 3 first steps above
- 2 months: convert individual functions
- last day: submit the whole thing

And you absolutely want to avoid this. You need to get reviewable and
mergeable code ASAP.

As I wrote earlier, I'm not convinced that your plan is the best
approach. Converting shell functions to the bisect helper is IMHO a
better first step, and having a builtin cmd_bisect can come later.

> a list of commits and then store the standard output in an array as
> bash can directly do the conversion, but it would not be a good thing
> to do in C.

Small confusion here: there's no bash involved, just a POSIX /bin/sh
(which may, or may not point to bash), and POSIX /bin/sh has no notion
of array.

> The goal would be to produce quality code that can be included in the
> next maintenance release 2.7.5.

I don't think this is a candidate for a maintenance release. Maintenance
release include fixes for which we're confident enough that no
regression or unexpected behavior change will happen. Complete rewrite
is the opposite of that.

> Also I am quite unsure how
> the patches would be maintained by Junio. Would he create a separate
> branch for me in his personal repo and then add the patches to it
> without merging it to pu and then when it is completely done, the
> merge will take place? Or he will individually first place every patch
> in pu and the normal process?

Junio usually does not maintain branches that are not merged in pu.
"merged in pu" does not mean "accepted", just "worth paying attention".
But this implies "does not introduce obvious regression" (cf. above).

Each series is applied in its own branch, and then this branch is merged
into pu.

We consider GSoC students as normal contributors when it comes to
submitting code (that's one of the reason why Junio is not a mentor).

> Should I also include "How git bisect works internally?" in the
> proposal along with this?

You should include any convincing argument to support the claim that you
are able to comptlete the project. I think this includes re-explaining
in your own words how you understand bisect in its current form.

> And most importantly, Would anyone like to mentor me for this project?

Christian is a potential mentor and he knows bisect very well. I can't
speak for him, but he'd probably be a good mentor for such project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
