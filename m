From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Tue, 06 Oct 2015 21:03:49 +0200
Message-ID: <vpqmvvvhl9m.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-9-git-send-email-Karthik.188@gmail.com>
	<vpqvbao86pj.fsf@grenoble-inp.fr>
	<CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com>
	<vpq7fn1qhp2.fsf@grenoble-inp.fr>
	<CAOLa=ZS5x=ksfnBt1kLp5bJJHmqeBztR7Zn7U5VKZN-56T-_5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 21:04:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjXX3-0004lg-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 21:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbbJFTED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 15:04:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41691 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbbJFTEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 15:04:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t96J3kvm030367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 6 Oct 2015 21:03:47 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t96J3nSJ029936;
	Tue, 6 Oct 2015 21:03:49 +0200
In-Reply-To: <CAOLa=ZS5x=ksfnBt1kLp5bJJHmqeBztR7Zn7U5VKZN-56T-_5A@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 6 Oct 2015 21:00:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Oct 2015 21:03:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t96J3kvm030367
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444763028.80257@SRDDAs3vJBF7qm1dEHL9Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279159>

Karthik Nayak <karthik.188@gmail.com> writes:

> If you look closely, thats only for the local branches, the remotes
> have `align` atom when
> printing in verbose.

Yes, but that's already one thing factored out of the if, even if it's
just for local.

Actually, I think you can also factor some parts out of the
%(if:notequals=remotes). In 'local', you have an %(if) to display either
"* " or "  ", and in remote you always start with "  ". Why not always
apply the %(if), and let it display "  " if not displaying the current
branch? Similarly, the "verbose" part of remote branches seems like a
particular case of the one for local ones (remotes don't have tracking
branches, so the tracking info should expand to the empty string).

To go a bit further, you can pre-build a string or strbuf aligned_short
with value like "%%(align:20,left)%%(refname:short)%%(end)" and use it
where needed (it's not a constant because you have to introduce maxwidth
into the string, so it's not a candidate for #define).

> I could cook up this:

Your mailer broke the formatting, so it looks terrible, but from what I
could parse, it's already much better than the previous one. It's not a
matter of size of the function, I very much prefer reading 10 lines of
nice code than 4 lines like

> +                        local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
> +                                        " %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
> +                                        "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
> +                                        branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
> +                                        branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));

;-).

One obvious issue with the initial version was this big hard-to-parse
block, but another one is that the code did not make it easy to
understand what was changing depending on which branch of the if, and
depending on local/remote. It's getting much easier already.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
