From: Junio C Hamano <gitster@pobox.com>
Subject: gitweb chokes on recursive symlink
Date: Fri, 27 Jul 2007 01:23:03 -0700
Message-ID: <7v8x922r2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 10:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEL6N-0005TA-2l
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 10:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbXG0IXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 04:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbXG0IXG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 04:23:06 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39256 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbXG0IXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 04:23:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727082304.XWZ1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 04:23:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UYP31X00L1kojtg0000000; Fri, 27 Jul 2007 04:23:04 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53908>

If somebody used to advertise his repository that physically
resides at /pub/lic.git/ as:

	git://git.example.com/pub/lic.git/

but now wants to use --base-path to allow:

	git://git.example.com/lic.git/

she can start git-daemon with --base-path option, like this:

	git-daemon --base-path=/pub --export-all

During the transition, however, she would also want to allow
older URL as well.  One natural way to achieve that is to create
a symlink:

	ln -s /pub /pub/pub

so that a request to git://git.example.com/pub/lic.git/ is first
translated by --base-path to a request to /pub/pub/lic.git/
which goes to /pub/lic.git, thanks to the symlink.

So far so good.

However, gitweb chokes if there is such a symlink (File::Find
barfs with "/pub/pub is a recursive symbolic link" --- I think
this is because you use "follow_fast => 1").

As I happen to think using a symlink that goes up for backward
compatible URL support is a rather common practice, I think we
should do something about it.  My gut feeling is that we could
simply ignore such symlinks.

What do you think about this issue?

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b381692..c8ad84e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1492,6 +1492,7 @@ sub git_get_projects_list {
 
 		File::Find::find({
 			follow_fast => 1, # follow symbolic links
+			follow_skip => 2, # ignore duplicates
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
 			wanted => sub {
 				# skip project-list toplevel, if we get it.

	
