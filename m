From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix blocking with svn:// servers after do_switch
Date: Wed, 4 Jul 2007 14:07:42 -0700
Message-ID: <20070704210526.GA9582@muzzle>
References: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 430091@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 23:07:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6C4f-0000zZ-Ak
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 23:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbXGDVHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 17:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514AbXGDVHn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 17:07:43 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57935 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931AbXGDVHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 17:07:42 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E11462DC032;
	Wed,  4 Jul 2007 14:07:40 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 04 Jul 2007 14:07:42 -0700
Content-Disposition: inline
In-Reply-To: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51642>

We now explicitly disconnect before starting new SVN::Ra
connections.  SVN::Ra objects will automatically be disconnected
from the server on DESTROY.

SVN servers seem to have problems accepting multiple connections
from one client, and the SVN library has trouble being connected
to multiple servers at once.  This appears to cause opening the
second connection to block, and cause git-svn to be unusable
after using the do_switch() function.

git-svn opens another connection because a workaround is
necesary for the buggy reparent function handling on certain
versions of svn:// and svn+ssh:// servers.  Instead of using the
reparent function (analogous to chdir), it will reopen a new
connection to a different URL on the SVN server.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  Gerrit Pape <pape@smarden.org> wrote:
  > Hi, on Debian unstable the current version of libsvn-perl is 1.4.4dfsg1.
  > With this version git-svn uses do_switch instead of do_update, which
  > seems to not work properly, please see
  > 
  >  http://bugs.debian.org/430091
  > 
  > on how to reproduce the problem.  The following also is showing a
  > problem, as it blocks in read() after do_switch
  > 
  >  git svn clone -T trunk -b branches -t tags \
  >    svn://bruce-guenter.dyndns.org/bglibs
  > 
  > I'm not sure whether this is a git-svn or a subversion problem, thanks
  > for your input.

  Thanks for the bug report.  Sorry for the latency these days, I've
  been quite busy with other things.

  Although this fixes blocking reads, this does *not* fix the
  "Malformed network data" issue, which has been around for a
  while...

  I'll try to find time to fix the "Malformed network data" bug
  in a few days time, but it's not fatal (just restart git-svn,
  this error happens at a point where it's not possible to have
  a corrupted import).

 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 51979f9..b3dffcc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3002,6 +3002,7 @@ sub new {
 	      \&Git::SVN::Prompt::username, 2),
 	  ]);
 	my $config = SVN::Core::config_get_config($config_dir);
+	$RA = undef;
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
-- 
Eric Wong
