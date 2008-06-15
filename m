From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/4] Teach "git clone" to pack refs
Date: Sun, 15 Jun 2008 16:02:03 +0200
Message-ID: <200806151602.03445.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 16:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7spM-0008Oa-TQ
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 16:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236AbYFOOCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 10:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759233AbYFOOCc
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 10:02:32 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34337 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759229AbYFOOCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 10:02:31 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00M0DCC6P300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:02:30 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00HQECBF3420@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:02:03 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I009S0CBFUC20@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 16:02:03 +0200 (CEST)
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85094>

(This is meant for AFTER v1.5.6.)

This is a re-post of the series I posted while builtin-clone was still
under development. The rationale for this series can be found in earlier
threads, but it roughly boils down to the following:

1. "git clone" currently creates "loose" refs for every ref in the cloned
   repo. A subsequent "git gc" will pack these refs into a packed-refs file.
   Having "git clone" produce the "packed" refs in the first place seems
   more efficient.

2. For repos with few refs the performance difference between writing loose
   refs and packed refs is negligible. However, for repos with thousands of
   refs [1], the difference between writing one packed-refs file and
   thousands of "loose" refs files is definitely noticeable. Even more so
   on Windows.

3. When the user updates a ref, a "loose" ref is written, and the
   corresponding packed ref (if any) is left unused. By making "git clone"
   write packed refs, we increase the overhead of unused packed refs
   (proportionally to the number of refs updated by the user). However,
   the number of refs updated by the user is typically small. If the user
   updates tens - or even hundreds - of refs, I still expect this overhead
   to be negligible, and in any case outweighed by the added performance
   when cloning repos with many refs.

The series is based on current 'next'.

Johan Herland (4):
  Incorporate fetched packs in future object traversal
  Move pack_refs() and friends into libgit
  Prepare testsuite for a "git clone" that packs refs
  Teach "git clone" to pack refs

 Makefile                     |    2 +
 builtin-clone.c              |    8 ++-
 builtin-fetch-pack.c         |    1 +
 builtin-pack-refs.c          |  121 +-----------------------------------------
 pack-refs.c                  |  117 ++++++++++++++++++++++++++++++++++++++++
 pack-refs.h                  |   18 ++++++
 t/t5515-fetch-merge-logic.sh |   19 +++++++
 7 files changed, 164 insertions(+), 122 deletions(-)
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h


Have fun! :)

...Johan


[1]: At $dayjob I'm converting old CVS modules with up to ~10 years of
     history, and some of the resulting repos have ~30000 refs (mostly
     build tags). When cloning these repos, the speedup of this series
     can be measured in seconds on Linux; minutes on Windows.
