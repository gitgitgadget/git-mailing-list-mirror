From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add title attribute with full first line of tag comment if it is needed
Date: Wed, 21 Jun 2006 16:10:41 -0700
Message-ID: <7vu06exfym.fsf@assigned-by-dhcp.cox.net>
References: <11509297422173-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 01:11:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtBqR-0008GQ-28
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 01:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWFUXKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 19:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWFUXKo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 19:10:44 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:23953 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030452AbWFUXKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 19:10:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621231042.HUPV18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 19:10:42 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11509297422173-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Thu, 22 Jun 2006 00:42:22 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22289>

Jakub Narebski <jnareb@gmail.com> writes:

> For commits in oneline view (summary, shortlog, history) commit title
> (first line of commit message) is link to commit itself. If commit title
> (commit description) is shortened in output, hyperlink has title attribute
> with full title.

There are pure fixes and this "-title" enhancement intermixed.
Can we have fixes-only first?

> diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
> index e044c61..8f8ae4a 100755
> --- a/gitweb/gitweb.cgi
> +++ b/gitweb/gitweb.cgi
> @@ -326,7 +326,7 @@ EOF
>  		} elsif (defined $hash) {
>  			$search_hash = $hash;
>  		} else {
> -			$search_hash  = "HEAD";
> +			$search_hash = "HEAD";
>  		}
>  		$cgi->param("a", "search");
>  		$cgi->param("h", $search_hash);

Is a fix.

> @@ -1107,7 +1107,8 @@ sub git_summary {
>  		foreach my $entry (@$taglist) {
>  			my %tag = %$entry;
>  			my $comment_lines = $tag{'comment'};
> -			my $comment = shift @$comment_lines;
> +			my $comment_long = shift @$comment_lines;
> +			my $comment = $comment_long;
>  			if (defined($comment)) {
>  				$comment = chop_str($comment, 30, 5);
>  			}

Is an enhancement.

> @@ -1119,13 +1120,17 @@ sub git_summary {
>  			$alternate ^= 1;
>  			if ($i-- > 0) {
>  				print "<td><i>$tag{'age'}</i></td>\n" .
> -				      "<td>" .
> +				      "<td>";
>  				      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}"), -class => "list"},
>  				      "<b>" . esc_html($tag{'name'}) . "</b>") .
>  				      "</td>\n" .
>  				      "<td>";

Is a fix.  How could we have missed this?

>  				if (defined($comment)) {
> -				      print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
> +					if (length($comment) < length($comment_long)) {
> +						print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}"), -title => "$comment_long"}, $comment);
> +					} else {
> +						print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
> +					}
>  				}
>  				print "</td>\n" .
>  				      "<td class=\"link\">";

Is an enhancement -- I suspect it is not worth to switch
depending on the length of $comment_long.  Does it clutter the
output too much if you did -title to everybody?

> @@ -1346,7 +1351,8 @@ sub git_tags {
>  		foreach my $entry (@$taglist) {
>  			my %tag = %$entry;
>  			my $comment_lines = $tag{'comment'};
> -			my $comment = shift @$comment_lines;
> +			my $comment_long = shift @$comment_lines;
> +			my $comment = $comment_long;
>  			if (defined($comment)) {
>  				$comment = chop_str($comment, 30, 5);
>  			}

Is an enhancement.  I think the matching hunk to fix the same
"$cgi->a() output concatenated as print argument" problem is
missing here.  And the next hunk the same comment as the one for
git_summary applies.

And as you say, git_summary and git_tags do look similar.  Maybe
we would want to refactor them first to clean things up before
piling up more features?
