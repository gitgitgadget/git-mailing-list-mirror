From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH (try 2)] git-svn: fix "Malformed network data" with svn:// servers
Date: Fri, 7 Sep 2007 04:00:40 -0700
Message-ID: <20070907110040.GA9369@mayonaise>
References: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org> <20070704210526.GA9582@muzzle> <20070807134220.23420.qmail@c96e4a6cce1e57.315fe32.mid.smarden.org> <20070907073424.GA16468@mayonaise> <20070907100711.GA24166@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 430091@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbZw-0008SL-4p
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbXIGLAn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 07:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbXIGLAn
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:00:43 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33341 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965123AbXIGLAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 07:00:42 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C6AF32DC08D;
	Fri,  7 Sep 2007 04:00:40 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 07 Sep 2007 04:00:40 -0700
Content-Disposition: inline
In-Reply-To: <20070907100711.GA24166@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58023>

We have a workaround for the reparent function not working
correctly on the SVN native protocol servers.  This workaround
opens a new connection (SVN::Ra object) to the new
URL/directory.

Since libsvn appears limited to only supporting one connection
at a time, this workaround invalidates the Git::SVN::Ra object
that is $self inside gs_fetch_loop_common().  So we need to
restart that connection once all the fetching is done for each
loop iteration to be able to run get_log() successfully.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d3c8cd0..fbd4691 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3013,7 +3013,7 @@ package Git::SVN::Ra;
 use vars qw/@ISA $config_dir $_log_window_size/;
 use strict;
 use warnings;
-my ($can_do_switch, %ignored_err, $RA);
+my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
 
 BEGIN {
 	# enforce temporary pool usage for some simple functions
@@ -3174,7 +3174,11 @@ sub gs_do_switch {
 			$self->{url} = $full_url;
 			$reparented = 1;
 		} else {
+			$_[0] = undef;
+			$self = undef;
+			$RA = undef;
 			$ra = Git::SVN::Ra->new($full_url);
+			$ra_invalid = 1;
 		}
 	}
 	$ra ||= $self;
@@ -3234,6 +3238,7 @@ sub gs_fetch_loop_common {
 	my $inc = $_log_window_size;
 	my ($min, $max) = ($base, $head < $base + $inc ? $head : $base + $inc);
 	my $longest_path = longest_common_path($gsv, $globs);
+	my $ra_url = $self->{url};
 	while (1) {
 		my %revs;
 		my $err;
@@ -3295,6 +3300,13 @@ sub gs_fetch_loop_common {
 				        "$g->{t}-maxRev";
 				Git::SVN::tmp_config($k, $r);
 			}
+			if ($ra_invalid) {
+				$_[0] = undef;
+				$self = undef;
+				$RA = undef;
+				$self = Git::SVN::Ra->new($ra_url);
+				$ra_invalid = undef;
+			}
 		}
 		# pre-fill the .rev_db since it'll eventually get filled in
 		# with '0' x40 if something new gets committed
-- 
Eric Wong
