From: Christian Stimming <christian@cstimming.de>
Subject: git svn relocate [SCRIPT]
Date: Tue, 22 Jun 2010 11:40:43 +0200
Message-ID: <20100622114043.1419733jtkx6m0co@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_6vmwszr0so4k"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 22 12:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR0pB-0003mS-4C
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 12:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab0FVKfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 06:35:18 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:55371 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0FVKfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 06:35:17 -0400
X-Greylist: delayed 3270 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2010 06:35:16 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o5M9eijO030292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 22 Jun 2010 11:40:44 +0200
Received: from webmail.tu-harburg.de (webmail.rz.tu-harburg.de [134.28.202.69])
	(user=alucst mech=PLAIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o5M9eh2j022109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 22 Jun 2010 11:40:44 +0200
Received: from hansjoerg.sick.de (hansjoerg.sick.de [91.207.92.112]) by
 webmail.tu-harburg.de (Horde Framework) with HTTP; Tue, 22 Jun 2010
 11:40:43 +0200
User-Agent: Internet Messaging Program (IMP) H3 (4.3.7)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149469>

This message is in MIME format.

--=_6vmwszr0so4k
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Dear all,

I haven't found an easy solution for when a git-svn SVN server changes  
its address, but I think the attached patch implements a solution  
useful for others as well.

In plain svn this is the "svn switch --relocate URL1 URL2" command to  
change the URL of a working copy from URL1 to URL2. In git-svn, there  
didn't seem to be a suitable command available. What I found were the  
instructions here  
http://translate.org.za/blogs/wynand/en/content/changing-your-svn-repository-address-git-svn-setup and some other google hits related to this one. The instructions from the wynand blog uses git-filter-branch, and the instructions were complete enough so that an all-in-one shell script wasn't too difficult to write. So the attached script implements this: Just call "git-svn-relocate URL1 URL2" and all the rest should happen  
automatically.

Hope this helps.

Regards,

Christian Stimming

--=_6vmwszr0so4k
Content-Type: application/x-sh;
 name="git-svn-relocate.sh"
Content-Disposition: attachment;
 filename="git-svn-relocate.sh"
Content-Transfer-Encoding: 7bit

#!/bin/sh

# Copyright (C) 2010, Christian Stimming <christian@cstimming.de>
# This file is published under the same license as the git package.

FROM=$1
TO=$2
TERMINATE=0

if [ -z "${FROM}" ] ; then
	echo "No From-Argument given."
	TERMINATE=1
fi
if [ -z "${TO}" ] ; then
	echo "No To-Argument given."
	TERMINATE=1
fi
if [ ! -d .git ] ; then
	echo "You are not in the directory where the .git/ subdirectory is located."
	TERMINATE=1
else
	if ! git diff --exit-code >/dev/null ; then
		echo "There are uncommitted changes in your working copy - commit them first (or use git stash):"
		git diff --name-status
		TERMINATE=1
	fi
fi

if [ ${TERMINATE} -eq 1 ] ; then
	echo "Usage: $0 <From-URL> <To-URL>"
	exit 1
fi

OLDURL=`git config --get svn-remote.svn.url`
if [ -z "${OLDURL}" ] ; then
	echo "Cannot determine old URL of your git-svn repository."
	exit 1
fi
if ! echo "${OLDURL}" | grep -q -F "${FROM}" ; then
	echo "The old URL of your working copy <${OLDURL}> does not contain your From-Argument <${FROM}>."
	exit 1
fi

NEWURL=`echo ${OLDURL} | sed "s!${FROM}!${TO}!g"`

echo "Checking whether we can access the new URL at <${NEWURL}>."
echo "  Note: This will wait for 60 seconds if no server responds..."

if svn ls ${NEWURL} >/dev/null ; then
	echo "Ok, server at new URL ${NEWURL} was contacted successfully."
else
	echo "Cannot contact the new repository at ${NEWURL}. This means"
	echo "git svn rebase will not work, so we refuse to rewrite this working copy."
	exit 1
fi
echo 

echo "Will now rewrite <${OLDURL}> to <${NEWURL}>."
echo "Cleaning up working copy..."
git gc >/dev/null 2>&1

echo "Running git-filter-branch to rewrite the history..."
git filter-branch --msg-filter "sed 's!git-svn-id: ${OLDURL}!git-svn-id: ${NEWURL}!g'" $(cat .git/packed-refs | awk '// {print $2}' | grep -v 'pack-refs')

git config svn-remote.svn.url "${NEWURL}"

rm -r .git/svn

echo "Running: git svn rebase..."
git svn rebase

echo "Finished git-svn-relocate successfully."

--=_6vmwszr0so4k--
