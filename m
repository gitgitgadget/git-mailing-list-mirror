From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: bisect ends with a commit marked good and bad
Date: Wed, 15 Feb 2006 02:19:32 -0500
Message-ID: <E1F9Gwm-0001Dy-3b@approximate.corpus.cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Feb 15 08:19:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Gx3-0002jb-5a
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 08:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423009AbWBOHTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 02:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423010AbWBOHTn
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 02:19:43 -0500
Received: from smtpauth02.mail.atl.earthlink.net ([209.86.89.62]:51398 "EHLO
	smtpauth02.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1423009AbWBOHTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 02:19:42 -0500
Received: from [24.41.6.91] (helo=approximate.corpus.cam.ac.uk)
	by smtpauth02.mail.atl.earthlink.net with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1F9Gwu-0005sn-1C; Wed, 15 Feb 2006 02:19:40 -0500
Received: from sanjoy by approximate.corpus.cam.ac.uk with local (Exim 4.60)
	(envelope-from <sanjoy@mrao.cam.ac.uk>)
	id 1F9Gwm-0001Dy-3b; Wed, 15 Feb 2006 02:19:32 -0500
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: MH-E 7.85; nmh 1.1; GNU Emacs 21.4.1
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478f6de188fdd142d4e61c7b7bbb4b4943f8ba6cab01003fca1350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16217>

In doing a huge bisect (from 1875 or so revisions but fortunately
log(anything) is not too big) to chase a S3 sleep bug (bugme #5989), I
also noticed another problem.  In several 'good' kernels, where S3
sleep-wake worked twice, the fan would not turn on despite the
temperature getting high, after the system went through two sleep-wake
cycles.  [In the 'bad' kernels the system hangs on the second sleep, so
I couldn't collect any data about the fan.]

The result is that, for several kernels, I got free bisect data about
this second bug.  I tried feeding this data to a fresh bisect, but
bisect says that one particular commit is good and bad.  Here's the
script to run bisect:

  #!/bin/bash -x
  bad="a2d823bf ee408c79 d1138cf0"
  good="0f442aa2 49799291 4a90c7e8"
  git bisect start
  for r in $bad  ; do git-bisect bad  $r ; done
  for r in $good ; do git-bisect good $r ; done

The output:

  + bad='a2d823bf ee408c79 d1138cf0'
  + good='0f442aa2 49799291 4a90c7e8'
  + git bisect start
  + for r in '$bad'
  + git-bisect bad a2d823bf
  + for r in '$bad'
  + git-bisect bad ee408c79
  + for r in '$bad'
  + git-bisect bad d1138cf0
  + for r in '$good'
  + git-bisect good 0f442aa2
  d1138cf035ad5a8dc0796b213bd078a2fb92eb7c was both good and bad
  + for r in '$good'
  + git-bisect good 49799291
  d1138cf035ad5a8dc0796b213bd078a2fb92eb7c was both good and bad
  + for r in '$good'
  + git-bisect good 4a90c7e8
  d1138cf035ad5a8dc0796b213bd078a2fb92eb7c was both good and bad

At first I thought it was impossible for a bug to behave this way, and
concluded that my data must be corrupt, since d1138cf0 is marked bad.
But on further thought, I'm not sure.  Maybe there are quadratic
interactions between patches.  For example, if a particular bug happens
only when two patches occur together?  No, that would result in the
merge of their branches being the problematic commit.  So I'm stuck.
Before I conclude that the data is corrupt and spend several hours
retesting several kernels, I thought I'd ask for advice from the
entomologists and bisectors.

How would I use gitk to show the those three good and three bad commits,
and their spanning tree?  Neither the man entry nor the examples of its
use in git-bisect taught me enough to use it properly.

-Sanjoy
