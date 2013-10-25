From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] merge-base: "--reflog" mode finds fork point from
 reflog entries
Date: Fri, 25 Oct 2013 09:09:24 +0100
Message-ID: <20131025080923.GG10779@serenity.lan>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
 <1382641884-14756-1-git-send-email-gitster@pobox.com>
 <1382641884-14756-3-git-send-email-gitster@pobox.com>
 <CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
 <xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
 <CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
 <xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
 <xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
 <526A19CA.9020609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 10:09:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZcSl-0001Nb-91
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 10:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3JYIJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 04:09:38 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:57599 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3JYIJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 04:09:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 635926064FD;
	Fri, 25 Oct 2013 09:09:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fI1W1XC2kY47; Fri, 25 Oct 2013 09:09:34 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 57C406064D7;
	Fri, 25 Oct 2013 09:09:25 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <526A19CA.9020609@viscovery.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236695>

On Fri, Oct 25, 2013 at 09:12:10AM +0200, Johannes Sixt wrote:
> Am 10/25/2013 0:21, schrieb Junio C Hamano:
> > +test_expect_success 'using reflog to find the fork point' '
> > +	git reset --hard &&
> > +	git checkout -b base $E &&
> > +
> > +	for count in 1 2 3 4 5
> > +	do
> > +		git commit --allow-empty -m "Base commit #$count" &&
> > +		git rev-parse HEAD >expect$count &&
> > +		git checkout -B derived &&
> > +		git commit --allow-empty -m "Derived #$count" &&
> > +		git rev-parse HEAD >derived$count &&
> > +		git checkout base || break
> > +	done &&
> > +
> > +	for count in 1 2 3 4 5
> > +	do
> > +		git merge-base --reflog base $(cat derived$count) >actual &&
> > +		test_cmp expect$count actual || break
> > +	done &&
> 
> This does not work as intended because the exit code of 'break' is always
> zero. Unlike 'exit' and 'return', it does *not* pick up the exit code of
> the last command that was executed.
> 
> That's annoying, but makes some sense because 'break 2' does not mean to
> apply exit code 2 to the command, either, but to break out of 2 levels of
> loops.
> 
> You could put the loops into a function from which you 'return', but that
> is obscure in this case. The first iteration was better, IMO.

Wouldn't it be simpler to just return from the test?  That is, replace
the "break" in the above patch with "return 1".

There's code in several other test cases (e.g. t3311) which handles the
same problem like that.
