From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 3/3] git-cvsserver: add ability to guess -kb from contents
Date: Wed, 14 May 2008 22:35:48 -0600
Message-ID: <1210826148-8708-4-git-send-email-mmogilvi_git@miniinfo.net>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1210826148-8708-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1210826148-8708-3-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 06:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwVCx-0001W0-T2
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 06:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbYEOEf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 00:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbYEOEfz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 00:35:55 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:49950
	"EHLO QMTA06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751409AbYEOEfx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 00:35:53 -0400
Received: from OMTA05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by QMTA06.westchester.pa.mail.comcast.net with comcast
	id RgW41Z00A0vyq2s5600F00; Thu, 15 May 2008 04:35:52 +0000
Received: from fast.fake.domain.org ([75.70.160.185])
	by OMTA05.westchester.pa.mail.comcast.net with comcast
	id Rgbq1Z00A40J0Bv3R00000; Thu, 15 May 2008 04:35:52 +0000
X-Authority-Analysis: v=1.0 c=1 a=SYIO-6-9SWkA:10 a=ghjZNOx5_soA:10
 a=UOw8lT3EqpaAlmvKE-0A:9 a=DFr2-9tpnKzTpsXHO6MA:7
 a=RieDrKLIODzpIVK5bwRQmfY6oF4A:4 a=3cjVDzgxsZYA:10 a=f3vTY2RCmVgA:10
Received: from localhost.localdomain(really [192.168.30.96]) by fast.fake.domain.org
	via sendmail with esmtp
	id <m1JwVC3-000twSC@fast.fake.domain.org>
	for <mmogilvi_git@miniinfo.net>; Wed, 14 May 2008 22:35:51 -0600 (MDT)
	(Smail-3.2 1996-Jul-4 #13 built 1998-Aug-8)
X-Mailer: git-send-email 1.5.4.3.340.g97b97
In-Reply-To: <1210826148-8708-3-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82176>

If "gitcvs.allbinary" is set to "guess", then any file that has
not been explicitly marked as binary or text using the "crlf" attribute
and the "gitcvs.usecrlfattr" config will guess binary based on the contents
of the file.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 Documentation/config.txt        |   13 ++-
 Documentation/git-cvsserver.txt |   14 ++-
 git-cvsserver.perl              |  193 +++++++++++++++++++++++++++++++++++---
 t/t9401-git-cvsserver-crlf.sh   |  159 ++++++++++++++++++++++++++++++++
 4 files changed, 354 insertions(+), 25 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 820795f..2c867d3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -655,11 +655,14 @@ gitcvs.usecrlfattr
 	then 'gitcvs.allbinary' is used. See linkgit:gitattribute[5].
 
 gitcvs.allbinary::
-	If true, all files not otherwise specified using
-	'gitcvs.usecrlfattr' and an explicitly set or unset `crlf`
-	attribute are sent to the client in mode '-kb'. This
-	causes the client to treat them as binary files which
-	suppresses any newline munging it otherwise might do.
+	This is used if 'gitcvs.usecrlfattr' does not resolve
+	the correct '-kb' mode to use. If true, all
+	unresolved files are sent to the client in
+	mode '-kb'. This causes the client to treat them
+	as binary files, which suppresses any newline munging it
+	otherwise might do. Alternatively, if it is set to "guess",
+	then the contents of the file are examined to decide if
+	it is binary, similar to 'core.autocrlf'.
 
 gitcvs.dbname::
 	Database used by git-cvsserver to cache revision information
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 8393028..7611c5b 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -311,17 +311,23 @@ to crnl conversion on some platforms.
 You can make the server use `crnl` attributes to set the '-k' modes
 for files by setting the `gitcvs.usecrlfattr` config variable.
 In this case, if `crlf` is explicitly unset ('-crnl'), then the
-will set '-kb' mode, for binary files.  If it `crlf` is set,
+server will set '-kb' mode for binary files. If `crlf` is set,
 then the '-k' mode will explicitly be left blank.  See
 also linkgit:gitattributes[5] for more information about the `crlf`
 attribute.
 
 Alternatively, if `gitcvs.usecrlfattr` config is not enabled
 or if the `crlf` attribute is unspecified for a filename, then
-the server uses the `gitcvs.allbinary` for the default setting.
-If `gitcvs.allbinary` is set, then the files not otherwise
+the server uses the `gitcvs.allbinary` config for the default setting.
+If `gitcvs.allbinary` is set, then file not otherwise
 specified will default to '-kb' mode. Otherwise the '-k' mode
-is left blank.
+is left blank. But if `gitcvs.allbinary` is set to "guess", then
+the correct '-k' mode will be guessed based on the contents of
+the file.
+
+For best consistency with cvs, it is probably best to override the
+defaults by setting `gitcvs.usecrlfattr` to true,
+and `gitcvs.allbinary` to "guess".
 
 Dependencies
 ------------
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 58206ae..920bbe1 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -502,7 +502,7 @@ sub req_add
                 print $state->{CVSROOT} . "/$state->{module}/$filename\n";
 
                 # this is an "entries" line
-                my $kopts = kopts_from_path($filename);
+                my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
                 $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
                 print "/$filepart/1.$meta->{revision}//$kopts/\n";
                 # permissions
@@ -533,7 +533,8 @@ sub req_add
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        my $kopts = kopts_from_path($filename);
+        my $kopts = kopts_from_path($filename,"file",
+                        $state->{entries}{$filename}{modified_filename});
         print "/$filepart/0//$kopts/\n";
 
         my $requestedKopts = $state->{opt}{k};
@@ -631,7 +632,7 @@ sub req_remove
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        my $kopts = kopts_from_path($filename);
+        my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
         print "/$filepart/-1.$wrev//$kopts/\n";
 
         $rmcount++;
@@ -910,7 +911,7 @@ sub req_co
        print $state->{CVSROOT} . "/$module/" . ( defined ( $git->{dir} ) and $git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "$git->{name}\n";
 
         # this is an "entries" line
-        my $kopts = kopts_from_path($fullName);
+        my $kopts = kopts_from_path($fullName,"sha1",$git->{filehash});
         print "/$git->{name}/1.$git->{revision}//$kopts/\n";
         # permissions
         print "u=$git->{mode},g=$git->{mode},o=$git->{mode}\n";
@@ -1119,7 +1120,7 @@ sub req_update
 		print $state->{CVSROOT} . "/$state->{module}/$filename\n";
 
 		# this is an "entries" line
-		my $kopts = kopts_from_path($filename);
+		my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
 		$log->debug("/$filepart/1.$meta->{revision}//$kopts/");
 		print "/$filepart/1.$meta->{revision}//$kopts/\n";
 
@@ -1167,7 +1168,8 @@ sub req_update
                     print "Merged $dirpart\n";
                     $log->debug($state->{CVSROOT} . "/$state->{module}/$filename");
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    my $kopts = kopts_from_path("$dirpart/$filepart");
+                    my $kopts = kopts_from_path("$dirpart/$filepart",
+                                                "file",$mergedFile);
                     $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
                     print "/$filepart/1.$meta->{revision}//$kopts/\n";
                 }
@@ -1183,7 +1185,8 @@ sub req_update
                 {
                     print "Merged $dirpart\n";
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    my $kopts = kopts_from_path("$dirpart/$filepart");
+                    my $kopts = kopts_from_path("$dirpart/$filepart",
+                                                "file",$mergedFile);
                     print "/$filepart/1.$meta->{revision}/+/$kopts/\n";
                 }
             }
@@ -1434,7 +1437,7 @@ sub req_ci
             }
             print "Checked-in $dirpart\n";
             print "$filename\n";
-            my $kopts = kopts_from_path($filename);
+            my $kopts = kopts_from_path($filename,"sha1",$meta->{filehash});
             print "/$filepart/1.$meta->{revision}//$kopts/\n";
         }
     }
@@ -2312,7 +2315,7 @@ sub cleanupTmpDir
 # file should get -kb.
 sub kopts_from_path
 {
-	my ($path) = @_;
+    my ($path, $srcType, $name) = @_;
 
     if ( defined ( $cfg->{gitcvs}{usecrlfattr} ) and
          $cfg->{gitcvs}{usecrlfattr} =~ /\s*(1|true|yes)\s*$/i )
@@ -2332,15 +2335,55 @@ sub kopts_from_path
         }
     }
 
-    unless ( defined ( $cfg->{gitcvs}{allbinary} ) and $cfg->{gitcvs}{allbinary} =~ /^\s*(1|true|yes)\s*$/i )
+    if ( defined ( $cfg->{gitcvs}{allbinary} ) )
     {
-		# Return "" to give no special treatment to any path
-		return "";
-    } else {
-		# Alternatively, to have all files treated as if they are binary (which
-		# is more like git itself), always return the "-kb" option
-		return "-kb";
+        if( ($cfg->{gitcvs}{allbinary} =~ /^\s*(1|true|yes)\s*$/i) )
+        {
+            return "-kb";
+        }
+        elsif( ($cfg->{gitcvs}{allbinary} =~ /^\s*guess\s*$/i) )
+        {
+            if( $srcType eq "sha1Or-k" &&
+                !defined($name) )
+            {
+                my ($ret)=$state->{entries}{$path}{options};
+                if( !defined($ret) )
+                {
+                    $ret=$state->{opt}{k};
+                    if(defined($ret))
+                    {
+                        $ret="-k$ret";
+                    }
+                    else
+                    {
+                        $ret="";
+                    }
+                }
+                if( ! ($ret=~/^(|-kb|-kkv|-kkvl|-kk|-ko|-kv)$/) )
+                {
+                    print "E Bad -k option\n";
+                    $log->warn("Bad -k option: $ret");
+                    die "Error: Bad -k option: $ret\n";
+                }
+
+                return $ret;
+            }
+            else
+            {
+                if( is_binary($srcType,$name) )
+                {
+                    $log->debug("... as binary");
+                    return "-kb";
+                }
+                else
+                {
+                    $log->debug("... as text");
+                }
+            }
+        }
     }
+    # Return "" to give no special treatment to any path
+    return "";
 }
 
 sub check_attr
@@ -2360,6 +2403,124 @@ sub check_attr
     }
 }
 
+# This should have the same heuristics as convert.c:is_binary() and related.
+# Note that the bare CR test is done by callers in convert.c.
+sub is_binary
+{
+    my ($srcType,$name) = @_;
+    $log->debug("is_binary($srcType,$name)");
+
+    # Minimize amount of interpreted code run in the inner per-character
+    # loop for large files, by totalling each character value and
+    # then analyzing the totals.
+    my @counts;
+    my $i;
+    for($i=0;$i<256;$i++)
+    {
+        $counts[$i]=0;
+    }
+
+    my $fh = open_blob_or_die($srcType,$name);
+    my $line;
+    while( defined($line=<$fh>) )
+    {
+        # Any '\0' and bare CR are considered binary.
+        if( $line =~ /\0|(\r[^\n])/ )
+        {
+            close($fh);
+            return 1;
+        }
+
+        # Count up each character in the line:
+        my $len=length($line);
+        for($i=0;$i<$len;$i++)
+        {
+            $counts[ord(substr($line,$i,1))]++;
+        }
+    }
+    close $fh;
+
+    # Don't count CR and LF as either printable/nonprintable
+    $counts[ord("\n")]=0;
+    $counts[ord("\r")]=0;
+
+    # Categorize individual character count into printable and nonprintable:
+    my $printable=0;
+    my $nonprintable=0;
+    for($i=0;$i<256;$i++)
+    {
+        if( $i < 32 &&
+            $i != ord("\b") &&
+            $i != ord("\t") &&
+            $i != 033 &&       # ESC
+            $i != 014 )        # FF
+        {
+            $nonprintable+=$counts[$i];
+        }
+        elsif( $i==127 )  # DEL
+        {
+            $nonprintable+=$counts[$i];
+        }
+        else
+        {
+            $printable+=$counts[$i];
+        }
+    }
+
+    return ($printable >> 7) < $nonprintable;
+}
+
+# Returns open file handle.  Possible invocations:
+#  - open_blob_or_die("file",$filename);
+#  - open_blob_or_die("sha1",$filehash);
+sub open_blob_or_die
+{
+    my ($srcType,$name) = @_;
+    my ($fh);
+    if( $srcType eq "file" )
+    {
+        if( !open $fh,"<",$name )
+        {
+            $log->warn("Unable to open file $name: $!");
+            die "Unable to open file $name: $!\n";
+        }
+    }
+    elsif( $srcType eq "sha1" || $srcType eq "sha1Or-k" )
+    {
+        unless ( defined ( $name ) and $name =~ /^[a-zA-Z0-9]{40}$/ )
+        {
+            $log->warn("Need filehash");
+            die "Need filehash\n";
+        }
+
+        my $type = `git cat-file -t $name`;
+        chomp $type;
+
+        unless ( defined ( $type ) and $type eq "blob" )
+        {
+            $log->warn("Invalid type '$type' for '$name'");
+            die ( "Invalid type '$type' (expected 'blob')" )
+        }
+
+        my $size = `git cat-file -s $name`;
+        chomp $size;
+
+        $log->debug("open_blob_or_die($name) size=$size, type=$type");
+
+        unless( open $fh, '-|', "git", "cat-file", "blob", $name )
+        {
+            $log->warn("Unable to open sha1 $name");
+            die "Unable to open sha1 $name\n";
+        }
+    }
+    else
+    {
+        $log->warn("Unknown type of blob source: $srcType");
+        die "Unknown type of blob source: $srcType\n";
+    }
+    return $fh;
+}
+
 # Generate a CVS author name from Git author information, by taking
 # the first eight characters of the user part of the email address.
 sub cvs_author
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index b7a779b..e27a1c5 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -175,4 +175,163 @@ test_expect_success 'updating' '
     cmp cvswork/binfile.bin tmpExpect1
 '
 
+rm -rf cvswork
+test_expect_success 'cvs co (use attributes/guess)' '
+    GIT_DIR="$SERVERDIR" git config gitcvs.allbinary guess &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    marked_as cvswork textfile.c "" &&
+    marked_as cvswork binfile.bin -kb &&
+    marked_as cvswork .gitattributes "" &&
+    marked_as cvswork mixedUp.c "" &&
+    marked_as cvswork/subdir withCr.bin -kb &&
+    marked_as cvswork/subdir file.h "" &&
+    marked_as cvswork/subdir unspecified.other "" &&
+    marked_as cvswork/subdir newfile.bin -kb &&
+    marked_as cvswork/subdir newfile.c ""
+'
+
+test_expect_success 'setup multi-line files' '
+    ( echo "line 1" &&
+      echo "line 2" &&
+      echo "line 3" &&
+      echo "line 4 with NUL: Q <-" ) | q_to_nul > multiline.c &&
+    git add multiline.c &&
+    ( echo "line 1" &&
+      echo "line 2" &&
+      echo "line 3" &&
+      echo "line 4" ) | q_to_nul > multilineTxt.c &&
+    git add multilineTxt.c &&
+    git commit -q -m "multiline files" &&
+    git push gitcvs.git >/dev/null
+'
+
+rm -rf cvswork
+test_expect_success 'cvs co (guess)' '
+    GIT_DIR="$SERVERDIR" git config --bool gitcvs.usecrlfattr false &&
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork master >cvs.log 2>&1 &&
+    marked_as cvswork textfile.c "" &&
+    marked_as cvswork binfile.bin -kb &&
+    marked_as cvswork .gitattributes "" &&
+    marked_as cvswork mixedUp.c -kb &&
+    marked_as cvswork multiline.c -kb &&
+    marked_as cvswork multilineTxt.c "" &&
+    marked_as cvswork/subdir withCr.bin -kb &&
+    marked_as cvswork/subdir file.h "" &&
+    marked_as cvswork/subdir unspecified.other "" &&
+    marked_as cvswork/subdir newfile.bin "" &&
+    marked_as cvswork/subdir newfile.c ""
+'
+
+test_expect_success 'cvs co another copy (guess)' '
+    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
+    marked_as cvswork2 textfile.c "" &&
+    marked_as cvswork2 binfile.bin -kb &&
+    marked_as cvswork2 .gitattributes "" &&
+    marked_as cvswork2 mixedUp.c -kb &&
+    marked_as cvswork2 multiline.c -kb &&
+    marked_as cvswork2 multilineTxt.c "" &&
+    marked_as cvswork2/subdir withCr.bin -kb &&
+    marked_as cvswork2/subdir file.h "" &&
+    marked_as cvswork2/subdir unspecified.other "" &&
+    marked_as cvswork2/subdir newfile.bin "" &&
+    marked_as cvswork2/subdir newfile.c ""
+'
+
+test_expect_success 'add text (guess)' '
+    cd cvswork &&
+    echo "simpleText" > simpleText.c &&
+    GIT_CONFIG="$git_config" cvs -Q add simpleText.c &&
+    cd .. &&
+    marked_as cvswork simpleText.c ""
+'
+
+test_expect_success 'add bin (guess)' '
+    cd cvswork &&
+    echo "simpleBin: NUL: Q <- there" | q_to_nul > simpleBin.bin &&
+    GIT_CONFIG="$git_config" cvs -Q add simpleBin.bin &&
+    cd .. &&
+    marked_as cvswork simpleBin.bin -kb
+'
+
+test_expect_success 'remove files (guess)' '
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs -Q rm -f subdir/file.h &&
+    cd subdir &&
+    GIT_CONFIG="$git_config" cvs -Q rm -f withCr.bin &&
+    cd ../.. &&
+    marked_as cvswork/subdir withCr.bin -kb &&
+    marked_as cvswork/subdir file.h ""
+'
+
+test_expect_success 'cvs ci (guess)' '
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs -Q ci -m "add/rm files" >cvs.log 2>&1 &&
+    cd .. &&
+    marked_as cvswork textfile.c "" &&
+    marked_as cvswork binfile.bin -kb &&
+    marked_as cvswork .gitattributes "" &&
+    marked_as cvswork mixedUp.c -kb &&
+    marked_as cvswork multiline.c -kb &&
+    marked_as cvswork multilineTxt.c "" &&
+    not_present cvswork/subdir withCr.bin &&
+    not_present cvswork/subdir file.h &&
+    marked_as cvswork/subdir unspecified.other "" &&
+    marked_as cvswork/subdir newfile.bin "" &&
+    marked_as cvswork/subdir newfile.c "" &&
+    marked_as cvswork simpleBin.bin -kb &&
+    marked_as cvswork simpleText.c ""
+'
+
+test_expect_success 'update subdir of other copy (guess)' '
+    cd cvswork2/subdir &&
+    GIT_CONFIG="$git_config" cvs -Q update &&
+    cd ../.. &&
+    marked_as cvswork2 textfile.c "" &&
+    marked_as cvswork2 binfile.bin -kb &&
+    marked_as cvswork2 .gitattributes "" &&
+    marked_as cvswork2 mixedUp.c -kb &&
+    marked_as cvswork2 multiline.c -kb &&
+    marked_as cvswork2 multilineTxt.c "" &&
+    not_present cvswork2/subdir withCr.bin &&
+    not_present cvswork2/subdir file.h &&
+    marked_as cvswork2/subdir unspecified.other "" &&
+    marked_as cvswork2/subdir newfile.bin "" &&
+    marked_as cvswork2/subdir newfile.c "" &&
+    not_present cvswork2 simpleBin.bin &&
+    not_present cvswork2 simpleText.c
+'
+
+echo "starting update/merge" >> "${WORKDIR}/marked.log"
+test_expect_success 'update/merge full other copy (guess)' '
+    git pull gitcvs.git master &&
+    sed "s/3/replaced_3/" < multilineTxt.c > ml.temp &&
+    mv ml.temp multilineTxt.c &&
+    git add multilineTxt.c &&
+    git commit -q -m "modify multiline file" >> "${WORKDIR}/marked.log" &&
+    git push gitcvs.git >/dev/null &&
+    cd cvswork2 &&
+    sed "s/1/replaced_1/" < multilineTxt.c > ml.temp &&
+    mv ml.temp multilineTxt.c &&
+    GIT_CONFIG="$git_config" cvs update > cvs.log 2>&1 &&
+    cd .. &&
+    marked_as cvswork2 textfile.c "" &&
+    marked_as cvswork2 binfile.bin -kb &&
+    marked_as cvswork2 .gitattributes "" &&
+    marked_as cvswork2 mixedUp.c -kb &&
+    marked_as cvswork2 multiline.c -kb &&
+    marked_as cvswork2 multilineTxt.c "" &&
+    not_present cvswork2/subdir withCr.bin &&
+    not_present cvswork2/subdir file.h &&
+    marked_as cvswork2/subdir unspecified.other "" &&
+    marked_as cvswork2/subdir newfile.bin "" &&
+    marked_as cvswork2/subdir newfile.c "" &&
+    marked_as cvswork2 simpleBin.bin -kb &&
+    marked_as cvswork2 simpleText.c "" &&
+    echo "line replaced_1" > tmpExpect2 &&
+    echo "line 2" >> tmpExpect2 &&
+    echo "line replaced_3" >> tmpExpect2 &&
+    echo "line 4" | q_to_nul >> tmpExpect2 &&
+    cmp cvswork2/multilineTxt.c tmpExpect2
+'
+
 test_done
-- 
1.5.4.3.340.g97b97
