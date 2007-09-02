From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sun, 2 Sep 2007 12:40:35 +0200
Message-ID: <200709021240.36807.robin.rosenberg@dewire.com>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com> <200709020152.30070.robin.rosenberg@dewire.com> <20070902101825.1938C576FA@dx.sixt.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	spearce@spearce.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 02 12:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRmrY-0008Aw-Hc
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 12:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbXIBKjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 06:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755702AbXIBKjF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 06:39:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14088 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755678AbXIBKjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 06:39:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 19A2A802849;
	Sun,  2 Sep 2007 12:31:10 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28514-02; Sun,  2 Sep 2007 12:31:09 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 9C80B800199;
	Sun,  2 Sep 2007 12:31:09 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070902101825.1938C576FA@dx.sixt.local>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57314>

s=F6ndag 02 september 2007 skrev Johannes Sixt:
> Robin Rosenberg wrote:
> > +             if [ -d "$g/../.dotest" ]
> > +             then
> > +                     ...
> > +             else
> > +                     if [ -d "$g/.dotest-merge" ]
> > +                     then
> > +                             ...
> > +                     else
> > +                             if [ -f "$g/MERGE_HEAD" ]
> > +                             then
> > +                                     ...
> > +                             else
> > +                                     ...
> > +                             fi
> > +                     fi
> > +             fi
>=20
> You can use 'elif' to avoid the increasing indentation.
>=20
> -- Hannes

Ofcourse :)

-- robin

=46rom a0cce4fd418dc3ba715566980aa901dd12791b66 Mon Sep 17 00:00:00 200=
1
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sat, 1 Sep 2007 12:20:48 +0200
Subject: [PATCH] Improve bash prompt to detect various states like an u=
nfinished merge

This patch makes the git prompt (when enabled) show if a merge or a
rebase is unfinished. It also detects if a bisect is being done as
well as detached checkouts.

An uncompleted git-am cannot be distinguised from a rebase (the
non-interactive version). Instead of having an even longer prompt
we simply ignore that and hope the power users that use git-am knows
the difference.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 contrib/completion/git-completion.bash |   33 ++++++++++++++++++++++++=
++++---
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5ed1821..433be3a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,12 +64,37 @@ __gitdir ()
=20
 __git_ps1 ()
 {
-	local b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
-	if [ -n "$b" ]; then
+	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
+	if [ -n "$g" ]; then
+		local r
+		local b
+		if [ -d "$g/../.dotest" ]
+		then
+			local b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+			r=3D"|REBASING"
+		elif [ -d "$g/.dotest-merge" ]
+		then
+			r=3D"|REBASING"
+			b=3D"$(cat $g/.dotest-merge/head-name)"
+		elif [ -f "$g/MERGE_HEAD" ]
+		then
+			r=3D"|MERGING"
+				b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+		else
+			if [ -f $g/BISECT_LOG ]
+			then
+				r=3D"|BISECTING"
+			fi
+			if ! b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+			then
+				b=3D"$(cut -c1-7 $g/HEAD)..."
+			fi
+		fi
+
 		if [ -n "$1" ]; then
-			printf "$1" "${b##refs/heads/}"
+			printf "$1" "${b##refs/heads/}$r"
 		else
-			printf " (%s)" "${b##refs/heads/}"
+			printf " (%s)" "${b##refs/heads/}$r"
 		fi
 	fi
 }
--=20
1.5.3
