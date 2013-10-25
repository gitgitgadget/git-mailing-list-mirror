From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] merge-base: "--reflog" mode finds fork point from
 reflog entries
Date: Fri, 25 Oct 2013 09:12:10 +0200
Message-ID: <526A19CA.9020609@viscovery.net>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>	<1382641884-14756-1-git-send-email-gitster@pobox.com>	<1382641884-14756-3-git-send-email-gitster@pobox.com>	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com> <xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:12:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbZI-0002un-Ld
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab3JYHMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 03:12:18 -0400
Received: from so.liwest.at ([212.33.55.16]:7330 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab3JYHMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 03:12:17 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VZbZ5-0004bB-Ro; Fri, 25 Oct 2013 09:12:11 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6539B16613;
	Fri, 25 Oct 2013 09:12:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236689>

Am 10/25/2013 0:21, schrieb Junio C Hamano:
> +test_expect_success 'using reflog to find the fork point' '
> +	git reset --hard &&
> +	git checkout -b base $E &&
> +
> +	for count in 1 2 3 4 5
> +	do
> +		git commit --allow-empty -m "Base commit #$count" &&
> +		git rev-parse HEAD >expect$count &&
> +		git checkout -B derived &&
> +		git commit --allow-empty -m "Derived #$count" &&
> +		git rev-parse HEAD >derived$count &&
> +		git checkout base || break
> +	done &&
> +
> +	for count in 1 2 3 4 5
> +	do
> +		git merge-base --reflog base $(cat derived$count) >actual &&
> +		test_cmp expect$count actual || break
> +	done &&

This does not work as intended because the exit code of 'break' is always
zero. Unlike 'exit' and 'return', it does *not* pick up the exit code of
the last command that was executed.

That's annoying, but makes some sense because 'break 2' does not mean to
apply exit code 2 to the command, either, but to break out of 2 levels of
loops.

You could put the loops into a function from which you 'return', but that
is obscure in this case. The first iteration was better, IMO.

> +
> +	# check defaulting to HEAD
> +	git merge-base --reflog base >actual &&
> +	test_cmp expect5 actual
> +'
> +
>  test_done

-- Hannes
