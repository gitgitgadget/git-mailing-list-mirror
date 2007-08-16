From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
	scripts/get_maintainer.pl
Date: Thu, 16 Aug 2007 13:36:55 -0700
Message-ID: <1187296616.5906.100.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost>
	 <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 22:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILm67-0001aP-Ou
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 22:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008AbXHPUhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 16:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756663AbXHPUhO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 16:37:14 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:3157 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbXHPUhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 16:37:11 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id NAA01588;
	Thu, 16 Aug 2007 13:58:33 -0700
In-Reply-To: <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56031>

On Tue, 2007-08-14 at 11:40 -0700, Linus Torvalds wrote:
> Do a script like this:
> 
> 	#!/bin/sh
> 	git log --since=6.months.ago -- "$@" |
> 		grep -i '^    [-a-z]*by:.*@' |
> 		sort | uniq -c |
> 		sort -r -n | head
> (Maybe you want to add a
> 	grep -v '\(Linus Torvalds\)\|\(Andrew Morton\)'
> to avoid seeing the normal chain too much, but hey, we probably want to 
> know too. Anyway - the script can certainly be tweaked, the point is 
> really just that the git tree _already_ contains the relevant 
> information).

So, here's the same get_maintainer.pl with the git
addition.  Seems to work well in combination with MAINTAINERS.

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
new file mode 100755
index 0000000..eb3f023
--- /dev/null
+++ b/scripts/get_maintainer.pl
@@ -0,0 +1,351 @@
+#!/usr/bin/perl -w
+# (c) 2007, Joe Perches <joe@perches.com>
+#           created from checkpatch.pl
+#
+# Print the contact information for the maintainers
+# of the files modified in a patch
+#
+# usage: perl scripts/get_maintainers.pl <patch>
+#
+# Licensed under the terms of the GNU GPL License version 2
+
+use strict;
+
+my $P = $0;
+$P =~ s@.*/@@g;
+
+my $V = '0.06';
+
+use Getopt::Long qw(:config no_auto_abbrev);
+
+my $tree = "./";
+my $email_maintainer = 1;
+my $email_usename = 1;
+my $email_list = 1;
+my $email_subscriber_list = 0;
+my $email_separator = ", ";
+my $email_git = 1;
+my $email_git_chief_penguins = 0;
+my $email_multiline = 0;
+my %saw;
+
+my $chief_penguins = "(Linus Torvalds|Andrew Morton)";
+
+GetOptions(
+	   'tree=s' => \$tree,
+	   'git!' => $email_git,
+	   'git-chief-penguins' => \$email_git_chief_penguins,
+	   'm!' => \$email_maintainer,
+	   'n!' => \$email_usename,
+	   'l!' => \$email_list,
+	   's!' => \$email_subscriber_list,
+	   'multiline!' => \$email_multiline,
+	   'separator=s' => \$email_separator,
+	   ) or exit;
+
+my $exit = 0;
+
+if ($#ARGV < 0 ||
+    ($email_maintainer == 0
+     && $email_list == 0
+     && $email_subscriber_list == 0
+     && $email_git == 0)) {
+    print "usage: $P [options] patchfile\n";
+    print "version: $V\n";
+    print "  --tree [path] => linux kernel source path\n";
+    print "  --git => include recent git \*-by: signers\n";
+    print "  --git_chief_penguins => include ${chief_penguins}\n";
+    print "  --m => include maintainer(s) if any\n";
+    print "  --n => include name 'Full Name <addr\@domain.tld>'\n";
+    print "  --l => include list(s) if any\n";
+    print "  --s => include subscriber only list(s) if any\n";
+    print "  --separator [, ] => separator for multiple addresses on 1 line\n";
+    print "  --multiline => print 1 address per line\n";
+    print "Default: [--g --m --l --separator \", \"]\n";
+    print "Be sure to select something...\n";
+    exit(1);
+}
+
+if ($tree && !top_of_kernel_tree($tree)) {
+    if (${tree} ne "") {
+	print "'${tree}' ";
+    } else {
+	print "The current directory ";
+    }
+    print "doesn't appear to be a linux kernel source tree\n";
+    exit(2);
+}
+
+## Read MAINTAINERS for type/value pairs
+
+my @typevalue = ();
+open(MAINT, "<${tree}MAINTAINERS") || die "$P: Can't open ${tree}MAINTAINERS\n";
+while (<MAINT>) {
+    if (m/^(\C):\s*(.*)/) {
+	my $type = $1;
+	my $value = $2;
+
+	##Filename pattern matching
+	if ($type eq "F" || $type eq "X") {
+	    $value =~ s@\.@\\\.@g;       ##Convert . to \.
+	    $value =~ s/\*/\.\*/g;       ##Convert * to .*
+	}
+	push(@typevalue, "$type:$value");
+    } elsif (!/^(\s)*$/) {
+	push(@typevalue, $_);
+    }
+}
+close(MAINT);
+
+## Find the patched filenames
+
+my @patchedfiles = ();
+open(PATCH, "<$ARGV[0]") or die "Can't open $ARGV[0]\n";
+while (<PATCH>) {
+    if (m/^\+\+\+\s+(\S+)/) {
+	my $file = $1;
+	$file =~ s@^[^/]*/@@;
+	$file =~ s@\n@@;
+	push(@patchedfiles, $file);
+    }
+}
+close(PATCH);
+
+# Sort and uniq patchedfiles
+
+undef %saw;
+@patchedfiles = sort @patchedfiles;
+@patchedfiles = grep(!$saw{$_}++, @patchedfiles);
+
+# Find responsible parties
+
+my @email_to = ();
+foreach (@patchedfiles) {
+    my $patchedfile = $_;
+    my $exclude = 0;
+
+#Git
+
+    recent_git_signoffs($patchedfile);
+
+#Do not match excluded file patterns
+
+    foreach (@typevalue) {
+	if (m/^(\C):(.*)/) {
+	    my $type = $1;
+	    my $value = $2;
+	    if ($type eq 'X') {
+		if (file_match_pattern($patchedfile, $value)) {
+		    $exclude = 1;
+		}
+	    }
+	}
+    }
+
+    if ($exclude == 0) {
+	my $tvi = 0;
+	foreach (@typevalue) {
+	    if (m/^(\C):(.*)/) {
+		my $type = $1;
+		my $value = $2;
+		if ($type eq 'F') {
+		    if (file_match_pattern($patchedfile, $value)) {
+			add_emails($tvi);
+		    }
+		}
+	    }
+	    $tvi++;
+	}
+    }
+}
+
+## sort and uniq email_to
+
+@email_to = sort @email_to;
+undef %saw;
+@email_to = grep(!$saw{$_}++, @email_to);
+
+## add lk if no one is interested...
+
+my $address_cnt = @email_to;
+if ($address_cnt == 0 && $email_list > 0) {
+    push(@email_to, "linux-kernel\@vger.kernel.org");
+}
+if ($email_multiline != 0) {
+    foreach (@email_to) {
+	print("$_\n");
+    }
+} else {
+    print(join($email_separator, @email_to));
+    print("\n");
+}
+
+exit($exit);
+
+sub file_match_pattern {
+    my ($file, $pattern) = @_;
+    if (substr($pattern, -1) eq "/") {
+	if ($file =~ m@^$pattern@) {
+	    return 1;
+	}
+    } else {
+	if ($file =~ m@^$pattern@) {
+	    my $s1 = ($file =~ tr@/@@);
+	    my $s2 = ($pattern =~ tr@/@@);
+	    if ($s1 == $s2) {
+		return 1;
+	    }
+	}
+    }
+    return 0;
+}
+
+sub top_of_kernel_tree {
+	my ($tree) = @_;
+
+	if ($tree ne "" && substr($tree,length($tree)-1,1) ne "/") {
+	    $tree = $tree . "/";
+	}
+	if (   (-f "${tree}COPYING")
+	    && (-f "${tree}CREDITS")
+	    && (-f "${tree}Kbuild")
+	    && (-f "${tree}MAINTAINERS")
+	    && (-f "${tree}Makefile")
+	    && (-f "${tree}README")
+	    && (-d "${tree}Documentation")
+	    && (-d "${tree}arch")
+	    && (-d "${tree}include")
+	    && (-d "${tree}drivers")
+	    && (-d "${tree}fs")
+	    && (-d "${tree}init")
+	    && (-d "${tree}ipc")
+	    && (-d "${tree}kernel")
+	    && (-d "${tree}lib")
+	    && (-d "${tree}scripts")) {
+		return 1;
+	}
+	return 0;
+}
+
+sub format_email {
+    my ($name, $email) = @_;
+    my $formatted_email = $name;
+
+    if ($name =~ /[^a-z0-9 \.\-]/i) {    ##has "must quote" chars
+	$name =~ s/(?<!\\)"/\\"/g;       ##escape quotes
+	$formatted_email = "\"${name}\"\ \<${email}\>";
+    } else {
+	$formatted_email = "${name} \<${email}\>";
+    }
+    return $formatted_email;
+}
+
+sub add_emails {
+    my ($index) = @_;
+
+    $index = $index - 1;
+    while ($index >= 0) {
+	my $tv = $typevalue[$index];
+	if ($tv =~ m/^(\C):(.*)/) {
+	    my $ptype = $1;
+	    my $pvalue = $2;
+	    if ($ptype eq "L") {
+		my $subscr = $pvalue;
+		if ($subscr =~ m/\s*\(subscribers-only\)/) {
+		    if ($email_subscriber_list > 0) {
+			$subscr =~ s/\s*\(subscribers-only\)//g;
+			push(@email_to, $subscr);
+		    }
+		} else {
+		    if ($email_list > 0) {
+			push(@email_to, $pvalue);
+		    }
+		}
+	    } elsif ($ptype eq "M") {
+		if ($email_maintainer > 0) {
+		    if ($index >= 0) {
+			my $tv = $typevalue[$index - 1];
+			if ($tv =~ m/^(\C):(.*)/) {
+			    if ($1 eq "P" && $email_usename > 0) {
+				push(@email_to, format_email($2, $pvalue));
+			    } else {
+				push(@email_to, $pvalue);
+			    }
+			}
+		    } else {
+			push(@email_to, $pvalue);
+		    }
+		}
+	    }
+	    $index--;
+	} else {
+	    $index = -1;
+	}
+    }
+}
+
+sub which {
+    my ($bin) = @_;
+
+    my $path;
+
+    foreach $path (split /:/, $ENV{PATH}) {
+	if (-e "$path/$bin") {
+	    return "$path/$bin";
+	}
+    }
+    
+    return "";
+}
+
+sub recent_git_signoffs {
+    my ($file) = @_;
+
+    my $sign_offs = "";
+    my $cmd = "";
+    my $output = "";
+
+    my @lines = ();
+
+    if (which("git") eq "") {
+	die("Git not found\n");
+    }
+
+# Search the git logs for "by:" lines per file
+# sort in reverse order by occurance
+# add at most 5
+
+    $cmd = "git log --since=6.months.ago -- ${file} ";
+    $cmd = $cmd . " | grep -i '^    [-a-z]*by:.*\\\@' ";
+    if ($email_git_chief_penguins == 0) {
+	$cmd = $cmd . " | grep -E -v '${chief_penguins}'";
+    }
+    $cmd = $cmd . " | sort | uniq -c | sort -r -n | head -n 5";
+    $cmd = $cmd . " | cut -f 2 -d ':' -s ";
+
+    $output = `${cmd}`;
+
+    $output =~ s/^\s*//gm;
+
+    @lines = split("\n", $output);
+    foreach (@lines) {
+	my $line = $_;
+	if ($line =~ m/(.*) <(.*)>/) {
+	    my $git_name = $1;
+	    my $git_addr = $2;
+	    $git_name =~ tr/^\"//;
+	    $git_name =~ tr/\"$//;
+	    if ($email_usename > 0) {
+		push(@email_to, format_email($git_name, $git_addr));
+	    } else {
+		push(@email_to, $git_addr);
+	    }
+	} elsif ($line =~ m/<(.*)>/) {
+	    my $git_addr = $1;
+	    push(@email_to, $git_addr);
+	} else {
+	    push(@email_to, $line);
+	}
+    }
+    return $output;
+}
