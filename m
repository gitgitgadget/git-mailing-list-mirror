From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Sun, 27 Aug 2006 03:52:10 -0700
Message-ID: <7v64gexxgl.fsf@assigned-by-dhcp.cox.net>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
	<115637597423-git-send-email-madcoder@debian.org>
	<7vfyfiyaex.fsf@assigned-by-dhcp.cox.net>
	<200608271228.09718.madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 12:52:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHIFV-00034G-4U
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 12:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWH0Kvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 06:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWH0Kvr
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 06:51:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52391 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750701AbWH0Kvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 06:51:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827105146.EQXY21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sun, 27 Aug 2006 06:51:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id Eyrj1V02N4Noztg0000000
	Sun, 27 Aug 2006 06:51:46 -0400
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <200608271228.09718.madcoder@debian.org> (Pierre Habouzit's
	message of "Sun, 27 Aug 2006 12:28:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26090>

Pierre Habouzit <madcoder@debian.org> writes:

> There is also a second patch that never made it to the list that fixes:
>  * some indentation problems due to a bad vimrc
>  * --default-hostname switch (to handle virtual hosts even with older
>    clients)
>  * possible overflow in the formatting method.
>
> I'll recompute a new patch that superseeds that one, and merge your 
> comments and my never sent patch too.

I have to admit that I kinda liked JDL's simpler one first (and
it has been in production use for some time).  We'll see.

About vger potentially throwing things away, I use this script
(called "taboo.perl") to check my messages before sending them
out.

Obviously the taboo-word list itself is not attached here, but
the actual script should have a copy of it after the __DATA__
marker.

-- >8 --

#!/usr/bin/perl -w

my $tmpl = '	if (%%PATTERN%%) {
		print "$lineno ${_}matches %%QPATTERN%%\n";
		return;
	}
';
my $stmt = "";
my $in_header = 1;

while (<DATA>) {
	if (/^\$global_taboo_body =/) {
		$in_header = 0;
	}
	next if (/^\043/ || /^\$/ || /^END$/ || /^\s*$/);
	chomp;
	my $p = $_;
	if ($in_header) {
		$p = '/^[-\w_]*:/ && ' . $p;
	}
	my $q = quotemeta($p);
	my $stmt1 = $tmpl;
	$stmt1 =~ s|%%PATTERN%%|$p|g;
	$stmt1 =~ s|%%QPATTERN%%|$q|g;
	$stmt .= $stmt1;
}
close DATA;

$stmt = 'sub check {
	my ($line, $lineno) = @_;
' . $stmt . '
}
';
eval $stmt;
while (<>) {
	check($_, $.);
}

my $how_to_update_this_script = <<'EOF' ;
	( sed -e '/^__DATA__$$/q' taboo.perl && \
	  wget -q -O - http://vger.kernel.org/majordomo-taboos.txt ) \
		>taboo.perl+
	if diff -u taboo.perl taboo.perl+; \
	then \
		rm -f taboo.perl+; \
		echo >&2 No changes.; \
	else \
		mv taboo.perl+ taboo.perl; \
		chmod +x taboo.perl; \
	fi
EOF

__DATA__
