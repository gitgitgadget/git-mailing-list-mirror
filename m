From: Jeff King <peff@peff.net>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 18:52:38 -0500
Message-ID: <20070127235238.GA28706@coredump.intra.peff.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <20070127201640.GA25637@coredump.intra.peff.net> <Pine.LNX.4.64.0701271432450.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 00:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAxLn-0000aD-Sw
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 00:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbXA0Xwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 27 Jan 2007 18:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbXA0Xwm
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 18:52:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3405 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751938AbXA0Xwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 18:52:41 -0500
Received: (qmail 8923 invoked from network); 27 Jan 2007 18:53:03 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Jan 2007 18:53:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Jan 2007 18:52:38 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701271432450.25027@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38006>

On Sat, Jan 27, 2007 at 02:39:30PM -0800, Linus Torvalds wrote:

> (For some reason I have never fathomed, gtk apps seem to always like=20
> adding about a mile of empty space around lines. I want my text nice =
and=20
> tight - gtk menus and text always look like it's 1=BD line spacing to=
 me.=20
> Which may be ok when you're writing a paper and want space to add you=
r=20
> scribbles and underlining etc, but not when you're looking at the scr=
een,=20
> and it just means that there's *less* space for commentary).

Yes, I spent quite a bit of time trying to correct this, but it seems t=
o
be an artifact of the GtkTreeView widget (which maybe I am abusing, but
it seems like the right thing conceptually). As the vertical spacing is
a "style" attribute, I'm not as a developer allowed to change it. You
can try this, which helps a bit (the default is '2'); put it before any
widgets are created:

Gtk2::Rc->parse_string(<<'EOS');
style "treeview_style"
{
  GtkTreeView::vertical-separator =3D 0
}
class "GtkTreeView" style "treeview_style"
EOS

But it's still pretty ugly. I'm not inclined to hack on it much more --
IMHO, a nice curses interface like tig would be much more sensible.

> Yeah. It needs the logic to coalesce consecutive file-name/line-nr=20
> entries, but even after you add a "-C" to the arguments (which really=
=20
> makes 'git-blame' quite a bit more expensive), it doesn't feel "slow"=
=2E=20

Yes, it would ideally color the blobs (try adding
$fileview->set_rules_hint(1) to get alternating line colors!). But I
don't think I can do anything that magical with their widget, which
means I get to write my own widget. Bleh.

> Just ugly ;)

:)

Here's my "final" version that looks up the committer name. It also
takes blame output on the command line:
  git-blame --incremental -C file | perl foo.pl file
I won't be working on it anymore, but if somebody wants to see an
example of some really ugly perl/gtk code, here it is.

-Peff

-- >8 --
#!/usr/bin/perl

use Gtk2 -init;
use Gtk2::SimpleList;

my $fn =3D shift or die "require filename to blame";

Gtk2::Rc->parse_string(<<'EOS');
style "treeview_style"
{
  GtkTreeView::vertical-separator =3D 0
}
class "GtkTreeView" style "treeview_style"
EOS

my $window =3D Gtk2::Window->new('toplevel');
$window->signal_connect(destroy =3D> sub { Gtk2->main_quit });
my $scrolled_window =3D Gtk2::ScrolledWindow->new;
$window->add($scrolled_window);
my $fileview =3D Gtk2::SimpleList->new(
    'Commit' =3D> 'text',
    'CommitInfo' =3D> 'text',
    'FileLine' =3D> 'text',
    'Data' =3D> 'text'
);
$scrolled_window->add($fileview);
$fileview->get_column(0)->set_spacing(0);
$fileview->set_size_request(1024, 768);
$fileview->set_rules_hint(1);

open(my $fh, '<', $fn)
  or die "unable to open $fn: $!";
while(<$fh>) {
  chomp;
  $fileview->{data}->[$.] =3D ['HEAD', '?', "$fn:$.", $_];
}

Glib::IO->add_watch(fileno(STDIN), 'in', \&read_blame_line);

$window->show_all;
Gtk2->main;
exit 0;

my $buf;
sub read_blame_line {
  my $r =3D sysread(STDIN, $buf, 1024, length($buf));
  return 0 unless $r;
  while($buf =3D~ s/([^\n]*)\n//) {
    my $line =3D $1;
    $line =3D~ /^(\d+) (\d+) ([0-9a-f]+):(.*):(\d+)$/
      or die "bad blame output: $line";
    my $info =3D commitinfo($3);
    for(my $i =3D 0; $i < $2; $i++) {
      @{$fileview->{data}->[$1+$i]}[0,1] =3D
        (substr($3, 0, 8), $info, $4 . ':' . ($5+$i+1));
    }
  }
  return 1;
}

sub commitinfo {
  my $hash =3D shift;
  open(my $fh, '-|', qw(git rev-list -1 --pretty=3Draw), $hash)
    or die "unable to open git-rev-list: $!";
  while(<$fh>) {
    chomp;
    next unless /^author (.*) <.*> (\d+) ([+-]\d+)/;
    return $1 . ' ' . format_time($2, $3);
  }
}

sub format_time {
  my $time =3D shift;
  my $tz =3D shift;

  my $minutes =3D $tz < 0 ? 0-$tz : $tz;
  $minutes =3D ($minutes / 100)*60 + ($minutes % 100);
  $minutes =3D $tz < 0 ? 0-$minutes : $minutes;
  $time +=3D $minutes * 60;
  my @t =3D gmtime($time);
  return sprintf('%04d-%02d-%02d %02d:%02d:%02d %s', @t[5,4,3,2,1,0], $=
tz);
}
