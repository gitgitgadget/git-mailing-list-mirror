From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set API
Date: Fri, 01 Aug 2014 10:33:42 +0200
Message-ID: <vpqfvhg4nix.fsf@anie.imag.fr>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>
	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com>
	<vpqr411bhd5.fsf@anie.imag.fr> <53DA7C23.3090603@gmail.com>
	<vpqa97p8koq.fsf@anie.imag.fr> <53DA8A54.6060208@gmail.com>
	<vpqoaw55q16.fsf@anie.imag.fr>
	<xmqqtx5xw7n7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 10:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XD8Ik-0007Hp-GN
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 10:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbaHAIex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 04:34:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52651 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697AbaHAIeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 04:34:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s718Xgkl026695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2014 10:33:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s718XhNI009243;
	Fri, 1 Aug 2014 10:33:43 +0200
In-Reply-To: <xmqqtx5xw7n7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 31 Jul 2014 14:17:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 01 Aug 2014 10:33:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s718Xgkl026695
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407486823.20397@nCvAzkqYbgOtXr6Z9WapPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254623>

Junio C Hamano <gitster@pobox.com> writes:

> Hmm, I am still confused ;-)
>
> Can there be more than one 'i' whose value->items[i].string is the
> same as the given value?  IOW, if you have "[user] name<EOL>" in
> both .git/config and ~/.gitconfig, don't we want to make sure that
> we complain on the one in .git/config, which would have taken
> precedence if it were spelled correctly?

For single-valued variables, yes. And for them, git_die_config(), as
currently implemented does the right thing. My proposed change does not
modify the behavior, it just extracts error messages and an if/then/else
into a helper that can be used elsewhere.

For multi-valued variables, it's different. If you have a boggus value,
further values will not override it. It will remain bogus.

The code consuming such multi-valued variable has to iterate over the
string_list, and raise an error on bogus values. Ideally, it could show
all the errors, but it's also reasonable to die() at the first one. The
simplest behavior to implement is to die() at the first error.

(currently, git _segfaults_ at the first NULL value for
notes.displayref, so it can't be much worse)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
