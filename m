Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBCB2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbcF1Umg (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 16:42:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56052 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbcF1Umf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 16:42:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5SKgEH3014869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 22:42:15 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SKgHlq028419;
	Tue, 28 Jun 2016 22:42:17 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Hahler <git@thequod.de>
Subject: Re: [PATCH] rebase -i: restore autostash on abort
References: <20160628175704.26095-1-ps@pks.im>
	<xmqqa8i587cx.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 28 Jun 2016 22:42:17 +0200
In-Reply-To: <xmqqa8i587cx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jun 2016 12:02:22 -0700")
Message-ID: <vpqvb0tqc46.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 28 Jun 2016 22:42:15 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SKgEH3014869
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467751339.65964@DqJ+0wyHafDat3KDUtnWmw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> +test_expect_success 'restore autostash on editor failure' '
>> +	test_when_finished "git reset --hard" &&
>> +	echo uncommited-content >file0 &&
>> +	(
>> +		test_set_editor "false" &&
>> +		test_must_fail git rebase -i --autostash HEAD^
>> +	) &&
>> +	echo uncommited-content >expected &&
>
> While making sure this case works is crucial, it is not an
> interesting failure mode, is it? Can we also have "does not apply
> cleanly anymore" case, too?

It is "interesting" if you mean "matches real-life use-case", as it
corresponds to the case where the user killed the editor (as reported by
Daniel Hahler indeed, "Abort with ":cq", which will make Vim exit
non-zero").

If you mean "likely to trigger nasty bugs", then indeed testing the case
when apply_autostash fails is interesting: for example, calling
die_abort when "stash apply" fails is tempting, but would lead to
infinite recursion (it doesn't seem to be the case, but a test would be
nice). Setting the editor to something that modifies uncommited-content
before 'false' should do the trick.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
