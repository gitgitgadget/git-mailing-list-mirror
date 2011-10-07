From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 3/2] Refactor Git::config_*
Date: Fri, 7 Oct 2011 23:17:16 +0200
Message-ID: <201110072317.17436.jnareb@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr> <201110010000.13328.jnareb@gmail.com> <7voby1oesm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:17:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCHnO-0006hH-0z
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 23:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab1JGVRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 17:17:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46439 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1JGVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 17:17:24 -0400
Received: by bkbzt4 with SMTP id zt4so5282494bkb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=eg7sgKs5ujpqqWMmPqoIGALEA2q3k1/mRIjWyItN1y4=;
        b=Rmm7H765Nlk7yNl9WYTXmKZChprauQRSXtU1U7XxxNpWyidaZ+eRvwsbDOxZxi5Uv4
         P2cmpX7WC0xpOcdKTV56euBKBvG0xaE8f4EpJS6fefoHkdfbIY8042RtFiI6ye8vPBOF
         GgqXJ8oxqT46y27nmtgsc3cge3lBx7SwpWzik=
Received: by 10.223.65.68 with SMTP id h4mr12628342fai.24.1318022243313;
        Fri, 07 Oct 2011 14:17:23 -0700 (PDT)
Received: from [192.168.1.13] (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id r6sm2304429fam.0.2011.10.07.14.17.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 14:17:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7voby1oesm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183111>

From: Junio C Hamano <gitster@pobox.com>

There is, especially with addition of Git::config_path(), much code
repetition in the Git::config_* family of subroutines.  Refactor
common parts of Git::config(), Git::config_bool(), Git::config_int()
and Git::config_path() into _config_common() subroutine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is version which has fixed style to be more Perl-ish, and which
actually works (i.e. t9700 passes).

I have also moved _config_common() after commands that use it, just like
it is done with other "private" methods (methods with names starting with
'_'), and excluded this private detail of implementation from docs.

 perl/Git.pm |   85 ++++++++++++++---------------------------------------------
 1 files changed, 20 insertions(+), 65 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index c279bfb..d6df2e8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -562,7 +562,6 @@ sub wc_chdir {
 	$self->{opts}->{WorkingSubdir} = $subdir;
 }
 
-
 =item config ( VARIABLE )
 
 Retrieve the configuration C<VARIABLE> in the same manner as C<config>
@@ -570,30 +569,11 @@ does. In scalar context requires the variable to be set only one time
 (exception is thrown otherwise), in array context returns allows the
 variable to be set multiple times and returns all the values.
 
-This currently wraps command('config') so it is not so fast.
-
 =cut
 
 sub config {
 	my ($self, $var) = _maybe_self(@_);
-
-	try {
-		my @cmd = ('config');
-		unshift @cmd, $self if $self;
-		if (wantarray) {
-			return command(@cmd, '--get-all', $var);
-		} else {
-			return command_oneline(@cmd, '--get', $var);
-		}
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return;
-		} else {
-			throw $E;
-		}
-	};
+	return _config_common($self, $var);
 }
 
 
@@ -603,60 +583,24 @@ Retrieve the bool configuration C<VARIABLE>. The return value
 is usable as a boolean in perl (and C<undef> if it's not defined,
 of course).
 
-This currently wraps command('config') so it is not so fast.
-
 =cut
 
 sub config_bool {
 	my ($self, $var) = _maybe_self(@_);
-
-	try {
-		my @cmd = ('config', '--bool', '--get', $var);
-		unshift @cmd, $self if $self;
-		my $val = command_oneline(@cmd);
-		return undef unless defined $val;
-		return $val eq 'true';
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return undef;
-		} else {
-			throw $E;
-		}
-	};
+	my $val = scalar _config_common($self, $var, {'kind' => '--bool'});
+	return (defined $val && $val eq 'true');
 }
 
-
 =item config_path ( VARIABLE )
 
 Retrieve the path configuration C<VARIABLE>. The return value
 is an expanded path or C<undef> if it's not defined.
 
-This currently wraps command('config') so it is not so fast.
-
 =cut
 
 sub config_path {
 	my ($self, $var) = _maybe_self(@_);
-
-	try {
-		my @cmd = ('config', '--path');
-		unshift @cmd, $self if $self;
-		if (wantarray) {
-			return command(@cmd, '--get-all', $var);
-		} else {
-			return command_oneline(@cmd, '--get', $var);
-		}
-	} catch Git::Error::Command with {
-		my $E = shift;
-		if ($E->value() == 1) {
-			# Key not found.
-			return undef;
-		} else {
-			throw $E;
-		}
-	};
+	return _config_common($self, $var, {'kind' => '--path'});
 }
 
 =item config_int ( VARIABLE )
@@ -667,28 +611,39 @@ or 'g' in the config file will cause the value to be multiplied
 by 1024, 1048576 (1024^2), or 1073741824 (1024^3) prior to output.
 It would return C<undef> if configuration variable is not defined,
 
-This currently wraps command('config') so it is not so fast.
-
 =cut
 
 sub config_int {
 	my ($self, $var) = _maybe_self(@_);
+	return scalar _config_common($self, $var, {'kind' => '--int'});
+}
+
+# Common subroutine to implement bulk of what the config* family of methods
+# do. This wraps command('config') so it is not so fast.
+sub _config_common {
+	my ($self, $var, $opts) = _maybe_self(@_);
 
 	try {
-		my @cmd = ('config', '--int', '--get', $var);
+		my @cmd = ('config', $opts->{'kind'} ? $opts->{'kind'} : ());
 		unshift @cmd, $self if $self;
-		return command_oneline(@cmd);
+		if (wantarray) {
+			return command(@cmd, '--get-all', $var);
+		} else {
+			return command_oneline(@cmd, '--get', $var);
+		}
 	} catch Git::Error::Command with {
 		my $E = shift;
 		if ($E->value() == 1) {
 			# Key not found.
-			return undef;
+			return;
 		} else {
 			throw $E;
 		}
 	};
+
 }
 
+
 =item get_colorbool ( NAME )
 
 Finds if color should be used for NAMEd operation from the configuration,
-- 
1.7.6
