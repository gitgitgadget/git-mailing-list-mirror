From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitweb: gravatar support
Date: Fri, 19 Jun 2009 13:28:42 -0700
Message-ID: <7v63esklxh.fsf@alter.siamese.dyndns.org>
References: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHkhp-0006QM-4q
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 22:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZFSU2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 16:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbZFSU2p
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 16:28:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58450 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZFSU2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 16:28:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090619202842.JAUI25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jun 2009 16:28:42 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5wUi1c0064aMwMQ04wUiiC; Fri, 19 Jun 2009 16:28:42 -0400
X-VR-Score: -50.00
X-Authority-Analysis: v=1.0 c=1 a=UEgj5xvCJugA:10 a=pGLkceISAAAA:8
 a=aiVve9j61QldTkKputwA:9 a=_kDi5SsmJS51O-6sNNwA:7
 a=hlKgZc-wIkc1Gzt4us_2qsBIGZUA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121909>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Introduce gravatar support by adding the appropriate img tag next to
> author and committer in commit, shortlog and log view.
>
> The feature is disabled by default, and depends on Digest::MD5, which
> is available in most Perl installations.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.css  |    4 ++++
>  gitweb/gitweb.perl |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 48 insertions(+), 7 deletions(-)
>
> Changes from the previous version include gravatar use in history view,
> CSS use and the possibility to override the feature on a per-project basis.

I see these repeated patterns in your patch.

> @@ -4145,7 +4179,7 @@ sub git_shortlog_body {
>  		my $author = chop_and_escape_str($co{'author_name'}, 10);
>  		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> -		      "<td><i>" . $author . "</i></td>\n" .
> +		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
>...
> -		      "<td><i>" . $author . "</i></td>\n" .
> +		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
>...
> -		      "<td><i>" . $author . "</i></td>\n" .
> +		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
>...
> -	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
> +	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_gravatar($co{'author_email'}) . "</td></tr>\n" .
>...
> -	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
> +	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_gravatar($co{'committer_email'}) . "</td></tr>\n";
>...

Doesn't it strike you as needing a bit more refactoring?  The first three
are identical, and you can refactor them to

-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . oneline_person($author) . "</td>\n" .

where oneline_person is

	sub oneline_person {
        	my ($me) = @_;
                return ($me->{'smallicon'} .
			"<i>" . $me->{'name_escaped'} . "</i>");
        }

And instead of doing "my $author = chop_and_escape_str()", you will
set up richer my $author upfront, like so:

	my $author = +{
		name_escaped => chop_and_escape_str($co{'author_name'}, 10),
                smallicon => git_get_gravatar($co{'author_email'}, 16, 1),
        };

and pass it to the helper function.

That way, people who do not like italics, or people who want to have the
icon at the end instead of at the beginning, can touch only one place
(i.e. "sub oneline_person").

By the way, in the above example, I named the field 'smallicon', as use of
gravatar is merely an implementation detail.  It is plausible other people
may want to use picons instead.

I do not know about the following hunk (why does it have the icon at the
end, unlike the other ones?), but I think you got the idea.

> -		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
> -		      "</div>\n";
> +		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i>&nbsp;" .
> +		      git_get_gravatar($co{'author_email'}, 16) .
> +		      "<br/>\n</div>\n";

In the medium term, we may want to go one step further and do

    package person;

and make sets of methods like "oneline_person".
