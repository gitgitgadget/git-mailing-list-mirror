From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Fwd: [PATCH] blameview: Move the commit info to a pane below the blame window.
Date: Tue, 13 Feb 2007 17:20:34 +0530
Message-ID: <cc723f590702130350x5dab5188y13a6041b5c4bd574@mail.gmail.com>
References: <11713014281257-git-send-email-aneesh.kumar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 12:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGwBE-0003Qk-4V
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 12:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXBMLuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 06:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbXBMLuh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 06:50:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:20866 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXBMLug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 06:50:36 -0500
Received: by nf-out-0910.google.com with SMTP id o25so249082nfa
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 03:50:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ka0YmYoQK/ukkl70f62qdRysDF+KwQi3e3PZxHpVxqKINqFJXVehXGZQ8N8bo+0iQ5PKNarIJ2i3Kg1wcnZwZkIIrIiivzaS2HBmlG1gZhymqVN6hY7diOg6/ApYK7WN+ydbwUfbAoTKKuzMmzVH0e+X6+swC7nbFPArZOCK8Gc=
Received: by 10.82.188.15 with SMTP id l15mr8195021buf.1171367434405;
        Tue, 13 Feb 2007 03:50:34 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Tue, 13 Feb 2007 03:50:34 -0800 (PST)
In-Reply-To: <11713014281257-git-send-email-aneesh.kumar@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39517>

Forwarding this again. Mail sent by git send-email doesn't appear in
git mailing list archive. I don't know why. I don't get any bounce
mails also.

-aneesh

---------- Forwarded message ----------
From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
Date: Feb 12, 2007 11:00 PM
Subject: [PATCH] blameview: Move the commit info to a pane below the
blame window.
To: git@vger.kernel.org
Cc: junkio@cox.net, "Aneesh Kumar K. V" <aneesh.kumar@gmail.com>


Also spawn the the new blameview in the background

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/blameview/blameview.perl |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blameview.perl
index 807d01f..a9a509f 100755
--- a/contrib/blameview/blameview.perl
+++ b/contrib/blameview/blameview.perl
@@ -25,11 +25,12 @@ EOS

 my $window = Gtk2::Window->new('toplevel');
 $window->signal_connect(destroy => sub { Gtk2->main_quit });
+my $vpan = Gtk2::VPaned->new();
+$window->add($vpan);
 my $scrolled_window = Gtk2::ScrolledWindow->new;
-$window->add($scrolled_window);
+$vpan->pack1($scrolled_window, 1, 1);
 my $fileview = Gtk2::SimpleList->new(
     'Commit' => 'text',
-    'CommitInfo' => 'text',
     'FileLine' => 'text',
     'Data' => 'text'
 );
@@ -40,8 +41,27 @@ $fileview->set_rules_hint(1);
 $fileview->signal_connect (row_activated => sub {
                my ($sl, $path, $column) = @_;
                my $row_ref = $sl->get_row_data_from_path ($path);
-               system("blameview @$row_ref[0] $fn");
-               # $row_ref is now an array ref to the double-clicked row's data.
+               system("blameview @$row_ref[0] $fn &");
+               });
+
+my $commitwindow = Gtk2::ScrolledWindow->new();
+$commitwindow->set_policy ('GTK_POLICY_AUTOMATIC','GTK_POLICY_AUTOMATIC');
+$vpan->pack2($commitwindow, 1, 1);
+my $commit_text = Gtk2::TextView->new();
+my $commit_buffer = Gtk2::TextBuffer->new();
+$commit_text->set_buffer($commit_buffer);
+$commitwindow->add($commit_text);
+
+$fileview->signal_connect (cursor_changed => sub {
+               my ($sl) = @_;
+               my ($path, $focus_column) = $sl->get_cursor();
+               my $row_ref = $sl->get_row_data_from_path ($path);
+               my $c_fh;
+               open($c_fh,  '-|', "git cat-file commit @$row_ref[0]")
+                                       or die "unable to find commit
@$row_ref[0]";
+               my @buffer = <$c_fh>;
+               $commit_buffer->set_text("@buffer");
+               close($c_fh);
                });

 my $fh;
@@ -50,7 +70,7 @@ open($fh, '-|', "git cat-file blob $hash:$fn")

 while(<$fh>) {
   chomp;
-  $fileview->{data}->[$.] = ['HEAD', '?', "$fn:$.", $_];
+  $fileview->{data}->[$.] = ['HEAD', "$fn:$.", $_];
 }

 my $blame;
@@ -79,8 +99,7 @@ sub flush_blame_line {

        for(my $i = 0; $i < $cnt; $i++) {
                @{$fileview->{data}->[$lno+$i-1]}[0,1,2] =
-                   (substr($commit, 0, 8), $info,
-                    $filename . ':' . ($s_lno+$i));
+               (substr($commit, 0, 8), $filename . ':' . ($s_lno+$i));
        }
 }

--
1.5.0.rc4.345.gb4d2-dirty
