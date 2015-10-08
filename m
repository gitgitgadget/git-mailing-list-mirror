From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 01/10] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Thu, 08 Oct 2015 20:48:41 +0200
Message-ID: <vpqvbahmc1i.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGFN-0007aB-CU
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 20:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbbJHSss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 14:48:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48551 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080AbbJHSss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 14:48:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t98ImduF009128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 20:48:39 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98ImfWq009520;
	Thu, 8 Oct 2015 20:48:41 +0200
In-Reply-To: <1444295885-1657-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 8 Oct 2015 14:47:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Oct 2015 20:48:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98ImduF009128
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444934921.69764@zVir7vRGTxaWcd8TGK+eCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279258>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void if_then_else_handler(struct ref_formatting_stack **stack)
> +{
> +	struct ref_formatting_stack *cur = *stack;
> +	struct ref_formatting_stack *prev = cur->prev;
> +	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
> +

You should add

	if (!if_then_else->then_atom)
		die(_("format: %%(if) atom used without a %%(then) atom"));

here ...

> +static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +	struct ref_formatting_stack *cur = state->stack;
> +	struct if_then_else *if_then_else = NULL;
> +
> +	if (cur->at_end == if_then_else_handler)
> +		if_then_else = (struct if_then_else *)cur->at_end_data;
> +	if (!if_then_else)
> +		die(_("format: %%(then) atom used without an %%(if) atom"));
> +	if (if_then_else->then_atom)
> +		die(_("format: %%(then) atom used more than once"));
> +	if_then_else->then_atom = 1;

... and

	if (if_then_else->else_atom)
		die(_("format: %%(then) atom used after %%(else)"));

here, just in case (adding the two corresponding test_must_fail wouldn't
harm of course).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
