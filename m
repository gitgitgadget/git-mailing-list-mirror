From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 0/2] fixing git pull from symlinked directory
Date: Sat, 15 Nov 2008 07:11:33 -0800
Message-ID: <cover.1226759762.git.marcel@oak.homeunix.org>
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 16:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Mvv-0002FL-8m
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 16:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYKOPST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 10:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYKOPST
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 10:18:19 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:22101 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751327AbYKOPSS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 10:18:18 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Nov 2008 10:18:18 EST
Received: (qmail 75644 invoked from network); 15 Nov 2008 15:11:38 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp106.sbc.mail.mud.yahoo.com with SMTP; 15 Nov 2008 15:11:38 -0000
X-YMail-OSG: jTNliokVM1k4qbr2ujdDUBIstpREPMD.AXw3aHAqF8y8E3zQpbpRGy5RAeB0UbGscvKtQbjOZcjzNeH6tEgncS9HEYL3V2Re9JjZ8b2xvcXGvoeDlErgs2rU8cZzGTHyhWPCkn9mkMO.VAFxeKt68QRy
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L1MoC-0006gV-4T; Sat, 15 Nov 2008 07:11:36 -0800
X-Mailer: git-send-email 1.6.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101071>

In a past message I described a problem when pulling in a
directory that I arrived at by "cd"-ing to a symlink.

http://article.gmane.org/gmane.comp.version-control.git/98223

I've created a unit test to illustrate the problem and
compare it to "git pull" without the symlink and "git push"
with the symlink, which both work.  That's the first patch
in this series.

I think the root cause here is that a shell's "cd" and C's
chdir() behave slightly different with symlinks.  See the unit
test comments for more details.

I can make the unit test pass if I make bash's "cd" behave
like chdir() by adding "-P", as in the second patch of this
series, but I think that has portability issues.  Any tips
for addressing that?  Maybe instead call realpath() on the
result of "git rev-parse --show-cdup" in C before printing
it?  That's a substantial change as it would print
/full/path/to/work-dir/ instead of just "../".

Marcel M. Cary (2):
  Add failing test for "git pull" in symlinked directory
  Support shell scripts that run from symlinks into a git working dir

 git-sh-setup.sh         |    2 +-
 t/t5521-pull-symlink.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100644 t/t5521-pull-symlink.sh
