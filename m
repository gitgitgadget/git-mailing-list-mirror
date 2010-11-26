From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 07/18] revert: put option information in an option
 struct
Date: Fri, 26 Nov 2010 10:42:53 -0800
Message-ID: <7vzksworiq.fsf@alter.siamese.dyndns.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
 <20101125212050.5188.8316.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 26 19:43:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM3GS-0007x5-C6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab0KZSnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 13:43:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760Ab0KZSnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:43:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B28D5219C;
	Fri, 26 Nov 2010 13:43:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BaY+Bw0bCCSefYV+AcA1covG17Y=; b=qVE68OlNYmxJyy7bQNkLH4f
	ip5x8dU7rzysdVrqVKFghMP/PDdpASaGug3S/EMU5+2V14aqb0o5j3lKW7Dcvv3U
	lfYdJztzsmDxaoFxTkCUjvg7LUQlabuGAMxXXbM43X7odagyX+A+PVQSbMMej5+a
	FOXmcCxQZD/wHHRtqiF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Tx5mPdUr0zO+oBrh3ZbJEu2W1mBrAxNOnALQK2/sUWoIdO31J
	jrvG1AQmbW2pPppotoabAZL4pHj3sLY8o8jP39hZ6PXtYJAQ2Xxy3yBgAodIx8yO
	n5HpzfbNa4L4c4IHn/t0Eo3xfvNYSl/IhqQxEuP/0fkGX1LNqBhNvrsEdQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3484B2196;
	Fri, 26 Nov 2010 13:43:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9349E2195; Fri, 26 Nov 2010
 13:43:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AD26C30-F98D-11DF-9179-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162274>

Christian Couder <chriscool@tuxfamily.org> writes:

> This is needed because we want to reuse the parse_args() function
> so that we can parse options saved in a TODO file.

This probably is not _needed_ but something you thought would be a
good thing to do while at it.

You forgot to mention something more important, though.  You added two
extra arguments to revert_or_cherry_pick, neither of which I agree with.

 * it is a regression to call the first extra argument "int revert";
   (action == REVERT) was more readable.

 * "int edit" is ill thought out; it is about giving the default of "edit"
   to revert_or_cherry_pick() depending on what action it is going to
   take.  In this particular case, the logic for the default of "edit" is
   trivial and localized (it is 0 unless we are interactive revert), so I
   would drop the argument and have default logic immediately after
   "memset(&info, 0, sizeof(info))".

   If there were many such args-info elements whose default have to be
   different depending on the action, the caller should be passing an
   instance of "struct args_info" with the default, and have the parser
   to update the default supplied.  I don't think it is warranted in this
   case.

By the way, "infos" is an eyesore at least to me.  Any data you work on is
information, naming a variable "struct args_info info", unless it
primarily works on that "args_info" and not any other kinds of info (like
"struct rev_info revs"), is like calling a variable "var", adding _no_
useful information.
