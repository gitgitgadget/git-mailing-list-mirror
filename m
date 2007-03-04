From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Amusement: ASCII Art generator
Date: Sun, 4 Mar 2007 02:44:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703040240190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 02:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNflg-0004tR-4G
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 02:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbXCDBoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 20:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbXCDBoE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 20:44:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:56714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932610AbXCDBoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 20:44:03 -0500
Received: (qmail invoked by alias); 04 Mar 2007 01:44:00 -0000
X-Provags-ID: V01U2FsdGVkX18mG25gv18my00PGafoFBSeqVn03ak5seuYBAgUSg
	NLINhXes3Z/4Wj
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41342>

Hi,

a few days ago, I posted an ASCII representation of a commit graph. This 
was really tedious, so I wrote a simple script to generate it (and also to 
prove that I am not making everything a builtin). It takes revision range 
arguments, so if you call it with '-25 229ed74' on the git repository, you 
will get this:

A---C-----F---------------------Q---------------Y
   /     /                     /               /
  B   D-E   G-------K-------O-P---R---T-U-V-W-X
                           /         ,-----'
              H-I-J---L-M-N---------S

Now, without further ado, the script.

-- snipsnap --
#!/usr/bin/perl

if ($#ARGV < 1) {
	print STDERR "Usage: $ARGV0 <revision range>\n";
	exit(1);
}

open INPUT, 'git rev-list --parents ' . join(' ', @ARGV) . '|';

%commits=();
@list=();

sub add_parents ($$) {
	my $parents = $_[0];
	my $y = $_[1];
	foreach my $parent (split / /,$parents) {
		if ($commits->{$parent} == undef) {
			$commits->{$parent} = {
				'y' => $y++,
				'sha1' => $parent
			};
		} else {
			if ($commits->{$parent}->{y} < $y) {
				$commits->{$parent}->{y} = $y++;
			} else {
				$y = $commits->{$parent}->{y} + 1;
			}
		}
	}
}

# expects output of `rev-list --parents --topo-order`
$i = 0;
while (<INPUT>) {
	if (/^([0-9a-f]{40}) ?(.*)$/) {
		$sha1 = $1;
		$parents = $2;
		if ($commits->{$sha1} == undef) {
			$commits->{$sha1} = {
				'y' => 0,
				'sha1' => $sha1,
			};
		} else {
			$commits->{$sha1}->{index} = $#list;
		}
		$commits->{$sha1}->{parents} = $parents;
		$list[$i] = $commits->{$sha1};
		$commits->{$sha1}->{index} = $i++;
		add_parents($parents, $commits->{$sha1}->{y});
	}
}
close INPUT;

if ($#list >= 26) {
	print STDERR "Cannot draw more than 26 revs.";
	exit(1);
}

# make labels
$height = 0;
for ($i = 0; $i <= $#list; $i++) {
	$list[$i]->{x} = $#list - $i;
	$list[$i]->{label} = chr(0x41 + $list[$i]->{x});
	if ($height < $list[$i]->{y}) {
		$height = $list[$i]->{y};
	}
}

# make a canvas
$width = $#list * 2 + 1;
$height = $height * 2 + 1;
@canvas = ();
for ($i = 0; $i < $height; $i++) {
	$canvas[$i] = ' ' x $width . "\n";
}

sub set_cell ($$$) {
	my $x = $_[0];
	my $y = $_[1];
	my $c = $_[2];
	$canvas[$y] = substr($canvas[$y], 0, $x) . $c .
		substr($canvas[$y], $x + 1);
}

sub get_cell ($$) {
	my $x = $_[0];
	my $y = $_[1];
	return substr($canvas[$y], $x, 1);
}

sub msg($) {
	my $info = $_[0];
	return $info->{label} . ": " . $info->{x} . ", " . $info->{y};
}

sub draw_line ($$) {
	my $commit1 = $_[0];
	my $commit2 = $_[1];
	my $x1 = $commit1->{x};
	my $y1 = $commit1->{y};
	my $x2 = $commit2->{x};
	my $y2 = $commit2->{y};
	if ($y1 == $y2) {
		for (my $i = $x1 * 2 - 1; $i > $x2 * 2; $i--) {
			set_cell($i, $y1 * 2, "-");
		}
	} else {
		my $is_straight = 0;
		my $factor = ($y2 - $y1) / ($x1 - $x2);
		my $i;
		if ($x1 - $x2 == $y2 - $y1) {
			$is_straight = 1;
			for ($i = $x1 * 2 - 1; $i > $x2 * 2; $i -= 2) {
				my $y = $y1 * 2 + ($x1 * 2 - $i) * $factor;
				my $c = get_cell($i, int($y));
				if ($c ne ' ' && $c ne '-') {
					$is_straight = 0;
				}
			}
		}
		if ($is_straight) {
			for ($i = $x1 * 2 - 1; $i > $x2 * 2; $i--) {
				my $y = $y1 * 2 + ($x1 * 2 - $i) * $factor;
				my $c = (get_cell($i, int($y)) ne ' ') ?
					'+' : '/';
				set_cell($i, int($y), $c);
			}
		} else {
			set_cell($x1 * 2 - 1, $y1 * 2 + 1, '\'');
			for ($i = $x1 * 2 - 2; $i > $x2 * 2 + 1; $i--) {
				set_cell($i, $y1 * 2 + 1, '-');
			}
			set_cell($x2 * 2 + 1, $y1 * 2 + 1, ',');
			for ($i = $y1 * 2 + 2; $i < $y2 * 2; $i++) {
				my $c = (get_cell($x2 * 2, $i) ne ' ') ?
					'+' : '|';
				set_cell($x2 * 2, $i, $c);
			}
		}
	}
}

# draw it
for ($i = 0; $i <= $#list; $i++) {
	$info = $list[$i];
	$x = $info->{x} * 2;
	$y = $info->{y} * 2;
	set_cell ($x, $y, $info->{label});
	foreach my $parent (split / /,$info->{parents}) {
		if ($commits->{$parent}->{index} != undef) {
			draw_line($info, $commits->{$parent});
		}
	}
}

print @canvas;
