From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Wed, 2 May 2007 00:12:13 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705020012.13302.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <200704271223.03468.ismail@pardus.org.tr> <7vhcr1obuo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t06NGGqEpV97ONJ"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 23:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HizcY-0006CA-75
	for gcvg-git@gmane.org; Tue, 01 May 2007 23:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423659AbXEAVKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 17:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423650AbXEAVKq
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 17:10:46 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:39064 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423659AbXEAVKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 17:10:39 -0400
Received: from southpark.local (unknown [85.101.46.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id BD8BE5F851CC;
	Wed,  2 May 2007 00:10:28 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vhcr1obuo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45978>

--Boundary-00=_t06NGGqEpV97ONJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 27 April 2007 22:29:03 you wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> >> Which means that there is something else going on.  Your change
> >> may fix what you observed (I do not doubt that it fixed what you
> >> observed for you), but without understanding what really is
> >> going on (iow, why it is a fix, when the documentation clearly
> >> indicates they should be equivalent and it should not fix
> >> anything), we cannot tell what *ELSE* we are breaking with this
> >> change.
> >
> > That might be a bug in Encode itself indeed, I will dig a bit more.
> > Thanks.
>
> Thanks.

Ok found out the reason. decode() tries to decode data that is already UTF-=
8=20
and borks.

This is from Encode.pm :

sub decode_utf8($;$) {
    my ( $str, $check ) =3D @_;
    return $str if is_utf8($str); <--- Checks if the $str is already UTF-8
    if ($check) {
        return decode( "utf8", $str, $check ); <--- Else do what gitweb does
    [...]

So my patch is indeed correct. I attach it again for reference. Can it be=20
please applied?

Regards,
ismail

--Boundary-00=_t06NGGqEpV97ONJ
Content-Type: text/x-diff;
  charset="utf-8";
  name="decode-utf8.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="decode-utf8.patch"

=2D-- gitweb/gitweb.perl	2007-04-24 16:53:00.000000000 +0300
+++ gitweb/gitweb.perl	2007-04-24 16:54:22.000000000 +0300
@@ -566,12 +566,6 @@
 	return $input;
 }
=20
=2D# very thin wrapper for decode("utf8", $str, Encode::FB_DEFAULT);
=2Dsub to_utf8 {
=2D	my $str =3D shift;
=2D	return decode("utf8", $str, Encode::FB_DEFAULT);
=2D}
=2D
 # quote unsafe chars, but keep the slash, even when it's not
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
@@ -596,7 +590,7 @@
 	my $str =3D shift;
 	my %opts =3D @_;
=20
=2D	$str =3D to_utf8($str);
+	$str =3D decode_utf8($str);
 	$str =3D $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =3D~ s/ /&nbsp;/g;
@@ -610,7 +604,7 @@
 	my $str =3D shift;
 	my %opts =3D @_;
=20
=2D	$str =3D to_utf8($str);
+	$str =3D decode_utf8($str);
 	$str =3D $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =3D~ s/ /&nbsp;/g;
@@ -893,7 +887,7 @@
=20
 	if (length($short) < length($long)) {
 		return $cgi->a({-href =3D> $href, -class =3D> "list subject",
=2D		                -title =3D> to_utf8($long)},
+		                -title =3D> decode_utf8($long)},
 		       esc_html($short) . $extra);
 	} else {
 		return $cgi->a({-href =3D> $href, -class =3D> "list subject"},
@@ -1110,7 +1104,7 @@
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr =3D {
 					path =3D> $path,
=2D					owner =3D> to_utf8($owner),
+					owner =3D> decode_utf8($owner),
 				};
 				push @list, $pr
 			}
@@ -1139,7 +1133,7 @@
 			$pr =3D unescape($pr);
 			$ow =3D unescape($ow);
 			if ($pr eq $project) {
=2D				$owner =3D to_utf8($ow);
+				$owner =3D decode_utf8($ow);
 				last;
 			}
 		}
@@ -1613,7 +1607,7 @@
 	}
 	my $owner =3D $gcos;
 	$owner =3D~ s/[,;].*$//;
=2D	return to_utf8($owner);
+	return decode_utf8($owner);
 }
=20
 ## ......................................................................
@@ -1696,7 +1690,7 @@
=20
 	my $title =3D "$site_name";
 	if (defined $project) {
=2D		$title .=3D " - " . to_utf8($project);
+		$title .=3D " - " . decode_utf8($project);
 		if (defined $action) {
 			$title .=3D "/$action";
 			if (defined $file_name) {
@@ -1969,7 +1963,7 @@
=20
 	print "<div class=3D\"page_path\">";
 	print $cgi->a({-href =3D> href(action=3D>"tree", hash_base=3D>$hb),
=2D	              -title =3D> 'tree root'}, to_utf8("[$project]"));
+	              -title =3D> 'tree root'}, decode_utf8("[$project]"));
 	print " / ";
 	if (defined $name) {
 		my @dirname =3D split '/', $name;
@@ -2584,7 +2578,7 @@
 		($pr->{'age'}, $pr->{'age_string'}) =3D @aa;
 		if (!defined $pr->{'descr'}) {
 			my $descr =3D git_get_project_description($pr->{'path'}) || "";
=2D			$pr->{'descr_long'} =3D to_utf8($descr);
+			$pr->{'descr_long'} =3D decode_utf8($descr);
 			$pr->{'descr'} =3D chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
@@ -3616,7 +3610,7 @@
 		$hash =3D git_get_head_hash($project);
 	}
=20
=2D	my $filename =3D to_utf8(basename($project)) . "-$hash.tar.$suffix";
+	my $filename =3D decode_utf8(basename($project)) . "-$hash.tar.$suffix";
=20
 	print $cgi->header(
 		-type =3D> "application/$ctype",

--Boundary-00=_t06NGGqEpV97ONJ--
