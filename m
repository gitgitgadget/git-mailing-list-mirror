From: avar@cpan.org (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
Subject: [PATCH] Authentication support for pserver
Date: Fri, 14 Dec 2007 04:08:51 +0000
Message-ID: <87wsrhex4c.fsf@cpan.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: martyn@catalyst.net.nz, martin@catalyst.net.nz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 05:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J322q-0001tl-9r
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 05:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021AbXLNEUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 23:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758820AbXLNEUl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 23:20:41 -0500
Received: from main.gmane.org ([80.91.229.2]:49010 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbXLNEUk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 23:20:40 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1J321q-0002jW-Vs
	for git@vger.kernel.org; Fri, 14 Dec 2007 04:20:03 +0000
Received: from dsl-228-236.hive.is ([85.197.228.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 04:20:02 +0000
Received: from avar by dsl-228-236.hive.is with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 04:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-228-236.hive.is
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:GNopR/UJ3JlvP2Ia6ulH5xHLiek=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68218>

--=-=-=

I've patched git-cvsserver so that it supports pserver authentication as
opposed to only anonymous access. The patch itself works but I haven't
updated the relevant documentation or test cases and won't be able to do
so until after the weekend so I'm submitting what I have for review on
the list.

The pserver user/password database is stored in the config file for each
repository because I didn't know where else to put it, for example:

avar@oe:/tmp/fleh$ cat /tmp/git-test.git/config 
[core]
	repositoryformatversion = 0
	filemode = true
	bare = true

[gitcvs]
    enabled = 1

[gitcvs.users]
    avar = foobar
    whee = whoo

The user can then login/checkout and do other operations with the
user/password set in the config file:

avar@oe:/tmp/fleh$ cvs -d:pserver:whee:whoo@localhost/tmp/git-test.git login
Logging in to :pserver:whee@localhost:2401/tmp/git-test.git
avar@oe:/tmp/fleh$ cvs -d:pserver:whee:oops@localhost/tmp/git-test.git login
Logging in to :pserver:whee@localhost:2401/tmp/git-test.git
The password supplied for user whee was incorrect
cvs login: authorization failed: server localhost rejected access to
    /tmp/git-test.git for user whee

$ cvs -d:pserver:whee:whoo@localhost/tmp/git-test.git co master
cvs checkout: Updating master
U master/.emacs
[...]


--=-=-=
Content-Disposition: inline; filename=git-cvsserver.patch
Content-Description: Patch that adds pserver authentication support to
 git-cvsserver

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ecded3b..851383b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -150,12 +150,32 @@ if ($state->{method} eq 'pserver') {
        exit 1;
     }
     $line = <STDIN>; chomp $line;
-    unless ($line eq 'anonymous') {
-       print "E Only anonymous user allowed via pserver\n";
-       print "I HATE YOU\n";
-       exit 1;
+    my $user = $line;
+    $line = <STDIN>; chomp $line;
+    my $password = $line;
+
+    unless ($user eq 'anonymous') {
+        # Trying to authenticate a user
+        if (not exists $cfg->{gitcvs}->{users}) {
+            print "E the repo config file needs a [gitcvs.users] section with user/password key-value pairs\n";
+            print "I HATE YOU\n";
+            exit 1;
+        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg->{gitcvs}->{users}->{$user}) {
+            print "E the repo config file has a [gitcvs.users] section but the user $user is not defined in it\n";
+            print "I HATE YOU\n";
+            exit 1;
+        } else {
+            my $descrambled_password = descramble($password);
+            my $cleartext_password = $cfg->{gitcvs}->{users}->{$user};
+            if ($descrambled_password ne $cleartext_password) {
+                print "E The password supplied for user $user was incorrect\n";
+                print "I HATE YOU\n";
+                exit 1;
+            }
+            # else fall through to LOVE
+        }
     }
-    $line = <STDIN>; chomp $line;    # validate the password?
+
     $line = <STDIN>; chomp $line;
     unless ($line eq "END $request REQUEST") {
        die "E Do not understand $line -- expecting END $request REQUEST\n";
@@ -273,7 +293,7 @@ sub req_Root
     }
     foreach my $line ( @gitvars )
     {
-        next unless ( $line =~ /^(gitcvs)\.(?:(ext|pserver)\.)?([\w-]+)=(.*)$/ );
+        next unless ( $line =~ /^(gitcvs)\.(?:(ext|pserver|users)\.)?([\w-]+)=(.*)$/ );
         unless ($2) {
             $cfg->{$1}{$3} = $4;
         } else {
@@ -1176,12 +1196,6 @@ sub req_ci
 
     $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
 
-    if ( $state->{method} eq 'pserver')
-    {
-        print "error 1 pserver access cannot commit\n";
-        exit;
-    }
-
     if ( -e $state->{CVSROOT} . "/index" )
     {
         $log->warn("file 'index' already exists in the git repository");
@@ -2107,6 +2121,41 @@ sub kopts_from_path
     }
 }
 
+
+sub descramble
+{
+    # This table is from src/scramble.c in the CVS source
+    my @SHIFTS = (
+        0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+        114,120, 53, 79, 96,109, 72,108, 70, 64, 76, 67,116, 74, 68, 87,
+        111, 52, 75,119, 49, 34, 82, 81, 95, 65,112, 86,118,110,122,105,
+        41, 57, 83, 43, 46,102, 40, 89, 38,103, 45, 50, 42,123, 91, 35,
+        125, 55, 54, 66,124,126, 59, 47, 92, 71,115, 78, 88,107,106, 56,
+        36,121,117,104,101,100, 69, 73, 99, 63, 94, 93, 39, 37, 61, 48,
+        58,113, 32, 90, 44, 98, 60, 51, 33, 97, 62, 77, 84, 80, 85,223,
+        225,216,187,166,229,189,222,188,141,249,148,200,184,136,248,190,
+        199,170,181,204,138,232,218,183,255,234,220,247,213,203,226,193,
+        174,172,228,252,217,201,131,230,197,211,145,238,161,179,160,212,
+        207,221,254,173,202,146,224,151,140,196,205,130,135,133,143,246,
+        192,159,244,239,185,168,215,144,139,165,180,157,147,186,214,176,
+        227,231,219,169,175,156,206,198,129,164,150,210,154,177,134,127,
+        182,128,158,208,162,132,167,209,149,241,153,251,237,236,171,195,
+        243,233,253,240,194,250,191,155,142,137,245,235,163,242,178,152
+    );
+    my ($str) = @_;
+
+    # This should never happen, the same format has been used since
+    # CVS was spawned
+    $str =~ s/^(.)//;
+    die "invalid password format $1" unless $1 eq 'A';
+
+    $str =~ s/(.)/chr $SHIFTS[ord $1]/ge;
+
+    return $str;
+}
+
+
 package GITCVS::log;
 
 ####

--=-=-=--
