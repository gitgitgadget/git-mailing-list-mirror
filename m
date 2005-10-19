From: John Ellson <ellson@research.att.com>
Subject: [PATCH] cg-history FILE [NTH_PARENT]      - was: Re: Wanted - a file
 browser interface to git
Date: Tue, 18 Oct 2005 23:15:15 -0400
Message-ID: <4355BA43.5030509@research.att.com>
References: <dj45np$e88$1@sea.gmane.org> <Pine.LNX.4.64.0510181806250.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 05:17:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES4RC-0000gN-3z
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 05:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVJSDPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 23:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbVJSDPW
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 23:15:22 -0400
Received: from mail-dark.research.att.com ([192.20.225.112]:28819 "EHLO
	mail-yellow.research.att.com") by vger.kernel.org with ESMTP
	id S1750861AbVJSDPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 23:15:21 -0400
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id j9J3I0fF014997;
	Tue, 18 Oct 2005 23:18:01 -0400 (EDT)
User-Agent: Mail/News 1.4.1 (X11/20051008)
Newsgroups: gmane.comp.version-control.git
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181806250.3369@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10262>

Linus Torvalds wrote:
> 
> On Tue, 18 Oct 2005, John Ellson wrote:
>> An example is:  "I know that file xxx contained algorithm yyy at some point in
>> the past and now I'd like to browse back through the history of xxx to find
>> the exact details."
> 
> You are aware of "git whatchanged -p xxx", right?
> 
> Yeah, it's not graphical, and I agree that it might be very cool to have a 
> graphical version of it. But I thought I'd mention it even so. A 
> surprising number of people seem to have never realized, and at least for 
> me personally, it's one of the most common things I do.
> 
> 		Linus


OK.  Here is a not-very-smart cogito command to display the history of a file, 
or the state of the nth parent of the file in its history.

Feedback and or complete rewrites are requested ;-)

John


produce the history of a file, or its state at its nth_parent

---
commit 8478ad1164e37e9cca039a3f9552d2a98f7bead6
tree 40b39d5f9af573a7815f073cada03c7903bfc6fa
parent 5d74e4859afc81a4658133d5a83809ac814dbf34
author John Ellson <ellson@ontap.ellson.com> Tue, 18 Oct 2005 23:13:44 -0400
committer John Ellson <ellson@ontap.ellson.com> Tue, 18 Oct 2005 23:13:44 -0400

  cg-history |   36 ++++++++++++++++++++++++++++++++++++
  1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/cg-history b/cg-history
new file mode 100755
index 0000000..ba86f71
--- /dev/null
+++ b/cg-history
@@ -0,0 +1,36 @@
+#!/usr/bin/env bash
+#
+# Display the change history of a file.
+# Copyright (c) John Ellson, 2005
+#
+# The change history of a file is displayed on stdout, or
+# if an integer is provided for NTH_PARENT, then the complete
+# state of the file at that step in its history is sent to stdout.
+#
+
+USAGE="cg-history FILE [NTH_PARENT]"
+
+. ${COGITO_LIB}cg-Xlib || exit 1
+
+[ "$ARGS" ] || usage
+
+if [ "${ARGS[1]}" = "" ]; then
+       git-whatchanged -p "${ARGS[0]}"
+else
+       i=0
+       git-whatchanged -p "${ARGS[0]}" |
+       while read -r cmd sha rest
+       do
+               case "$cmd" in
+               diff-tree)
+                       i=`expr $i + 1`
+                       if [ $i = ${ARGS[1]} ] ; then
+                               cg-admin-cat -r "$sha" "${ARGS[0]}"
+                               exit 0
+                       fi
+                       ;;
+               *)
+                       ;;
+               esac
+       done
+fi
