From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 2/3] implement gitcvs.usecrlfattr
Date: Wed, 14 May 2008 22:35:47 -0600
Message-ID: <1210826148-8708-3-git-send-email-mmogilvi_git@miniinfo.net>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1210826148-8708-2-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 06:36:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwVCz-0001W0-NY
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 06:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYEOEgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 00:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYEOEgB
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 00:36:01 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:60851
	"EHLO QMTA08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751468AbYEOEf4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 00:35:56 -0400
Received: from OMTA14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by QMTA08.westchester.pa.mail.comcast.net with comcast
	id Rebc1Z0031HzFnQ5806j00; Thu, 15 May 2008 04:35:35 +0000
Received: from fast.fake.domain.org ([75.70.160.185])
	by OMTA14.westchester.pa.mail.comcast.net with comcast
	id Rgbt1Z00F40J0Bv3a00000; Thu, 15 May 2008 04:35:54 +0000
X-Authority-Analysis: v=1.0 c=1 a=x6wSr6WJCuPq7gmNE9MA:9
 a=hSQuJCcBFNyrhOYmYUwA:7 a=j9ITLBzh-0PXCXVOiv4VXtu2JXcA:4 a=3cjVDzgxsZYA:10
 a=f3vTY2RCmVgA:10
Received: from localhost.localdomain(really [192.168.30.96]) by fast.fake.domain.org
	via sendmail with esmtp
	id <m1JwVC3-000twRC@fast.fake.domain.org>
	for <mmogilvi_git@miniinfo.net>; Wed, 14 May 2008 22:35:51 -0600 (MDT)
	(Smail-3.2 1996-Jul-4 #13 built 1998-Aug-8)
X-Mailer: git-send-email 1.5.4.3.340.g97b97
In-Reply-To: <1210826148-8708-2-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82174>

If gitcvs.usecrlfattr is set to true, git-cvsserver will consult
the "crlf" for each file to determine if it should mark the file
as binary (-kb).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

There may be a performance issue with using a separate invocation of
git-check-attr for every file.  Perhaps an additional patch is needed
to reorganize things to check multiple files in one invocation.

 Documentation/config.txt        |   23 ++++--
 Documentation/git-cvsserver.txt |   26 +++++-
 git-cvsserver.perl              |   71 +++++++++++++---
 t/t9401-git-cvsserver-crlf.sh   |  178 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 276 insertions(+), 22 deletions(-)
 create mode 100755 t/t9401-git-cvsserver-crlf.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a6fc5a2..820795f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -645,11 +645,21 @@ gitcvs.logfile::
 	Path to a log file where the CVS server interface well... logs
 	various stuff. See linkgit:git-cvsserver[1].
 
+gitcvs.usecrlfattr
+	If true, the server will look up the `crlf` attribute for
+	files to determine the '-k' modes to use. If `crlf` is set,
+	the '-k' mode will be left blank, so cvs clients will
+	treat it as text. If `crlf` is explicitly unset, the file
+	will be set with '-kb' mode, which supresses any newline munging
+	the client might otherwise do. If `crlf` is not specified,
+	then 'gitcvs.allbinary' is used. See linkgit:gitattribute[5].
+
 gitcvs.allbinary::
-	If true, all files are sent to the client in mode '-kb'. This
-	causes the client to treat all files as binary files which suppresses
-	any newline munging it otherwise might do. A work-around for the
-	fact that there is no way yet to set single files to mode '-kb'.
+	If true, all files not otherwise specified using
+	'gitcvs.usecrlfattr' and an explicitly set or unset `crlf`
+	attribute are sent to the client in mode '-kb'. This
+	causes the client to treat them as binary files which
+	suppresses any newline munging it otherwise might do.
 
 gitcvs.dbname::
 	Database used by git-cvsserver to cache revision information
@@ -680,8 +690,9 @@ gitcvs.dbTableNamePrefix::
 	linkgit:git-cvsserver[1] for details).  Any non-alphabetic
 	characters will be replaced with underscores.
 
-All gitcvs variables except for 'gitcvs.allbinary' can also be
-specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
+All gitcvs variables except for 'gitcvs.usecrlfattr' and
+'gitcvs.allbinary' can also be specified as
+'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index b110671..8393028 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -301,11 +301,27 @@ checkout, diff, status, update, log, add, remove, commit.
 Legacy monitoring operations are not supported (edit, watch and related).
 Exports and tagging (tags and branches) are not supported at this stage.
 
-The server should set the '-k' mode to binary when relevant, however,
-this is not really implemented yet. For now, you can force the server
-to set '-kb' for all files by setting the `gitcvs.allbinary` config
-variable. In proper GIT tradition, the contents of the files are
-always respected. No keyword expansion or newline munging is supported.
+CRLF Line Ending Conversions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+By default the server leaves the '-k' mode blank for all files,
+which causes the cvs client to treat them as a text files, subject
+to crnl conversion on some platforms.
+
+You can make the server use `crnl` attributes to set the '-k' modes
+for files by setting the `gitcvs.usecrlfattr` config variable.
+In this case, if `crlf` is explicitly unset ('-crnl'), then the
+will set '-kb' mode, for binary files.  If it `crlf` is set,
+then the '-k' mode will explicitly be left blank.  See
+also linkgit:gitattributes[5] for more information about the `crlf`
+attribute.
+
+Alternatively, if `gitcvs.usecrlfattr` config is not enabled
+or if the `crlf` attribute is unspecified for a filename, then
+the server uses the `gitcvs.allbinary` for the default setting.
+If `gitcvs.allbinary` is set, then the files not otherwise
+specified will default to '-kb' mode. Otherwise the '-k' mode
+is left blank.
 
 Dependencies
 ------------
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 674892b..58206ae 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -502,7 +502,7 @@ sub req_add
                 print $state->{CVSROOT} . "/$state->{module}/$filename\n";
 
                 # this is an "entries" line
-                my $kopts = kopts_from_path($filepart);
+                my $kopts = kopts_from_path($filename);
                 $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
                 print "/$filepart/1.$meta->{revision}//$kopts/\n";
                 # permissions
@@ -533,9 +533,25 @@ sub req_add
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        my $kopts = kopts_from_path($filepart);
+        my $kopts = kopts_from_path($filename);
         print "/$filepart/0//$kopts/\n";
 
+        my $requestedKopts = $state->{opt}{k};
+        if(defined($requestedKopts))
+        {
+            $requestedKopts = "-k$requestedKopts";
+        }
+        else
+        {
+            $requestedKopts = "";
+        }
+        if( $kopts ne $requestedKopts )
+        {
+            $log->warn("Ignoring requested -k='$requestedKopts'"
+                        . " for '$filename'; detected -k='$kopts' instead");
+            #TODO: Also have option to send warning to user?
+        }
+
         $addcount++;
     }
 
@@ -615,7 +631,7 @@ sub req_remove
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        my $kopts = kopts_from_path($filepart);
+        my $kopts = kopts_from_path($filename);
         print "/$filepart/-1.$wrev//$kopts/\n";
 
         $rmcount++;
@@ -785,6 +801,7 @@ sub req_co
     argsplit("co");
 
     my $module = $state->{args}[0];
+    $state->{module} = $module;
     my $checkout_path = $module;
 
     # use the user specified directory if we're given it
@@ -862,6 +879,7 @@ sub req_co
         # Don't want to check out deleted files
         next if ( $git->{filehash} eq "deleted" );
 
+        my $fullName = $git->{name};
         ( $git->{name}, $git->{dir} ) = filenamesplit($git->{name});
 
        if (length($git->{dir}) && $git->{dir} ne './'
@@ -892,7 +910,7 @@ sub req_co
        print $state->{CVSROOT} . "/$module/" . ( defined ( $git->{dir} ) and $git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "$git->{name}\n";
 
         # this is an "entries" line
-        my $kopts = kopts_from_path($git->{name});
+        my $kopts = kopts_from_path($fullName);
         print "/$git->{name}/1.$git->{revision}//$kopts/\n";
         # permissions
         print "u=$git->{mode},g=$git->{mode},o=$git->{mode}\n";
@@ -1101,7 +1119,7 @@ sub req_update
 		print $state->{CVSROOT} . "/$state->{module}/$filename\n";
 
 		# this is an "entries" line
-		my $kopts = kopts_from_path($filepart);
+		my $kopts = kopts_from_path($filename);
 		$log->debug("/$filepart/1.$meta->{revision}//$kopts/");
 		print "/$filepart/1.$meta->{revision}//$kopts/\n";
 
@@ -1149,7 +1167,7 @@ sub req_update
                     print "Merged $dirpart\n";
                     $log->debug($state->{CVSROOT} . "/$state->{module}/$filename");
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    my $kopts = kopts_from_path($filepart);
+                    my $kopts = kopts_from_path("$dirpart/$filepart");
                     $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
                     print "/$filepart/1.$meta->{revision}//$kopts/\n";
                 }
@@ -1165,7 +1183,7 @@ sub req_update
                 {
                     print "Merged $dirpart\n";
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    my $kopts = kopts_from_path($filepart);
+                    my $kopts = kopts_from_path("$dirpart/$filepart");
                     print "/$filepart/1.$meta->{revision}/+/$kopts/\n";
                 }
             }
@@ -1416,7 +1434,7 @@ sub req_ci
             }
             print "Checked-in $dirpart\n";
             print "$filename\n";
-            my $kopts = kopts_from_path($filepart);
+            my $kopts = kopts_from_path($filename);
             print "/$filepart/1.$meta->{revision}//$kopts/\n";
         }
     }
@@ -2296,10 +2314,24 @@ sub kopts_from_path
 {
 	my ($path) = @_;
 
-	# Once it exists, the git attributes system should be used to look up
-	# what attributes apply to this path.
+    if ( defined ( $cfg->{gitcvs}{usecrlfattr} ) and
+         $cfg->{gitcvs}{usecrlfattr} =~ /\s*(1|true|yes)\s*$/i )
+    {
+        my ($val) = check_attr( "crlf", $path );
+        if ( $val eq "set" )
+        {
+            return "";
+        }
+        elsif ( $val eq "unset" )
+        {
+            return "-kb"
+        }
+        else
+        {
+            $log->info("Unrecognized check_attr crlf $path : $val");
+        }
+    }
 
-	# Until then, take the setting from the config file
     unless ( defined ( $cfg->{gitcvs}{allbinary} ) and $cfg->{gitcvs}{allbinary} =~ /^\s*(1|true|yes)\s*$/i )
     {
 		# Return "" to give no special treatment to any path
@@ -2311,6 +2343,23 @@ sub kopts_from_path
     }
 }
 
+sub check_attr
+{
+    my ($attr,$path) = @_;
+    ensureWorkTree();
+    if ( open my $fh, '-|', "git", "check-attr", $attr, "--", $path )
+    {
+        my $val = <$fh>;
+        close $fh;
+        $val =~ s/.*: ([^:\r\n]*)\s*$/$1/;
+        return $val;
+    }
+    else
+    {
+        return undef;
+    }
+}
+
 # Generate a CVS author name from Git author information, by taking
 # the first eight characters of the user part of the email address.
 sub cvs_author
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
new file mode 100755
index 0000000..b7a779b
--- /dev/null
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -0,0 +1,178 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Matthew Ogilvie
+# Parts adapted from other tests.
+#
+
+test_description='git-cvsserver -kb modes
+
+tests -kb mode for binary files when accessing a git
+repository using cvs CLI client via git-cvsserver server'
+
+. ./test-lib.sh
+
+q_to_nul () {
+    perl -pe 'y/Q/\000/'
+}
+
+q_to_cr () {
+    tr Q '\015'
+}
+
+marked_as () {
+    foundEntry="$(grep "^/$2/" "$1/CVS/Entries")"
+    if [ x"$foundEntry" = x"" ] ; then
+       echo "NOT FOUND: $1 $2 1 $3" >> "${WORKDIR}/marked.log"
+       return 1
+    fi
+    test x"$(grep "^/$2/" "$1/CVS/Entries" | cut -d/ -f5)" = x"$3"
+    stat=$?
+    echo "$1 $2 $stat '$3'" >> "${WORKDIR}/marked.log"
+    return $stat
+}
+
+not_present() {
+    foundEntry="$(grep "^/$2/" "$1/CVS/Entries")"
+    if [ -r "$1/$2" ] ; then
+        echo "Error: File still exists: $1 $2" >> "${WORKDIR}/marked.log"
+        return 1;
+    fi
+    if [ x"$foundEntry" != x"" ] ; then
+        echo "Error: should not have found: $1 $2" >> "${WORKDIR}/marked.log"
+        return 1;
+    else
+        echo "Correctly not found: $1 $2" >> "${WORKDIR}/marked.log"
+        return 0;
+    fi
+}
+
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    test_expect_success 'skipping git-cvsserver tests, cvs not found' :
+    test_done
+    exit
+fi
+perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
+    test_done
+    exit
+}
+
+unset GIT_DIR GIT_CONFIG
+WORKDIR=$(pwd)
+SERVERDIR=$(pwd)/gitcvs.git
+git_config="$SERVERDIR/config"
+CVSROOT=":fork:$SERVERDIR"
+CVSWORK="$(pwd)/cvswork"
+CVS_SERVER=git-cvsserver
+export CVSROOT CVS_SERVER
+
+rm -rf "$CVSWORK" "$SERVERDIR"
+test_expect_success 'setup' '
+    echo "Simple text file" >textfile.c &&
+    echo "File with embedded NUL: Q <- there" | q_to_nul > binfile.bin &&
+    mkdir subdir &&
+    echo "Another text file" > subdir/file.h &&
+    echo "Another binary: Q (this time CR)" | q_to_cr > subdir/withCr.bin &&
+    echo "Mixed up NUL, but marked text: Q <- there" | q_to_nul > mixedUp.c
+    echo "Unspecified" > subdir/unspecified.other &&
+    echo "/*.bin -crlf" > .gitattributes &&
+    echo "/*.c crlf" >> .gitattributes &&
+    echo "subdir/*.bin -crlf" >> .gitattributes &&
+    echo "subdir/*.c crlf" >> .gitattributes &&
+    echo "subdir/file.h crlf" >> .gitattributes &&
+    git add .gitattributes textfile.c binfile.bin mixedUp.c subdir/* &&
+    git commit -q -m "First Commit" &&
+    git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+    GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+    GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log"
+'
+
+test_expect_success 'cvs co (default crlf)' '
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    test x"$(grep '/-k' cvswork/CVS/Entries cvswork/subdir/CVS/Entries)" = x""
+'
+
+rm -rf cvswork
+test_expect_success 'cvs co (allbinary)' '
+    GIT_DIR="$SERVERDIR" git config --bool gitcvs.allbinary true &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    marked_as cvswork textfile.c -kb &&
+    marked_as cvswork binfile.bin -kb &&
+    marked_as cvswork .gitattributes -kb &&
+    marked_as cvswork mixedUp.c -kb &&
+    marked_as cvswork/subdir withCr.bin -kb &&
+    marked_as cvswork/subdir file.h -kb &&
+    marked_as cvswork/subdir unspecified.other -kb
+'
+
+rm -rf cvswork cvs.log
+test_expect_success 'cvs co (use attributes/allbinary)' '
+    GIT_DIR="$SERVERDIR" git config --bool gitcvs.usecrlfattr true &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    marked_as cvswork textfile.c "" &&
+    marked_as cvswork binfile.bin -kb &&
+    marked_as cvswork .gitattributes -kb &&
+    marked_as cvswork mixedUp.c "" &&
+    marked_as cvswork/subdir withCr.bin -kb &&
+    marked_as cvswork/subdir file.h "" &&
+    marked_as cvswork/subdir unspecified.other -kb
+'
+
+rm -rf cvswork
+test_expect_success 'cvs co (use attributes)' '
+    GIT_DIR="$SERVERDIR" git config --bool gitcvs.allbinary false &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    marked_as cvswork textfile.c "" &&
+    marked_as cvswork binfile.bin -kb &&
+    marked_as cvswork .gitattributes "" &&
+    marked_as cvswork mixedUp.c "" &&
+    marked_as cvswork/subdir withCr.bin -kb &&
+    marked_as cvswork/subdir file.h "" &&
+    marked_as cvswork/subdir unspecified.other ""
+'
+
+test_expect_success 'adding files' '
+    cd cvswork/subdir &&
+    echo "more text" > src.c &&
+    GIT_CONFIG="$git_config" cvs -Q add src.c >cvs.log 2>&1 &&
+    marked_as . src.c "" &&
+    echo "psuedo-binary" > temp.bin &&
+    cd .. &&
+    GIT_CONFIG="$git_config" cvs -Q add subdir/temp.bin >cvs.log 2>&1 &&
+    marked_as subdir temp.bin "-kb" &&
+    cd subdir &&
+    GIT_CONFIG="$git_config" cvs -Q ci -m "adding files" >cvs.log 2>&1 &&
+    marked_as . temp.bin "-kb" &&
+    marked_as . src.c ""
+'
+
+cd "$WORKDIR"
+test_expect_success 'updating' '
+    git pull gitcvs.git &&
+    echo 'hi' > subdir/newfile.bin &&
+    echo 'junk' > subdir/file.h &&
+    echo 'hi' > subdir/newfile.c &&
+    echo 'hello' >> binfile.bin &&
+    git add subdir/newfile.bin subdir/file.h subdir/newfile.c binfile.bin &&
+    git commit -q -m "Add and change some files" &&
+    git push gitcvs.git >/dev/null &&
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs -Q update &&
+    cd .. &&
+    marked_as cvswork textfile.c "" &&
+    marked_as cvswork binfile.bin -kb &&
+    marked_as cvswork .gitattributes "" &&
+    marked_as cvswork mixedUp.c "" &&
+    marked_as cvswork/subdir withCr.bin -kb &&
+    marked_as cvswork/subdir file.h "" &&
+    marked_as cvswork/subdir unspecified.other "" &&
+    marked_as cvswork/subdir newfile.bin -kb &&
+    marked_as cvswork/subdir newfile.c "" &&
+    echo "File with embedded NUL: Q <- there" | q_to_nul > tmpExpect1 &&
+    echo "hello" >> tmpExpect1 &&
+    cmp cvswork/binfile.bin tmpExpect1
+'
+
+test_done
-- 
1.5.4.3.340.g97b97
