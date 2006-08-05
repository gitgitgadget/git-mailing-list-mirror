From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] gitweb: Cleanup input validation and error messages
Date: Fri, 04 Aug 2006 17:15:31 -0700
Message-ID: <7vu04sghr0.fsf@assigned-by-dhcp.cox.net>
References: <200608050036.06490.jnareb@gmail.com>
	<200608050038.20534.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 02:15:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G99pI-00041v-DS
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 02:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWHEAPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 20:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbWHEAPd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 20:15:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8951 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422664AbWHEAPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 20:15:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805001532.OQLB1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 20:15:32 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608050038.20534.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 5 Aug 2006 00:38:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24868>

Jakub Narebski <jnareb@gmail.com> writes:

>  our $action = $cgi->param('a');
>  if (defined $action) {
>  	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
> -		undef $action;
> -		die_error(undef, "Invalid action parameter.");
> +		die_error(undef, "Invalid action parameter $action");
>  	}

Doesn't this make us parrot what the browser threw at us without
escaping back for HTML (iow, die_error does not seem to escape
$error)?

>  our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
> -if (defined $project) {
> -	$project =~ s|^/||; $project =~ s|/$||;
> -	$project = validate_input($project);
> -	if (!defined($project)) {
> -		die_error(undef, "Invalid project parameter.");
> +$project =~ s|^/||; $project =~ s|/$||;

Unrelated change but it is probably safe.

> +if (defined $project || $project) {
> +	if (!validate_input($project)) {
> +		die_error(undef, "Invalid project parameter $project");
>  	}

Because undef is not true, "|| $project" here does not make much
sense to me.  Even if you meant to say "&&" to exclude empty
string or "0", wouldn't validate_input() take care of them?
Same input parrotting comment applies here and everywhere.

> -	$rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
> -	            "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";

The reason of removal is...?  Ah, you inlined it.  It was not
clear from the proposed commit log message.
