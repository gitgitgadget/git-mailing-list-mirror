From: Alex Chiang <achiang@hp.com>
Subject: [PATCH RFC] git-send-email --expand-aliases
Date: Mon, 23 Nov 2009 15:16:28 -0700
Message-ID: <20091123221628.GE26810@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 23 23:16:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NChD1-000484-3F
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 23:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbZKWWQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 17:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757307AbZKWWQX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 17:16:23 -0500
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:23487 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287AbZKWWQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 17:16:22 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0006.atlanta.hp.com (Postfix) with ESMTP id 9A2CDC097;
	Mon, 23 Nov 2009 22:16:28 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id 7238F2005D;
	Mon, 23 Nov 2009 22:16:28 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 2E384CF000B;
	Mon, 23 Nov 2009 15:16:28 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id naAMv-t5JbKF; Mon, 23 Nov 2009 15:16:28 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 17F82CF0007; Mon, 23 Nov 2009 15:16:28 -0700 (MST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133536>

I'm an StGit user, and while StGit has its own 'stg mail'
feature, it doesn't know how to expand email aliases (yet).

Certainly, one way to solve that problem would be to hack stgit
so that it can parse alias files, but to me, that seems silly
when git-send-email can already do that.

This patch teaches git-send-email to only expand email addresses
so that other git porcelains don't have to roll their own mail
alias parsers.

I imagine the internal implementation of stg mail to work
something like:

	call git-send-email --expand-aliases repeatedly, once for
	all the combined --to= args, then for all the combined --cc= args,
	and finally for all the combined --bcc= args (all passed
	to stg mail), read from stdout until EOF

That API is a little ugly, requiring 3 calls to git-send-email
for each class of recipient (to, cc, bcc).

The other interface that I thought of would be to have
git-send-email print a heading like:

	TO
	<expanded alias 1>
	<expanded alias 2>
	CC
	<expanded alias 3>
	BCC
	<expanded alias 4>

But, that requires more parsing in the porcelain. Requiring a
call to git-send-email for each class of recipient seems like a
reasonable interface for what will presumably be an API only used
in an automated manner by a porcelain like stg (and possibly
guilt?).

I haven't patched stg yet, wanted to see what the feedback on
this RFC patch was first. If folks are receptive, I can send a
fuller patch with expanded help text, etc.

Thanks,
/ac

---
diff --git a/git-send-email.perl b/git-send-email.perl
index a0279de..ac34bec 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -79,6 +79,7 @@ git send-email [options] <file | directory | rev-list options >
                                      auto, cc, compose, always, or never.
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
+    --expand-aliases               * Expands email aliases only and exits
     --[no-]validate                * Perform patch sanity checks. Default on.
     --[no-]format-patch            * understand any non optional arguments as
                                      `git format-patch` ones.
@@ -156,7 +157,7 @@ if ($@) {
 }
 
 # Behavior modification variables
-my ($quiet, $dry_run) = (0, 0);
+my ($quiet, $dry_run, $expand_aliases_only) = (0, 0, 0);
 my $format_patch;
 my $compose_filename;
 
@@ -263,6 +264,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
 		    "confirm=s" => \$confirm,
+		    "expand-aliases" => \$expand_aliases_only,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
@@ -441,6 +443,22 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	}
 }
 
+if ($expand_aliases_only) {
+	my @expand_to = expand_aliases(@to);
+	my @expand_cc = expand_aliases(@initial_cc);
+	my @expand_bcc = expand_aliases(@bcclist);
+
+	@expand_to = (map { sanitize_address($_) } @expand_to);
+	@expand_cc = (map { sanitize_address($_) } @expand_cc);
+	@expand_bcc = (map { sanitize_address($_) } @expand_bcc);
+
+	for my $a (@expand_to, @expand_cc, @expand_bcc) {
+		print $a . "\n";
+	}
+
+	exit(1);
+}
+
 ($sender) = expand_aliases($sender) if defined $sender;
 
 # returns 1 if the conflict must be solved using it as a format-patch argument
