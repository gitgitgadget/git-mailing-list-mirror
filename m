From: Dan Zwell <dzwell@gmail.com>
Subject: [PATCH] Color support added to git-add--interactive.
Date: Fri, 12 Oct 2007 23:13:14 -0500
Message-ID: <471045DA.5050902@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000000060506000005050401"
Cc: Jeff King <peff@peff.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	"Johannes Schindelin <Johannes.Schindelin@gmx.de>Wincent Colaiuta" 
	<win@wincent.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 06:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgYOV-00053A-CE
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 06:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXJMEOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 00:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXJMEOV
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 00:14:21 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:55953 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbXJMEOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 00:14:20 -0400
Received: by py-out-1112.google.com with SMTP id u77so1995733pyb
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 21:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        bh=VS6qM7pR9QyKXON8OALoLx/RaluBnebDIjVEldX7qeU=;
        b=lcf05PzxpJVR/5XrGO3mJkW+r/e/FXb+1/RHuYGVqHVwq0lIZ8rxiXtD/oBapzJkzwC/bC4PL5QWVk2ItNiFoZ+a3TANqbaRwPQ9SM67ybrWYjC1en8Gvu/xIS3xnSeT3TBE/fjgIb2WLXKd8jxn/36iz7/NRs+BlWxiWgtU1AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=FcJLZK/Kp2JQhzCE1TfJcLOA/c0fb2T1qNzuDn2Bi90QpR5DZtldeTsLKZunxn6uSp+kn4Lk8yUElpQmz5Fl4q+BamDnrbrEDzaHyBfECBQqJ8O+Wia3ANbyonEwkecx9h/9lnz4hD/I3x/FGEblblJ9OEJCqOhJBDMv7wENPyU=
Received: by 10.65.194.13 with SMTP id w13mr7940467qbp.1192248858907;
        Fri, 12 Oct 2007 21:14:18 -0700 (PDT)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id 3sm5591389nzf.2007.10.12.21.14.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Oct 2007 21:14:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070922)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60721>

This is a multi-part message in MIME format.
--------------000000060506000005050401
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Recently there was some talk of color for git-add--interactive, but the 
person who said he already had a patch didn't produce it.

-Reads configuration from git-config (using a new key,
  color.add-interactive), respects "auto" if called from a script
-Uses the library Term::ANSIColor, which is included with modern
  versions of perl.

There is one problem--a block is commented out, because adding the 
"--color" option to git-diff-files somehow breaks git-add--interactive, 
and I would love some help from someone who knows a little more about 
the rest of the script than I do. Also, this is the first perl I have 
written, and criticism is welcome. A gzipped patch is attached, in case 
thunderbird mangles the tabs. Feel free to replace the colors that I 
chose with something that better conforms to the "git style", if there 
is such a thing.

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index be68814..f55d787 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,18 @@

  use strict;

+my $use_color;
+my $color_config = qx(git config --get color.add-interactive);
+if ($color_config=~"true" || -t STDOUT && $color_config=~"auto") {
+	$use_color = "true";
+	require Term::ANSIColor;
+}
+sub print_ansi_color {
+	if ($use_color) {
+		print Term::ANSIColor::color($_[0]);
+	}
+}
+
  sub run_cmd_pipe {
  	if ($^O eq 'MSWin32') {
  		my @invalid = grep {m/[":*]/} @_;
@@ -175,7 +187,9 @@ sub list_and_choose {
  			if (!$opts->{LIST_FLAT}) {
  				print "     ";
  			}
+			print_ansi_color "bold";
  			print "$opts->{HEADER}\n";
+			print_ansi_color "clear";
  		}
  		for ($i = 0; $i < @stuff; $i++) {
  			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -205,7 +219,9 @@ sub list_and_choose {

  		return if ($opts->{LIST_ONLY});

+		print_ansi_color "bold blue";
  		print $opts->{PROMPT};
+		print_ansi_color "reset";
  		if ($opts->{SINGLETON}) {
  			print "> ";
  		}
@@ -338,6 +354,16 @@ sub add_untracked_cmd {

  sub parse_diff {
  	my ($path) = @_;
+	# FIXME: the following breaks git, and I'm not sure why. When
+	# the following is uncommented, git no longer asks whether we
+	# want to add given hunks.
+	#my @diff;
+	#if ($use_color) {
+	#    #@diff = run_cmd_pipe(qw(git diff-files --color -p --), $path);
+	#}
+	#else {
+	#    #@diff = run_cmd_pipe(qw(git diff-files -p --), $path);
+	#}
  	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
  	my (@hunk) = { TEXT => [] };

@@ -544,6 +570,7 @@ sub coalesce_overlapping_hunks {
  }

  sub help_patch_cmd {
+	print_ansi_color "blue";
  	print <<\EOF ;
  y - stage this hunk
  n - do not stage this hunk
@@ -555,6 +582,7 @@ k - leave this hunk undecided, see previous 
undecided hunk
  K - leave this hunk undecided, see previous hunk
  s - split the current hunk into smaller hunks
  EOF
+	print_ansi_color "clear";
  }

  sub patch_update_cmd {
@@ -619,7 +647,9 @@ sub patch_update_cmd {
  		for (@{$hunk[$ix]{TEXT}}) {
  			print;
  		}
+		print_ansi_color "bold";
  		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print_ansi_color "reset";
  		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
-- 
1.5.3.4.207.gc0ee

Dan Zwell

--------------000000060506000005050401
Content-Type: application/gzip;
 name="Color-add-interactive.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="Color-add-interactive.patch.gz"

H4sICI9DEEcAA0NvbG9yLWFkZC1pbnRlcmFjdGl2ZS5wYXRjaACdVvFT2kgU/pn8Fe+QKVgI
JEAAo1WcqlfnVDqFTntnKbNJNmRrSOImkXI2/dvv7SZU9LA3PccRsvvet+9979svnvFwAVa3
Yxl6t2v1dduimmMRd89y9toW6fYc23J6mt7pD6wuXIYBjGkEeh80zZS/0NY0XTlDGBNOSAB/
Lanvw4Hzt/gczheE+U07XBwqJyShJpxx1gC9DSM7EZl9aLdNvWPqXVA1Q9OUcWp9oXZiwvXb
48nrN1N4HfohhziNopAnQByHOpCEMGeJig+qyoKEcmIn7I42FUV9R4kTgx0GLpunnCQMK3ZF
jyIhX4ZaGrNgDgQCuoQbumoomICnNAXgBt5uAziNIywnhjJJk7AMzAWb+D7WIEEJxDZnUaKo
72MaQ+JR8JnFCV/BhPKFaR5fjc9lBw1Yesz2gMXAAttPRRtLlniwCB3KAwXuKI+x2BhCFyLK
fWzGYa4LqoqVA2ltbVgEgvX8nsICh34Fi/YGA73bbLqG4fQHfdCRecNQVFX9GbJSr9d/ij4c
gtpu9KDebugDGA4VUCCNKcQJZ3ayj4/1xQoquDSTBO/nz/L7rBjGK7j9WhMtFs/YL02emQfm
4wBqjwBefS8nPKVl+PYN1ATGk5PR+wm8eAFPo+QAd+FeqZceKsLj83SELnF6mzJOn44OtzKl
HqcWRByrmZEgZkW2AJMV/QDMDyjJyKdApilDapXZtTYVzZQyCa2AAOdpMLMXzixiEUUQyIE/
j4DeQvVy/IEFnXZ1V+6UkMUhC+6IzxzsYM7xSt4vWtdl8+W0lcFwti9Ho/eNRh/q+qDf2MPp
yFN8FosOnJnthWGcH1SSR/1WCaMkVg/vL87Hk9nZxfEkK05bt1MG8YNUibVMtFn6FyNlK/Sd
IqTIWuO+OT0+OX2XfQok2dtybZ8Snidn4o+Li7UKwxa1fcDPAxjGSeq64qFeX1cnJeVhMwEG
Ft+uK2wKR1B9WQUTqlDNCWlrkpC2vvdTQgQqp0nKA5Az2ORldHXxZ7Yrpf1c92D5UlCwZmAN
8Pbd6PLtJNvfnopWQ5M8bfPU8fnV7xenk9HVj2kUtB7CminRWqczEBexY3Qbem/dG96fWRok
eH1uqCPElXcnpUw4SlY6jEBFDmuViCTeLnIo9FMv7cDZ+cfLU1O6mhv6frgUrmlxSm5iYacN
QNrgvLqAIEwQFG/O0ls14YNHA5n/OBGdLw3wTbCgeKOdhkDARPDDYE45kBhBlx7FHA5LKvOX
BPtEr8c2MPoO5+ulwU3cFJviBojqZaXbruCO0OqOjMGWNi9X7XYpDUdsqS7z0bhVNR+CGuFX
tP2cCoktdL5DfamMX0Xdhia5/p8A+ZyGggUxp3uYnH6cwKtDuJ5CJjQplGB0u0IJRl9DrRdC
sEOCeDadhfia8UkU4UBmkkwx/WwtCo/60QzPsr1CLPVtEl+rO9fhwcGn09EZ4MIKVHR+Mqc4
eBy2gFcgwEUnzBXyZE8Waxiy2EE7L/YGw9EE7jbiUDUOtZkjNBNTiiZM71iYxg/rxVF//EJu
nhGLiiMfSRdStVPOUZt5IrYWQrwQ73qey04B7HMrIz9sK3u4XYLDNHLwf56CStFtD40H/afX
3TDkLaFr5xveV8TJ6GVfp/di1NljDyiu/7NGtOlB5fFj9uF61QpapOVUQnHlWkfTIyj/tzMJ
r/VZQFF9B/iqPb86fDAssb678UIpAr9D6/OqxcQO/ruh6E2j2Wl2m22t35zbGqWK8g8a/vWD
hAoAAA==
--------------000000060506000005050401--
