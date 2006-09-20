From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Make git_get_refs_list do work of git_get_references
Date: Wed, 20 Sep 2006 11:12:58 -0700
Message-ID: <7veju6h0et.fsf@assigned-by-dhcp.cox.net>
References: <200609191430.51252.jnareb@gmail.com>
	<200609191433.22878.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 20:13:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ6ZH-0008BD-Ty
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 20:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWITSNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 14:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWITSNE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 14:13:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25048 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932197AbWITSNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 14:13:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920181259.EGRS6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 14:12:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QiCl1V0081kojtg0000000
	Wed, 20 Sep 2006 14:12:45 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609191433.22878.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 19 Sep 2006 14:33:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27388>

Jakub Narebski <jnareb@gmail.com> writes:

> Make git_get_refs_list do also work of git_get_references, to avoid
> calling git-peek-remote twice.  Change meaning of git_get_refs_list
> meaning: it is now type, and not a full path, e.g. we now use
> git_get_refs_list("heads") instead of former
> git_get_refs_list("refs/heads").
>
> Modify git_summary to use only one call to git_get_refs_list instead
> of one call to git_get_references and two to git_get_refs_list.

Will apply as-is; the following comments might be useful for
further improvements.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 034a88c..01fae94 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1127,14 +1128,21 @@ sub git_get_refs_list {
> +		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?([^\^]+))(\^\{\})?$/) {
> +			if (defined $refs{$1}) {
> +				push @{$refs{$1}}, $2;
> +			} else {
> +				$refs{$1} = [ $2 ];
> +			}

Logically this should be "exists $refs{$1}" but defined would
work fine in this particular case, because the elements of the
hash are always an arrayref (this is just an advise to have the
right habit).

> +			if (! $4) { # unpeeled, direct reference
> +				push @refs, { hash => $1, name => $3 }; # without type
> +			} elsif ($3 eq $refs[-1]{'name'}) {
> +				# most likely a tag is followed by its peeled
> +				# (deref) one, and when that happens we know the
> +				# previous one was of type 'tag'.
> +				$refs[-1]{'type'} = "tag";
> +			}
>...
> -	return \@reflist;
> +	return (\@reflist, \%refs);

You are maintaining reflist (an array of hashrefs each element
of which describes name, type, hash and other parse_ref()
information for the ref) and refs (a hash that maps from name to
hash) separatly.  I wonder if this really has the performance
advantage over just compute and return reflist from here and
have the callers who need the mapping to derive it from the list
(i.e.

	my ($reflist) = git_get_refs_list();
	my %refs = map { $_->{name} => $_->{hash} } @$reflist;
).

> @@ -2114,14 +2122,14 @@ sub git_tags_body {
>  
>  sub git_heads_body {
>  	# uses global variable $project
> -	my ($taglist, $head, $from, $to, $extra) = @_;
> +	my ($headlist, $head, $from, $to, $extra) = @_;
>  	$from = 0 unless defined $from;
> -	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
> +	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
>  
>  	print "<table class=\"heads\" cellspacing=\"0\">\n";
>  	my $alternate = 0;
>  	for (my $i = $from; $i <= $to; $i++) {
> -		my $entry = $taglist->[$i];
> +		my $entry = $headlist->[$i];
>  		my %tag = %$entry;
>  		my $curr = $tag{'id'} eq $head;
>  		if ($alternate) {

I guess either would do but I think it is more conventional to
say:

	my $limit = @list;
        for (my $i = $from; $i < $limit; $i++) { ... }

than 

	my $limit = $#list;
        for (my $i = $from; $i <= $limit; $i++) { ... }

At least the former would be easier to read for C types among us.

The remaining hunks are very nice improvements.

> @@ -2291,7 +2299,19 @@ sub git_summary {
> @@ -2321,17 +2341,15 @@ sub git_summary {
> @@ -2542,7 +2560,7 @@ sub git_tags {
> @@ -2555,9 +2573,9 @@ sub git_heads {
