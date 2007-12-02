From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Fixes for automatic prefix highlighting
Date: Sun,  2 Dec 2007 14:44:11 +0100
Message-ID: <1196603051-92641-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 14:46:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyp9F-00077W-S4
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 14:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbXLBNp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 08:45:56 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbXLBNp4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 08:45:56 -0500
Received: from wincent.com ([72.3.236.74]:57720 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbXLBNpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 08:45:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB2DiEc4000651;
	Sun, 2 Dec 2007 07:44:18 -0600
X-Mailer: git-send-email 1.5.3.6.953.gdffc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66777>

These changes make the automatic prefix highlighting work with the "Add
untracked" subcommand in git-add--interactive by explicitly handling
arrays, hashes and strings internally (previously only arrays and hashe=
s
were handled).

In addition, prefixes which have special meaning for list_and_choose
(things like "*" for "all" and "-" for "deselect) are explicitly
excluded (highlighting these prefixes would be misleading).

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

El 1/12/2007, a las 19:04, Junio C Hamano escribi=C3=B3:

> I've locally munged and pushed out the results before sending the
> message you are responding to.  Sorry, I should have been clearer (an=
d
> this is the second time with you if I recall correctly).

Sorry, Junio. I do fetch, inspect and integrate changes fairly
regularly, but I missed that one.

This patch which I am sending now applies on top of "next" (as fetched =
a
few minutes ago).

 git-add--interactive.perl |   47 ++++++++++++++++++++++++++++---------=
-------
 1 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 23fd2f7..32fb9ea 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -193,7 +193,7 @@ sub find_unique_prefixes {
 		if ((ref $print) eq 'ARRAY') {
 			$print =3D $print->[0];
 		}
-		else {
+		elsif ((ref $print) eq 'HASH') {
 			$print =3D $print->{VALUE};
 		}
 		update_trie(\%trie, $print);
@@ -230,12 +230,25 @@ sub find_unique_prefixes {
 	return @return;
 }
=20
+# filters out prefixes which have special meaning to list_and_choose()
+sub is_valid_prefix {
+	my $prefix =3D shift;
+	return (defined $prefix) &&
+	    !($prefix =3D~ /[\s,]/) && # separators
+	    !($prefix =3D~ /^-/) &&    # deselection
+	    !($prefix =3D~ /^\d+/) &&  # selection
+	    ($prefix ne '*');        # "all" wildcard
+}
+
 # given a prefix/remainder tuple return a string with the prefix highl=
ighted
 # for now use square brackets; later might use ANSI colors (underline,=
 bold)
 sub highlight_prefix {
 	my $prefix =3D shift;
 	my $remainder =3D shift;
-	return (defined $prefix) ? "[$prefix]$remainder" : $remainder;
+	return $remainder unless defined $prefix;
+	return is_valid_prefix($prefix) ?
+	    "[$prefix]$remainder" :
+	    "$prefix$remainder";
 }
=20
 sub list_and_choose {
@@ -257,21 +270,21 @@ sub list_and_choose {
 		for ($i =3D 0; $i < @stuff; $i++) {
 			my $chosen =3D $chosen[$i] ? '*' : ' ';
 			my $print =3D $stuff[$i];
-			if (ref $print) {
-				if ((ref $print) eq 'ARRAY') {
-					$print =3D @prefixes ?
-					    highlight_prefix(@{$prefixes[$i]}) :
-					    $print->[0];
-				}
-				else {
-					my $value =3D @prefixes ?
-					    highlight_prefix(@{$prefixes[$i]}) :
-					    $print->{VALUE};
-					$print =3D sprintf($status_fmt,
-					    $print->{INDEX},
-					    $print->{FILE},
-					    $value);
-				}
+			my $ref =3D ref $print;
+			my $highlighted =3D highlight_prefix(@{$prefixes[$i]})
+			    if @prefixes;
+			if ($ref eq 'ARRAY') {
+				$print =3D $highlighted || $print->[0];
+			}
+			elsif ($ref eq 'HASH') {
+				my $value =3D $highlighted || $print->{VALUE};
+				$print =3D sprintf($status_fmt,
+				    $print->{INDEX},
+				    $print->{FILE},
+				    $value);
+			}
+			else {
+				$print =3D $highlighted || $print;
 			}
 			printf("%s%2d: %s", $chosen, $i+1, $print);
 			if (($opts->{LIST_FLAT}) &&
--=20
1.5.3.6.953.gdffc
