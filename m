From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 12:58:57 -0700
Message-ID: <7veju2s6bi.fsf@assigned-by-dhcp.cox.net>
References: <200609212356.31806.jnareb@gmail.com>
	<20060923032948.GE8259@pasky.or.cz>
	<200609231034.49545.jnareb@gmail.com>
	<20060923121134.GM13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 21:59:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRDeR-0005T8-KI
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWIWT7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWIWT7A
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:59:00 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5275 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751502AbWIWT66 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 15:58:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923195858.BQWV6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 15:58:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rvyw1V00D1kojtg0000000
	Sat, 23 Sep 2006 15:58:57 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923121134.GM13132@pasky.or.cz> (Petr Baudis's message of
	"Sat, 23 Sep 2006 14:11:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27623>

Petr Baudis <pasky@suse.cz> writes:

> Also, there is a fundamental limitation for the multi-word patterns that
> they won't work if the line wraps at that point in the log message. This
> will likely be a problem especially for the msgids, because those are
> very long and are very likely to cause a linewrap immediately before.
>
> By the way, I don't think taking just 40-digits sha1s is very useful,
> since that's insanely long and besides the linewrap issue, a lot of
> people just shorten that to some 8 to 12 digits now - I'd use {8-40}
> instead (the enforced minimum is 4 in the Git autocompletion code but we
> shouldn't encourage people to write so ambiguous sha1s to persistent
> records).

True.  Without looking at Jakub's code under discussion, off the
top of my head, I wonder if we can do something like this:

 (1) take the whole commit log message, not line by line, into a
     Perl variable, say $log.  Note that this is _before_ HTML
     escaping.

 (2) each enabled tag-marking sub are expected to take a list of
     string or ref as its parameter.  The first one in the chain
     takes a single parameter which is ($log).  You call all the
     enabled ones, in some order, and feed the return value from
     the previous one as the input to the next one.

 (3) a tag-marking sub are expected to inspect the list it
     received as its input parameter, and build its return value
     by looking at each element in the list:

	(3-1) if the element is not a string, pass it down as-is
	in the output list.

	(3-2) if the element is a string, do the pattern match,
	and output one or more elements in the output list.
	Literal string you did not care about are placed as
	string for later taggers to be processed, the links you
	generate are placed as a ref to string.

    For example, commit_id tag-marker might look like this:

        sub tag_marker_commit_id {
                my @input = (@_);
                my @output;
                for (@input) {
                        if (!ref $_) {
                                push @output, $_;
                                next;
                        }
                        while ($_ ne '' && m/(.*?)\b([0-9a-fA-F]{6,})\b(.*)/s) {
                                my ($pre, $sha1, $post) = ($1, $2, $3);
                                if (!is_a_commit_id($sha1)) {
                                        push @output, "$pre$sha1";
                                }
                                else {
					my $subst =
                                          href(action => 'commit', hash => $2);
                                        push @output, $1;
                                        push @output, \$subst;
                                }
                                $_ = $post;
                        }
                }
                return @output;
        }

 (4) when you finished calling the chain, you would have a list
     of string and ref.  You html quote the strings and pass
     the ref's (which are supposed to be already HTML) as is,
     and concatenate the result:

	sub markup_all {
        	my ($log) = @_;
                my @current = $log;
                for my $tag_marker (@tag_markers) {
			@current = $tag_marker->(@current);
		}
                return join('',
                	map {
                        	(ref $_) ? $$_ : esc_html($_)
			} @current);
	}

Hmm?

     
