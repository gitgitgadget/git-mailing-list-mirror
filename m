From: Adam Roben <aroben@apple.com>
Subject: [PATCH 7/9] Git.pm: Add command_bidi_pipe and command_close_bidi_pipe
Date: Thu, 25 Oct 2007 03:25:25 -0700
Message-ID: <1193307927-3592-8-git-send-email-aroben@apple.com>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
 <1193307927-3592-2-git-send-email-aroben@apple.com>
 <1193307927-3592-3-git-send-email-aroben@apple.com>
 <1193307927-3592-4-git-send-email-aroben@apple.com>
 <1193307927-3592-5-git-send-email-aroben@apple.com>
 <1193307927-3592-6-git-send-email-aroben@apple.com>
 <1193307927-3592-7-git-send-email-aroben@apple.com>
Cc: Junio Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 12:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzvk-0007WS-9j
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbXJYK0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbXJYK0W
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:26:22 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:63570 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074AbXJYK0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:26:07 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id F07561639CF4;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id D5016280A7;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
X-AuditID: 11807134-a665bbb000000c52-47-47206f3d59e9
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id BA4E7280A3;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1342.g32de
In-Reply-To: <1193307927-3592-7-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62301>

command_bidi_pipe hands back the stdin and stdout file handles from the
executed command. command_close_bidi_pipe closes these handles and terminates
the process.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 perl/Git.pm |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 3f4080c..46c5d10 100644
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
+	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --stdin');
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
+		if (not close $fh) {
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
1.5.3.4.1337.g8e67d-dirty
