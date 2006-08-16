From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb / cg-export
Date: Wed, 16 Aug 2006 11:01:49 -0700
Message-ID: <7v4pwc4l0y.fsf@assigned-by-dhcp.cox.net>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org>
	<44E2F911.6060002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 20:02:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDPiG-0004EA-Fm
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 20:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWHPSBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWHPSBw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 14:01:52 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40073 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751233AbWHPSBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 14:01:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060816180150.WMGI12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 14:01:50 -0400
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
In-Reply-To: <44E2F911.6060002@gmail.com> (Aneesh Kumar K. V.'s message of
	"Wed, 16 Aug 2006 16:23:05 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25521>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> How about the below on top of latest git
>
> -aneesh

This looks Ok (except "$project" needs to be shell quoted on the
pipe-open line and possibly in the URL; there may be some other
minor details I missed).  It needs to be protected by elective,
opt-in configuration variable, similarly to how "blame" is done,
since I suspect this would be rather expensive.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 37a6284..b9b522a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -175,6 +175,7 @@ my %actions = (
>  	"tag" => \&git_tag,
>  	"tags" => \&git_tags,
>  	"tree" => \&git_tree,
> +	"snapshot" => \&git_snapshot,
>  );
>  
>  $action = 'summary' if (!defined($action));
> @@ -1334,6 +1335,7 @@ sub git_shortlog_body {
>  		      "<td class=\"link\">" .
>  		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
>  		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
> +		      " | " .$cgi->a({-href => "$my_uri/$project.tar.gz?" . esc_param("p=$project;a=snapshot;h=$commit")}, "snapshot") .
>  		      "</td>\n" .
>  		      "</tr>\n";
>  	}
> @@ -2097,6 +2099,21 @@ sub git_tree {
>  	git_footer_html();
>  }
>  
> +sub git_snapshot {
> +	if (!defined $hash) {
> +		$hash = git_get_head_hash($project);
> +	}
> +	print $cgi->header(-type=>'application/x-tar',
> +			  -Content-Encoding=>'x-gzip', -status=> '200 OK');
> +	open my $fd, "-|", "$GIT tar-tree $hash $project | gzip -c9" or die_error(undef, "Execute git-tar-tree failed.");
> +	binmode STDOUT, ':raw';
> +	print <$fd>;
> +	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +	close $fd;
> +
> +
> +}
> +
>  sub git_log {
>  	my $head = git_get_head_hash($project);
>  	if (!defined $hash) {
