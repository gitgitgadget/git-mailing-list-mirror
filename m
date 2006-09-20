From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read refs
Date: Wed, 20 Sep 2006 08:53:12 -0700
Message-ID: <7vodtak00n.fsf@assigned-by-dhcp.cox.net>
References: <20060920085200.GA21865@shadowen.org> <eer19l$6hm$1@sea.gmane.org>
	<4511173D.7020702@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:54:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4Nx-0004g0-Go
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWITPxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWITPxO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:53:14 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8331 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751678AbWITPxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 11:53:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920155311.JBNI12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 11:53:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qfsz1V00G1kojtg0000000
	Wed, 20 Sep 2006 11:52:59 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4511173D.7020702@shadowen.org> (Andy Whitcroft's message of
	"Wed, 20 Sep 2006 11:26:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27353>

Andy Whitcroft <apw@shadowen.org> writes:

> I guess we could teach for-each-ref to output this as well?  Perhaps
> something like authorstamp?

I think you can work with "author" or "committer" to grab the
whole raw line.

About the quoting and parsing, language specific quoting mode is
meant for git-for-each-ref to produce a string that can be eval'ed
in the host language.  Think of the command as a tool to write a
short program for you.

The original is like this:

	# Get the last import timestamps
	opendir(D,"$git_dir/refs/heads");
	while(defined(my $head = readdir(D))) {
		next if $head =~ /^\./;
		open(F,"$git_dir/refs/heads/$head")
			or die "Bad head branch: $head: $!\n";
		chomp(my $ftag = <F>);
		close(F);
		open(F,"git-cat-file commit $ftag |");
		while(<F>) {
			next unless /^author\s.*\s(\d+)\s[-+]\d{4}$/;
			$branch_date{$head} = $1;
			last;
		}
		close(F);
	}
	closedir(D);

The purpose of the loop is to grab all branch heads, and grab
author timestamp for all of them, _and_ stash that in
%branch_date hash indexed by head name.  You would want to have
something like this executed for each branch:

	$refname = %(refname);
	$authorline = %(author);
	$authorline =~ /^author\s.*\s(\d+)\s[-+]\d{4}$/;
        $branch_date{$refname} = $1;

So, you have the tool to write such a program for you, by doing
something like this:

	my $template = '
                $refname = %(refname);
                $authorline = %(author);
                $authorline =~ /^author\s.*\s(\d+)\s[-+]\d{4}$/;
                $branch_date{$refname} = $1;
	';
        my @cmd = ('git-for-each-ref', '--perl', "--format=$template");

	open I, '-|', @cmd, 'refs/heads';
        my $script = join('',<I>);
        close I;

	my ($refname, $authorline);
        eval "$script";

The language specific quoting flag --perl affects how %() are
interpolated into the generated program text as literals.
That's why there is no quote around %(refname) or %(author)
in the example above when defining the $template.
