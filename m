From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 01:56:31 +0200
Message-ID: <20050529235630.GG12290@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <20050529230240.GB12290@cip.informatik.uni-erlangen.de> <20050529231053.GD12290@cip.informatik.uni-erlangen.de> <20050529231621.GE12290@cip.informatik.uni-erlangen.de> <20050529234606.GF12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:54:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXbm-0002cd-27
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVE2X4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVE2X4p
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:56:45 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37821 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261466AbVE2X4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:56:39 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4TNuVS8006413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 May 2005 23:56:31 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4TNuVWO006412;
	Mon, 30 May 2005 01:56:31 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050529234606.GF12290@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
here is the actual version of my merge function. However I have a
question left over: When I do an automatic merge or a threeway merge
should I set the head for the next round to the remote one or just let
it be the current one (this is the current behaviour) or maybe make it
configurable? Note: At the moment the *local* head for the merge-base is only
modified during the set of the first head *or* on a head forward condition. I
have no clue. I am going to write the 'more on merging chapter' after I have
figured this out. ;-)

sub
merge
{

	my $message      = undef;
	my $head         = undef;
	my $last_tree    = undef;
	my $fh;
	my @heads        = ();

	foreach my $r (@_) {
		my $current_head = @{$r}[0];
		my $current_url  = @{$r}[1];

		print "current_head => $current_head\ncurrent_url => $current_url\n";

		push(@heads, '-p', ${current_head});

		if (! defined($last_tree)) {
			$message    = "=> ${current_url}\n";
			$head       = $current_head;
			$last_tree  = $current_head;
			
			if (@_ == 1) {
				head($head);
				return;
			}

			next;
		}

		my $merge_base = gitcmdout('git-merge-base', $head, $current_head)
				 || die ("no merge-base");
		chomp($merge_base);

		print "head => $head\nremote => $current_head\nbase => $merge_base\n";
	
		if ($merge_base eq $current_head) {
			$message .= "<= ${current_url} (nothing to merge)\n";

			$#heads -= 2;

			next;
		}

		if ($merge_base eq $head) {
			$message   .= "<= ${current_url} (bringing head ahead)\n";
			$head       = ${current_head};
			$last_tree  = ${current_head};

			$#heads -= 4;
			push(@heads, '-p', $current_head);

			next;
		}

		gitcmd('git-read-tree', '-m', $merge_base, $last_tree, $current_head);
		if (! defined($last_tree = write_tree())) {
			system('git-merge-cache', '-o', 'git-merge-one-file-script', '-a');
			if (! defined($last_tree = write_tree())) {
				# FIXME: Make manual intervention possible
				# --tg 23:11 05-05-29
				die("Couldn't merge automatically: Call 'git resolve'");
			}
			$message .= "<= ${current_url} (threeway merge)\n";

		} else {
			$message .= "<= ${current_url} (automatic merge)\n";
		}
	}

	if (@heads == 1) {
		head(@head[0]);
		return;
	}

	open($fh, "+>", undef);
	print $fh $message;
	seek($fh, 0, 0);
	$head = gitcmdinout($fh, 'git-commit-tree', $last_tree, @heads);
	chomp($head);
	close $fh;

	head($head);
	return;
}

	Thomas
