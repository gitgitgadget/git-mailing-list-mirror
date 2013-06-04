From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix `git svn rebase` if top-level HEAD directory exist
Date: Tue, 4 Jun 2013 03:49:56 -0400
Message-ID: <20130604074956.GA13555@sigill.intra.peff.net>
References: <51AD9828.7080508@ojab.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ojab <ojab@ojab.ru>
X-From: git-owner@vger.kernel.org Tue Jun 04 09:50:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujm0L-0007Ml-FO
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760057Ab3FDHuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 03:50:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:38850 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759665Ab3FDHt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 03:49:59 -0400
Received: (qmail 2629 invoked by uid 102); 4 Jun 2013 07:50:44 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 02:50:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 03:49:56 -0400
Content-Disposition: inline
In-Reply-To: <51AD9828.7080508@ojab.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226323>

On Tue, Jun 04, 2013 at 11:32:56AM +0400, ojab wrote:

> Oh hai!

You can haz patch?

> I have a svn repo with the top-level directory named HEAD and `git
> svn rebase [HEAD] [--]` fails with
> >$ git svn rebase
> >fatal: ambiguous argument 'HEAD': both revision and filename
> >Use '--' to separate paths from revisions, like this:
> >'git <command> [<revision>...] -- [<file>...]'
> >rev-list --first-parent --pretty=medium HEAD: command returned error: 128

This rationale should probably go in the commit message.

> From 522cbc8b8a7c4f2ab4268551a550585753164677 Mon Sep 17 00:00:00 2001
> From: ojab <ojab@ojab.ru>
> Date: Tue, 4 Jun 2013 11:28:16 +0400
> Subject: [PATCH] Fix `git svn rebase` if top-level HEAD directory exist

We prefer patches to be inline in the email; these lines can be
dropped, as they are picked up from your email headers.

> Signed-off-by: ojab <ojab@ojab.ru>

Do you mind providing a real name? The point of Signed-off-by is for
licensing and attribution.

> diff --git a/git-svn.perl b/git-svn.perl
> index d070de0..e35a66a 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1932,7 +1932,7 @@ sub cmt_sha2rev_batch {
>  sub working_head_info {
>  	my ($head, $refs) = @_;
>  	my @args = qw/rev-list --first-parent --pretty=medium/;
> -	my ($fh, $ctx) = command_output_pipe(@args, $head);
> +	my ($fh, $ctx) = command_output_pipe(@args, $head, "--");

Looks obviously correct to me. I did a quick grep, and there is one
other spot that probably should get the same treatment:

diff --git a/git-svn.perl b/git-svn.perl
index d070de0..07797ad 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -831,7 +831,7 @@ sub cmd_dcommit {
 sub cmd_dcommit {
 	my $head = shift;
 	command_noisy(qw/update-index --refresh/);
-	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
+	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD --/) }
 		'Cannot dcommit with a dirty index.  Commit your changes first, '
 		. "or stash them with `git stash'.\n";
 	$head ||= 'HEAD';

Feel free to squash it in if you re-roll your patch. There are a few
other spots that feed full sha1s. They are probably less likely to
trigger, but perhaps should be protected, too, just in case.

-Peff
