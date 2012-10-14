From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 15/20] cvsserver: implement req_Sticky and related utilities
Date: Sat, 13 Oct 2012 23:42:28 -0600
Message-ID: <1350193353-19210-16-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDr-0007Eo-FW
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab2JNF6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:18 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:39682 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752038Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id Att51k00716AWCUA1ty3b8; Sun, 14 Oct 2012 05:58:03 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta06.emeryville.ca.mail.comcast.net with comcast
	id Att21k0052wKXRC8Stt2Up; Sun, 14 Oct 2012 05:53:03 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 0B1271E96026; Sat, 13 Oct 2012 23:43:20 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207633>

Nothing sets sticky yet, or uses the values set by this, but soon...

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 16e2e1f..53d8de7 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -60,6 +60,7 @@ my $methods = {
     'Valid-responses' => \&req_Validresponses,
     'valid-requests'  => \&req_validrequests,
     'Directory'       => \&req_Directory,
+    'Sticky'          => \&req_Sticky,
     'Entry'           => \&req_Entry,
     'Modified'        => \&req_Modified,
     'Unchanged'       => \&req_Unchanged,
@@ -470,11 +471,19 @@ sub req_Directory
     {
         $log->info("Setting prepend to '$state->{path}'");
         $state->{prependdir} = $state->{path};
+        my %entries;
         foreach my $entry ( keys %{$state->{entries}} )
         {
-            $state->{entries}{$state->{prependdir} . $entry} = $state->{entries}{$entry};
-            delete $state->{entries}{$entry};
+            $entries{$state->{prependdir} . $entry} = $state->{entries}{$entry};
         }
+        $state->{entries}=\%entries;
+
+        my %dirMap;
+        foreach my $dir ( keys %{$state->{dirMap}} )
+        {
+            $dirMap{$state->{prependdir} . $dir} = $state->{dirMap}{$dir};
+        }
+        $state->{dirMap}=\%dirMap;
     }
 
     if ( defined ( $state->{prependdir} ) )
@@ -482,9 +491,60 @@ sub req_Directory
         $log->debug("Prepending '$state->{prependdir}' to state|directory");
         $state->{directory} = $state->{prependdir} . $state->{directory}
     }
+
+    if ( ! defined($state->{dirMap}{$state->{directory}}) )
+    {
+        $state->{dirMap}{$state->{directory}} =
+            {
+                'names' => {}
+                #'tagspec' => undef
+            };
+    }
+
     $log->debug("req_Directory : localdir=$data repository=$repository path=$state->{path} directory=$state->{directory} module=$state->{module}");
 }
 
+# Sticky tagspec \n
+#     Response expected: no. Tell the server that the directory most
+#     recently specified with Directory has a sticky tag or date
+#     tagspec. The first character of tagspec is T for a tag, D for
+#     a date, or some other character supplied by a Set-sticky
+#     response from a previous request to the server. The remainder
+#     of tagspec contains the actual tag or date, again as supplied
+#     by Set-sticky.
+#          The server should remember Static-directory and Sticky requests
+#     for a particular directory; the client need not resend them each
+#     time it sends a Directory request for a given directory. However,
+#     the server is not obliged to remember them beyond the context
+#     of a single command.
+sub req_Sticky
+{
+    my ( $cmd, $tagspec ) = @_;
+
+    my ( $stickyInfo );
+    if($tagspec eq "")
+    {
+        # nothing
+    }
+    elsif($tagspec=~/^T([^ ]+)\s*$/)
+    {
+        $stickyInfo = { 'tag' => $1 };
+    }
+    elsif($tagspec=~/^D([0-9.]+)\s*$/)
+    {
+        $stickyInfo= { 'date' => $1 };
+    }
+    else
+    {
+        die "Unknown tag_or_date format\n";
+    }
+    $state->{dirMap}{$state->{directory}}{stickyInfo}=$stickyInfo;
+
+    $log->debug("req_Sticky : tagspec=$tagspec repository=$state->{repository}"
+                . " path=$state->{path} directory=$state->{directory}"
+                . " module=$state->{module}");
+}
+
 # Entry entry-line \n
 #     Response expected: no. Tell the server what version of a file is on the
 #     local machine. The name in entry-line is a name relative to the directory
@@ -511,6 +571,8 @@ sub req_Entry
         tag_or_date => $data[5],
     };
 
+    $state->{dirMap}{$state->{directory}}{names}{$data[1]} = 'F';
+
     $log->info("Received entry line '$data' => '" . $state->{directory} . $data[1] . "'");
 }
 
@@ -2213,6 +2275,110 @@ sub argsfromdir
     }
 }
 
+
+## look up directory sticky tag, of either fullPath or a parent:
+sub getDirStickyInfo
+{
+    my($fullPath)=@_;
+
+    $fullPath=~s%/+$%%;
+    while($fullPath ne "" && !defined($state->{dirMap}{"$fullPath/"}))
+    {
+        $fullPath=~s%/?[^/]*$%%;
+    }
+
+    if( !defined($state->{dirMap}{"$fullPath/"}) &&
+        ( $fullPath eq "" ||
+          $fullPath eq "." ) )
+    {
+        return $state->{dirMap}{""}{stickyInfo};
+    }
+    else
+    {
+        return $state->{dirMap}{"$fullPath/"}{stickyInfo};
+    }
+}
+
+# Resolve precedence of various ways of specifying which version of
+# a file you want.  Returns undef (for default head), or a ref to a hash
+# that contains "tag" and/or "date" keys.
+sub resolveStickyInfo
+{
+    my($filename,$stickyTag,$stickyDate,$reset) = @_;
+
+    # Order of precedence of sticky tags:
+    #    -A       [head]
+    #    -r /tag/
+    #    [file entry sticky tag]
+    #    [the tag specified in dir req_Sticky]
+    #    [the tag specified in a parent dir req_Sticky]
+    #    [head]
+
+    my $result;
+    if($reset)
+    {
+        # $result=undef;
+    }
+    elsif( defined($stickyTag) && $stickyTag ne "" )
+           # || ( defined($stickyDate) && $stickyDate ne "" )   # TODO
+    {
+        $result={ 'tag' => (defined($stickyTag)?$stickyTag:undef) };
+
+        # TODO: Convert -D value into the form 2011.04.10.04.46.57,
+        #   similar to an entry line's sticky date, without the D prefix.
+        #   It sometimes (always?) arrives as something more like
+        #   '10 Apr 2011 04:46:57 -0000'...
+        # $result={ 'date' => (defined($stickyDate)?$stickyDate:undef) };
+    }
+    elsif( defined($state->{entries}{$filename}) &&
+           defined($state->{entries}{$filename}{tag_or_date}) &&
+           $state->{entries}{$filename}{tag_or_date} ne "" )
+    {
+        my($tagOrDate)=$state->{entries}{$filename}{tag_or_date};
+        if($tagOrDate=~/^T([^ ]+)\s*$/)
+        {
+            $result = { 'tag' => $1 };
+        }
+        elsif($tagOrDate=~/^D([0-9.]+)\s*$/)
+        {
+            $result= { 'date' => $1 };
+        }
+        else
+        {
+            die "Unknown tag_or_date format\n";
+        }
+    }
+    else
+    {
+        $result=getDirStickyInfo($filename);
+    }
+
+    return $result;
+}
+
+# Convert a stickyInfo (ref to a hash) as returned by resolveStickyInfo into
+# a form appropriate for the sticky tag field of an Entries
+# line (field index 5, 0-based).
+sub getStickyTagOrDate
+{
+    my($stickyInfo)=@_;
+
+    my $result;
+    if(defined($stickyInfo) && defined($stickyInfo->{tag}))
+    {
+        $result="T$stickyInfo->{tag}";
+    }
+    # TODO: When/if we actually pick versions by {date} properly,
+    #   also handle it here:
+    #   "D$stickyInfo->{date}" (example: "D2011.04.13.20.37.07").
+    else
+    {
+        $result="";
+    }
+
+    return $result;
+}
+
 # This method cleans up the $state variable after a command that uses arguments has run
 sub statecleanup
 {
@@ -2220,6 +2386,7 @@ sub statecleanup
     $state->{args} = [];
     $state->{arguments} = [];
     $state->{entries} = {};
+    $state->{dirMap} = {};
 }
 
 # Return working directory CVS revision "1.X" out
-- 
1.7.10.2.484.gcd07cc5
