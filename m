From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Subject: [PATCH] use refnames instead of "left"/"right" in dirdiffs
Date: Wed, 27 Mar 2013 23:13:17 +0100
Message-ID: <1364422397.8091.1.camel@heisenberg.scientia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha512";
	protocol="application/x-pkcs7-signature";
	boundary="=-v4mW7m8IXEgm3O5aJFpw"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 23:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKyhW-0000cl-4W
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab3C0WTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:19:42 -0400
Received: from mailgw02.dd24.net ([193.46.215.43]:60274 "EHLO
	mailgw02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3C0WTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:19:41 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2013 18:19:41 EDT
Received: from localhost (amavis01.dd24.net [192.168.1.111])
	by mailgw02.dd24.net (Postfix) with ESMTP id 4E7C1356816
	for <git@vger.kernel.org>; Wed, 27 Mar 2013 22:13:25 +0000 (GMT)
X-Virus-Scanned: domaindiscount24.com mail filter gateway
Received: from mailgw02.dd24.net ([192.168.1.197])
	by localhost (amavis01.dd24.net [192.168.1.105]) (amavisd-new, port 10197)
	with ESMTP id pNYdt33gXEqG for <git@vger.kernel.org>;
	Wed, 27 Mar 2013 22:13:20 +0000 (GMT)
Received: from [192.168.0.101] (host-188-174-221-1.customer.m-online.net [188.174.221.1])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mailgw02.dd24.net (Postfix) with ESMTPSA id 073933567BF
	for <git@vger.kernel.org>; Wed, 27 Mar 2013 22:13:19 +0000 (GMT)
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219341>


--=-v4mW7m8IXEgm3O5aJFpw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, when a dir-diff is made with git-difftool the two revisions are
stored in two temporary directories ".../left" and ".../right".
Many difftools show these pathnames in ther UI and therefore it would be he=
lpful
for users, if actual reference names specified as progam arguments was used
instead.

Reference names might contain slash / characters which are not allowed to b=
e
part of a file name. These must therefore be encoded.

Also, reference names that would could possibly "break out" of the temporar=
y
directory (e.g. "/foo", "foo/../bar" or "foo/././bar") must be sanitised.
* Added a subroutine escape_reference_to_single_directory_name() which enco=
des a
  reference name to a valid single directory name.
  Any occurance of a slash / is replaced by two backslashes \\.
  Having a backslash \ in a reference name should be forbidden, but just to=
 be
  save from collisions, any occurance of a backslash \ is replaced by a
  backslash followed by an underscore \_ at first.

* Use this new function to construct the pathnames of the temporary directo=
ries
  for the two revisions in dir-diffs.

Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name=
>

diff --git a/git-difftool.perl b/git-difftool.perl
index 12231fb..53e756d 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -83,6 +83,28 @@ sub exit_cleanup
        exit($status | ($status >> 8));
 }
=20
+sub escape_reference_to_single_directory_name
+{
+       # Git allows reference names (see git-check-ref-format(1)) which ca=
nnot
+       # be directly mapped to a single directory name.
+       #
+       # This subroutines replaces any occurance of a slash / by two
+       # backslashes \\.
+       # Thereby, break-out attempts like "/foo", "foo/../bar" or "foo/./.=
/bar"
+       # are prevented, too.
+       #
+       # Having a backslash \ in a reference name should be forbidden, but=
 just
+       # to be save from collisions, any occurance of a backslash \ is rep=
laced
+       # by a backslash followed by an underscore \_ at first.
+
+       my ($commit_name)  =3D @_;
+
+       $commit_name =3D~ s/\\/\\_/g;
+       $commit_name =3D~ s/\//\\\\/g;
+
+       return $commit_name;
+}
+
 sub setup_dir_diff
 {
        my ($repo, $workdir, $symlinks) =3D @_;
@@ -169,8 +191,13 @@ EOF
=20
        # Setup temp directories
        my $tmpdir =3D tempdir('git-difftool.XXXXX', CLEANUP =3D> 0, TMPDIR=
 =3D> 1);
-       my $ldir =3D "$tmpdir/left";
-       my $rdir =3D "$tmpdir/right";
+       my $ldir =3D "$tmpdir/" . escape_reference_to_single_directory_name=
($ARGV[0]);
+       my $rdir =3D "$tmpdir/";
+       if (@ARGV < 2) {
+               $rdir .=3D 'HEAD';
+       } else {
+               $rdir .=3D escape_reference_to_single_directory_name($ARGV[=
1]);
+       }
        mkpath($ldir) or exit_cleanup($tmpdir, 1);
        mkpath($rdir) or exit_cleanup($tmpdir, 1);
=20


--=-v4mW7m8IXEgm3O5aJFpw
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCCEP4w
ggV1MIIDXaADAgECAgMBAYIwDQYJKoZIhvcNAQEFBQAwVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4x
HjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMg
Um9vdDAeFw0xMjA3MjMxNDU2NDVaFw0xNDA3MjMxNDU2NDVaMHwxITAfBgNVBAMTGENocmlzdG9w
aCBBbnRvbiBNaXR0ZXJlcjEkMCIGCSqGSIb3DQEJARYVY2FsZXN0eW9Ac2NpZW50aWEubmV0MTEw
LwYJKoZIhvcNAQkBFiJtYWlsQGNocmlzdG9waC5hbnRvbi5taXR0ZXJlci5uYW1lMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqv+F91K5vyBwiGFMqj6wTehWdqZnfFeXqT8g5b3qrXWL
ywSzcoD9xtyoRqAgOCX+PSmBpm6pPhe31VnBtc3HcBMe4rSico9/Z2H9h1l6IMVEnyhabWzoKbE3
BFrsYJGthJCbhK072G8AhCk+5p+L+knLhQXN0Ph7MJbdY26o3M4vjsXFNbJL8TOYxo80cGD1LIh2
SUZFqaIG24TVmTW8F4jD5Z9/NEwJa8kQK+VBNHUntXYNah4Reh0jSsGnq9Pg3Hf4KC+F0IR8QgBm
SnwitMFUX9UnhLEvRQxjDI1tm+h6RxfjlV7moI68Ulh7bcdPhM/z2Q16XmaY12rc85pSRQIDAQAB
o4IBJjCCASIwDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIgb3duIGNl
cnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2VydC5vcmcwQAYD
VR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMDBglghkgB
hvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5jYWNlcnQub3Jn
MEQGA1UdEQQ9MDuBFWNhbGVzdHlvQHNjaWVudGlhLm5ldIEibWFpbEBjaHJpc3RvcGguYW50b24u
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
+G8T/HNZ92ZCdB6K4/jc0m+YnMtHmJVABfvpAgMBAAGjgb8wgbwwDwYDVR0TAQH/BAUwAwEB/zBd
BggrBgEFBQcBAQRRME8wIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLkNBY2VydC5vcmcvMCgGCCsG
AQUFBzAChhxodHRwOi8vd3d3LkNBY2VydC5vcmcvY2EuY3J0MEoGA1UdIARDMEEwPwYIKwYBBAGB
kEowMzAxBggrBgEFBQcCARYlaHR0cDovL3d3dy5DQWNlcnQub3JnL2luZGV4LnBocD9pZD0xMDAN
BgkqhkiG9w0BAQQFAAOCAgEAfwiIodoaUEnaifuhCHLzivcexDq0eVsgMLFF3sJd02Vp8cJdVFQ8
hV+5e0KRwpn9G1Gbq0aloRBTnm2IrHNuLDOm8PSe4HXBPohFqeFmQ/5WWtF6QXj3QNpKOvELW6W7
FgbmwueTuYVNl0+xHjhDgO+bDYzvuKdgAIdXfR5EHMsj75s8mZ2vtSkcRXkWlk0nbfEcbMPCVWSz
vBTi86QfHjL8JxUFz90urj6CYXvwIRAY9kTqUzn53NCaIODGu+C7Wk/EmcgHvbW9otsuYg1CNEG8
/4uK9VEiqogwAOKw1Ly+ZbrVA1d5m+jcyE34UO2RpVIooqz7Nlg+6ZQrkVCHG9Ze1ozM9w8QDFJO
0BZh5eUKbL8Xx3JGV5yY9WxgY3pvXrlOL8i5ubtqhbyYDe35PpeENJSuAK+h5eeSbk698+LZFItc
0usBbKAXpS0Q65x6Sr297s797SJAq3A4iPUKh2rCqwVgyUgF2lPB3kR3arPzPDztgLymOEopJF/+
WTubJXpWYwBkuV2kYn1XNk+tg+8fklOgjndX3eVhET0jAJBMPPqjYJMEo6819g5qj09KYKeFBWxG
oY/0x3bjoVlX93GyxG4UXG1tQWbfG5Ox1ADD7svPPD0hgKlfY2X83eBfpPQr8IVxQdRnJfsasZeu
1pmCE0HSbqUbmSeA5wupqAAxggLtMIIC6QIBATBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4w
HAYDVQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJv
b3QCAwEBgjANBglghkgBZQMEAgMFAKCCAWMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTMwMzI3MjIxMzE3WjBPBgkqhkiG9w0BCQQxQgRAABDsUBER5AdYL24CURpQ
TSOI4qljSofxXBjOUqzCfr5nPXs+HmV4pxbsUyd2LUO4k53TKtG9NSZjSx5sCJB6xDBqBgkrBgEE
AYI3EAQxXTBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYDVQQLExVodHRwOi8vd3d3LkNB
Y2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJvb3QCAwEBgjBsBgsqhkiG9w0BCRAC
CzFdoFswVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0
Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMgUm9vdAIDAQGCMA0GCSqGSIb3DQEBAQUABIIB
ADH+S6qzjA0lkZi0HAbXKuIve2k5+guvJbKtQ7VKslNTxTItEBheTDmWA8mMkRQTDNAm4Nd9TqqB
cGZX/6LyUply0ETSe321gN7QkfhtygJSTZpd8jtHvRFewBBxRxvvzSKqgPa+GGesX/AeHnGmbPz1
0T5Ecl+cxO/wxzCFYwqqMWYEQDMr9NCB5pibznIORIVS/64ZtkaBjMsbxg0rIMoKvBnmUAUBh++c
SJXysSQIwGnhq2uxmVS7gQn89LikhFVHEHvrElqZbDYB8ZRfbD2Cvj0SsiUkm+rTBlXhjDaaq6Nl
IdTcusUi3xpkpdZdR11CGuiVPga7+CRDofrrfcAAAAAAAAA=


--=-v4mW7m8IXEgm3O5aJFpw--
