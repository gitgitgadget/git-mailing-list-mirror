From: Adam Roben <aroben@apple.com>
Subject: [PATCH 09/11] Git.pm: Add command_bidi_pipe and command_close_bidi_pipe
Date: Wed, 23 Apr 2008 15:17:51 -0400
Message-ID: <1208978273-98146-10-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
 <1208978273-98146-5-git-send-email-aroben@apple.com>
 <1208978273-98146-6-git-send-email-aroben@apple.com>
 <1208978273-98146-7-git-send-email-aroben@apple.com>
 <1208978273-98146-8-git-send-email-aroben@apple.com>
 <1208978273-98146-9-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUx-00058u-98
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbYDWTSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbYDWTSK
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:10 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49425 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbYDWTSF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:05 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id F1184293B00F;
	Wed, 23 Apr 2008 12:18:04 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id D7AC828042;
	Wed, 23 Apr 2008 12:18:04 -0700 (PDT)
X-AuditID: 1180711d-aa394bb000000ed7-41-480f8b6ccdee
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 22D3C2807F;
	Wed, 23 Apr 2008 12:18:04 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-9-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80238>

command_bidi_pipe hands back the stdin and stdout file handles from the
executed command. command_close_bidi_pipe closes these handles and terminates
the process.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 perl/Git.pm |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 2e7f896..d766974 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -51,6 +51,7 @@ require Exporter;
 # Methods which can be called as standalone functions as well:
 @EXPORT_OK = qw(command command_oneline command_noisy
                 command_output_pipe command_input_pipe command_close_pipe
+                command_bidi_pipe command_close_bidi_pipe
                 version exec_path hash_object git_cmd_try);
 
 
@@ -92,6 +93,7 @@ increate nonwithstanding).
 use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path);
+use IPC::Open2 qw(open2);
 
 }
 
@@ -375,6 +377,60 @@ sub command_close_pipe {
 	_cmd_close($fh, $ctx);
 }
 
+=item command_bidi_pipe ( COMMAND [, ARGUMENTS... ] )
+
+Execute the given C<COMMAND> in the same way as command_output_pipe()
+does but return both an input pipe filehandle and an output pipe filehandle.
+
+The function will return return C<($pid, $pipe_in, $pipe_out, $ctx)>.
+See C<command_close_bidi_pipe()> for details.
+
+=cut
+
+sub command_bidi_pipe {
+	my ($pid, $in, $out);
+	$pid = open2($in, $out, 'git', @_);
+	return ($pid, $in, $out, join(' ', @_));
+}
+
+=item command_close_bidi_pipe ( PID, PIPE_IN, PIPE_OUT [, CTX] )
+
+Close the C<PIPE_IN> and C<PIPE_OUT> as returned from C<command_bidi_pipe()>,
+checking whether the command finished successfully. The optional C<CTX>
+argument is required if you want to see the command name in the error message,
+and it is the fourth value returned by C<command_bidi_pipe()>.  The call idiom
+is:
+
+	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --batch-check');
+	print "000000000\n" $out;
+	while (<$in>) { ... }
+	$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
+
+Note that you should not rely on whatever actually is in C<CTX>;
+currently it is simply the command name but in future the context might
+have more complicated structure.
+
+=cut
+
+sub command_close_bidi_pipe {
+	my ($pid, $in, $out, $ctx) = @_;
+	foreach my $fh ($in, $out) {
+		unless (close $fh) {
+			if ($!) {
+				carp "error closing pipe: $!";
+			} elsif ($? >> 8) {
+				throw Git::Error::Command($ctx, $? >>8);
+			}
+		}
+	}
+
+	waitpid $pid, 0;
+
+	if ($? >> 8) {
+		throw Git::Error::Command($ctx, $? >>8);
+	}
+}
+
 
 =item command_noisy ( COMMAND [, ARGUMENTS... ] )
 
-- 
1.5.5.1.152.g9aeb7
