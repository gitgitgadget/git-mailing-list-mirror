From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 14:20:00 -0700
Message-ID: <7vwso74p33.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <alpine.LSU.1.00.0803121833210.1656@racer.site>
 <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil>
 <alpine.LSU.1.00.0803122058430.1656@racer.site>
 <47D83C53.7000602@nrlssc.navy.mil>
 <7vejaf65q0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122153440.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYNp-0002DQ-50
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYCLVUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbYCLVUK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:20:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbYCLVUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:20:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 432E819A9;
	Wed, 12 Mar 2008 17:20:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 50F0419A4; Wed, 12 Mar 2008 17:20:02 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803122153440.1656@racer.site> (Johannes
 Schindelin's message of "Wed, 12 Mar 2008 21:55:47 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76989>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ---prune::

I am fairly paranoid about end users wondering about what is described in
ancient documentation and complaining that we do not talk about it
anymore.  I am tempted to suggest:

	This is a no-op but you may see it mentioned in older docs and
	scripts.  Older git-gc never ran 'prune' without being told, and
	this option was a way to tell it to.

but this would lead to littering the documentation with too much
historical information in the long run.  I dunno.  I am inclined to favor
the removal as your patch did, but somebody else may have clever ideas.

> +	if (!strcmp(var, "gc.pruneexpire")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		if (strcmp(value, "now") &&
> +				approxidate(value) - approxidate("now") >= 0)
> +			return error("Invalid gc.pruneExpire: '%s'", value);

Yuck; approxidate() returns ulong.  Can subtracting a ulong from another
ever go negative?

Besides, because there is no guarantee of the order of evaluation between
these two approxidate() calls, you may get +1 or -1 on the second boundary.

I think the reason why you did not catch it in your test is because your
tests are half complete; they test only what you wanted to catch
(misconfigured case) and do not test the other half (properly working
case).
