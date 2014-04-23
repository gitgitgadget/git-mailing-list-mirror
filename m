From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 13:48:05 -0700
Message-ID: <xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
References: <20140416141519.GA9684@camelia.ucw.cz>
	<20140416154653.GB4691@sigill.intra.peff.net>
	<alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
	<20140417213238.GA14792@sigill.intra.peff.net>
	<alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
	<20140417215817.GA822@sigill.intra.peff.net>
	<20140423075325.GA7268@camelia.ucw.cz>
	<xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
	<20140423191628.GA20596@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stepan Kasal <kasal@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:48:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd45Z-0007Qw-OC
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbaDWUsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:48:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456AbaDWUsK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:48:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 725997F0B5;
	Wed, 23 Apr 2014 16:48:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D9B03oGm6qpQnDVn7J7RVX02DgY=; b=KoU+yz
	0w6o5fkSVNbLToXmDsyYFMsmT01KaCrtWm3gd1tZrb0QFQOst6QxRyyd0QQLJXPD
	zLF4TiOp5pSsjk8FOD/QnGC8n2CnOfMNvI0Gms5fGmW7yUqLsXx27SvE/M49fhtJ
	fs0Tc1vQzoAcAWGqIzxjV8Q2C5dgrHapRhd7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZQD3FNhm/ouCGFt+nlYok4Cz7gu0s1xp
	qRfCM45wOyhsniPzurCk5jmHL9Lzl9IlAi54SI4FPFApkC1nhgBPJITL9N8Z5Z95
	bj3TujFeOy0I7EAzwQ6p7BNNQO21J6L4OCCzOPfwjh+a9kuI5e7SoBj8Vc3WAvo5
	XpF7GBpOxXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 577397F0B4;
	Wed, 23 Apr 2014 16:48:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65A367F0B3;
	Wed, 23 Apr 2014 16:48:07 -0400 (EDT)
In-Reply-To: <20140423191628.GA20596@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 23 Apr 2014 15:16:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 92E67380-CB28-11E3-8DAA-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246892>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 23, 2014 at 12:12:14PM -0700, Junio C Hamano wrote:
>
>> > +ulimit_stack="ulimit -s 64"
>> > +test_lazy_prereq ULIMIT 'bash -c "'"$ulimit_stack"'"'
>> 
>> With this implementaion, ULIMIT implies bash, and we use bash that
>> appears on user's PATH that may not be the one the user chose to run
>> git with.  Can't we fix both of them by using $SHELL_PATH?
>
> I don't think so. The point is that we _must_ use bash here, not any
> POSIX shell.

Sorry, but I do not understand.  Isn't what you want "any POSIX
shell with 'ulimit -s 64' supported"?

    $ dash -c 'ulimit -s && ulimit -s 64 && ulimit -s'
    8192
    64

> We want to run "some bash" if we can. We may pick a bash on the user's
> PATH that is not what they put into $SHELL_PATH, but that should be
> relatively rare. And the consequence is that either that bash works fine
> and we run the test, or it does not, and we skip the test.
>
>> How about doing it along this line instead?
>> 
>> 	run_with_limited_stack () {
>> 		"$SHELL_PATH" -c "ulimit -s 64 && $*"
>> 	}
>> 
>> 	test_lazy_prereq ULIMIT "run_with_limited_stack true"
>
> That's a much more direct test. I like it (aside from the $SHELL_PATH
> thing as described above).

Still puzzled.
