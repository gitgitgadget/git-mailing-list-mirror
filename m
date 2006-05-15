From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Sun, 14 May 2006 22:52:12 -0700
Message-ID: <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 07:52:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfW0A-00022i-8P
	for gcvg-git@gmane.org; Mon, 15 May 2006 07:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWEOFwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 01:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWEOFwO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 01:52:14 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33162 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932241AbWEOFwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 01:52:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515055213.GUNA9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 01:52:13 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <1147660345772-git-send-email-normalperson@yhbt.net> (Eric Wong's
	message of "Sun, 14 May 2006 19:32:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20021>

Eric Wong <normalperson@yhbt.net> writes:

> This should make local mailing possible for machines without
> a connection to an SMTP server.

Which is a good thing, but

> It'll default to using /usr/sbin/sendmail or /usr/lib/sendmail
> if no SMTP server is specified (the default).  If it can't find
> either of those paths, it'll fall back to connecting to an SMTP
> server on localhost.

I do not know if it is OK to change the default to first prefer
local MDA executable and then "localhost".  That is, ...

> @@ -179,8 +180,14 @@ if (!defined $initial_reply_to && $promp
>  	$initial_reply_to =~ s/(^\s+|\s+$)//g;
>  }
>  
> -if (!defined $smtp_server) {
> -	$smtp_server = "localhost";
> +if (!$smtp_server) {
> +	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
> +		if (-x $_) {
> +			$smtp_server = $_;
> +			last;
> +		}
> +	}
> +	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
>  }
>  
>  if ($compose) {

Without this hunk, people who did not specify --smtp-server=host
could get away with having anything that listens to 25/tcp on
the localhost that is not either of the above two paths; now
they have to explicitly say --smtp-server=localhost to defeat
what this hunk does.  I do not know if it is a big deal, though.

> +	if ($smtp_server =~ m#^/#) {

I like this if(){}else{} here, but have a feeling that the
logging part should be placed outside it to be shared.

While we are at it, we might want to enhance $smtp_server parsing
to take host:port notation so that people can use message
submission port 587/tcp (RFC 4409) instead.
