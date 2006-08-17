From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: continue consolidation of URL generation.
Date: Wed, 16 Aug 2006 18:59:15 -0700
Message-ID: <7voduk15sc.fsf@assigned-by-dhcp.cox.net>
References: <11557673213372-git-send-email-tali@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 03:59:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDXAI-0005gd-H8
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 03:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWHQB7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 21:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWHQB7S
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 21:59:18 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65462 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932358AbWHQB7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 21:59:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817015916.BJOP554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 21:59:16 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <11557673213372-git-send-email-tali@admingilde.org> (Martin
	Waitz's message of "Thu, 17 Aug 2006 00:28:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25544>

Martin Waitz <tali@admingilde.org> writes:

> Further use href() instead of URL generation by string concatenation.
> Almost all functions are converted now.
>
> Signed-off-by: Martin Waitz <tali@admingilde.org>
> ---
>  gitweb/gitweb.perl |   68 +++++++++++++++++++++++++++-------------------------
>  1 files changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 37a6284..72e687e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -204,7 +204,9 @@ sub href(%) {
>  
>  	my $href = "$my_uri?";
>  	$href .= esc_param( join(";",
> -		map { "$mapping{$_}=$params{$_}" } keys %params
> +		map {
> +			"$mapping{$_}=$params{$_}" if $params{$_}
> +		} keys %params
>  	) );
>  
>  	return $href;

This is not about "further use href()".

I think "if $params{$_}" is unsafe here.  Can you guarantee that
we will never want to pass 0 or an empty string as an parameter
value both in the current and the future code?

I think it needs to be "if defined $params{$_}", at least.

> @@ -1252,7 +1254,7 @@ sub git_difftree_body {
>  			      "<td class=\"link\">" .
>  				$cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob");
>  			if ($to_id ne $from_id) { # modified
> -				print $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
> +				print " | " . $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
>  			}
>  			print " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash, file_name=>$file)}, "history") . "\n";
>  			print "</td>\n";

Well spotted.
