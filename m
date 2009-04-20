From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 02/12] send-email: No longer repeatedly test if
 $smtp_server is a command
Date: Sun, 19 Apr 2009 18:41:30 -0700
Message-ID: <7veivop0dx.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 03:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LviXY-0000TB-Ht
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 03:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbZDTBlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 21:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbZDTBlg
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 21:41:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZDTBlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 21:41:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1854BACE08;
	Sun, 19 Apr 2009 21:41:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03BDAACE07; Sun,
 19 Apr 2009 21:41:31 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61E38356-2D4C-11DE-8DE4-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116921>

Michael Witten <mfwitten@gmail.com> writes:

> This is a minor change, but it's cleaner, and it sets up the
> $smtp_server initialization code for future improvements.
> ...
> -if (!defined $smtp_server) {
> +if (defined $smtp_server) {
> +
> +	$smtp_server_is_a_command = ($smtp_server =~ m{^/});
> +
> +} else { # use a default:
> +
>  	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
>  		if (-x $_) {
>  			$smtp_server = $_;
> +			$smtp_server_is_a_command = 1;
>  			last;
>  		}
>  	}
> -	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
> +
> +	$smtp_server = 'localhost'; # 127.0.0.1 is not compatible with IPv6
> +		unless $smtp_server_is_a_command;

Nobody suggests to use 127.0.0.1 anymore with this change, so why not just
get rid of that comment?

Also the new statement looks wrong.

 (1) you have ';' after assignment before the statement modifier "unless";
     I do not think you meant it.  I generally *dis*like statement
     modifiers, but if you use it, at least please use it correctly.

 (2) earlier, when $smtp_server is defined (say, the name of your smtp
     host) but is not a command, we did not set smtp_server to
     'localhost', but kept the value given by the user.  Now you seem to
     kill the user's wish with this change.

I think a genuine improvement would be something like:

	if (!defined $smtp_server) {
        	$smtp_server = 'localhost';
	}

Of course if you are writing for a project that is "5.8.1 or later only",
you could say:

	$smtp_server //= 'localhost';
