From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv4 3/6] Git.pm: refactor command_close_bidi_pipe to use _cmd_close
Date: Tue, 12 Feb 2013 15:02:30 +0100
Message-ID: <fc760829f74f31d23f94b61a9e087eda2a66956e.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 15:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5GSz-0000kl-EA
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 15:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286Ab3BLODW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 09:03:22 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:57273 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933265Ab3BLODQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 09:03:16 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so53556eek.20
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 06:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=gX4vElO2l70gOzqqiknUPYBxZXgEZ6RmvdyF3/F2Ft8=;
        b=napX3tlrwb06S/6MNFiDmwRDSa9TlUkjgHJ5w7Its6j/Cd/wq3zzhxAkkD7Y60UrK5
         1AK3NlDvu6zACyM6A6714RmZ2/AqqOMiNJ+cEZ4+5pq0vhPQyOVr0rq0Q7jwCl3txqRC
         OnqpJBAOZHROcKsWces8UOBFW9aUfLIvTO69tquK3BzCrn3VshSJSOvTk9Pz/v8rftlK
         g7GeZGxsaZlcV6FXwc4gWESkB7vDm2jkrTKEonBOjXqT1/d+QdJ4WuCp15b8Ws54j6pp
         Ui9lQ/lGpb2Exd/Wtu+KZK3fXTzI2SkfBG7yCg+1fLUWyKyw2+z4ZzINmwVlC5T6h2gh
         GgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=gX4vElO2l70gOzqqiknUPYBxZXgEZ6RmvdyF3/F2Ft8=;
        b=oNzxuP9GV9Zp38B4qz/2+xMOGAcjQH/p5tN2WY7kW0Dd/6fBj5vTUlqnkUHG1VvWFI
         HAaWY5oLP0FR7f+reZXlRereoC20ELp5W1Y90cGgOspAjo/wO37IAPiwRjnBf/sNdITS
         CJ2lzHe0Dl4I29uU1nFixkiHNDcJ3oUmwBv5vWesQZxKxk+P4b+qWkFQS2O7JWwhfLlO
         xlPY5LD3iGZqSvQ8HltaRtdNhr70M8l119K8Nqeh/70j5gUBT+InFBq0XsqkRYqj9RqD
         4SWEwBftBgk2iQaLWrdZ0lGldwSccpObXMZtLwubT5pY5WhsXNcbIG4KeWe7Vg/d/S43
         zPgw==
X-Received: by 10.14.220.135 with SMTP id o7mr47178488eep.3.1360677782749;
        Tue, 12 Feb 2013 06:03:02 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm68000941eek.5.2013.02.12.06.03.01
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 06:03:01 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.572.g32bae1f
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQkBxheStrajmD0ylKoBly766fFi1azTEuLB3gQElmMgI8V5/w/WPTm9vwesP94yfBVvwNeSoiKOUtyMeqrSBHr0cMsqaYFwd/yA2DznYDFJgagQR2VutkTxuuRG2TWh1NGSo2EqbcxqEIyfu6jHM0qHSVwNcQmvzFHI0bPpBVJgLc057tt81+13nA7Or2+FN8aoeenN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216155>

From: Michal Nazarewicz <mina86@mina86.com>

The body of the loop in command_close_bidi_pipe function is identical to
what _cmd_close function does so instead of duplicating, refactor change
_cmd_close so that it accepts list of file handlers to be closed, which
makes it usable with command_close_bidi_pipe.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 11f310a..6bc9a3c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -267,13 +267,13 @@ sub command {
 
 	if (not defined wantarray) {
 		# Nothing to pepper the possible exception with.
-		_cmd_close($fh, $ctx);
+		_cmd_close($ctx, $fh);
 
 	} elsif (not wantarray) {
 		local $/;
 		my $text = <$fh>;
 		try {
-			_cmd_close($fh, $ctx);
+			_cmd_close($ctx, $fh);
 		} catch Git::Error::Command with {
 			# Pepper with the output:
 			my $E = shift;
@@ -286,7 +286,7 @@ sub command {
 		my @lines = <$fh>;
 		defined and chomp for @lines;
 		try {
-			_cmd_close($fh, $ctx);
+			_cmd_close($ctx, $fh);
 		} catch Git::Error::Command with {
 			my $E = shift;
 			$E->{'-outputref'} = \@lines;
@@ -313,7 +313,7 @@ sub command_oneline {
 	my $line = <$fh>;
 	defined $line and chomp $line;
 	try {
-		_cmd_close($fh, $ctx);
+		_cmd_close($ctx, $fh);
 	} catch Git::Error::Command with {
 		# Pepper with the output:
 		my $E = shift;
@@ -381,7 +381,7 @@ have more complicated structure.
 sub command_close_pipe {
 	my ($self, $fh, $ctx) = _maybe_self(@_);
 	$ctx ||= '<unknown>';
-	_cmd_close($fh, $ctx);
+	_cmd_close($ctx, $fh);
 }
 
 =item command_bidi_pipe ( COMMAND [, ARGUMENTS... ] )
@@ -431,18 +431,8 @@ have more complicated structure.
 sub command_close_bidi_pipe {
 	local $?;
 	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
-	foreach my $fh ($in, $out) {
-		unless (close $fh) {
-			if ($!) {
-				carp "error closing pipe: $!";
-			} elsif ($? >> 8) {
-				throw Git::Error::Command($ctx, $? >>8);
-			}
-		}
-	}
-
+	_cmd_close($ctx, $in, $out);
 	waitpid $pid, 0;
-
 	if ($? >> 8) {
 		throw Git::Error::Command($ctx, $? >>8);
 	}
@@ -1355,9 +1345,11 @@ sub _execv_git_cmd { exec('git', @_); }
 
 # Close pipe to a subprocess.
 sub _cmd_close {
-	my ($fh, $ctx) = @_;
-	if (not close $fh) {
-		if ($!) {
+	my $ctx = shift @_;
+	foreach my $fh (@_) {
+		if (close $fh) {
+			# nop;
+		} elsif ($!) {
 			# It's just close, no point in fatalities
 			carp "error closing pipe: $!";
 		} elsif ($? >> 8) {
-- 
1.8.1.3.572.g32bae1f
