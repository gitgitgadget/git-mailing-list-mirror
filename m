From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Generalize auto-cc recipient mechanism.
Date: Tue, 25 Dec 2007 13:04:54 -0800
Message-ID: <7vk5n2o58p.fsf@gitster.siamese.dyndns.org>
References: <1198216860-487-1-git-send-email-git@davidb.org>
	<1198532163-25308-1-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joel Becker <Joel.Becker@oracle.com>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Dec 25 22:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7Gy5-0004tJ-Np
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 22:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbXLYVFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 16:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbXLYVFF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 16:05:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbXLYVFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 16:05:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AC8C4412;
	Tue, 25 Dec 2007 16:05:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BA9654411;
	Tue, 25 Dec 2007 16:04:56 -0500 (EST)
In-Reply-To: <1198532163-25308-1-git-send-email-git@davidb.org> (David Brown's
	message of "Mon, 24 Dec 2007 13:36:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69237>

David Brown <git@davidb.org> writes:

> ...
>   self   - patch sender.  Same as --suppress-from.
>   author - patch author.
>   cc     - cc lines mentioned in the patch.
>   cccmd  - avoid running the cccmd.
>   sob    - signed off by lines.
>   all    - all non-explicit recipients
>
> Signed-off-by: David Brown <git@davidb.org>
> ...
> What bothers me most about this change is that --signed-of-cc
> and --suppress-from are silently ignored if --suppress-cc is given, either
> on the command line, or in the config.

The order in which various variables are set in the current code
before your patch is like this:

 * my ($var) introduces them -- they are undefined at the
   beginning;

 * GetOptions() may set them to explicit values;

 * read_config(), first for the specific sendemail identity and
   then for the generic ones, fill the ones that are still
   undefined;

 * the built-in default from %config_bool_settings are used to
   fill the ones that are still undefined at this point;

Now, I think you can build on top of the above by adding the
following after that sequence:

 * fill %suppress_cc with explicit @suppress_cc GetOptions and
   read_config() read;

 * if the --suppress-from and/or --signed-off-by-cc, either from
   GetOptions() or from read_config() are given, make them
   override what @suppress_cc says.  So giving --suppress-cc=all
   and --signed-off-by-cc at the same time will still send cc to
   people who signed off the patch (because these old-style ones
   are more specific).

Perhaps something like this (untested, of course!) patch on top
of yours.


 git-send-email.perl |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1f03d12..cde5ffb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -188,8 +188,8 @@ my (@suppress_cc);
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
-    "suppressfrom" => [\$suppress_from, 0],
-    "signedoffcc" => [\$signed_off_cc, 1],
+    "suppressfrom" => [\$suppress_from, undef],
+    "signedoffcc" => [\$signed_off_cc, undef],
     "smtpssl" => [\$smtp_ssl, 0],
 );
 
@@ -279,18 +279,20 @@ if (@suppress_cc) {
 			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
 		$suppress_cc{$entry} = 1;
 	}
-} else {
-	# Convert the old-style options.
-	$suppress_cc{'self'} = 1 if $suppress_from;
-	$suppress_cc{'sob'} = 1 unless $signed_off_cc;
 }
-
 if ($suppress_cc{'all'}) {
 	foreach my $entry (qw (ccmd cc author self sob)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
 }
+# If explicit old-style ones are specified, they trump supress-cc
+if (defined $suppress_from) {
+	$suppress_cc{'self'} = $suppress_from;
+}
+if (defined $signed_off_cc) {
+	$suppress_cc{'sob'} = !$signed_off_cc;
+}
 
 my ($repoauthor) = $repo->ident_person('author');
 my ($repocommitter) = $repo->ident_person('committer');
