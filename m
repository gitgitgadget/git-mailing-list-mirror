From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: git-gui blametool
Date: Mon, 12 Feb 2007 21:58:33 +0530
Message-ID: <45D095B1.9070308@gmail.com>
References: <45D07A76.1070009@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090102080803070405000402"
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 17:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGe4J-0007ae-4l
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 17:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbXBLQ3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 11:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbXBLQ3c
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 11:29:32 -0500
Received: from main.gmane.org ([80.91.229.2]:57039 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964926AbXBLQ3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 11:29:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HGe3I-0005Fv-Cd
	for git@vger.kernel.org; Mon, 12 Feb 2007 17:29:16 +0100
Received: from 59.92.185.27 ([59.92.185.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 17:29:16 +0100
Received: from aneesh.kumar by 59.92.185.27 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 17:29:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.185.27
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <45D07A76.1070009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39411>

This is a multi-part message in MIME format.
--------------090102080803070405000402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
> Hi All,
> 
> I found the git-gui blame tool interface quiet confusing with the all 
> those color code. What does the color code actually mean ? A simple 
> interface would be
> 
> [ commit ] [ line number ] [ code ]
> 
> ....
> ...
> --------------------------------------
> commit details of the selected commit
> 
> 

Sine i don't have a tcl/tk reference around i update blameview to show 
the above. The patch is attached below in case you are interested.

NOTE: How do i resize the widgets in perl-gtk ? I wanted the commit 
window to be a bit larger. Any help ?

-aneesh


--------------090102080803070405000402
Content-Type: text/x-patch;
 name="blameview.perl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blameview.perl.diff"

diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blameview.perl
index 807d01f..67a0714 100755
--- a/contrib/blameview/blameview.perl
+++ b/contrib/blameview/blameview.perl
@@ -25,11 +25,13 @@ EOS
 
 my $window = Gtk2::Window->new('toplevel');
 $window->signal_connect(destroy => sub { Gtk2->main_quit });
+my $vbox = Gtk2::VBox->new();
+$vbox->set_homogeneous(0);
+$window->add($vbox);
 my $scrolled_window = Gtk2::ScrolledWindow->new;
-$window->add($scrolled_window);
+$vbox->pack_start($scrolled_window, 1, 1, 0);
 my $fileview = Gtk2::SimpleList->new(
     'Commit' => 'text',
-    'CommitInfo' => 'text',
     'FileLine' => 'text',
     'Data' => 'text'
 );
@@ -41,7 +43,26 @@ $fileview->signal_connect (row_activated => sub {
 		my ($sl, $path, $column) = @_;
 		my $row_ref = $sl->get_row_data_from_path ($path);
 		system("blameview @$row_ref[0] $fn");
-		# $row_ref is now an array ref to the double-clicked row's data.
+		});
+
+my $commitwindow = Gtk2::ScrolledWindow->new();
+$commitwindow->set_policy ('GTK_POLICY_AUTOMATIC','GTK_POLICY_AUTOMATIC');
+$vbox->pack_start($commitwindow, 1, 1, 0);
+my $commit_text = Gtk2::TextView->new();
+my $commit_buffer = Gtk2::TextBuffer->new();
+$commit_text->set_buffer($commit_buffer);
+$commitwindow->add($commit_text);
+
+$fileview->signal_connect (cursor_changed => sub {
+		my ($sl) = @_;
+		my ($path, $focus_column) = $sl->get_cursor();
+		my $row_ref = $sl->get_row_data_from_path ($path);
+		my $c_fh;
+		open($c_fh,  '-|', "git cat-file commit @$row_ref[0]")
+					or die "unable to find commit @$row_ref[0]";
+		my @buffer = <$c_fh>;
+		$commit_buffer->set_text("@buffer");
+		close($c_fh);
 		});
 
 my $fh;
@@ -50,7 +71,7 @@ open($fh, '-|', "git cat-file blob $hash:$fn")
 
 while(<$fh>) {
   chomp;
-  $fileview->{data}->[$.] = ['HEAD', '?', "$fn:$.", $_];
+  $fileview->{data}->[$.] = ['HEAD', "$fn:$.", $_];
 }
 
 my $blame;
@@ -79,8 +100,7 @@ sub flush_blame_line {
 
 	for(my $i = 0; $i < $cnt; $i++) {
 		@{$fileview->{data}->[$lno+$i-1]}[0,1,2] =
-		    (substr($commit, 0, 8), $info,
-		     $filename . ':' . ($s_lno+$i));
+		(substr($commit, 0, 8), $filename . ':' . ($s_lno+$i));
 	}
 }
 

--------------090102080803070405000402--
