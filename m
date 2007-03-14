From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Upgrade to 1.5.0 utility
Date: Wed, 14 Mar 2007 02:16:12 -0400
Message-ID: <20070314061611.GD20978@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 07:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRMmh-0007WV-6F
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 07:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbXCNGQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 02:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbXCNGQQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 02:16:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49324 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030473AbXCNGQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 02:16:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HRMmT-0003Kj-16
	for git@vger.kernel.org; Wed, 14 Mar 2007 02:16:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6049E20FBAE; Wed, 14 Mar 2007 02:16:12 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42176>

Yesterday on #git DrNick wanted a script to update a pre-1.5.0
Git repository to be like a 1.5.0 (and later) style repository.

This basically means rewriting the remotes into .git/config, setting
up wildcard tracking branches under refs/remotes and deleting the
old tracking branches from the refs/heads namespace.

Much earlier I had cobbled together a short shell script that does
this for a *working directory repository*.  Please don't use it on
a bare repository, at least not without editing, as it is hardcoding
the config options.  ;-)

Here it is:

cat <<END_OF_SCRIPT >upgrade.sh
#!/bin/sh

##
## Upgrades a pre-1.5.0 repository to a 1.5.0-style layout.
## Use at your own risk.  I've used it to upgrade many of
## my own repositories, but I also know what I'm doing.  ;-)
##

sh remotes2config.sh; # from git.git/contrib

git config core.bare false
git config core.logallrefupdates true

for r in $(git remote)
do
  old="`git config --get-all remote.$r.fetch | sed s,^.*:refs/heads/,,`"
  if [ -z "$old" ]
  then
    echo "No fetch lines for $r."
    continue
  fi

  echo "Converting $r..."
  git config --replace-all remote.$r.fetch +refs/heads/*:refs/remotes/$r/*
  git fetch $r
  for r in $old
  do
    case "$r" in
    *:*) echo "Not deleting $r" ;;
    *) git branch -D $r ;;
    esac
  done
done
END_OF_SCRIPT

-- 
Shawn.
