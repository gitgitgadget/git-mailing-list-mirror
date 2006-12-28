From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] gitweb: Separate HTTP header output
Date: Wed, 27 Dec 2006 17:23:58 -0800
Message-ID: <7v7iwc4xu9.fsf@assigned-by-dhcp.cox.net>
References: <200612272355.31923.jnareb@gmail.com>
	<200612272357.56532.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:24:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzk0B-0001N1-22
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWL1BYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWL1BYA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:24:00 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41254 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964840AbWL1BX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:23:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228012359.ZKXL29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 20:23:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 41QC1W00l1kojtg0000000; Wed, 27 Dec 2006 20:24:13 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200612272357.56532.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 27 Dec 2006 23:57:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35498>

Jakub Narebski <jnareb@gmail.com> writes:

> Always return just after HTTP header is sent when asking only about
> headers (HTTP request method 'HEAD'); first appeared in git_rss.
>
> While at it uniquify style of http_header(...) calls, formerly
> "print $cgi->header(...)", and remove default HTTP status, '200 OK'.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This one is fairly generic, and if considered worthy, I think
> can be accepted without much ado.

Maybe I am missing something fundamental, but I cannot see how
this affects anything whatsoever...

> +## functions printing HTTP or HTML: header, footer, error page
> +
> +sub http_header {
> +	my @header = @_;
> +
> +	print $cgi->header(@header);
> +
> +	# Optimization: skip generating the body if client asks only
> +	# for HTTP header (e.g. cache validation).
> +	return if ($cgi->request_method() eq 'HEAD');
> +}

Ok, so this explicitly written "return" returns when it is a
HEAD request not GET.  Otherwise the control falls out of the
end of the function.  Either way you return undef.

Then the caller does...

> @@ -1709,8 +1719,11 @@ sub git_header_html {
>  	} else {
>  		$content_type = 'text/html';
>  	}
> -	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
> -	                   -status=> $status, -expires => $expires);
> +	http_header(
> +		-type => $content_type,
> +		-charset => 'utf-8',
> +		-status => $status,
> +		-expires => $expires);
>  	print <<EOF;
>  <?xml version="1.0" encoding="utf-8"?>
>  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

which means it does not omit generating the body anyway no
matter what "sub http_header" did...

Or is there some Perl magic that makes a return from sub named
*_header magically terminate the execution of the caller?

Puzzled...
