From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-findtags
Date: Tue, 11 Oct 2005 22:19:38 -0700
Message-ID: <7vek6rmhw5.fsf@assigned-by-dhcp.cox.net>
References: <1129087169926-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 07:20:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPZ28-0000Gc-KR
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 07:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVJLFTk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 01:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVJLFTk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 01:19:40 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22680 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932448AbVJLFTk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 01:19:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012051924.KJLN29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 01:19:24 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10007>

Martin Langhoff <martin@catalyst.net.nz> writes:

> +my @tagfiles   = `find $git_dir/refs/tags -follow -type f`; # haystack

Please do this with File::Find(), unless you have a compelling
reason not to.  $git_dir could contain shell metacharacters
and/or whitespace.

> +    # grab the first 2 lines (the whole tag could be large)
> +    my $tagobj = `git-cat-file tag $tagid | head -n2 `;

Careful; $tagfile could be a lightweight tag, and you would want
to consider it a hit if ($tagid eq $target).

BTW, does `` in Perl behave well upon SIGPIPE (hehe, we now have
Merlyn on the list so I can ask these silly Perl questions ;-))?

> +    if ($tagobj =~  m/^type commit$/m) { # only deal with commits
> +
> +	if ($tagobj =~ m/^object $target$/m) { # match on the commit
> +	    print basename($tagfile) . "\n";

Please show "tags/bl/ah" when ".git/refs/tags/bl/ah" points at
the target, not just "ah".  Alternatively, "bl/ah" may also be
acceptable, since this command is about tags.

> +	} elsif ( $opt_t &&                      # follow the commit
> +		 $tagobj =~ m/^object (\S+)$/m) { # and try to match trees

I am not sure how useful '-t' would be in practice.  If it is, I
wonder if it would also be useful to look for a subtree match..

> +sub quickread {
> +    my $file = shift;
> +    local $/; undef $/; # slurp mode

Nit -- "local $/;" without "undef $/;" would do just fine.

BTW, wouldn't it be easier for this particular script, and more
useful in general, if something like what 'git-rev-parse' does
for commit objects when given "REV^0" is supported for tags?

I am uncertain the about syntax/notation, but just like "^0" is
a postfix operator for "peel the onion repeatedly until you get
a commit, or barf if you ended up with a non-commit", maybe if
we had "peel the onion repeatedly until you get a non-tag"
operator, let's call it '%', then you could say something like
this:

        # This is pseudo-code -- it does not handle tagname with
        # embedded $IFS letter very well.

        # list local refs
	git-rev-parse --symbolic --all |

        # limit only to tags
        sed -ne '/^refs\/tags\/p' |
        while read tagname
        do
        	if test $(git-rev-parse --verify "${tagname}%") = "$target"
		then
                	echo "$tagname"
		fi
	done
