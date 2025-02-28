Received: from evolvis.org (evolvis.org [217.144.135.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B823DE
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.135.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724279; cv=none; b=gbWFi2Wzmhx0Rm6eniUDIQBl0ggkA4y5Q7hI9QcyDD7vP5wGFQ0SgjhilRA+moynFAM3dHk3s9OT1Hpa3Em/lWrZoS4ebXtGMgITspFzUN31Gr0wlE3KmbiYIWHO02qrnzNoyZcApkdnMhxrsMescGBQb+V1l/J9f9HBkZuCjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724279; c=relaxed/simple;
	bh=4MDOvwrksQBNDtWGuIyRkJg98oWP8kM3TwOY1mc1djY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=l6GY135MMQiwOFUh4mRdBGNrXxodi+0tNDletMbdS5TeYOs8lr7ZbgXACT5Otl0m/YW7XgLvynTwqQdy5a+l50DbWzNJGdHFsSleHNC0NwPXF6H6U9lIaD0+g9KmNlBaDjNvdzfFo+9hKcbpH6vnYABKaSnGrruHC7QZv4DUj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.144.135.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from x61p.mirbsd.org (xdsl-212-8-144-17.nc.de [212.8.144.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	(Authenticated sender: x61p@relay.evolvis.org)
	by evolvis.org (Postfix) with ESMTPSA id 1F642100119
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:31:16 +0000 (UTC)
Received: by x61p.mirbsd.org (Postfix, from userid 1000)
	id CF7CC147132; Fri, 28 Feb 2025 07:31:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by x61p.mirbsd.org (Postfix) with ESMTP id CB3E2147131
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 07:31:15 +0100 (CET)
Date: Fri, 28 Feb 2025 07:31:15 +0100 (CET)
From: Thorsten Glaser <tg@debian.org>
To: git@vger.kernel.org
Subject: =?UTF-8?Q?misc=2E_gitweb_patches_=28directories_first=2C_?=
 =?UTF-8?Q?=E2=80=A6=29?=
Message-ID: <a9673d0b-4698-fc68-1a80-10940c4a8330@debian.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi again=C2=B2,

and while at it, why not feed the remainder of my local gitweb
patches to you in the hope they can be applied.

The two extra comments are to not desynchronise the syntax
highlighting of my editor (jupp) which mis-interprets the
presence of that unescaped double quote in the regex before.

The other hunk is to render subdirectories before files in
a directory, as is prudent and expected, on Unix at least.
It may not be the most efficient way to do this (I=E2=80=99m not a
Perl programmer, but willing to learn) though does the job.

diff --git a/src/plugins/scmgit/cgi-bin/gitweb.cgi b/src/plugins/scmgit/cgi=
-bin/gitweb.cgi
index c81eef0e5d..909d55792a 100755
--- a/src/plugins/scmgit/cgi-bin/gitweb.cgi
+++ b/src/plugins/scmgit/cgi-bin/gitweb.cgi
@@ -5436,7 +5437,7 @@ sub git_patchset_body {
 =09while ($patch_line) {
=20
 =09=09# parse "git diff" header line
-=09=09if ($patch_line =3D~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"=
|[^ "]*) (.*)$/) {
+=09=09if ($patch_line =3D~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"=
|[^ "]*) (.*)$/) {  #"
 =09=09=09# $1 is from_name, which we do not use
 =09=09=09$to_name =3D unquote($2);
 =09=09=09$to_name =3D~ s!^b/!!;
@@ -7287,8 +7288,26 @@ sub git_tree {
=20
 =09=09print "</tr>\n";
 =09}
+=09# directories first
 =09foreach my $line (@entries) {
 =09=09my %t =3D parse_ls_tree_line($line, -z =3D> 1, -l =3D> $show_sizes);
+=09=09next unless ($t{'type'} eq "tree");
+
+=09=09if ($alternate) {
+=09=09=09print "<tr class=3D\"dark\">\n";
+=09=09} else {
+=09=09=09print "<tr class=3D\"light\">\n";
+=09=09}
+=09=09$alternate ^=3D 1;
+
+=09=09git_print_tree_entry(\%t, $basedir, $hash_base, $have_blame);
+
+=09=09print "</tr>\n";
+=09}
+=09# then n=C5=8Dn-directories
+=09foreach my $line (@entries) {
+=09=09my %t =3D parse_ls_tree_line($line, -z =3D> 1, -l =3D> $show_sizes);
+=09=09next if ($t{'type'} eq "tree");
=20
 =09=09if ($alternate) {
 =09=09=09print "<tr class=3D\"dark\">\n";
@@ -7422,7 +7441,7 @@ sub git_snapshot {
 =09=09$cmd .=3D ' | ' . quote_command(@{$known_snapshot_formats{$format}{'=
compressor'}});
 =09}
=20
-=09$filename =3D~ s/(["\\])/\\$1/g;
+=09$filename =3D~ s/(["\\])/\\$1/g;  #"
 =09my %latest_date;
 =09if (%co) {
 =09=09%latest_date =3D parse_date($co{'committer_epoch'}, $co{'committer_t=
z'});


bye,
//mirabilos
--=20
=E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.=E2=80=9C
=09-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every system=
=2E=E2=80=9D)
