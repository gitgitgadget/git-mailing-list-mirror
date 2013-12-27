From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Fri, 27 Dec 2013 12:05:15 +0400
Message-ID: <1388131515-3015-1-git-send-email-rkagan@mail.ru>
References: <20131226202805.GV20443@google.com>
Cc: Roman Kagan <rkagan@mail.ru>,
	Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 27 09:06:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwSQp-0001Lm-K6
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 09:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab3L0IFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 03:05:47 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:42268 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab3L0IFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 03:05:47 -0500
Received: from rkaganb.sw.ru ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id rBR85Wgw015805;
	Fri, 27 Dec 2013 12:05:37 +0400 (MSK)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <20131226202805.GV20443@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239722>

Subversion serf backend in versions 1.8.5 and below has a bug that the
function creating the descriptor of a file change -- add_file() --
doesn't make a copy of its third argument when storing it on the
returned descriptor.  As a result, by the time this field is used (in
transactions of file copying or renaming) it may well be released, and
the memory reused.

One of its possible manifestations is the svn assertion triggering on an
invalid path, with a message

svn_fspath__skip_ancestor: Assertion
`svn_fspath__is_canonical(child_fspath)' failed.

This patch works around this bug, by storing the value to be passed as
the third argument to add_file() in a local variable with the same scope
as the file change descriptor, making sure their lifetime is the same.

Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Roman Kagan <rkagan@mail.ru>
---
changes since v1:
  - fix grammar in the patch and the log message
  - refer to the triggered error message

 perl/Git/SVN/Editor.pm | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index b3bcd47..34e8af9 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -304,8 +304,12 @@ sub C {
 	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir, $deletions);
+	# workaround for a bug in svn serf backend (v1.8.5 and below):
+	# store third argument to ->add_file() in a local variable, to make it
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
