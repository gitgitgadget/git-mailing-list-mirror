From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 0/4] Add guards to guilt
Date: Sun, 29 Jul 2007 00:50:14 -0700
Message-ID: <118569541814-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Sun Jul 29 10:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF47S-0005fa-7K
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 10:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760398AbXG2I1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760316AbXG2I1O
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 04:27:14 -0400
Received: from smtp-8.smtp.ucla.edu ([169.232.47.138]:42113 "EHLO
	smtp-8.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760302AbXG2I1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 04:27:13 -0400
X-Greylist: delayed 2203 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2007 04:27:13 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.158])
	by smtp-8.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oN6V003713;
	Sun, 29 Jul 2007 00:50:23 -0700
Received: from localhost (adsl-75-26-192-134.dsl.scrm01.sbcglobal.net [75.26.192.134])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oMEn011649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 00:50:23 -0700
Received: by localhost (Postfix, from userid 1000)
	id 907181E80A8; Sun, 29 Jul 2007 00:50:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.47.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54094>


This series adds Mercurial Queues-like guards to guilt.  It allows you
to assign guards to related patches in the series file to selectively
push patches.

See Chapter 13 of the HG Book for more info.
(http://hgbook.red-bean.com/hgbookch13.html)

Guards are appended as "#+foo" or "#-foo" to the end of the patch name
in the series file, so they are compatible with quilt. The
guard setting and unsetting functions also respect comments on the
patch line, so they aren't mangled when you use guards.

This introduces the command `get_guarded_series`, which just lists
patches that are to be applied based on the guards.  It also makes
        eidx=`wc -l < $applied`
inaccurate if you're using it as an index into get_series.

If you change guards on a patch or select a different guard while
patches are applied, some commands might get confused. guilt pop -a will fix
everything though.  Usually, it's best to pop -a before fiddling with
guards anyway.

This is an RFC, but I have tested it and things seem to be working
well.

[PATCH 1/4] get_series: Remove comments from end of series lines
       This just strips everything but the patch name from get_series,
       to hide comments or guards on the line.

[PATCH 2/4] guilt-guard: Assign guards to patches in series
       This adds the guilt-guard command and utility functions to
       guilt.

[PATCH 3/4] guilt-select: Select guards to apply when pushing patches
       This puts selected guards in .git/patch/$branch/guards, and
       adds a $guards_file variable to guilt.

[PATCH 4/4] Use guards information and functions
       This changes guilt-header, guilt-next, guilt-push and guilt-unapplied to
       use the guards information properly.

       After the guilt-push change, header, next, and unapplied get
       confused and break, so I rolled their fixes into this patch
       instead of separate ones.

 Documentation/guilt-guards.txt |   40 +++++++++++++++++++++++++
 Documentation/guilt-select.txt |   42 ++++++++++++++++++++++++++
 guilt                          |   62 ++++++++++++++++++++++++++++++++++++++-
 guilt-guards                   |   63 ++++++++++++++++++++++++++++++++++++++++
 guilt-header                   |    7 ++--
 guilt-next                     |    2 +-
 guilt-push                     |    8 ++--
 guilt-select                   |   36 +++++++++++++++++++++++
 guilt-unapplied                |    2 +-
 9 files changed, 252 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/guilt-guards.txt
 create mode 100644 Documentation/guilt-select.txt
 create mode 100755 guilt-guards
 create mode 100755 guilt-select
