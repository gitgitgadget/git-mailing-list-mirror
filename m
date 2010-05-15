From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/6] git-cvsserver: use a password file cvsserver pserver
Date: Sat, 15 May 2010 02:46:00 +0000
Message-ID: <1273891564-7523-3-git-send-email-avarab@gmail.com>
References: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 04:47:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD7P9-0008Qv-W8
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 04:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab0EOCqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 22:46:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:48640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0EOCqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 22:46:42 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1937174fga.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XJ7Xog7LVN2Ce7DeSLQHOr6esCCbbEPlygjiL3ememc=;
        b=qb/tBn/Wt66r2YRnndAtVs4aEZnZ37wqMek3Dj4rPnCCPnL2nShcUU1+oEjlI2YCbV
         BOmFgVxMvnFM0CsVJm8SADRjhPWM188z7WoVE6LNXgYBej93SOHfG7SDBBMOe7Ljbm1n
         aMl7I9Fsuz7h/BFUZCOYs7D0DYc/h5pEQYZ04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wv7GJyZbGNgJ/HVNptctFheACobhRUwDlgiQ3SSIkvLy6/MIPLfnTadf5t165+mZDC
         PTUBIYhmP4KeYveRevZeV7qBUnB+PXCOTqbSxkZJ/EAn0p8AQEa44XBoEyTwKsNZpwtJ
         0epxTzxE1ejbNbygCEUdU18iU5EGZkjJH5y50=
Received: by 10.86.124.8 with SMTP id w8mr3960880fgc.8.1273891601729;
        Fri, 14 May 2010 19:46:41 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 22sm4155718fkq.17.2010.05.14.19.46.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 19:46:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147128>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

If a git repository is shared via HTTP, the config file is typically
visible.  Use an external file instead.
---
 Documentation/git-cvsserver.txt |   21 ++++++++++++++++-----
 git-cvsserver.perl              |   27 ++++++++++++++-------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index f4e1339..bc2da8c 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -100,16 +100,27 @@ looks like
 ------
 
 Only anonymous access is provided by pserve by default. To commit you
-will have to create pserver accounts, simply add a [gitcvs.users]
-section to the repositories you want to access, for example:
+will have to create pserver accounts, simply add a gitcvs.authdb
+setting in the config file of the repositories you want the cvsserver
+to allow writes to, for example:
 
 ------
    
-   [gitcvs.users]
-        someuser = somepassword
-        otheruser = otherpassword
+   [gitcvs]
+        authdb = /etc/cvsserver/passwd
    
 ------
+The format of these files is username followed by the crypted password,
+for example:
+
+------
+   myuser:$1Oyx5r9mdGZ2
+   myuser:$1$BA)@$vbnMJMDym7tA32AamXrm./
+------
+You can use the 'htpasswd' facility that comes with Apache to make these
+files, but Apache's MD5 crypt method differs from the one used by most C
+library's crypt() function, so don't use the -m option.
+
 Then provide your password via the pserver method, for example:
 ------
    cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co <HEAD_name>
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index d9a26cb..ca02fba 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -189,24 +189,25 @@ if ($state->{method} eq 'pserver') {
 
     unless ($user eq 'anonymous') {
         # Trying to authenticate a user
-        if (not exists $cfg->{gitcvs}->{users}) {
-            print "E the repo config file needs a [gitcvs.users] section with user/password key-value pairs\n";
+        if (not exists $cfg->{gitcvs}->{authdb}) {
+            print "E the repo config file needs a [gitcvs.authdb] section with a filename\n";
             print "I HATE YOU\n";
             exit 1;
-        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg->{gitcvs}->{users}->{$user}) {
-            #print "E the repo config file has a [gitcvs.users] section but the user $user is not defined in it\n";
+        }
+	my $auth_ok;
+	open PASSWD, "<$cfg->{gitcvs}->{authdb}" or die $!;
+	while(<PASSWD>) {
+	    if (m{^\Q$user\E:(.*)}) {
+		if (crypt($user, $1) eq $1) {
+		    $auth_ok = 1;
+		}
+	    };
+	}
+	unless ($auth_ok) {
             print "I HATE YOU\n";
             exit 1;
-        } else {
-            my $descrambled_password = descramble($password);
-            my $cleartext_password = $cfg->{gitcvs}->{users}->{$user};
-            if ($descrambled_password ne $cleartext_password) {
-                #print "E The password supplied for user $user was incorrect\n";
-                print "I HATE YOU\n";
-                exit 1;
-            }
-            # else fall through to LOVE
         }
+        # else fall through to LOVE
     }
 
     # For checking whether the user is anonymous on commit
-- 
1.7.1.84.gd92f8
