From: Brian Foster <brian.foster@innova-card.com>
Subject: [Q] `git fetch tag NAME' into mirror repo does not update HEAD, what to do?
Date: Thu, 12 Aug 2010 09:54:27 +0200
Message-ID: <201008120954.27648.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 10:28:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjT8p-0000To-5b
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 10:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024Ab0HLI1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 04:27:54 -0400
Received: from 6-61.252-81.static-ip.oleane.fr ([81.252.61.6]:36407 "EHLO
	zebulon.innova-card.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751798Ab0HLI1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 04:27:51 -0400
X-Greylist: delayed 1993 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2010 04:27:50 EDT
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 09:54:35 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.28-15-generic; KDE/4.3.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153352>


 Bare repository ORIG's master looks like this:

   o--o--o--o--v1--o--v2--o--o--o HEAD

 where v1 and v2 are (annotated) tagged commits.

 Repository SLAVE is a mirror clone of ORIG which
 (very deliberately!) lags behind (i.e., its HEAD
 is one of the earlier (and usually tagged) commits
 on ORIG).  SLAVE's master was like this:

   o--o--o--o--v1 HEAD

 We wanted to update its HEAD to v2, so did:

   git fetch ORIG tag v2

 This gave us:

   o--o--o--o--v1 HEAD
                 \ 
                  o--v2

 It did not update SLAVE's HEAD to v2, which we wanted.
 This was worked-around by editing refs/heads/master(?)
 but we don't want to do that again (esp. since we got
 it wrong the first time (Thank you back-ups!)).

 Whilst we want to switch to a push from ORIG to SLAVE
 model, until that happens (there are some IT issues),
 we are still fetching on SLAVE from ORIG.  Hence, how
 can we avoid the above issue; that is, what should we
 have done?  Searching various docs has failed to find
 any clew or answer.

 There are several GIT versions involved (all(?) are
 1.5-ish or later).  Below is a script to reproduce
 the situation (tested with v1.7.0.2).

cheers!
	-blf-

=====(cut here and below)===== demo.sh =====(git version 1.7.0.2)=====
#!/bin/bash

add_new_files() {
	touch   -- "$@"
	git add -- "$@"
	git commit -m "Added: $*"
}

set -xe

mkdir ORIG
cd ORIG
git init	# ORIG is bare in real case

add_new_files foo
add_new_files bar

git tag -a -m First v1

cd ..
git clone --bare --mirror ORIG SLAVE.git

cd ORIG

add_new_files xyzzy
add_new_files plover

git tag -a -m Update v2

add_new_files stuff
add_new_files more_stuff

cd ../SLAVE.git

git fetch --verbose origin tag v2

# SLAVE's master's HEAD has not changed ....  ;-(

git tag -l
git log --oneline master
git log --oneline v2
=====(cut here and above)===== demo.sh =====(git version 1.7.0.2)=====
