From: Sam Vilain <samv@utsl.gen.nz>
Subject: post-update script to update wc - suggestions welcome
Date: Wed, 20 Jun 2007 18:21:44 +1200
Message-ID: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 08:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0tri-0003VI-DQ
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 08:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622AbXFTGk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 02:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759468AbXFTGk1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 02:40:27 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33582 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759603AbXFTGk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 02:40:26 -0400
X-Greylist: delayed 1115 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2007 02:40:26 EDT
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 3F74213A4F8; Wed, 20 Jun 2007 18:21:48 +1200 (NZST)
Received: from www.watts.utsl.gen.nz (www.magnus.utsl.gen.nz [192.168.253.11])
	by magnus.utsl.gen.nz (Postfix) with ESMTP id C4BA613A342
	for <git@vger.kernel.org>; Wed, 20 Jun 2007 18:21:44 +1200 (NZST)
Received: from samv by www.watts.utsl.gen.nz with local (Exim 3.36 #1 (Debian))
	id 1I0tZY-0001Uz-00
	for <git@vger.kernel.org>; Wed, 20 Jun 2007 18:21:44 +1200
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50540>

#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, make this file executable by "chmod +x post-update".

git-update-server-info

ref=$1
active=`git-symbolic-ref HEAD`
if [ "$ref" = "$active" ]
then
  echo "Pushing to checked out branch - updating working copy" >&2
  export GIT_DIR=`cd $GIT_DIR; pwd`
  cd ..
  success=
  if git-diff-files
  then
    git-diff-index -z -R --name-status HEAD | perl -n0 -le \
	'if ($z^=1) {
		$status=$_;
	 }
	 else {
        	$filename=$_;
		printf STDERR "$status\t$filename\n";
		if($status eq "D"){
			unlink($filename)
				or die("unlink($filename) failed; $!")
		}
         }' &&
    git-reset --hard HEAD && success=1
  fi
  if [ -z "$success" ]
  then
    (
    echo "Non-bare repository checkout is not clean - not updating it"
    echo "However I AM going to update the index.  Any in-progress commit"
    echo "happening in that checkout will be thrown away, but on the bright"
    echo "side this is probably the least confusing thing for us to do and"
    echo "at least we're not throwing any files somebody has changed away"
    git-reset --mixed HEAD
    echo 
    echo "This is the new status of the upstream working copy:"
    git-status
    ) >&2
  fi
fi
