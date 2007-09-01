From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sun, 2 Sep 2007 01:52:28 +0200
Message-ID: <200709020152.30070.robin.rosenberg@dewire.com>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com> <7vir6us1ia.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:11:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRd3z-0001to-Uj
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 02:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933567AbXIBALa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 1 Sep 2007 20:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933459AbXIBALa
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 20:11:30 -0400
Received: from [83.140.172.130] ([83.140.172.130]:10720 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932509AbXIBAL3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2007 20:11:29 -0400
X-Greylist: delayed 1230 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Sep 2007 20:11:29 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 943D2802849;
	Sun,  2 Sep 2007 01:43:04 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23813-06; Sun,  2 Sep 2007 01:43:04 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0AF748003E1;
	Sun,  2 Sep 2007 01:43:03 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vir6us1ia.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57287>

l=F6rdag 01 september 2007 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>=20
> > diff --git a/contrib/completion/git-completion.bash b/contrib/compl=
etion/git-completion.bash
> > index 5ed1821..1fef857 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -64,12 +64,34 @@ __gitdir ()
> > =20
> >  __git_ps1 ()
> >  {
> > -	local b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
> > -	if [ -n "$b" ]; then
> > +	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
> > +	if [ -n "$g" ]; then
> > +		local r
> > +		local b
> > +		if [ -d "$g/../.dotest" ]
> > +		then
> > +			local b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
> > +			r=3D"|REBASEING"
>=20
> I might be in the middle of resolving a conflicted "git am".
>=20
> But I love the idea.  We need to think about cleaning up our
> "state machine" mechanism to make this kind of thing easier to
> do.  We've had a few suggestions on the list in the past but
> they never passed the suggestion/speculation stage.

I'd love to see that. The Eclipse plugin needs to know about such thing=
s
in order to prevent the user from making errors he wouldn't like to do.=
 We do
commit and checkouts without looking for these states now. Not too good=
=2E

The downside of improving the state machine is that we'll have to detec=
t
the old AND the new states.

Here's an ever better version which handles bisect and detached heads.

-- robin

=46rom e5b2b9833786f13d729b7fead74297580b03f775 Mon Sep 17 00:00:00 200=
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
 contrib/completion/git-completion.bash |   37 ++++++++++++++++++++++++=
++++---
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5ed1821..048a715 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,12 +64,41 @@ __gitdir ()
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
+		else
+			if [ -d "$g/.dotest-merge" ]
+			then
+				r=3D"|REBASING"
+				b=3D"$(cat $g/.dotest-merge/head-name)"
+			else
+				if [ -f "$g/MERGE_HEAD" ]
+				then
+					r=3D"|MERGING"
+					b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+				else
+					if [ -f $g/BISECT_LOG ]
+					then
+						r=3D"|BISECTING"
+					fi
+					if ! b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+					then
+						b=3D"$(cut -c1-7 $g/HEAD)..."
+					fi
+				fi
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
1.5.3.rc7.844.gfd3c5
