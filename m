X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Small optimizations to gitweb
Date: Mon, 18 Dec 2006 15:45:41 -0800
Message-ID: <7vbqm0vkd6.fsf@assigned-by-dhcp.cox.net>
References: <20061218224327.GG16029@localhost> <em77cg$obn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 23:58:20 +0000 (UTC)
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <em77cg$obn$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	19 Dec 2006 00:17:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34770>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwSB0-0002AV-Nw for gcvg-git@gmane.org; Tue, 19 Dec
 2006 00:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932196AbWLRXpn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWLRXpn
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 18:45:43 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46013 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932196AbWLRXpn (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 18:45:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218234542.LPYX4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 18
 Dec 2006 18:45:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0Pl11W00K1kojtg0000000; Mon, 18 Dec 2006
 18:45:01 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Actually, that is needed to implement checking if we have more than
> the number of commits to show to add '...' at the end only if there
> are some commits which we don't show.

The counting code in git_*_body is seriously unusual to tempt
anybody who reviews the code to reduce that 17 to 16.

The caller says:

	git_shortlog_body(\@revlist, 0, 15, $refs,
	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));

If it counts up, especially if it counts from zero, the loop
would usually say:

	for (i = bottom; i < end; i++)

and anybody who reads that caller would expect it to show 15
lines of output.

But the actual code does this instead:

    sub git_shortlog_body {
            # uses global variable $project
            my ($revlist, $from, $to, $refs, $extra) = @_;

            $from = 0 unless defined $from;
            $to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
            ...
            for (my $i = $from; $i <= $to; $i++) {
                    ... draw each item ...
            }
            if (defined $extra) {
                    print "<tr>\n" .
                          "<td colspan=\"4\">$extra</td>\n" .
                          "</tr>\n";
            }
    }

By the way, I wonder how that $extra is omitted when $revlist is
longer than $to; it should be a trivial fix but it seems to me
that it is always spitted out with the current code.


