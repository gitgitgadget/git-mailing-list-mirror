From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/9] gitweb: Change appereance of marker of refs pointing to given object
Date: Mon, 14 Aug 2006 17:27:53 -0700
Message-ID: <7vy7tqc06u.fsf@assigned-by-dhcp.cox.net>
References: <200608140202.46160.jnareb@gmail.com>
	<200608140214.20450.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 02:28:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCmmw-0001Js-4h
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 02:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbWHOA14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 20:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbWHOA14
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 20:27:56 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:18408 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932755AbWHOA1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 20:27:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815002754.JGUX12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 20:27:54 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608140214.20450.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 14 Aug 2006 02:14:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25426>

Jakub Narebski <jnareb@gmail.com> writes:

> Change git_get_references to include type of ref in the %refs value, which
> means putting everything after 'refs/' as a ref name, not only last
> part of the name.  Instead of separating refs pointing to the same
> object by " / " separator, use anonymous array reference to store all
> refs pointing to given object.
>
> Use 'git-ls-remote .' if $projectroot/$project/info/refs does not
> exist.  (Perhaps it should be used always.)
>
> Refs are now in separate span elements.  Class is dependent on the ref
> type: currently known classes are 'tag', 'head', 'remote', and 'ref'
> (last one for HEAD and other refs in the main directory).  There is
> encompassing span element of class refs, just in case of unknown ref
> type.

I do not see definition that matches "span.refs span.remote" in
the CSS, though.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6be6c55..4fe3fc7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -364,9 +364,26 @@ sub format_log_line_html {
>  # format marker of refs pointing to given object
>  sub format_ref_marker {
>  	my ($refs, $id) = @_;
> +	my $markers = '';
>  
>  	if (defined $refs->{$id}) {
> -		return ' <span class="tag">' . esc_html($refs->{$id}) . '</span>';
> +		foreach my $ref (@{$refs->{$id}}) {
> +			my ($type, $name) = qw();

Just () -- qw() is not needed.

> +			# e.g. tags/v2.6.11 or heads/next
> +			if ($ref =~ m!^(.*?)s?/(.*)$!) {
> +				$type = $1;
> +				$name = $2;
> +			} else {
> +				$type = "ref";
> +				$name = $ref;
> +			}

Hmph.  Maybe have a hash that defines the ones you know how to
handle, and do something like:

        if ($ref =~ m|^([^/]+)/(.*)$| &&  exists $i_know_this_class{$1}) {
        	$type = $1;
                $name = $2;
	}
        else {
        	$type = 'ref';
                $name = $ref;
	}

> @@ -561,18 +578,24 @@ sub git_get_project_owner {
>...
> +		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
>  			if (defined $refs{$1}) {
> -				$refs{$1} .= " / $2";
> +				push @{$refs{$1}}, $2;
>  			} else {
> -				$refs{$1} = $2;
> +				$refs{$1} = [ $2 ];
>  			}
>  		}

It would work as in your patch, but I would have preferred to
see "exists $refs{$1}" there instead of "defined".

Or lose the if() and do it like this, which would be cleaner?

	if ($line =~ ...) {
        	push @{$refs{$1}}, $2;
	}
