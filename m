From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 4/5] Fix sed string regex escaping in module_name.
Date: Tue, 6 Nov 2007 21:20:02 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106202002.GE6361@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUuJ-0002nl-Ul
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbXKFUUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbXKFUUF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:20:05 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:36787 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbXKFUUE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:20:04 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 3F6B540002DD2
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:20:03 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106201518.GA6361@ins.uni-bonn.de>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63718>

When escaping a string to be used as a sed regex, it is important
to only escape active characters.  Escaping other characters is
undefined according to POSIX, and may lead to problems with some
sed's extensions.
---
With this one, I'm not sure whether it is necessary, simply because I
don't know what kinds of characters can be part of a submodule path.
It anyway should be safe though.

 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4aaaaab..5af28ec 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -73,7 +73,7 @@ resolve_relative_url ()
 module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
-	re=$(printf '%s' "$1" | sed -e 's/\([^a-zA-Z0-9_]\)/\\\1/g')
+	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=$( GIT_CONFIG=.gitmodules \
 		git config --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
-- 
1.5.3.5.561.g140d
