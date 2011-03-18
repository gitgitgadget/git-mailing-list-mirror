From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v3 (amend) 1/3] gitweb: fix #patchNN anchors when path_info is enabled
Date: Fri, 18 Mar 2011 17:00:16 +0100
Message-ID: <201103181700.18004.jnareb@gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost> <201103181359.46600.jnareb@gmail.com> <AANLkTi=pe-ystbXhFLoOKRoCvY1axS8D9XuVyU+GxQPC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 17:00:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0c6N-0004B1-TX
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 17:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108Ab1CRQAa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 12:00:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50384 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab1CRQA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 12:00:29 -0400
Received: by fxm17 with SMTP id 17so3829293fxm.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=IYKRdXle0rGfKzdGwv80feRgKANrkS1XwcuVFOjSRAU=;
        b=qPuFlwBlrUkBluMJTzpvgSq2p8aVlyeb0DiGnEcIrzd0yf0NfgwmZ4LHlz2C6tHmbn
         Gvzszqx8g6EsJX6310ZJrofiJsyuOnEhWQ00vjL5LU+l3rbcXVEiDU8KNfKJ7GyhFEqR
         wIfxbQkXCz5B22S1/ZpSkW87bTLNXGv7dg+AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CdUsWKtjvQ/yOAp3UbiPMIYIpfrOHbnLLujXPMMMV0WP7cTkd+MqgX8PrW+2uXMACM
         Ubq4UyGdeOKI9QdVgPZuWq4G2xldLrSGMCpPSXYw2qwY/fx+mxTlfGdaUkBvuQALQsiN
         fxY7JSjnALwXw7wGpWKIEHH92Ai9IIWh+zmFA=
Received: by 10.223.55.12 with SMTP id s12mr1429632fag.124.1300464027515;
        Fri, 18 Mar 2011 09:00:27 -0700 (PDT)
Received: from [192.168.1.13] (abuz4.neoplus.adsl.tpnet.pl [83.8.197.4])
        by mx.google.com with ESMTPS id c24sm1109470fak.7.2011.03.18.09.00.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 09:00:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=pe-ystbXhFLoOKRoCvY1axS8D9XuVyU+GxQPC@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169337>

Kevin Cernekee wrotr:
> On Fri, Mar 18, 2011 at 5:59 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0$params{'project'} =3D $project unless e=
xists $params{'project'};
> >
> > + =C2=A0 =C2=A0 =C2=A0 # implicit -replay
> > + =C2=A0 =C2=A0 =C2=A0 $params{-replay} =3D 1 if (keys %params =3D=3D=
 1 && $params{-anchor});
>=20
> If this test occurs after $params{'project'} is set, it needs to coun=
t
> both 'project' and '-anchor':

Right.  I'm sorry about that.
=20
> > +       $params{-replay} =3D 1 if (keys %params =3D=3D 2 && $params=
{-anchor});

The above is not a good solution, as it hides the fact that -anchor mus=
t
be only parameter for trigger implicit -replay.

-- >8 --
=46rom: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] gitweb: fix #patchNN anchors when path_info is enabled

When $feature{'pathinfo'} is used, gitweb script sets the base URL to
itself, so that relative links to static files work correctly.  It
does it by adding something like below to HTML head:

  <base href=3D"http://HOST/gitweb.cgi">

This breaks the "patch" anchor links seen on the commitdiff pages,
because these links, being relative (<a href=3D"#patch1">), are resolve=
d
(computed) relative to the base URL and not relative to current URL,
i.e. as:

  http://HOST/gitweb.cgi#patch1

Instead, they should look like this:

  http://HOST/gitweb.cgi/myproject.git/commitdiff/35a9811ef9d68eae9afd7=
6bede121da4f89b448c#patch1

Add an "-anchor" parameter to href(), and use href(-anchor=3D>"patch1")
to generate "patch" anchor links, so that the full path is included in
the patch link.


While at it, convert

  print "foo";
  print "bar";

to

  print "foo" .
        "bar";

in the neighborhood of changes.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b04ab8c..f275adb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1199,11 +1199,15 @@ if (defined caller) {
 # -full =3D> 0|1      - use absolute/full URL ($my_uri/$my_url as base=
)
 # -replay =3D> 1      - start from a current view (replay with modific=
ations)
 # -path_info =3D> 0|1 - don't use/use path_info URL (if possible)
+# -anchor =3D> ANCHOR - add #ANCHOR to end of URL, implies -replay if =
used alone
 sub href {
 	my %params =3D @_;
 	# default is to use -absolute url() i.e. $my_uri
 	my $href =3D $params{-full} ? $my_url : $my_uri;
=20
+	# implicit -replay, must be first of implicit params
+	$params{-replay} =3D 1 if (keys %params =3D=3D 1 && $params{-anchor})=
;
+
 	$params{'project'} =3D $project unless exists $params{'project'};
=20
 	if ($params{-replay}) {
@@ -1314,6 +1318,10 @@ sub href {
 	# final transformation: trailing spaces must be escaped (URI-encoded)
 	$href =3D~ s/(\s+)$/CGI::escape($1)/e;
=20
+	if ($params{-anchor}) {
+		$href .=3D "#".esc_param($params{-anchor});
+	}
+
 	return $href;
 }
=20
@@ -4335,7 +4343,8 @@ sub git_difftree_body {
 				# link to patch
 				$patchno++;
 				print "<td class=3D\"link\">" .
-				      $cgi->a({-href =3D> "#patch$patchno"}, "patch") .
+				      $cgi->a({-href =3D> href(-anchor=3D>"patch$patchno")},
+				              "patch") .
 				      " | " .
 				      "</td>\n";
 			}
@@ -4432,8 +4441,9 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href =3D> "#patch$patchno"}, "patch");
-				print " | ";
+				print $cgi->a({-href =3D> href(-anchor=3D>"patch$patchno")},
+				              "patch") .
+				      " | ";
 			}
 			print $cgi->a({-href =3D> href(action=3D>"blob", hash=3D>$diff->{'t=
o_id'},
 			                             hash_base=3D>$hash, file_name=3D>$diff=
->{'file'})},
@@ -4452,8 +4462,9 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href =3D> "#patch$patchno"}, "patch");
-				print " | ";
+				print $cgi->a({-href =3D> href(-anchor=3D>"patch$patchno")},
+				              "patch") .
+				      " | ";
 			}
 			print $cgi->a({-href =3D> href(action=3D>"blob", hash=3D>$diff->{'f=
rom_id'},
 			                             hash_base=3D>$parent, file_name=3D>$di=
ff->{'file'})},
@@ -4494,7 +4505,8 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href =3D> "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =3D> href(-anchor=3D>"patch$patchno")},
+				              "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not onlu mode changed)
@@ -4539,7 +4551,8 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href =3D> "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =3D> href(-anchor=3D>"patch$patchno")},
+				              "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not only pure rename or copy)
--=20
1.7.3
