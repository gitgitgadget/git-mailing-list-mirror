From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Thu, 14 Sep 2006 16:09:59 -0700
Message-ID: <7v8xkm2gfs.fsf@assigned-by-dhcp.cox.net>
References: <200609142327.23059.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 01:10:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO0LM-0004hY-QH
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 01:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWINXKB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 19:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWINXKB
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 19:10:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36348 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932110AbWINXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 19:10:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914230959.NENY6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 19:09:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NP9o1V00U1kojtg0000000
	Thu, 14 Sep 2006 19:09:49 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609142327.23059.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 14 Sep 2006 23:27:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27051>

Jakub Narebski <jnareb@gmail.com> writes:

> Remove git_get_hash_by_ref while at it, as git_get_refs_list was the
> only place it was used.

That's a very good news.

> +	open my $fd, "-|", $GIT, "peek-remote", "$projectroot/$project/"
> +		or return;
> +	while (my $line = <$fd>) {
> +		chomp $line;
> +		if ($line =~ m/^([0-9a-fA-F]{40})\t$ref_dir\/?([^\^]+)$/) {
> +			push @refs, { hash => $1, name => $2 };
> +		} elsif ($line =~ m/^[0-9a-fA-F]{40}\t$ref_dir\/?.*\^\{\}$/) {
> +			# assume that "peeled" ref is always after ref,
> +			# and that you "peel" (deref) tags only
> +			$refs[$#refs]->{'type'} = "tag";
> 		}

The assumption is good; we never show a ref^{} before showing
ref itself.  But you probably would want to safeguard yourself
from future changes by not depending on "immediately after".
At least you can check $refs[-1]{'name'} is the same as the
unpeeled ref you are looking at, like this:

	if ($line =~ m/^([0-9a-fA-F]{40})\t$ref_dir\/?([^\^]+)$/) {
		push @refs, { hash => $1, name => $2 };
	} elsif ($line =~ m/^[0-9a-fA-F]{40}\t$ref_dir\/?(.*)\^\{\}$/ &&
                 $1 eq $refs[-1]{'name'}) {
		# most likely a tag is followed by its peeled
		# one, and when that happens we know the
		# previous one was of type 'tag'.
		$refs[$#refs]->{'type'} = "tag";
	} ...

> +	foreach my $ref (@refs) {
> +		my $ref_file = $ref->{'name'};
> +		my $ref_id   = $ref->{'hash'};
> -		my $type = git_get_type($ref_id) || next;
> +		my $type = $ref->{'type'} || git_get_type($ref_id) || next;

And this is a good incremental change to reduce number of
external calls.
