From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 06/12] send-email: Cleanup and streamline the SMTP
 code in send_message
Date: Sun, 19 Apr 2009 18:42:43 -0700
Message-ID: <7vskk4nlrg.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 03:44:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LviZ7-0000nb-Cj
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 03:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZDTBmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 21:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbZDTBmt
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 21:42:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbZDTBmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 21:42:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E5D0ACE17;
	Sun, 19 Apr 2009 21:42:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 11498ACE16; Sun,
 19 Apr 2009 21:42:44 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D742750-2D4C-11DE-A46A-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116924>

Michael Witten <mfwitten@gmail.com> writes:

> +				die "Server does not support STARTTLS: " . $smtp->message . "\n"
> +					unless $smtp->code == 220;

Statement modifiers merely make things even less readable, especially when
the conditional is the unlikely case.  Please do not add more of them.

	do this;
	do that;
	do something
        	if some condition that holds true most of the time;
	do some other thing;

is already hard to follow, but it is probably excusable in some cases,
because your thought can flow "ah, Ok, these four things are done in
sequence" when you are quickly scanning the code to understand the overall
structure, letting your eyes ignore the "true most of the time" part.

But the following, which is equivalent to what you did, is inexcuable.

	do this;
	do that;
	do something unusual
        	if some condition that rarely holds true;
	do some other thing;

When your eyes and brain are coasting over this segment of code, your
thought process needs to stumble and hiccup at the statment that does
something unusual, and then need to realize that it is qualified with a
statement modifier that says "this is only for rare case".

Written without statement modifier:

	do this;
	do that;
	if (some consition that rarely holds true) {
		do something unusual
        }
	do some other thing;

it is much easier to coast over; you can tell "Ah, after doing this and
that, in the normal case we do some other thing" and do not have to even
look at the details of "something unusual" part.

> -		$smtp->mail( $raw_from ) or die $smtp->message;
> -		$smtp->to( @recipients ) or die $smtp->message;
> -		$smtp->data or die $smtp->message;
> -		$smtp->datasend("$header\n$message") or die $smtp->message;
> -		$smtp->dataend() or die $smtp->message;
> -		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
> +		SEND_MAIL:
> +
> +		$smtp->mail($raw_from)               and
> +		$smtp->to(@recipients)               and
> +		$smtp->data                          and
> +		$smtp->datasend("$header\n$message") and
> +		$smtp->dataend                       or
> +
> +		die "Failed to send '$subject': " . $smtp->message . "\n";

These do make things more pleasant to read.
