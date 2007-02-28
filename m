From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-archimport on empty summary
Date: Wed, 28 Feb 2007 11:29:12 -0800
Message-ID: <7vd53u13p3.fsf@assigned-by-dhcp.cox.net>
References: <es39f9$sqh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUUX-0003DN-F9
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbXB1T3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbXB1T3T
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:29:19 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38409 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406AbXB1T3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:29:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228192918.QVZU2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Feb 2007 14:29:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id V7VH1W00X1kojtg0000000; Wed, 28 Feb 2007 14:29:18 -0500
In-Reply-To: <es39f9$sqh$1@sea.gmane.org> (Paolo Bonzini's message of "Wed, 28
	Feb 2007 08:03:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40995>

Paolo Bonzini <bonzini@gnu.org> writes:

> The patch seems pretty obvious to me, and Martin Langhoff has already
> seen it in private e-mail.
>    
> Thanks,
>
> Paolo
>
> 2007-02-27  Paolo Bonzini  <bonzini@gnu.org>
>
>         * git-archimport (parselog): Cope with an empty summary.
>

I would have liked a proposed commit message that is more in
line with the rest of the git.git history.

The patch seems pretty obvious and does not do any _worse_ than
the existing code.

> --- /usr/bin/git-archimport     2007-01-09 21:15:39.000000000 +0100
> +++ ./git-archimport    2007-02-27 14:28:33.000000000 +0100
> @@ -780,7 +780,11 @@
>      }
>
>      # post-processing:
> -    $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
> +    if (defined $ps->{summary}) {
> +        $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
> +    } else {
> +        $ps->{summary} = "\n";
> +    }
>      $ps->{message} = join("\n",@$log);
>
>      # skip Arch control files, unescape pika-escaped files

However, I see that the result is used this way:

    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par) 
        or die $!;
    print WRITER $ps->{summary},"\n";
    print WRITER $ps->{message},"\n";

What's the arch way of formatting log messages?  Are summary
lines expected to be multi-line?  I see that there is a
continuation line handling that builds @{$ps->{summary}} array.
What does a summary line like this mean to an arch person?

	Summary: Fix git-archimport's handling of a commit that
	 lack a "Summary:" line.
 	Creator: Paolo Bonzini <bonzini@gnu.org>

Does it mean the Summary is logically two lines, or it is
logically one line but linewrapped into two physical lines?  If
that is the case, I would almost suggest to update the part your
patch touches to read like:

	chomp(@$log);
	while ($_ = shift @$log) {
        	...
	}
	# drop leading empty lines from the log message
	while (@$log && $log->[0] ne '') {
        	shift @$log;
	}
	if (exists $ps->{summary} && @{$ps->{summary}}) {
        	$ps->{summary} = join(' ', @{$ps->{summary}});
        }
	else {
        	$ps->{summary} = $log->[0] . '...';
	}
	$ps->{message} = join("\n",@$log);

and then update the user of these two to:

    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par) 
        or die $!;
    print WRITER $ps->{summary},"\n\n";
    print WRITER $ps->{message},"\n";

That way, you will always have a one-line that can sensibly
serve as a summary to appear in "git shortlog".
