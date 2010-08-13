From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20git-rebase--interactive=2Esh=3A=20rework=20skip=5Funnecessary=5Fpicks?=
Date: Fri, 13 Aug 2010 15:47:34 -0500
Message-ID: <vFgTzGXLhalxcMpLoOFhqltkPrQzeonuuQVYAuW79a2bfz1SRlvXGh7w8kLO_mBu9DM-e8Omq9k@cipher.nrlssc.navy.mil>
References: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com, Matthieu.Moy@imag.fr, gitster@pobox.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: benji@silverinsanity.com
X-From: git-owner@vger.kernel.org Fri Aug 13 22:48:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1BN-0003CF-Oa
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109Ab0HMUss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:48:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40061 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0HMUsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:48:47 -0400
Received: by mail.nrlssc.navy.mil id o7DKm8kG032314; Fri, 13 Aug 2010 15:48:08 -0500
In-Reply-To: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com>
X-OriginalArrivalTime: 13 Aug 2010 20:48:08.0730 (UTC) FILETIME=[D61F57A0:01CB3B28]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153504>

=46rom: Brandon Casey <drafnel@gmail.com>

Commit cd035b1c introduced the exec command to interactive rebase.  In
doing so, it modified the way that skip_unnecessary_picks iterates thro=
ugh
the list of rebase commands so that it avoided collapsing multiple spac=
es
into a single space.  This is necessary for example if the argument to =
the
exec command contains a path with multiple spaces in it.

The way it did this was by reading each line of rebase commands into a
single variable, and then breaking the individual components out using
echo, sed, and cut.  It used the individual broken-out components for
decision making, and was still able to write the original line to the
output file from the variable it had saved it in.  But, since we only
really need to look at anything other than the first element of the lin=
e
when a 'pick' command is encountered, and even that is only necessary w=
hen
we are still searching for "unnecessary" picks, and since newer rebase
commands like 'exec' may not even require a sha1 field, let's make our =
read
statement parse its input into a "command" variable, and a "rest" varia=
ble,
and then only break out the sha1 from $rest, and call git-rev-parse, wh=
en
absolutely necessary.

I think this future proofs this subroutine, avoids calling git-rev-pars=
e
unnecessarily, and possibly with bogus arguments, and still accomplishe=
s
the goal of not mangling the $rest of the rebase command.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Brian Gernhardt wrote:
> On Aug 13, 2010, at 12:37 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
>=20
>> 39e388728 (merging git rebase -i exec support) broke the funny names
>> test in t3404-rebase-interactive.sh:
>=20
> Just noticed this myself when your e-mail hit the list.
>=20
>> This one breaks under bash too, does it work for you Matthieu? If so
>> what sort of environment are you executing it in?
>=20
> Also broken here: OS X 10.6.4 using bash 3.2.48 and dash 0.5.6-20-ga9=
2255d

The conversion to use printf instead of echo, introduced by 938791cd, w=
as
lost in the merge.  This first patch is just a cleanup that I think
simplifies and improves the code.  The second patch should fix the brea=
kage.

-Brandon


 git-rebase--interactive.sh |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bf49b5b..2e5bed0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -619,25 +619,30 @@ do_rest () {
 # skip picking commits whose parents are unchanged
 skip_unnecessary_picks () {
 	fd=3D3
-	while read -r line
+	while read -r command rest
 	do
-		command=3D$(echo "$line" | sed 's/  */ /' | cut -d ' ' -f 1)
-		sha1=3D$(echo "$line"    | sed 's/  */ /' | cut -d ' ' -f 2)
-		rest=3D$(echo "$line"    | sed 's/  */ /' | cut -d ' ' -f 3-)
 		# fd=3D3 means we skip the command
-		case "$fd,$command,$(git rev-parse --verify --quiet "$sha1"^)" in
-		3,pick,"$ONTO"*|3,p,"$ONTO"*)
+		case "$fd,$command" in
+		3,pick|3,p)
 			# pick a commit whose parent is current $ONTO -> skip
-			ONTO=3D$sha1
+			sha1=3D$(echo "$rest" | cut -d ' ' -f 1)
+			case "$(git rev-parse --verify --quiet "$sha1"^)" in
+			"$ONTO"*)
+				ONTO=3D$sha1
+				;;
+			*)
+				fd=3D1
+				;;
+			esac
 			;;
-		3,#*|3,,*)
+		3,#*|3,)
 			# copy comments
 			;;
 		*)
 			fd=3D1
 			;;
 		esac
-		echo "$line" >&$fd
+		echo "$command${rest:+ }$rest" >&$fd
 	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
 	mv -f "$TODO".new "$TODO" &&
 	case "$(peek_next_command)" in
--=20
1.7.2.1
