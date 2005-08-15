From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: [PATCH] Add -k kill keyword expansion option to git-cvsimport - revised
Date: Mon, 15 Aug 2005 23:32:36 +1200
Message-ID: <46a038f905081504327a8bfb38@mail.gmail.com>
References: <20050815113123.BDEA03300AD@ng.eduforge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 15 13:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4dCq-0005Kc-AF
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 13:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVHOLch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 07:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVHOLch
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 07:32:37 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:10297 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932676AbVHOLch convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 07:32:37 -0400
Received: by rproxy.gmail.com with SMTP id i8so758785rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 04:32:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qoGQNOdLr9Ir7WUZg7j32moQLeYnCjW6shYiLwWINoM0EJOvDoWSrwEq0qYeWnxteie7t6fgmXSC1H6s8CKSptuIrDiXpMsYGY+m8ek/kkbXe3faMrGD4D8V6Kf2fayCw5q4kXMB71fYxxciBPQ3ViITG9k4Ac/H1xTs8Dahg4I=
Received: by 10.38.181.48 with SMTP id d48mr1924044rnf;
        Mon, 15 Aug 2005 04:32:36 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 04:32:36 -0700 (PDT)
To: GIT <git@vger.kernel.org>
In-Reply-To: <20050815113123.BDEA03300AD@ng.eduforge.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add -k kill keyword expansion option to git-cvsimport - revised

Early versions of git-cvsimport defaulted to using preexisting keyword
expansion settings. This change preserves compatibility with existing cvs
imports and allows new repository migrations to kill keyword expansion.

After exploration of the different -k modes in the cvs protocol, we use -kk
which kills keyword expansion wherever possible. Against the protocol
spec, -ko and -kb will sometimes expand keywords.

Should improve our chances of detecting merges and reduce imported
repository size.

Signed-off: Martin Langhoff <martin.langhoff@gmail.com>
---

 Documentation/git-cvsimport-script.txt |    7 ++++++-
 git-cvsimport-script                   |   12 +++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

b30d52a3327183d371416661fc2c7d168791b3bd
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
+       Kill keywords: will extract files with -kk from the CVS archive
+       to avoid noisy changesets. Highly recommended, but off by default
+       to preserve compatibility with early imported trees.
+
 -o <branch-for-HEAD>::
        The 'HEAD' branch from CVS is imported to the 'origin' branch within
        the git repository, as 'HEAD' already has a special meaning for git.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -28,19 +28,19 @@ use POSIX qw(strftime dup2);
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";

-our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i);

 sub usage() {
        print STDERR <<END;
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
+       # -kk: Linus' version doesn't use it - defaults to off
+       if ($opt_k) {
+           $self->{'socketo'}->write("Argument -kk\n") or return undef;
+       }
        $self->{'socketo'}->write("Argument -r\n") or return undef;
        $self->{'socketo'}->write("Argument $rev\n") or return undef;
        $self->{'socketo'}->write("Argument --\n") or return undef;
