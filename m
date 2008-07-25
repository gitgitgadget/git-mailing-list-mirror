From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= 
	<4ux6as402@sneakemail.com>
Subject: [PATCH] Avoid warning when From: is encoded
Date: Fri, 25 Jul 2008 15:06:48 +0200
Message-ID: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 15:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMN1E-0006GA-5u
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 15:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYGYNGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 09:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYGYNGf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 09:06:35 -0400
Received: from morch.com ([193.58.255.207]:48468 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbYGYNGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 09:06:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by morch.com (Postfix) with ESMTP id D22DF27D3
	for <git@vger.kernel.org>; Fri, 25 Jul 2008 15:08:23 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.46.g07955.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90044>

=46rom: Peter Valdemar M=C3=B8rch <peter@morch.com>

In commit 0706bd19ef9b41e7519df2c73796ef93484272fd $1 is used from a re=
gexp
without using () to set up $1. Later, when that value was used, it caus=
ed a
warning about a variable being undefined.

Signed-off-by: Peter Valdemar M=C3=B8rch <peter@morch.com>
---
The commit introduces $body_encoding and: $body_encoding =3D $1; which =
is undef.

That commit then later uses $body_encoding only here:
+ if ($has_content_type) {
+         if ($body_encoding eq $author_encoding) {
+                 # ok, we already have the right encoding
+         }
+         else {
+                 # uh oh, we should re-encode
+         }
+ }
(I removed some whitespace for readability)

=2E. and it was the eq that gave the warning, because $body_encoding wa=
s
undefined. Perhaps a better fix is to remove $body_encoding and regexp
altogether since it isn't really used. Let me know if you think so.

This is where my non-commit message goes, yeah? I'm hand editing the ou=
tput of
'git format-patch'...

Junio C. Hamano commented on a previous post that I shouldn't send patc=
hes as
attachments so now I'm trying git-send-email. Are there any form proble=
ms with
this patch?

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2e4a44a..d2fd899 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -882,7 +882,7 @@ foreach my $t (@files) {
 				}
 				elsif (/^Content-type:/i) {
 					$has_content_type =3D 1;
-					if (/charset=3D"?[^ "]+/) {
+					if (/charset=3D"?([^ "]+)/) {
 						$body_encoding =3D $1;
 					}
 					push @xh, $_;
--=20
1.6.0.rc0.46.g07955.dirty
