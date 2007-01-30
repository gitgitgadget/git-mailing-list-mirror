From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] blameview: Support browsable functionality to blameview.
Date: Tue, 30 Jan 2007 13:26:50 +0530
Message-ID: <45befa66.29cc817d.6c37.ffffa9bc@mx.google.com>
References: <11701438112263-git-send-email-> <11701438241247-git-send-email->
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 08:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnsp-0000RL-Q0
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965437AbXA3H53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965443AbXA3H53
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:57:29 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:65169 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965437AbXA3H51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:57:27 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1581318nze
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:57:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:x-mailer:in-reply-to:references:message-id;
        b=gDne1n1DDPywJQbE9op/jkGES7DyaG3/uCLINi9xWqW7ZzYxQ55ToK4TJ40HNZvvMsTH15M/VJ8hRPp3TS6kqU73JkfdPYTaMBeffpQo2I7IoJbW15pTDR7o6E7RBjNqJ1oHvzNWEAOeILQr8L6sw7g40OM4GJ49DCK5du9UM9A=
Received: by 10.35.93.1 with SMTP id v1mr14590467pyl.1170143847006;
        Mon, 29 Jan 2007 23:57:27 -0800 (PST)
Received: from localhost ( [59.92.165.143])
        by mx.google.com with ESMTP id a70sm7287188pye.2007.01.29.23.57.22;
        Mon, 29 Jan 2007 23:57:26 -0800 (PST)
X-Mailer: git-send-email 1.5.0.rc2.75.gdbaa0-dirty
In-Reply-To: <11701438241247-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38131>

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com> - unquoted

Double clicking on the row  exec a new blameview with commit hash
as argument.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/blameview/blameview.perl |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blameview.perl
index 8261e47..8ad9bcf 100755
--- a/contrib/blameview/blameview.perl
+++ b/contrib/blameview/blameview.perl
@@ -3,7 +3,17 @@
 use Gtk2 -init;
 use Gtk2::SimpleList;
 
-my $fn = shift or die "require filename to blame";
+my $hash;
+my $fn;
+if ( @ARGV == 1 ) {
+	$hash = "HEAD";
+	$fn = shift;
+} elsif ( @ARGV == 2 ) {
+	$hash = shift;
+	$fn = shift;
+} else {
+	die "Usage blameview [<rev>] <filename>";
+}
 
 Gtk2::Rc->parse_string(<<'EOS');
 style "treeview_style"
@@ -27,17 +37,24 @@ $scrolled_window->add($fileview);
 $fileview->get_column(0)->set_spacing(0);
 $fileview->set_size_request(1024, 768);
 $fileview->set_rules_hint(1);
+$fileview->signal_connect (row_activated => sub {
+		my ($sl, $path, $column) = @_;
+		my $row_ref = $sl->get_row_data_from_path ($path);
+		system("blameview @$row_ref[0] $fn");
+		# $row_ref is now an array ref to the double-clicked row's data.
+		});
 
 my $fh;
-open($fh, '-|', "git cat-file blob HEAD:$fn")
+open($fh, '-|', "git cat-file blob $hash:$fn")
   or die "unable to open $fn: $!";
+
 while(<$fh>) {
   chomp;
   $fileview->{data}->[$.] = ['HEAD', '?', "$fn:$.", $_];
 }
 
 my $blame;
-open($blame, '-|', qw(git blame --incremental --), $fn)
+open($blame, '-|', qw(git blame --incremental --), $fn, $hash)
     or die "cannot start git-blame $fn";
 
 Glib::IO->add_watch(fileno($blame), 'in', \&read_blame_line);
-- 
1.5.0.rc2.75.gdbaa0-dirty
