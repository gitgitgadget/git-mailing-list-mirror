From: Junio C Hamano <junkio@cox.net>
Subject: Re: Adding color to git diff output.
Date: Tue, 11 Apr 2006 23:19:28 -0700
Message-ID: <7v8xqb48pb.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
	<7virpf4sg4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
	<BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 08:19:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTYhX-0000MH-F8
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 08:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWDLGTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 02:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWDLGTe
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 02:19:34 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:217 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750939AbWDLGTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 02:19:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060412061930.BFBP24539.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Apr 2006 02:19:30 -0400
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 11 Apr 2006 20:38:41 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18626>

sean <seanlkml@sympatico.ca> writes:

> What I have is a script ~/bin/gitcdiff:
>
> #!/bin/sh
> tty -s <&1 || exec cat
> colordiff | less -RS
>
> And then setting GIT_DIFF_PAGER="~/bin/gitcdiff".  When piping to a file 
> it just uses cat, but when the output is a terminal device it uses the 
> colordiff.
>
> I thought about integrating that logic into git-diff.sh, but i'm not sure
> it's always appropriate.

What Linus posted seems sensible.  And here is a hacked version
that is git-aware ;-).

-- >8 --
Subject: [PATCH] Add colordiff for git to contrib/colordiff.

I hacked it up to teach it the git extended diff headers, made
it not to read the whole patch in the array.

Also, the original program, when arguments are given, ran "diff"
with the given arguments and showed the output from it.  Of
course, I changed it to run "git diff" ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 contrib/colordiff/README         |    2 
 contrib/colordiff/colordiff.perl |  196 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+), 0 deletions(-)
 create mode 100644 contrib/colordiff/README
 create mode 100755 contrib/colordiff/colordiff.perl

2ee04989119dd5c00e066f740efb8f2155d81ede
diff --git a/contrib/colordiff/README b/contrib/colordiff/README
new file mode 100644
index 0000000..2678fdf
--- /dev/null
+++ b/contrib/colordiff/README
@@ -0,0 +1,2 @@
+This is "colordiff" (http://colordiff.sourceforge.net/) by Dave
+Ewart <davee@sungate.co.uk>, modified specifically for git.
diff --git a/contrib/colordiff/colordiff.perl b/contrib/colordiff/colordiff.perl
new file mode 100755
index 0000000..37c3559
--- /dev/null
+++ b/contrib/colordiff/colordiff.perl
@@ -0,0 +1,196 @@
+#!/usr/bin/perl -w
+# 
+# $Id: colordiff.pl,v 1.4.2.10 2004/01/04 15:02:59 daveewart Exp $
+
+########################################################################
+#                                                                      #
+# ColorDiff - a wrapper/replacment for 'diff' producing                #
+#             colourful output                                         #
+#                                                                      #
+# Copyright (C)2002-2004 Dave Ewart (davee@sungate.co.uk)              #
+#                                                                      #
+########################################################################
+#                                                                      #
+# This program is free software; you can redistribute it and/or modify #
+# it under the terms of the GNU General Public License as published by #
+# the Free Software Foundation; either version 2 of the License, or    #
+# (at your option) any later version.                                  #
+#                                                                      #
+# This program is distributed in the hope that it will be useful,      #
+# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
+# GNU General Public License for more details.                         #
+#                                                                      #
+# You should have received a copy of the GNU General Public License    #
+# along with this program; if not, write to the Free Software          #
+# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.            #
+#                                                                      #
+########################################################################
+
+use strict;
+use Getopt::Long qw(:config pass_through);
+use IPC::Open2;
+
+my $app_name     = 'colordiff';
+my $version      = '1.0.4';
+my $author       = 'Dave Ewart';
+my $author_email = 'davee@sungate.co.uk';
+my $app_www      = 'http://colordiff.sourceforge.net/';
+my $copyright    = '(C)2002-2004';
+my $show_banner  = 1;
+
+# ANSI sequences for colours
+my %colour;
+$colour{white}       = "\033[1;37m";
+$colour{yellow}      = "\033[1;33m";
+$colour{green}       = "\033[1;32m";
+$colour{blue}        = "\033[1;34m";
+$colour{cyan}        = "\033[1;36m";
+$colour{red}         = "\033[1;31m";
+$colour{magenta}     = "\033[1;35m";
+$colour{black}       = "\033[1;30m";
+$colour{darkwhite}   = "\033[0;37m";
+$colour{darkyellow}  = "\033[0;33m";
+$colour{darkgreen}   = "\033[0;32m";
+$colour{darkblue}    = "\033[0;34m";
+$colour{darkcyan}    = "\033[0;36m";
+$colour{darkred}     = "\033[0;31m";
+$colour{darkmagenta} = "\033[0;35m";
+$colour{darkblack}   = "\033[0;30m";
+$colour{OFF}         = "\033[0;0m";
+
+# Default colours if /etc/colordiffrc or ~/.colordiffrc do not exist
+my $plain_text = $colour{OFF};
+my $file_old   = $colour{red};
+my $file_new   = $colour{blue};
+my $diff_stuff = $colour{magenta};
+
+# Locations for personal and system-wide colour configurations
+my $HOME   = $ENV{HOME};
+my $etcdir = '/etc';
+
+my ($setting, $value);
+my @config_files = ("$etcdir/colordiffrc", "$HOME/.colordiffrc");
+my $config_file;
+
+foreach $config_file (@config_files) {
+    if (open(COLORDIFFRC, "<$config_file")) {
+        while (<COLORDIFFRC>) {
+            chop;
+            next if (/^#/ || /^$/);
+            s/\s+//g;
+            ($setting, $value) = split ('=');
+            if ($setting eq 'banner') {
+                if ($value eq 'no') {
+                    $show_banner = 0;
+                }
+                next;
+            }
+            if (!defined $colour{$value}) {
+                print "Invalid colour specification ($value) in $config_file\n";
+                next;
+            }
+            if ($setting eq 'plain') {
+                $plain_text = $colour{$value};
+            }
+            elsif ($setting eq 'oldtext') {
+                $file_old = $colour{$value};
+            }
+            elsif ($setting eq 'newtext') {
+                $file_new = $colour{$value};
+            }
+            elsif ($setting eq 'diffstuff') {
+                $diff_stuff = $colour{$value};
+            }
+            else {
+                print "Unknown option in $etcdir/colordiffrc: $setting\n";
+            }
+        }
+        close COLORDIFFRC;
+    }
+}
+
+# colordiff specfic options here.  Need to pre-declare if using variables
+GetOptions(
+    "no-banner" => sub { $show_banner = 0 },
+    "plain-text=s" => \&set_color,
+    "file-old=s"   => \&set_color,
+    "file-new=s"   => \&set_color,
+    "diff-stuff=s" => \&set_color
+);
+
+if ($show_banner == 1) {
+    print STDERR "$app_name $version ($app_www)\n";
+    print STDERR "$copyright $author, $author_email\n\n";
+}
+
+if (defined $ARGV[0]) {
+    # More reliable way of pulling in arguments
+    open2(\*INPUTSTREAM, undef, "git", "diff", @ARGV);
+}
+else {
+    *INPUTSTREAM = \*STDIN;
+}
+
+my $record;
+my $nrecs           = 0;
+my $inside_file_old = 1;
+my $nparents        = undef;
+
+while (<INPUTSTREAM>) {
+    $nrecs++;
+    if (/^(\@\@+) -[-+0-9, ]+ \1/) {
+	    print "$diff_stuff";
+	    $nparents = length($1) - 1;
+    }
+    elsif (/^diff -/ || /^index / ||
+	   /^old mode / || /^new mode / ||
+	   /^deleted file mode / || /^new file mode / ||
+	   /^similarity index / || /^dissimilarity index / ||
+	   /^copy from / || /^copy to / ||
+	   /^rename from / || /^rename to /) {
+	    $nparents = undef;
+	    print "$diff_stuff";
+    }
+    elsif (defined $nparents) {
+	    if ($nparents == 1) {
+		    if (/^\+/) {
+			    print $file_new;
+		    }
+		    elsif (/^-/) {
+			    print $file_old;
+		    }
+		    else {
+			    print $plain_text;
+		    }
+	    }
+	    elsif (/^ {$nparents}/) {
+		    print "$plain_text";
+	    }
+	    elsif (/^[+ ]{$nparents}/) {
+		    print "$file_new";
+	    }
+	    elsif (/^[- ]{$nparents}/) {
+		    print "$file_old";
+	    }
+	    else {
+		    print $plain_text;
+	    }
+    }
+    elsif (/^--- / || /^\+\+\+ /) {
+	    print $diff_stuff;
+    }
+    else {
+	    print "$plain_text";
+    }
+    s/$/$colour{OFF}/;
+    print "$_";
+}
+close INPUTSTREAM;
+
+sub set_color {
+    my ($type, $color) = @_;
+
+    $type =~ s/-/_/;
+    eval "\$$type = \$colour{$color}";
+}
-- 
1.3.0.rc3.g72c1
