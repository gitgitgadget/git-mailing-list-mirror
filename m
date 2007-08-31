From: Junio C Hamano <gitster@pobox.com>
Subject: git-svn: Protect against "diff.color = true".
Date: Fri, 31 Aug 2007 14:29:49 -0700
Message-ID: <7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	<7vveav21uv.fsf@gitster.siamese.dyndns.org>
	<20070831152153.GA30745@muzzle>
	<7v4pifzawc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Robert Newson <robert.newson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRE3y-0004Uz-E9
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965561AbXHaV3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965426AbXHaV3z
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:29:55 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965353AbXHaV3y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:29:54 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6891C12BFD8;
	Fri, 31 Aug 2007 17:30:13 -0400 (EDT)
In-Reply-To: <7v4pifzawc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 31 Aug 2007 13:50:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57217>

If the configuration of the user has "diff.color = true", the
output from "log" we invoke internally added color codes, which
broke the parser.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

  > We probably should do two things to resolve this.
  >
  >  * Protect our scripts.  When parsing from "git log" and any
  >    other Porcelain, explicitly give --no-color.

  Here is my attempt -- I do not have an easy access to SVN repo
  to interoperate with, so a testing by real-world users and an
  Ack is appreciated.  I think some fix for this issue (not
  necessarily this patch) should be in 1.5.3 final.

 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4e325b7..98218da 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -807,7 +807,7 @@ sub cmt_metadata {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my ($fh, $ctx) = command_output_pipe('log', $head);
+	my ($fh, $ctx) = command_output_pipe('log', '--no-color', $head);
 	my $hash;
 	my %max;
 	while (<$fh>) {
@@ -2072,7 +2072,7 @@ sub rebuild {
 		return;
 	}
 	print "Rebuilding $db_path ...\n";
-	my ($log, $ctx) = command_output_pipe("log", $self->refname);
+	my ($log, $ctx) = command_output_pipe("log", '--no-color', $self->refname);
 	my $latest;
 	my $full_url = $self->full_url;
 	remove_username($full_url);
