From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] gitweb: Split validate_input into validate_pathname and validate_refname
Date: Mon, 25 Sep 2006 21:11:30 -0700
Message-ID: <7v1wpzw9l9.fsf@assigned-by-dhcp.cox.net>
References: <200609260153.08503.jnareb@gmail.com>
	<200609260157.03035.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 06:12:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4IQ-000673-Se
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWIZELf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWIZELf
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:11:35 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30442 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750878AbWIZELb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:11:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926041130.ZIRD21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:11:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsBU1V0081kojtg0000000
	Tue, 26 Sep 2006 00:11:28 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27766>

Jakub Narebski <jnareb@gmail.com> writes:

> @@ -387,16 +400,37 @@ sub href(%) {
>  ## ======================================================================
>  ## validation, quoting/unquoting and escaping
>  
> -sub validate_input {
> -	my $input = shift;
> +sub validate_pathname {
> +	my $input = shift || return undef;
>  
> -	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
> -		return $input;
> +	# no '.' or '..' as elements of path, i.e. no '.' nor '..'
> +	# at the beginning, at the end, and between slashes.
> +	if ($input =~ m!(^|/)(|\.|\.\.)(/|$)!) {
> +		return undef;
>  	}
> -	if ($input =~ m/(^|\/)(|\.|\.\.)($|\/)/) {
> +	# no doubled slashes
> +	if ($input =~ m!//!) {
>  		return undef;
>  	}

I do not think you need the second check for double-slash.  The
pattern you borrowed from the original:

	/(^|\/)(|\.|\.\.)($|\/)/)

cleverly matches an empty string with $2, so you already match
double-slash with $1 = '/' $2 = '' $3 = '/', don't you?

> +	# it must be correct pathname
> +	$input = validate_pathname($input)
> +		or return undef;
> +	# restrictions on ref name according to git-check-ref-format
> +	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
>  		return undef;
>  	}

Why would you need validate_pathname here?
