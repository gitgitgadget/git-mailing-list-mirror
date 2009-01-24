From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sat, 24 Jan 2009 10:36:24 -0800
Message-ID: <7vk58ko8k7.fsf@gitster.siamese.dyndns.org>
References: <20090117153846.GB27071@coredump.intra.peff.net>
 <200901220113.32711.markus.heidelberg@web.de>
 <7vmydi4kiz.fsf@gitster.siamese.dyndns.org>
 <200901241228.33690.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Jan 24 19:38:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQnOP-00024f-EN
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbZAXSgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbZAXSgf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:36:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414AbZAXSge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:36:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EAC893FC5;
	Sat, 24 Jan 2009 13:36:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9D5F193FC4; Sat,
 24 Jan 2009 13:36:26 -0500 (EST)
In-Reply-To: <200901241228.33690.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Sat, 24 Jan 2009 12:28:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EBF17BF6-EA45-11DD-A445-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106984>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> I looked at the code and found this in git_format_config():
>
> 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
> 		return 0;
>
> Which of course didn't handle color.ui, but that wasn't necessary before
> the central color.ui handling from my patch.

Centralized handling is never a goal in itself.  The goal should be to
make it easier for various codepaths to use color settings correctly,
without having to have many special case workarounds.  Centralized
handling, if designed right, could be a good way to achieve that goal.

> So with the following diff it works:
>
> -	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
> +	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")
> +				       || !strcmp(var, "color.ui")) {

Why should format-patch need to even worry about protecting itself from
"color.ui" to begin with?

If your patch is making color handling saner, I would expect that
format-patch can *lose* the existing "ignore diff.color or color.diff"
workaround as a result of that.  If you need to add even *more* workaround
code like that, there's something wrong, don't you think?

> format-patch is perhaps the only place where the commit has broken
> things, because I didn't find other places,...

You did not find the breakage in format-patch either to begin with; so
your not finding does not give us much confidence that there is no other
breakage, does it?

Grumble...
