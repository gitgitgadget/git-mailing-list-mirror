From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 02:21:00 -0700
Message-ID: <11768880622402-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 11:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He6Le-00075Y-Aa
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 11:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbXDRJVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 05:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbXDRJVE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 05:21:04 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36162 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422709AbXDRJVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 05:21:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418092103.VAYR1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 18 Apr 2007 05:21:03 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oZM21W0041kojtg0000000; Wed, 18 Apr 2007 05:21:02 -0400
X-Mailer: git-send-email 1.5.1.1.901.g25ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44875>

This two-patch series concludes my initial attempt for
gitattributes for now.

It hooks into the merge-recursive backend to allow custom low-level
3-way merge drivers to be specified path-by-path basis.

To define a custom low-level merge driver, the usual
configuration mechanism is used.

	[merge]
		driver = ancient merge %A %O %B

The new configuration item, 'merge.driver', is multi-valued.
Each of its values begin with the name of the low-level driver
('ancient' in the above example), followed by its command line.
The command line can contain the following patterns to be
processed with the usual interpolation mechanism:

	%O	name of the temporary file that has the
		ancestor's version.

	%A	name of the temporary file that has the
		version from the current branch.

	%B	name of the temporary file that has the
		version from the other branch.

The low-level driver is expected to update the file named with
%A with the result of the merge, and exit with zero status upon
a clean merge.  It can exit with non-zero status to signal that
the result still has conflicts.

Once you set up a low-level merge driver, you can specify that
driver to be used for specific paths, using the attributes
mechanism, by using the driver's name as the value of 'merge'
attribute.  For example, taken together with the above 'ancient'
driver configuration and this line in your .git/info/attributes:

	*.txt	merge=ancient

will use the old "RCS merge" external program to merge a file
whose extension is ".txt", just like we used to do before
v1.5.0.
