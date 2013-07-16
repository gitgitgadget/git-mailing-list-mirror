From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] send-email: improve SSL certificate verification
Date: Tue, 16 Jul 2013 04:33:55 +0200
Message-ID: <51E4B113.8000009@web.de>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com> <1373025947-26495-2-git-send-email-artagnon@gmail.com> <51D82970.5070108@web.de> <20130706143256.GX862789@vauxhall.crustytoothpaste.net> <51D83C7E.8000902@web.de> <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com> <20130714170316.GE11097@vauxhall.crustytoothpaste.net> <51E3677D.6040903@web.de> <20130716001506.GG11097@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jul 16 04:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyv5j-0000E4-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 04:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab3GPCeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 22:34:11 -0400
Received: from mout.web.de ([212.227.15.4]:64890 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab3GPCeL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 22:34:11 -0400
Received: from [192.168.1.18] ([68.61.5.157]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MPHKO-1V3Inc2mky-004QVh; Tue, 16 Jul 2013 04:33:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130716001506.GG11097@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:yKCHs5UokKuIhCVQkgBoTku9tXyr3TZg9ns2jAvNl+hI2DSekjt
 SvHM2ktPfnUEPtSZbm/yEhd676o6RG6B7yQSOl59/fKvQHYYtS6VEZMAWb1TAJz1sF4Vlmh
 T64Bjv9rDDh8U4JRlTwLE8YHNAbWEm2sPLDNshVOlgq3dWUkC7mGUwo77O47xsrX4Xou8Dm
 Lj8MiWpmzbsbFUmiwaR7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230536>

[snip]
I wasn't sure where to apply the patch, so I manually copy/paste it
on top of pu:
commit 6b1ca0f4d443ee8716857b871b0513ae85c9f112
Merge: bce90ab f351fcf

Thanks, t9001 passes on Mac OS X 10.6.
To be sure I didn't messed it up, please see the diff below.
When it shows up on pu, I can re-test of course.



diff --git a/git-send-email.perl b/git-send-email.perl
index a9a6661..a965b8e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -28,7 +28,7 @@ use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
 use Error qw(:try);
 use Git;
-use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
+#use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -1092,19 +1092,34 @@ sub smtp_auth_maybe {
 # Helper to come up with SSL/TLS certification validation params
 # and warn when doing no verification
 sub ssl_verify_params {
-    if ($smtp_ssl_verify == 0) {
-        return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_NONE);
+    require IO::Socket::SSL;
+    eval {
+        IO::Socket::SSL->import(qw/SSL_VERIFY_PEER SSL_VERIFY_NONE/);
+    };
+    if ($@) {
+        print STDERR "Not using SSL_VERIFY_PEER due to out-of-date IO::Socket::SSL.\n";
+        return;
     }
 
-    if (! defined $smtp_ssl_cert_path) {
-        return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_PEER);
-    } elsif (-f $smtp_ssl_cert_path) {
-        return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_PEER,
-            SSL_ca_file => $smtp_ssl_cert_path);
-    } else {
-        return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_PEER,
+    if (!defined $smtp_ssl_cert_path) {
+        $smtp_ssl_cert_path ||= "/etc/ssl/certs";
+    }
+
+    if (!$smtp_ssl_cert_path) {
+        return (SSL_verify_mode => SSL_VERIFY_NONE());
+    }
+    elsif (-d $smtp_ssl_cert_path) {
+        return (SSL_verify_mode => SSL_VERIFY_PEER(),
             SSL_ca_path => $smtp_ssl_cert_path);
     }
+    elsif (-f $smtp_ssl_cert_path) {
+        return (SSL_verify_mode => SSL_VERIFY_PEER(),
+            SSL_ca_file => $smtp_ssl_cert_path);
+    }
+    else {
+        print STDERR "Not using SSL_VERIFY_PEER because the CA path does not exist.\n";
+        return (SSL_verify_mode => SSL_VERIFY_NONE());
+    }
 }
 
 # Returns 1 if the message was sent, and 0 otherwise.
@@ -1229,13 +1244,8 @@ X-Mailer: git-send-email $gitversion
                 if ($smtp->code == 220) {
                     $smtp = Net::SMTP::SSL->start_SSL($smtp,
                                       ssl_verify_params())
-                        or die "STARTTLS failed! ".$smtp->message;
-                    $smtp_encryption = '';
-                    # Send EHLO again to receive fresh
-                    # supported commands
-                    $smtp->hello($smtp_domain);
-                } else {
-                    die "Server does not support STARTTLS! ".$smtp->message;
+                        or die "STARTTLS failed! ".$smtp->message;
+
                 }
             }
         }
