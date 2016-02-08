From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 08 Feb 2016 12:12:27 -0800
Message-ID: <xmqqd1s77yhg.fsf@gitster.mtv.corp.google.com>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
	<20160208135013.GA27054@sigill.intra.peff.net>
	<CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
	<20160208163700.GA22929@sigill.intra.peff.net>
	<alpine.DEB.2.20.1602082027550.2964@virtualbox>
	<20160208193509.GA30554@sigill.intra.peff.net>
	<alpine.DEB.2.20.1602082056410.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:12:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSsAk-0005j6-IR
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 21:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbcBHUMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 15:12:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751435AbcBHUM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 15:12:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5FCC41EB0;
	Mon,  8 Feb 2016 15:12:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N2UzQylGRuGisvWlatMWyFxVP24=; b=VvMzBO
	fHeyOB0Egshg0RYkQZrAUyM+QACacGygnh6cPeLz0wNg7IZ93cgyTAkq4otf7vp4
	lZFfJMoAu0lGcID7JdgzBfGQUCtvkUpAC9c1tqDcC9URAmXVG6OhEjeGGrjH+vBM
	TtC/PH9ZWIcfpE0SDOD2VWNksT0iMbeGLf8fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+r5AzzbNW5RKYUVzFPSi2lLIN928OnM
	hAy1/BT/bw/uqVYa5MdWgSeGGXBixNFe/cWN87JcjVqyLXxZ07WwkvwBxqdwKuiI
	xSRuzJMRcOm4VKvAd13+n2QBBmRaM2xvu3sOVNecz2/khOR2QXj+KLBmVqqm7JD6
	hwAJ5kMgATk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ABFDB41EAE;
	Mon,  8 Feb 2016 15:12:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C26241EAC;
	Mon,  8 Feb 2016 15:12:28 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1602082056410.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 8 Feb 2016 20:59:31 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46C31A62-CEA0-11E5-B206-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285799>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> write_script is a semantically unambiguous way to specify what we *want*.
> And it would allow us to handle chmod specifically for Windows *in one
> place only*.

Correct.  write_script, for the intended target of the helper, is a
way to write a script that can later be invoked by the test with the
name "$1".  It is conceivable for write_script on UNIX to be writing
into "$1" while Windows version to be writing into "$1.bat" and the
script, i.e. the user of the write_script helper, to do this

	write_script foo <<EOF &&
        ...
        EOF
	...
        foo

which may result in foo.bat running on Windows without us having to
adjust the test script.  So it indeed is a very nice abstraction to
have.

But the way the test uses this exec.sh script is not consistent with
that.  exec.sh for this test is merely a data, whose content must
exactly match what later tests expect, i.e. it wants it to begin
with "#!/bin/sh" and its execute bit on, even though the test does
not have no intention to run it as a script.

So I think it was doubly wrong for me to suggest write_script
without realizing that this is _not_ writing a script in the usual
sense for us to write with write_script.



        	
