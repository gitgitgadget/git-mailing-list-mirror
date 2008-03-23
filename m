From: Jonathan Watt <jwatt@jwatt.org>
Subject: Working copy revision and push pain
Date: Sun, 23 Mar 2008 13:39:13 +0100
Message-ID: <47E64F71.3020204@jwatt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 13:41:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdPWB-0000iU-CY
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 13:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684AbYCWMkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 08:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755883AbYCWMkw
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 08:40:52 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:46669 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641AbYCWMkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 08:40:51 -0400
Received: from spunkymail-a19.g.dreamhost.com (balanced.mail.policyd.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 460EC17A8BF
	for <git@vger.kernel.org>; Sun, 23 Mar 2008 05:40:51 -0700 (PDT)
Received: from [192.168.1.6] (ip1-182-173-82.adsl2.versatel.nl [82.173.182.1])
	by spunkymail-a19.g.dreamhost.com (Postfix) with ESMTP id D6A1F11F00
	for <git@vger.kernel.org>; Sun, 23 Mar 2008 05:39:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77885>

Hi,

There seems to be a problem with git-push when the working copy of the directory
being pushed to came from the magic revision HEAD, but not when the working copy
came from some other revision.

Say I've got a repository called a:

  mkdir a
  cd a
  git-init
  echo "line 1" > file
  git-add file
  git-commit -m "commit 1" file
  echo "line 2" >> file
  git-commit -m "commit 2" file
  echo "line 3" >> file
  git-commit -m "commit 3" file

Now let's say there's a clone of repository a called b, and b has HEAD checked
out. If I make changes in a and push them to b, there's a problem:

  git-clone . ../b
  echo "line 4" >> file
  git-commit -m "commit 4" file
  git-push ../b
  cd ../b
  git-log file # says the working copy came from commit 4, but...
  cat file # only lists up to line 3 :-/

If on the other hand I have a clone of repository a called c that has a non-HEAD
revision checked out, there's no problem:

  git-clone ../a ../c
  cd ../c
  git-checkout HEAD^
  cd ../a
  echo "line 5" >> file
  git-commit -m "commit 5" file
  git-push ../c
  cd ../c
  git-log file # says the working copy came from commit 3, and...
  cat file # only lists up to line 3. great!

I don't know anything about the implementation of git, but could this mean that
when the working copy comes from HEAD git tracks it as coming from the revision
"HEAD" instead of the underlying revision's sha1? If so, this seems like an
unnecessary gotcha/pain point. Couldn't git be changed to always track the sha1
of the revision it really came from? That would seem like the correct thing to
do, and it would be nice to avoid unnecessarily breaking working copies.

Regards,
Jonathan
