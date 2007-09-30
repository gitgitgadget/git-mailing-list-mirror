From: Bruno Haible <bruno@clisp.org>
Subject: GIT_EXTERNAL_DIFF ignored after unstashing conflicts
Date: Sun, 30 Sep 2007 21:18:39 +0200
Message-ID: <200709302118.39406.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Pa//GXOS5F1YCnx"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 21:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic4JR-0005lg-El
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 21:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbXI3TSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 15:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXI3TSk
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 15:18:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:49641 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXI3TSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 15:18:39 -0400
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (mrclete mo42) (RZmta 13.2)
	with ESMTP id J05ba3j8UGwQxg ; Sun, 30 Sep 2007 21:18:37 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59550>


--Boundary-00=_Pa//GXOS5F1YCnx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

"git diff" ignores the GIT_EXTERNAL_DIFF variable in a particular situation:
when there are conflicts after "git stash apply".

To reproduce:
  - Set environment variable GIT_EXTERNAL_DIFF to point to the attached
    script.
  - Make a clean gnulib checkout, 1 day old.
  - Add a entry to the top of the ChangeLog.
  - $ git pull
    fails due a conflict.
  - $ git stash
  - $ git pull
  - $ git stash apply
  - $ git-diff | cat
    yields:
diff --cc ChangeLog
index 443ad76,991c26b..0000000
--- a/ChangeLog
+++ b/ChangeLog
@@@ -1,7 -1,6 +1,11 @@@
  2007-09-30  Bruno Haible  <bruno@clisp.org>
  
++<<<<<<< Updated upstream:ChangeLog
 +      * tests/test-getaddrinfo.c (AF_UNSPEC): Provide a fallback definition.
 +      Needed on BeOS.
++=======
+       * Some other changes.
++>>>>>>> Stashed changes:ChangeLog
  
  2007-09-30  Bruno Haible  <bruno@clisp.org>
  

The script has not been called (witness: the echo command at its line 2).

Can it be called, like in the case of "git-diff --cached"?

Bruno

--Boundary-00=_Pa//GXOS5F1YCnx
Content-Type: application/x-shellscript;
  name="my-diff-for-git"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="my-diff-for-git"

#!/bin/sh
echo "my-diff-for-git $@"
path="$1"
old_file="$2"
old_hex="$3"
old_filemode="$4"
new_file="$5"
new_hex="$6"
new_filemode="$7"

if test -n "$2" && test -n "$3" && test -n "$4" && test -n "$5" && test -n "$6" && test -n "$7"; then

  if test "$old_filemode" != "$new_filemode"; then
    echo "Changing permissions from $old_filemode to $new_filemode" || exit 1
  fi

  if test -f "$path".orig; then
    mv -f "$path".orig "$path".orig~~~
  fi
  ln -sf "$old_file" "$path".orig

  if test "$path" != "$new_file"; then
    if test -f "$path"; then
      mv -f "$path" "$path"~~~
    fi
    ln -sf "$new_file" "$path"
  fi

  diff -c3 "$path".orig "$path"
  err=$?

  if test "$path" != "$new_file"; then
    rm -f "$path"
    if test -f "$path"~~~; then
      mv -f "$path"~~~ "$path"
    fi
  fi

  rm -f "$path".orig
  if test -f "$path".orig~~~; then
    mv -f "$path".orig~~~ "$path".orig
  fi

  test $err = 2 && exit 1
  exit 0

else

  git-diff-files --cc "$path"

fi

--Boundary-00=_Pa//GXOS5F1YCnx--
