From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] add -p: warn if only binary changes present
Date: Sun, 26 Oct 2008 20:37:06 +0100
Message-ID: <1225049826-14941-1-git-send-email-trast@student.ethz.ch>
References: <20081026104006.GA18969@neumann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, szeder@ira.uka.de
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 20:38:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuBRQ-0000Yd-Tw
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 20:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbYJZThJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 15:37:09 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbYJZThJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 15:37:09 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:52979 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbYJZThI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 15:37:08 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Oct 2008 20:37:06 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Oct 2008 20:37:06 +0100
X-Mailer: git-send-email 1.6.0.3.785.g54a3
In-Reply-To: <20081026104006.GA18969@neumann>
X-OriginalArrivalTime: 26 Oct 2008 19:37:06.0041 (UTC) FILETIME=[3A609E90:01C937A2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99180>

Current 'git add -p' will say "No changes." if there are no changes to
text files, which can be confusing if there _are_ changes to binary
files.  Add some code to distinguish the two cases, and give a
different message in the latter one.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

SZEDER G=C3=A1bor wrote:
> What about
>=20
>    Only binary files changed.
>=20
> or something of the sort?

Yes, why not.


 git-add--interactive.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..b0223c3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -811,11 +811,16 @@ EOF
 }
=20
 sub patch_update_cmd {
-	my @mods =3D grep { !($_->{BINARY}) } list_modified('file-only');
+	my @all_mods =3D list_modified('file-only');
+	my @mods =3D grep { !($_->{BINARY}) } @all_mods;
 	my @them;
=20
 	if (!@mods) {
-		print STDERR "No changes.\n";
+		if (@all_mods) {
+			print STDERR "Only binary files changed.\n";
+		} else {
+			print STDERR "No changes.\n";
+		}
 		return 0;
 	}
 	if ($patch_mode) {
--=20
tg: (759ad19..) t/add-p-binary-warn (depends on: origin/master)
