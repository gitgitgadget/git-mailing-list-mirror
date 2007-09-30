From: Bruno Haible <bruno@clisp.org>
Subject: GIT_EXTERNAL_DIFF invoked with undocumented calling convention after unstashing conflicts
Date: Sun, 30 Sep 2007 21:17:37 +0200
Message-ID: <200709302117.37422.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RZ//GN+MjYyGu9V"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 21:17:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic4IS-0005Uo-Sc
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 21:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXI3TRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 15:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbXI3TRh
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 15:17:37 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:51874 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXI3TRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 15:17:37 -0400
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (fruni mo5) (RZmta 13.2)
	with ESMTP id Y06d82j8UGO2Aj ; Sun, 30 Sep 2007 21:17:35 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59549>


--Boundary-00=_RZ//GN+MjYyGu9V
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

"git diff --uncached" invokes the GIT_EXTERNAL_DIFF variable with just one
argument (instead of 7 arguments, as documented) in a particular situation:
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
  - $ git-diff --cached | cat
    yields:
my-diff-for-git ChangeLog
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
  

As you can see from the output of the script's line 2, it was called with
just one argument. This is not enough information for producing output
in a different way than the built-in way - defeating the purpose of
GIT_EXTERNAL_DIFF.

Can the GIT_EXTERNAL_DIFF invocation be done with 7 or more arguments?
It'd be OK to extend the calling convention.

Bruno

--Boundary-00=_RZ//GN+MjYyGu9V
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

--Boundary-00=_RZ//GN+MjYyGu9V--
