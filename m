From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 18:51:39 +1200
Message-ID: <46a038f9050814235140877be7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 15 08:52:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Yp3-0002Ay-N6
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVHOGvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 02:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVHOGvp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 02:51:45 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:11617 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932101AbVHOGvp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 02:51:45 -0400
Received: by rproxy.gmail.com with SMTP id i8so737745rne
        for <git@vger.kernel.org>; Sun, 14 Aug 2005 23:51:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xn2s0izxHqM+HksoSFDvekj8wKjS1gclyvyS61g9P3wFx22vluYOWOfAr6uVhsecA9H0vLivcsokdUbJAaij95v38kkujkHqSYiLWzYOKqKpMM5eesxXmVzKdYK0l8oUa7x6FpliNfbWubyacPERDuPE9B2HQZJaS6MYIQ2qPY8=
Received: by 10.38.79.11 with SMTP id c11mr1856294rnb;
        Sun, 14 Aug 2005 23:51:39 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Sun, 14 Aug 2005 23:51:39 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add -k kill keyword expansion option to git-cvsimport

Early versions of git-cvsimport defaulted to using preexisting keyword
expansion settings. This change preserves compatibility with existing cvs
imports and allows new repository migrations to kill keyword expansion.

Should improve our chances of detecting merges and reduce imported
repository size.

Signed-off: Martin Langhoff <martin.langhoff@gmail.com>
---

 Documentation/git-cvsimport-script.txt |    7 ++++++-
 git-cvsimport-script                   |   10 ++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

f0b33908e48ac75a1e3f08a3e3159de3a9a371d9
diff --git a/Documentation/git-cvsimport-script.txt
b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 --------
 'git-cvsimport-script' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
                       [ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
-                       [ -C <GIT_repository> ] [ -i ] [ <CVS_module> ]
+                       [ -C <GIT_repository> ] [ -i ] [ -k ] [ <CVS_module> ]


 DESCRIPTION
@@ -34,6 +34,11 @@ OPTIONS
       ensures the working directory and cache remain untouched and will
       not create them if they do not exist.

+-k::
+       Kill keywords: will extract files with -ko from the CVS archive
+       to avoid noisy changesets. Highly recommended, but off by default
+       to preserve compatibility with early imported trees.
+
 -o <branch-for-HEAD>::
       The 'HEAD' branch from CVS is imported to the 'origin' branch within
       the git repository, as 'HEAD' already has a special meaning for git.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -35,12 +35,12 @@ sub usage() {
 Usage: ${\basename $0}     # fetch/update GIT from CVS
       [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
       [ -p opts-for-cvsps ] [ -C GIT_repository ] [ -z fuzz ]
-       [ -i ] [ CVS_module ]
+       [ -i ] [ -k ] [ CVS_module ]
 END
       exit(1);
 }

-getopts("hivo:d:p:C:z:") or usage();
+getopts("hivko:d:p:C:z:") or usage();
 usage if $opt_h;

 @ARGV <= 1 or usage();
@@ -218,8 +218,10 @@ sub _file {
       my($self,$fn,$rev) = @_;
       $self->{'socketo'}->write("Argument -N\n") or return undef;
       $self->{'socketo'}->write("Argument -P\n") or return undef;
-       # $self->{'socketo'}->write("Argument -ko\n") or return undef;
-       # -ko: Linus' version doesn't use it
+       # -ko: Linus' version doesn't use it - defaults to off
+       if ($opt_k) {
+           $self->{'socketo'}->write("Argument -ko\n") or return undef;
+       }
       $self->{'socketo'}->write("Argument -r\n") or return undef;
       $self->{'socketo'}->write("Argument $rev\n") or return undef;
       $self->{'socketo'}->write("Argument --\n") or return undef;
