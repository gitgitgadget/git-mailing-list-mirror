From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not chop HTML tags in commit search result
Date: Wed, 13 Feb 2008 11:43:14 -0800
Message-ID: <7vbq6kprql.fsf@gitster.siamese.dyndns.org>
References: <ae63f8b50802130937mddf9df9re2a95bee44661ee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jean-Baptiste Quenot" <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:44:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPNWf-0001Q6-2j
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 20:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbYBMTni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 14:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYBMTni
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 14:43:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYBMTnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 14:43:37 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C4521378C;
	Wed, 13 Feb 2008 14:43:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 DDE3B378B; Wed, 13 Feb 2008 14:43:31 -0500 (EST)
In-Reply-To: <ae63f8b50802130937mddf9df9re2a95bee44661ee3@mail.gmail.com>
 (Jean-Baptiste Quenot's message of "Wed, 13 Feb 2008 18:37:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73814>

"Jean-Baptiste Quenot" <jbq@caraldi.com> writes:

> ... I encountered an annoying bug
> with gitweb 1.5.4.1, when searching for commits, if the search string
> is too long, the generated HTML is munged leading to an ill-formed
> XHTML document.

> Here is the patch, hope it helps:
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ae2d057..2c0b990 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3780,7 +3780,10 @@ sub git_search_grep_body {
>                                 my $trail = esc_html($3) || "";
>                                 $trail = chop_str($trail, 30, 10);
> ...
>                                 my $text = "$lead<span
> class=\"match\">$match</span>$trail";
> -                               print chop_str($text, 80, 5) . "<br/>\n";

I think esc_html() and chop_str() are backwards here.  If $3 is
overlong it is cut in the middle of some markup.  Even though
chop_str() claims to be "HTML aware", I do not think it is.  It
seems to know about "&entities;" but not mark-ups.

There are quite a many instances of esc_html() first then chop_str()
in that function, and I think they all deserve to be fixed.

	my $comment = $co{'comment'};
	foreach my $line (@$comment) {
		if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
			my $lead = esc_html($1) || "";
			$lead = chop_str($lead, 30, 10);
			my $match = esc_html($2) || "";
			my $trail = esc_html($3) || "";
			$trail = chop_str($trail, 30, 10);
			my $text = "$lead<span class=\"match\">$match</span>$trail";
			print chop_str($text, 80, 5) . "<br/>\n";
		}
	}

I think this is trying to fit the result on a line, showing the
match sandwitched by not-too-long part taken from leading and
trailing context ($lead and $trail can be chomped aggressively
than $match).  But $lead and $trail are escaped then chomped
which is already wrong.

I think the body of that if() would be better written like this:

	my ($lead, $match, $trail) = ($1, $2, $3);
	$match = chop_str($match, 70, $slop); # in case it is very long...
	$contextlen = (80 - len($match)) / 2; # and the remainder...
        if ($contextlen > 30) { $contextlen = 30 }; # but not too much
        $trail = chop_str($trail, $contextlen, $slop);
        $lead = chop_str($lead, $contextlen, $slop);

	$lead = esc_html($lead);
	$match = esc_html($match);
	$trail = esc_html($trail);

        print "$lead<span ...>$match</span>$trail";
