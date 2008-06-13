From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: don't append extra newlines at the end of
 commit messages.
Date: Thu, 12 Jun 2008 22:41:46 -0700
Message-ID: <7vfxrhyjqd.fsf@gitster.siamese.dyndns.org>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 07:42:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K723n-00041h-2x
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 07:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYFMFl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 01:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYFMFl5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 01:41:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYFMFl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 01:41:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF06A26BA;
	Fri, 13 Jun 2008 01:41:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D654B26B8; Fri, 13 Jun 2008 01:41:48 -0400 (EDT)
In-Reply-To: <1213312251-8081-1-git-send-email-apenwarr@gmail.com> (Avery
 Pennarun's message of "Thu, 12 Jun 2008 19:10:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6ED28066-390B-11DD-816A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84834>

Avery Pennarun <apenwarr@gmail.com> writes:

> In git, all commits end in exactly one newline character.  In svn, commits
> end in zero or more newlines.  Thus, when importing commits from svn into
> git, git-svn always appends two extra newlines to ensure that the
> git-svn-id: line is separated from the main commit message by at least one
> blank line.
>
> Combined with the terminating newline that's always present in svn commits
> produced by git, you usually end up with two blank lines instead of one
> between the commit message and git-svn-id: line, which is undesirable.
>
> Instead, let's remove all trailing whitespace from the git commit on the way
> through to svn.

Perl part of the code looks fine but I am unsure if we like the
ramifications of this patch on existing git-svn managed repositories.
Doesn't this change the commit object name on our end for almost all of
them?

> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
> ---
>  git-svn.perl |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 47b0c37..a54979d 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1023,6 +1023,7 @@ sub get_commit_entry {
>  		my $in_msg = 0;
>  		my $author;
>  		my $saw_from = 0;
> +		my $msgbuf = "";
>  		while (<$msg_fh>) {
>  			if (!$in_msg) {
>  				$in_msg = 1 if (/^\s*$/);
> @@ -1035,14 +1036,15 @@ sub get_commit_entry {
>  				if (/^From:/ || /^Signed-off-by:/) {
>  					$saw_from = 1;
>  				}
> -				print $log_fh $_ or croak $!;
> +				$msgbuf .= $_;
>  			}
>  		}
> +		$msgbuf =~ s/\s+$//s;
>  		if ($Git::SVN::_add_author_from && defined($author)
>  		    && !$saw_from) {
> -			print $log_fh "\nFrom: $author\n"
> -			      or croak $!;
> +			$msgbuf .= "\n\nFrom: $author";
>  		}
> +		print $log_fh $msgbuf or croak $!;
>  		command_close_pipe($msg_fh, $ctx);
>  	}
>  	close $log_fh or croak $!;
> -- 
> 1.5.4.3
