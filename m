From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: make search form generate pathinfo-style URLs
Date: Sat, 07 Jul 2007 14:01:09 -0700
Message-ID: <7vejjk6i96.fsf@assigned-by-dhcp.cox.net>
References: <1183057027.6108.4.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, pasky@suse.cz,
	ltuikov@yahoo.com
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 23:01:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7HP0-0003Sp-Sy
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 23:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXGGVBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 17:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbXGGVBL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 17:01:11 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40107 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbXGGVBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 17:01:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707210110.MKNW1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Jul 2007 17:01:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ll191X0081kojtg0000000; Sat, 07 Jul 2007 17:01:09 -0400
In-Reply-To: <1183057027.6108.4.camel@mattlaptop2> (Matt McCutchen's message
	of "Thu, 28 Jun 2007 14:57:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51845>

Matt McCutchen <hashproduct@gmail.com> writes:

> The search form generated traditional-style URLs with a "p=" parameter
> even when the pathinfo feature was on.  This patch makes it generate
> pathinfo-style URLs when appropriate.
>
> Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
> ---
>  gitweb/gitweb.perl |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f36428e..7b0e110 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2215,12 +2215,18 @@ EOF
>  		} else {
>  			$search_hash = "HEAD";
>  		}
> +		my $action = $my_uri;
> +		my ($use_pathinfo) = gitweb_check_feature('pathinfo');
> +		if ($use_pathinfo) {
> +			$action .= "/$project";
> +		} else {
> +			$cgi->param("p", $project);
> +		}
>  		$cgi->param("a", "search");
>  		$cgi->param("h", $search_hash);
> -		$cgi->param("p", $project);
> -		print $cgi->startform(-method => "get", -action => $my_uri) .
> +		print $cgi->startform(-method => "get", -action => $action) .
>  		      "<div class=\"search\">\n" .
> -		      $cgi->hidden(-name => "p") . "\n" .
> +		      (!$use_pathinfo && $cgi->hidden(-name => "p") . "\n") .

Ahhhhh.  (!$use_pathinfo && blah) when $use_pathinfo is true
evaluates to an empty string, which saves you from protecting
yourself from undef.  Perhaps clever, but is not terribly nice.

Other than that, the patch looks sane to me.
