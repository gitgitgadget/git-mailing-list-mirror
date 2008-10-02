From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename
	PATH_INFO
Date: Thu, 2 Oct 2008 17:34:03 +0200
Message-ID: <20081002153403.GQ10360@machine.or.cz>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:36:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlQDl-0003Lw-9E
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbYJBPeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbYJBPeH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:34:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42839 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897AbYJBPeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:34:06 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id EFC903939B57; Thu,  2 Oct 2008 17:34:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97358>

On Thu, Oct 02, 2008 at 02:10:29AM +0200, Giuseppe Bilotta wrote:
> This patch enables gitweb to parse URLs with more information embedded
> in PATH_INFO, reducing the need for CGI parameters. The typical gitweb
> path is now $project/$action/$hash_base:$file_name or
> $project/$action/$hash
> 
> This is mostly backwards compatible with the old-style gitweb paths,
> except when $project/$branch was used to access a branch whose name
> matches a gitweb action.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Just nits...

> ---
>  gitweb/gitweb.perl |   90 +++++++++++++++++++++++++++++++---------------------
>  1 files changed, 54 insertions(+), 36 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e7e4d6b..f088681 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -519,9 +550,19 @@ sub evaluate_path_info {
>  	# do not change any parameters if an action is given using the query string
>  	return if $action;
>  	$path_info =~ s,^\Q$project\E/*,,;
> +
> +	# next comes the action
> +	$action = $path_info;
> +	$action =~ s,/.*$,,;
> +	if (exists $actions{$action}) {
> +		$path_info =~ s,^$action/*,,;
> +	} else {
> +		$action  = undef;

Extra whitespace.

> +	}
> +
>  	my ($refname, $pathname) = split(/:/, $path_info, 2);
>  	if (defined $pathname) {
> -		# we got "project.git/branch:filename" or "project.git/branch:dir/"
> +		# we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
>  		# we could use git_get_type(branch:pathname), but it needs $git_dir
>  		$pathname =~ s,^/+,,;
>  		if (!$pathname || substr($pathname, -1) eq "/") {

But the old variant is still possible, maybe the comments should
indicate that the action/ part is optional.

> @@ -534,8 +575,9 @@ sub evaluate_path_info {
>  		$file_name ||= validate_pathname($pathname);
>  	} elsif (defined $refname) {
>  		# we got "project.git/branch"
> -		$action ||= "shortlog";
> -		$hash   ||= validate_refname($refname);
> +		$action    ||= "shortlog";
> +		$hash      ||= validate_refname($refname);
> +		$hash_base ||= validate_refname($refname);
>  	}
>  }
>  evaluate_path_info();

What is this good for?

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
