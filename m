From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Adapting scripts to work in current (not top) directory
Date: Thu, 12 May 2005 17:58:10 +0400
Message-ID: <200505121758.10971.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 12 15:55:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWE5L-0005n4-4Y
	for gcvg-git@gmane.org; Thu, 12 May 2005 15:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVELN6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVELN6W
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 09:58:22 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:54667
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261931AbVELN6P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 09:58:15 -0400
Received: (qmail 4166 invoked from network); 12 May 2005 13:58:13 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 12 May 2005 13:58:12 -0000
To: GIT Mailing List <git@vger.kernel.org>
User-Agent: KMail/1.7.2
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

All git and cogito scripts wants .git subdirectory. If I'm in a subdirectory 
that have no .git direcory in it I'm out of luck.
I have wrote an example script that determines the lowest possible .git 
directory position and changes to it to satisfy user request.

Problems with script:
1) May be I misunderstood the git ideology and it needs not this at all.

if point (1) is false then there are couple of other problems:
2) Script is extremelly ugly. I'm a week bash programmer so please criticize.
3) This logic shold be somehow embedded to all git- and cg- scripts. I can not 
figure how to do it non-intruisively.
4) files and patch with spaces not supported. Probably fixable but first I 
want to resolve points (1), (2) and (3)

===========================
#!/bin/bash
#
# Add new file to a GIT repository.
# Copyright (c) Petr Baudis, 2005
#
# Takes a list of file names at the command line, and schedules them
# for addition to the GIT repository at the next commit.

. ${COGITO_LIB:-/home/snake/lib/cogito/}cg-Xlib

[ "$1" ] || die "usage: cg-add FILE..."

gitpath=
subpath=
curpath=`pwd`
for ((i=2;i<9999;i=i+1)) ; do {
        path1=`echo $curpath | cut -d / -f 0-$i`
        path2=`echo $curpath | cut -d / -f $((i+1))-`
        [ -d "$path1"/.git ] && gitpath=$path1 && subpath=$path2
        [ "$path1" == "$curpath" ] && break
}; done

for file in "$@"; do
        if [ -f "$file" ]; then
                echo "Adding file $file"
        else
                die "$file does not exist"
        fi
done

cd "$gitpath"

files=

for file in "$@"; do
        files="$files $subpath/$file"
done

git-update-cache --add -- $files
===========================

-- 
Respectfully
Alexey Nezhdanov

