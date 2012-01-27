From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Revert "gitweb: Time::HiRes is in core for Perl 5.8"
Date: Fri, 27 Jan 2012 18:45:38 +0100
Message-ID: <201201271845.39576.jnareb@gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no> <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 18:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqprU-0008NA-5N
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 18:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab2A0RpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 12:45:14 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63385 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab2A0RpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 12:45:12 -0500
Received: by eekc14 with SMTP id c14so646813eek.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 09:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=N00TKXPFi4zwt/tpeZCCmylKmO9KmrR7rDHqwP0PWJ8=;
        b=BXJnFs9RwvykZZrvyOnSxc33hoe4seyK/PGSqi6eik95Vqau5O55wg7xhLITUQyuw3
         JZumIhvCjOmTtPW0LO/E7cL0LVJj0ONlAjccOD+E6zlKItM72EySKzqFLISun/tyt71L
         hdmfKH+IgPY19lAt1SZbUXvQJ5Hs2KHUfFqtE=
Received: by 10.14.35.73 with SMTP id t49mr2467230eea.84.1327686311545;
        Fri, 27 Jan 2012 09:45:11 -0800 (PST)
Received: from [192.168.1.13] (abvs200.neoplus.adsl.tpnet.pl. [83.8.216.200])
        by mx.google.com with ESMTPS id s16sm31984491eef.2.2012.01.27.09.45.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 09:45:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189227>

On Mon, 23 Jan 2012, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jan 23, 2012 at 05:50, Hallvard Breien Furuseth <h.b.furuseth=
@usit.uio.no> wrote:
> >
> > t9500-gitweb-standalone-no-errors fails: Git 1.7.9.rc2/1.7.8.4, RHE=
L
> > 6.2, Perl 5.10.1. =C2=A0Reverting 3962f1d756ab41c1d180e35483d1c8dff=
e51e0d1
> > fixes it. =C2=A0The commit expects Time::HiRes to be present, but R=
edHat
> > has split it out to a separate RPM perl-Time-HiRes. =C2=A0Better ad=
d a
> > comment about that, so it doesn't get re-reverted.
> >
> > Or pacify the test and expect gitweb@RHEL-users to install the RPM:
[...]
=20
> This doesn't actually fix the issue, it only sweeps it under the rug
> by making the tests pass, gitweb will still fail to compile on Red
> Hat once installed.

I think you meant "fail to run" here.

> I think the right solution is to partially revert
> 3962f1d756ab41c1d180e35483d1c8dffe51e0d1, but add a comment in the
> code indicating that it's to deal with RedHat's broken fork of Perl.

I have added comment in commit message, but not in code.  I wonder if
it would be enough.

> However even if it's required in an eval it might still fail at
> runtime in the reset_timer() function, which'll need to deal with it
> too.

It shouldn't; everything else related to timer is protected with
'if defined $t0', which is false if Time::HiRes module is not available=
=2E

Here is the patch
-- >8 --
=46rom: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Revert "gitweb: Time::HiRes is in core for Perl 5.8"

This reverts commit 3962f1d756ab41c1d180e35483d1c8dffe51e0d1.

Though Time::HiRes is a core Perl module, it doesn't necessarily mean
that it is included in 'perl' package, and that it is installed if
Perl is installed.

=46or example RedHat has split it out to a separate RPM perl-Time-HiRes=
=2E

Noticed-by: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..c86224a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -17,10 +17,12 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
-use Time::HiRes qw(gettimeofday tv_interval);
 binmode STDOUT, ':utf8';
=20
-our $t0 =3D [ gettimeofday() ];
+our $t0;
+if (eval { require Time::HiRes; 1; }) {
+	$t0 =3D [Time::HiRes::gettimeofday()];
+}
 our $number_of_git_cmds =3D 0;
=20
 BEGIN {
@@ -1142,7 +1144,7 @@ sub dispatch {
 }
=20
 sub reset_timer {
-	our $t0 =3D [ gettimeofday() ]
+	our $t0 =3D [Time::HiRes::gettimeofday()]
 		if defined $t0;
 	our $number_of_git_cmds =3D 0;
 }
@@ -3974,7 +3976,7 @@ sub git_footer_html {
 		print "<div id=3D\"generating_info\">\n";
 		print 'This page took '.
 		      '<span id=3D"generating_time" class=3D"time_span">'.
-		      tv_interval($t0, [ gettimeofday() ]).
+		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 		      ' seconds </span>'.
 		      ' and '.
 		      '<span id=3D"generating_cmd">'.
@@ -6253,7 +6255,7 @@ sub git_blame_common {
 		print 'END';
 		if (defined $t0 && gitweb_check_feature('timed')) {
 			print ' '.
-			      tv_interval($t0, [ gettimeofday() ]).
+			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 			      ' '.$number_of_git_cmds;
 		}
 		print "\n";
--=20
1.7.6
