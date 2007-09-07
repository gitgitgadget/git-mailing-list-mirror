From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix "Malformed network data" with svn:// servers
Date: Fri, 7 Sep 2007 00:34:24 -0700
Message-ID: <20070907073424.GA16468@mayonaise>
References: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org> <20070704210526.GA9582@muzzle> <20070807134220.23420.qmail@c96e4a6cce1e57.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 430091@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYMK-0007oA-SY
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757311AbXIGHe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbXIGHe1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:34:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33039 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804AbXIGHe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 03:34:26 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0631A2DC08D;
	Fri,  7 Sep 2007 00:34:24 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 07 Sep 2007 00:34:24 -0700
Content-Disposition: inline
In-Reply-To: <20070807134220.23420.qmail@c96e4a6cce1e57.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57997>

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

  Gerrit Pape <pape@smarden.org> wrote:
  > On Wed, Jul 04, 2007 at 02:07:42PM -0700, Eric Wong wrote:
  > >   Although this fixes blocking reads, this does *not* fix the
  > >   "Malformed network data" issue, which has been around for a
  > >   while...
  > > 
  > >   I'll try to find time to fix the "Malformed network data" bug
  > >   in a few days time, but it's not fatal (just restart git-svn,
  > >   this error happens at a point where it's not possible to have
  > >   a corrupted import).
  > 
  > Hi, this still is a problem we face on Debian with 1.5.3-rc3
  >  http://bugs.debian.org/436142
  >  http://bugs.debian.org/430091
  > 
  > I'm sorry, I didn't manage to provide a patch.

  Sorry for the latency again.

 git-svn.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d3c8cd0..7df4098 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3175,6 +3175,7 @@ sub gs_do_switch {
 			$reparented = 1;
 		} else {
 			$ra = Git::SVN::Ra->new($full_url);
+			$self->{-invalid} = 1;
 		}
 	}
 	$ra ||= $self;
@@ -3310,6 +3311,11 @@ sub gs_fetch_loop_common {
 		$min = $max + 1;
 		$max += $inc;
 		$max = $head if ($max > $head);
+		if ($self->{-invalid}) {
+			my $ra_url = $self->{url};
+			$self = undef;
+			$self = Git::SVN::Ra->new($ra_url);
+		}
 	}
 }
 
-- 
Eric Wong
