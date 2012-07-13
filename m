From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Fri, 13 Jul 2012 16:23:59 +0200
Message-ID: <vpq1ukf68ow.fsf@bauges.imag.fr>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxxcc36v.fsf@alter.siamese.dyndns.org>
	<vpq1ukgai4e.fsf@bauges.imag.fr>
	<7vwr28agcq.fsf@alter.siamese.dyndns.org>
	<vpq1ukg82st.fsf@bauges.imag.fr>
	<20120713130021.GA2553@sigill.intra.peff.net>
	<vpqliin6bva.fsf@bauges.imag.fr> <87hatboiwr.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 13 16:24:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpgnF-0000H1-IX
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 16:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947Ab2GMOYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 10:24:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57926 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab2GMOYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 10:24:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6DEMYmI029430
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2012 16:22:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Spgmm-0003xx-IL; Fri, 13 Jul 2012 16:24:00 +0200
In-Reply-To: <87hatboiwr.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Fri, 13 Jul 2012 16:05:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 13 Jul 2012 16:22:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6DEMYmI029430
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342794158.76948@0Rv2dj0ENrJn3/ENNDK9+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201404>

Thomas Rast <trast@student.ethz.ch> writes:

> Umm, are you sure?  I may be somewhat confused about this, but the tests
> I used to trigger the access(NULL) were IIRC
>
>   unset HOME
>   git config --get foo.bar
>   git config --global --get foo.bar
>
> none of which is writing....

I was inaccurate, but that doesn't change the conclusion: the question
is not reading Vs writting, but use of --global Vs no use of it (and
most of the time, --global is used for writing, hence my confusion).

Both the patch that introduce the NULL bug and the one that fix it touch
two files: $git/config.c, and $git/builtin/config.c.

My changes to $git/config.c, are straightforward because they touch
positive tests for file existance. The controversial one is
$git/builtin/config.c, which is inside a "if (use_global_config)".

This piece of code was already dying on unset $HOME, and in my proposal
it still is.

The old code was:

        if (use_global_config) {
                char *home = getenv("HOME");
                if (home) {
                        char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
                        given_config_file = user_config;
                } else {
                        die("$HOME not set");
                }
        }

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
