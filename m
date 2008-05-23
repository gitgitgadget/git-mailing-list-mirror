From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 4/8] Git.pm: Add command_bidi_pipe and command_close_bidi_pipe
Date: Fri, 23 May 2008 16:19:39 +0200
Message-ID: <1211552384-29636-5-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY56-00066y-LB
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbYEWOQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbYEWOQT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:19 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51425 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751829AbYEWOQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:12 -0400
Received: (qmail 32225 invoked by uid 89); 23 May 2008 14:14:53 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:53 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82704>

From: Adam Roben <aroben@apple.com>

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
1.5.5.1
