From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC] perl: bump the required Perl version to 5.8 from 5.6.[21]
Date: Fri, 24 Sep 2010 20:00:52 +0000
Message-ID: <1285358453-19292-1-git-send-email-avarab@gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Tor Arntsen <tor@spacetec.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 22:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzESG-0002id-RS
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048Ab0IXUBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 16:01:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54838 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045Ab0IXUBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:01:03 -0400
Received: by wyb28 with SMTP id 28so2264473wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lzVpkXJiWDd0C5vNc2Ue0ZUjlkl31k2Azpb9psNuC5s=;
        b=FddAoQcllXQDN/cwrAfCPTd/EsGrasNL9pnNk8EopbG5h6zea/08CTXyxCmtn4KvxR
         wRx2qiBviUrCCTSEkogz8QBy/8flSvm57aDq4ShcHEIPkjWfnQ87GP1eRkQ81AR860Hn
         Rh3kW462aJ/NjtXfSc8Ivhx0+M3Xwe0mpr5G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vVeBlUPxKO1zV0HQytbTCcUPMJQPlNHCs/pW7qwPoovuYmFfUORC27cNRqr4Ml0QEo
         I+ifeJrjzEex3rp0taXX+i7Pibbr20PbpYofCpw3neWGFWFtP+synXEpK+XyoQyXkGnt
         xxtUL2nXpHGoOyHhTv4pg8Ma5eFS0bIonzTbs=
Received: by 10.227.148.20 with SMTP id n20mr3388883wbv.94.1285358461472;
        Fri, 24 Sep 2010 13:01:01 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm2144047wbe.5.2010.09.24.13.01.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 13:01:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a
In-Reply-To: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157048>

=46ormalize our dependency on perl 5.8, bumped from 5.6.[12]. We alread=
y
used the three-arg form of open() which was introduced in 5.6.1, but
t/t9700/test.pl explicitly depended on 5.6.2.

However git-add--interactive.pl has been failing on the 5.6 line since
it was introduced in v1.5.0-rc0~12^2~2 back in 2006 due to this open
syntax:

    sub run_cmd_pipe {
           my $fh =3D undef;
           open($fh, '-|', @_) or die;
           return <$fh>;
    }

Which when executed dies on "Can't use an undefined value as
filehandle reference". Several of our tests also fail on 5.6 (even
more when compiled with NO_PERL_MAKEMAKER=3D1):

    t2016-checkout-patch.sh
    t3904-stash-patch.sh
    t3701-add-interactive.sh
    t7105-reset-patch.sh
    t7501-commit.sh
    t9700-perl-git.sh

Our code is bitrotting on 5.6 with no-one interested in fixing it, and
pinning us to such an ancient release of Perl is keeping us from using
useful features introduced in the 5.8 release.

The 5.6 series is now over 10 years old, and the 5.6.2 maintenance
release almost 7. 5.8 on the other hand is more than 8 years old.

All the modern Unix-like operating systems have now upgraded to it or
a later version, and 5.8 packages are available for old IRIX, AIX
Solaris and Tru64 systems.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Acked-by: Tor Arntsen <tor@spacetec.no>
Acked-by: Randal L. Schwartz <merlyn@stonehenge.com>
---

A follow-up to the discussion in "Let's bump the minimum Perl version
to 5.8". I took the liberty of adding Tor and Randal's Acked-by to the
patch based on their comments in the thread. Which is why this is an
RFC, if they're OK with it it can be applied.

 INSTALL                    |    8 ++++----
 git-add--interactive.perl  |    1 +
 git-archimport.perl        |    1 +
 git-cvsexportcommit.perl   |    1 +
 git-cvsimport.perl         |    1 +
 git-cvsserver.perl         |    1 +
 git-difftool.perl          |    1 +
 git-relink.perl            |    2 +-
 git-send-email.perl        |    1 +
 git-svn.perl               |    1 +
 gitweb/gitweb.perl         |    1 +
 perl/Git.pm                |    1 +
 t/t7006/test-terminal.perl |    1 +
 t/t9700/test.pl            |    2 +-
 14 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/INSTALL b/INSTALL
index 59200b7..10a1cba 100644
--- a/INSTALL
+++ b/INSTALL
@@ -67,10 +67,10 @@ Issues of note:
 	- A POSIX-compliant shell is required to run many scripts needed
 	  for everyday use (e.g. "bisect", "pull").
=20
-	- "Perl" is needed to use some of the features (e.g. preparing a
-	  partial commit using "git add -i/-p", interacting with svn
-	  repositories with "git svn").  If you can live without these, use
-	  NO_PERL.
+	- "Perl" version 5.8 or later is needed to use some of the
+	  features (e.g. preparing a partial commit using "git add -i/-p",
+	  interacting with svn repositories with "git svn").  If you can
+	  live without these, use NO_PERL.
=20
 	- "openssl" library is used by git-imap-send to use IMAP over SSL.
 	  If you don't need it, use NO_OPENSSL.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 27fc793..a96fb53 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,5 +1,6 @@
 #!/usr/bin/perl -w
=20
+use 5.008;
 use strict;
 use Git;
=20
diff --git a/git-archimport.perl b/git-archimport.perl
index 98f3ede..947638c 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -54,6 +54,7 @@ and can contain multiple, unrelated branches.
=20
 =3Dcut
=20
+use 5.008;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 59b6722..9a8188b 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,5 +1,6 @@
 #!/usr/bin/perl -w
=20
+use 5.008;
 use strict;
 use Getopt::Std;
 use File::Temp qw(tempdir);
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 9e03eee..53869fb 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -13,6 +13,7 @@
 # The head revision is on branch "origin" by default.
 # You can change that with the '-o' option.
=20
+use 5.008;
 use strict;
 use warnings;
 use Getopt::Long;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index e9f3037..2822bed 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -15,6 +15,7 @@
 ####
 ####
=20
+use 5.008;
 use strict;
 use warnings;
 use bytes;
diff --git a/git-difftool.perl b/git-difftool.perl
index adc42de..e95e4ad 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -10,6 +10,7 @@
 #
 # Any arguments that are unknown to this script are forwarded to 'git =
diff'.
=20
+use 5.008;
 use strict;
 use warnings;
 use Cwd qw(abs_path);
diff --git a/git-relink.perl b/git-relink.perl
index 937c69a..af2e305 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -6,7 +6,7 @@
 #
 # Scan two git object-trees, and hardlink any common objects between t=
hem.
=20
-use 5.006;
+use 5.008;
 use strict;
 use warnings;
 use Getopt::Long;
diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..314e59e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -16,6 +16,7 @@
 #    and second line is the subject of the message.
 #
=20
+use 5.008;
 use strict;
 use warnings;
 use Term::ReadLine;
diff --git a/git-svn.perl b/git-svn.perl
index 9b046b6..d292224 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,6 +1,7 @@
 #!/usr/bin/env perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
+use 5.008;
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..e645d4a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7,6 +7,7 @@
 #
 # This program is licensed under the GPLv2
=20
+use 5.008;
 use strict;
 use warnings;
 use CGI qw(:standard :escapeHTML -nosticky);
diff --git a/perl/Git.pm b/perl/Git.pm
index 6cb0dd1..205e48a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -7,6 +7,7 @@ Git - Perl interface to the Git version control system
=20
 package Git;
=20
+use 5.008;
 use strict;
=20
=20
diff --git a/t/t7006/test-terminal.perl b/t/t7006/test-terminal.perl
index 73ff809..6b5f22a 100755
--- a/t/t7006/test-terminal.perl
+++ b/t/t7006/test-terminal.perl
@@ -1,4 +1,5 @@
 #!/usr/bin/perl
+use 5.008;
 use strict;
 use warnings;
 use IO::Pty;
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 671f38d..c15ca2d 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
=20
-use 5.006002;
+use 5.008;
 use warnings;
 use strict;
=20
--=20
1.7.3.256.g00e8a
