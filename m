From: "Neal Kreitzinger" <neal@rsss.com>
Subject: can pre-commit hook accept user input?
Date: Fri, 21 May 2010 20:41:11 -0500
Message-ID: <ht7co7$d0s$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 22 03:42:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFdjC-00049K-WF
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 03:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935684Ab0EVBlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 21:41:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:60232 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935681Ab0EVBli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 21:41:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OFdib-00041o-Ey
	for git@vger.kernel.org; Sat, 22 May 2010 03:41:37 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 May 2010 03:41:37 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 May 2010 03:41:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147503>

Hi,

Can the pre-commit hook accept user input?  I'm new to linux and bash 
scripting and here's what I'm trying.  (It appears to work in a manually 
executed script.)  The 'read' commands do not let me input anything when 
running in a hook. (I've inserted a non-loop test at the beginning to be 
sure.)  The script just keeps going with a value of 'nothing' in the input 
variable.  This, of course, causes and endless loop in the code that I 
really want to use.

#!/bin/bash
#*******************************************************************************
#* PGM NAME: pre-commit  A hook script to verify what is about to be 
committed**
#*                       Called by git-commit with no arguments.  The hook 
**
#*                       should exit with non-zero status after issuing an 
**
#*                       appropriate message if it wants to stop the commit. 
**
#*                          MODIFICATION LOG 
**
#* PROJ#   DATE PRGMR        DESCRIPTION 
**
#* 000057 04/10 NEAL K    INSPECT SOURCE FILES FOR HEADER USER/DATE STAMP. 
**
#*                        PROMPT FOR VERIFICATION OF DD CHANGES. WARNING: 
**
#*                        TRACKED WORKING COPY FILES WILL BE STAGED IF THEIR 
**
#*                        INDEX ENTRY DIFFERS FROM THE HEAD COMMIT! 
**
#* 000378 05/10 NEAL K    BUGFIX: ONLY INSPECT/STAGE OBJECTS WHOSE INDEX 
ENTRY**
#*                        DIFFERS FROM THE HEAD COMMIT. MOD: MORE INFO IN 
**
#*                        HEADER STAMP WARNING. WARN/PROMPT TO STAGE WORKING 
**
#*                        COPIES OF STAGED FILES. 
**
#*******************************************************************************
echo "Start pre-commit hook... Confirmation:"
echo enter your name
read NAME
echo "hi $NAME"
# 
x
CONFIRMED="N"
until [ $CONFIRMED = "Y" ]; do
  echo "Any unstaged changes to staged files will be staged. 
Continue?(Y/N/H)elp"
  read CONFIRM
  case "$CONFIRM" in
    "Y" )
      echo "Re-staging algorithm approved by User. Continue pre-commit 
hook..."
      CONFIRMED="Y";;
    "N" )
      echo "Commit Aborted by User."
      exit 3;;
    "H" )
      echo "Example:"
      echo "1. After the last commit, you changed RCUSTMNT and staged it. 
We'll call this  "
      echo "   staged version of RCUSTMNT 'RCUSTMNT NEW'."
      echo "2. Then you modified RCUSTMNT again, but did not stage it again. 
We'll call    "
      echo "   this working copy version of RCUSTMNT 'RCUSTMNT NEWEST'. "
      echo "THIS SCRIPT WILL STAGE AND COMMIT 'RCUSTMNT NEWEST'!"
      echo "*This behavior is based on the notion that you will not have 
unstaged changes  "
      echo " to your staged source files.";;
    * )
      echo "Please enter Y, N, or H (Help)";;
  esac
done
ABORTMSG="Commit Aborted!"
DIFFFILES=`git diff-index HEAD --cached --name-only SRC/*/*`
if [ $? -ne 0 ]; then
  echo "Error running git diff-index command"
  echo $ABORTMSG
  exit 4
fi
for FILES in ${DIFFFILES}
  do
# 
x
# 
12345678901234567890
  echo "inspecting working copy & staged copy of staged source file:$FILES"
  if [ ! -r ${FILES} ]; then
    echo "${FILES} needs read permission"
    echo $ABORTMSG
    exit 6
  fi
  if [ ! -w ${FILES} ]; then
    echo "${FILES} needs write permission"
    echo $ABORTMSG
    exit 6
  fi
  CHKUSER=$(/usr/bin/head -1 ${FILES} | /bin/egrep -c '\$User\$|\$User:')
  CHKDATE=$(/usr/bin/head -1 ${FILES} | /bin/egrep -c '\$Date\$|\$Date:')
  if [ ${CHKUSER} -ne 1 -o ${CHKDATE} -ne 1 ]; then
# 
80
    echo "User/Date Stamp Header Comment, e.g. ':\$User$ \$Date$' missing in 
first line of"
    echo "source file:${FILES}"
    echo $ABORTMSG
    exit 7
  fi
  sed -i "s/\\\$User[^\\\$]*\\\$/\\\$User\\\$/; 
s/\\\$Date[^\\\$]*\\\$/\\\$Date\\\$/; s/\\\$User[^\\\$]*\\\$/\\\$User: 
`whoami`\\\$/; s/\\\$Date[^\\\$]*\\\$/\\\$Date: `date`\\\$/" ${FILES}
  if [ $? -ne 0 ]; then
    echo "Error in user/date stamp substitution for file ${FILES}"
    echo $ABORTMSG
    exit 5
  fi
  git add ${FILES}
  if [ $? -ne 0 ]; then
    echo "Error in re-staging (git add) of user/date stamped file ${FILES}"
    echo $ABORTMSG
    exit 8
  fi
  done
# We are not checking error codes on purpose for DDGIT
echo "Running Data Dictionary report (DDGIT)..."
Z -b -o/dev/null DDGIT
wait
echo "Checking for any changes in Data Dictionary report (DDGIT)..."
DIFFDDGIT=`git diff --exit-code DDGIT`
if [ $? -ne 0 ]; then
  echo "Warning: Data Dictionary report (DDGIT) indicates changes to Data 
Dictionary!"
  echo "If DD.idx and DD.dat have changed then a change in DDGIT is 
expected."
  echo "Otherwise, a change in DDGIT is not expected."
  echo "REVIEW THE OLD&NEW DDGIT OUTPUT DIFF AND VERIFY THAT *ALL* CHANGES 
ARE EXPECTED!"
  echo "If the format of the DDGIT output is suspect, then consult with the 
DD Admin."
  echo "After validating *ALL* DD changes, run 'git add DDGIT' and rerun the 
commit."
  echo $ABORTMSG
  exit 9
fi
echo "Info: no changes found in Data Dictionary report (DDGIT)."
echo "...end of pre-commit hook."
exit 0


v/r,
Neal 
