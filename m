From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-svn fails in prop_walk if $self->{path} is not empty
Date: Tue, 27 May 2008 08:46:55 +0000
Message-ID: <20080527084655.20379.qmail@5bba46d46c095e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 10:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0uqp-0005ad-Bu
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbYE0IrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 04:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756721AbYE0IrA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:47:00 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:43774 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755942AbYE0Iq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:46:58 -0400
Received: (qmail 20380 invoked by uid 1000); 27 May 2008 08:46:55 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82993>

From: Christian Engwer <christi@uni-hd.de>

If url://repo/trunk is the current Git branch, prop_walk strips trunk
from the path name. That is useful as, for example "git svn show-ignore"
should not return results like

trunk/foo

but

foo

if svn:ignore for trunk includes foo.

The problem now is that prop_walk strips trunk from the path and then
calls itself recursively. But now trunk is missing in the path and
get_dir fails, because it is called for a non existing path.

The attached patch fixed the problem, by adding the priviously stipped
$self->{path} in the recursive call. I tested it with my current
git-svn repository for the commands show-ignore and show-external.

Patch was submitted through
 http://bugs.debian.org/477393

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

I'm not that much a git-svn user, and didn't test this thoroughly.  I'd
be happy if anyone could crossread/test this, and maybe add a Acked-By.

Thanks, Gerrit.


 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 37976f2..72fef16 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1918,7 +1918,7 @@ sub prop_walk {
 
 	foreach (sort keys %$dirent) {
 		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
-		$self->prop_walk($p . $_, $rev, $sub);
+		$self->prop_walk($self->{path} . $p . $_, $rev, $sub);
 	}
 }
 
-- 
1.5.5.1
