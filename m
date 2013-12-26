From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH] git-svn: workaround for a bug in svn serf backend
Date: Thu, 26 Dec 2013 16:05:24 +0400
Message-ID: <1388059524-4864-1-git-send-email-rkagan@mail.ru>
References: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Cc: Thomas Rast <tr@thomasrast.ch>, Roman Kagan <rkagan@mail.ru>,
	Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 13:14:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vw9ny-0002ni-2A
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 13:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab3LZMMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 07:12:42 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:23685 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab3LZMMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 07:12:41 -0500
Received: from rkaganb.sw.ru ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id rBQC5VOj013734;
	Thu, 26 Dec 2013 16:05:36 +0400 (MSK)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239690>

Subversion serf backend in versions 1.8.5 and below has a bug that the
function creating the descriptor of a file change -- add_file() --
doesn't make a copy of its 3d argument when storing it on the returned
descriptor.  As a result, by the time this field is used (in
transactions of file copying or renaming) it may well be released.

This patch works around this bug, by storing the value to be passed as
the 3d argument to add_file() in a local variable with the same scope as
the file change descriptor, making sure their lifetime is the same.

Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Roman Kagan <rkagan@mail.ru>
---
 perl/Git/SVN/Editor.pm | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index b3bcd47..ae399c3 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -304,8 +304,12 @@ sub C {
 	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir, $deletions);
+	# workaround for a bug in svn serf backend (v1.8.5 and below):
+	# store 3d argument to ->add_file() in a local variable, to make it
+	# have the same lifetime as $fbat
+	my $upa = $self->url_path($m->{file_a});
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
-				$self->url_path($m->{file_a}), $self->{r});
+				$upa, $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
@@ -323,8 +327,10 @@ sub R {
 	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir, $deletions);
+	# workaround for a bug in svn serf backend, see comment in C() above
+	my $upa = $self->url_path($m->{file_a});
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
-				$self->url_path($m->{file_a}), $self->{r});
+				$upa, $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
 	$self->chg_file($fbat, $m);
-- 
1.8.4.2
