From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: confirm auto cc before sending
Date: Sat, 28 Feb 2009 22:53:50 -0500
Message-ID: <1235879630-39439-1-git-send-email-jaysoffian@gmail.com>
References: <7d1d9c250902281732m7293330bt108b70a850dc5cb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 04:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldcm8-0002Pm-5u
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 04:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbZCADx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbZCADx6
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:53:58 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:39328 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbZCADx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 22:53:56 -0500
Received: by an-out-0708.google.com with SMTP id c2so1350833anc.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 19:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=R/2RhfU50+3nJ2dKaXZcpBZpYtwFU6DlCEbXX5HDobw=;
        b=azklYGGMfRwKW4Xg8iCtkO8NBd6GQKgh0XG2S2ue4R5zryrrICDroGVMNzRBONPCao
         wfows8IrOGRznTl1LGlJ/Yb+uMt6JKr+Rc4voYEnjQ1AQp49CIPKIXXSdVJIiHMVAN5h
         KIOq2zLP3ohJz/6dFWm1CAiTW/XE5vZi0pGz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qodAAWEgXdEPD8mGc52xFRNJZp35kWGsv2k47zgjxAsBYZePzr/NMchyf7YebBcr5D
         nW4w/jYS9Ilo/WW46ChBYevUJPSHDsFDE/YKQbWXulHNFt0+KSlT/cXMhicZ8ZR4a0Q+
         SoA7bP6akRGu7L4v4aDyco6sZVJHBpfPGpFNY=
Received: by 10.100.141.5 with SMTP id o5mr3859906and.45.1235879634461;
        Sat, 28 Feb 2009 19:53:54 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c29sm6814534anc.23.2009.02.28.19.53.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Feb 2009 19:53:53 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <7d1d9c250902281732m7293330bt108b70a850dc5cb9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111814>

send-email violates the principle of least surprise by automatically
cc'ing additional recipients without even bothering to confirm this with
the user first.

This patch teaches send-email a new option --confirm-cc. In the case
where send-email has automatically added additional Cc recipients, it
will confirm the recipients with the user before sending.

It defaults to true unless another of the cc-related suppression options
has been specified, in which case it defaults to false.
---
Untested patch, just soliciting ideas. I actually don't like this patch
as is. I think a more general purpose --confirm option that takes
multiple values is in order:

 --confirm=never   never confirms
 --confirm=cc      confirms only when send-email has automagically added
                   additional recipient
 --confirm=always  always confirms

The default would be --confirm=cc unless the user has specified any of
the other Cc suppression options, which to me indicates the user knows
what they are doing.

j.

 git-send-email.perl |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index adf7ecb..d3e718e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -75,6 +75,7 @@ git send-email [options] <file | directory | rev-list options >
     --[no-]thread                  * Use In-Reply-To: field. Default on.
 
   Administering:
+    --confirm-cc                   * Confirm automatic cc'd before sending.
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Default on.
@@ -181,7 +182,7 @@ sub do_edit {
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
-my ($validate);
+my ($validate, $confirm_cc);
 my (@suppress_cc);
 
 my %config_bool_settings = (
@@ -190,6 +191,7 @@ my %config_bool_settings = (
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
+    "confirmcc"   => [\$confirm_cc, undef],
     "validate" => [\$validate, 1],
 );
 
@@ -258,6 +260,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "suppress-from!" => \$suppress_from,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
+		    "confirm-cc" => \$confirm_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
@@ -346,6 +349,12 @@ if ($suppress_cc{'body'}) {
 	delete $suppress_cc{'body'};
 }
 
+if (!defined $confirm_cc) {
+    # defaults to true unless user has specified any of the other cc options
+    $confirm_cc = scalar %suppress_cc ? 0 : 1;
+}
+
+
 # Debugging, print out the suppressions.
 if (0) {
 	print "suppressions:\n";
@@ -943,7 +952,7 @@ foreach my $t (@files) {
 	my $author_encoding;
 	my $has_content_type;
 	my $body_encoding;
-	@cc = @initial_cc;
+	@cc = ();
 	@xh = ();
 	my $input_format = undef;
 	my @header = ();
@@ -1080,6 +1089,22 @@ foreach my $t (@files) {
 		}
 	}
 
+	if (@cc and $confirm_cc) {
+		print "Automatically cc'ing:\n";
+		print "	  $_\n" for each @cc;
+		print "Okay? "
+		while (1) {
+			$_ = $term->readline("Okay (y/n)?");
+			last if defined $_;
+			print "\n";
+		}
+		if (/n/i) {
+			$message_id = undef;
+			continue;
+		}
+	}
+	push(@cc, @initial_cc);
+
 	send_message();
 
 	# set up for the next message
-- 
1.6.2.rc1.309.g5f417
