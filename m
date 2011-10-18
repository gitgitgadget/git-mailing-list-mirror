From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 3/2 (fixed)] Refactor Git::config_*
Date: Tue, 18 Oct 2011 11:47:01 +0200
Message-ID: <201110181147.02397.jnareb@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr> <7vsjmrl4ur.fsf@alter.siamese.dyndns.org> <201110172347.42568.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 11:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG6GX-00035k-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 11:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab1JRJrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 05:47:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36512 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757096Ab1JRJrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 05:47:14 -0400
Received: by eye27 with SMTP id 27so362316eye.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=rJwUELl2u4Nr7KNRccyz3W5ehWIgEtVsN5DCXqQrhHc=;
        b=Rm/+suviFUySU9aKQ/e+Cbz4wcsAV3swdpk2R5LlWI9jn7PDZAj3n/W7I1wOqZE9Hq
         iYDQV+kAXaHd13f9OY16/Y2KDdX/wquGm4yWimpnPYk94pc5+RvuAOElM8pBFQtXLMpZ
         KYWdP46OWSpo/u8N2ClkY7DMfChwu2bv9WfAY=
Received: by 10.223.7.14 with SMTP id b14mr3119375fab.10.1318931233031;
        Tue, 18 Oct 2011 02:47:13 -0700 (PDT)
Received: from [192.168.1.13] (abvu235.neoplus.adsl.tpnet.pl. [83.8.218.235])
        by mx.google.com with ESMTPS id n12sm2692450fan.9.2011.10.18.02.47.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 02:47:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201110172347.42568.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183876>

From: Junio C Hamano <gitster@pobox.com>

There is, especially with addition of Git::config_path(), much code
repetition in the Git::config_* family of subroutines.

Refactor common parts of Git::config(), Git::config_bool(),
Git::config_int() and Git::config_path() into _config_common()
helper method, reducing code duplication.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:
>
> I'll resend amended commit.

Here it is.

 perl/Git.pm |   74 ++++++++++++++--------------------------------------------
 1 files changed, 18 insertions(+), 56 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index c775b4f..8e1e2fd 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -576,24 +576,7 @@ This currently wraps command('config') so it is not so fast.
 
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
 
 
@@ -609,25 +592,10 @@ This currently wraps command('config') so it is not so fast.
 
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
@@ -639,24 +607,7 @@ This currently wraps command('config') so it is not so fast.
 
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
 
 
@@ -705,16 +656,27 @@ This currently wraps command('config') so it is not so fast.
 
 sub config_int {
 	my ($self, $var) = _maybe_self(@_);
+	return scalar _config_common($self, $var, {'kind' => '--int'});
+}
+
+# Common subroutine to implement bulk of what the config* family of methods
+# do. This curently wraps command('config') so it is not so fast.
+sub _config_common {
+	my ($self, $var, $opts) = @_;
 
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
-- 
1.7.6
