From: Jeff King <peff@peff.net>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 15:16:41 -0500
Message-ID: <20070127201640.GA25637@coredump.intra.peff.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 21:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAtyg-00083F-IO
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 21:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXA0UQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXA0UQn
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 15:16:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2928 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751453AbXA0UQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 15:16:43 -0500
Received: (qmail 1182 invoked from network); 27 Jan 2007 15:17:06 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Jan 2007 15:17:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Jan 2007 15:16:41 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37996>

On Sat, Jan 27, 2007 at 09:22:50AM -0800, Linus Torvalds wrote:

> Here's a patch. Use "git blame --incremental filename" to get the blame 
> output in a nicely parseable format that you can now write a simple 
> graphical viewer for. 

And here's a (very hackish) incremental viewer using perl/gtk (you will
need the Gtk2 perl module installed). It doesn't take any options, and it
just shows the blame output (no lookup of committer/date).

It needs much work (and cleanup) to be useful, but I think it proves
your point: in the time it takes me to actually start looking through
the output, the blame has finished without me noticing!

-Peff

-- >8 --
#!/usr/bin/perl

use Gtk2 -init;
use Gtk2::SimpleList;

my $fn = shift or die "require filename to blame";

my $window = Gtk2::Window->new('toplevel');
$window->signal_connect(destroy => sub { Gtk2->main_quit });
my $scrolled_window = Gtk2::ScrolledWindow->new;
$window->add($scrolled_window);
my $fileview = Gtk2::SimpleList->new(
    'Commit' => 'text',
    'FileLine' => 'text',
    'Data' => 'text'
);
$scrolled_window->add($fileview);
$fileview->get_column(0)->set_spacing(0);
$fileview->set_size_request(1024, 768);

open(my $fh, '<', $fn)
  or die "unable to open $fn: $!";
while(<$fh>) {
  chomp;
  $fileview->{data}->[$.] = ['HEAD', "$fn:$.", $_];
}

open(my $blame, '-|', qw(git blame --incremental), $fn)
  or die "unable to open git blame: $!";
Glib::IO->add_watch(fileno($blame), 'in', \&read_blame_line);

$window->show_all;
Gtk2->main;
exit 0;

my $buf;
sub read_blame_line {
  my $r = sysread($blame, $buf, 1024, length($buf));
  return 0 unless $r;
  while($buf =~ s/([^\n]*)\n//) {
    my $line = $1;
    $line =~ /^(\d+) (\d+) ([0-9a-f]+):(.*):(\d+)$/
      or die "bad blame output: $line";
    for(my $i = 0; $i < $2; $i++) {
      @{$fileview->{data}->[$1+$i]}[0,1] =
        (substr($3, 0, 8), $4 . ':' . ($5+$i+1));
    }
  }
  return 1;
}
