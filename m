From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] send-email: sanitize author when writing From line
Date: Tue, 18 Jun 2013 15:49:26 +0300
Message-ID: <1371559723-28059-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?us-ascii?B?PT9VVEYtOD9xP1NaRURFUj0yMEc9QzM9QTFib3I/PQ==?= 
	<szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 14:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UovLB-0000Hn-9v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab3FRMst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 08:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24392 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab3FRMss (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:48:48 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICmdJF017344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 18 Jun 2013 08:48:39 -0400
Received: from redhat.com (vpn1-5-182.ams2.redhat.com [10.36.5.182])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICmbhb013123;
	Tue, 18 Jun 2013 08:48:38 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228224>

sender is now sanitized, but we didn't sanitize
author when checking whether From: line is needed
in the message body.
As a result git started writing duplicate From lines
when author matched sender and has utf8 characters.

Reported-by: SZEDER G=E1bor <szeder@ira.uka.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-send-email.perl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 671762b..ecbf56f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1259,6 +1259,7 @@ foreach my $t (@files) {
 	open my $fh, "<", $t or die "can't open file $t";
=20
 	my $author =3D undef;
+	my $sauthor =3D undef;
 	my $author_encoding;
 	my $has_content_type;
 	my $body_encoding;
@@ -1297,7 +1298,7 @@ foreach my $t (@files) {
 			}
 			elsif (/^From:\s+(.*)$/i) {
 				($author, $author_encoding) =3D unquote_rfc2047($1);
-				my $sauthor =3D sanitize_address($author);
+				$sauthor =3D sanitize_address($author);
 				next if $suppress_cc{'author'};
 				next if $suppress_cc{'self'} and $sauthor eq $sender;
 				printf("(mbox) Adding cc: %s from line '%s'\n",
@@ -1393,7 +1394,7 @@ foreach my $t (@files) {
 		$subject =3D quote_subject($subject, $auto_8bit_encoding);
 	}
=20
-	if (defined $author and $author ne $sender) {
+	if (defined $sauthor and $sauthor ne $sender) {
 		$message =3D "From: $author\n\n$message";
 		if (defined $author_encoding) {
 			if ($has_content_type) {
--=20
MST
