From: Jeff King <peff@peff.net>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Mon, 4 Jan 2010 23:14:38 -0500
Message-ID: <20100105041438.GB12574@coredump.intra.peff.net>
References: <36FEB8A0-968D-4B43-AEFB-9B0E227A1F88@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 05:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS0pF-0000w4-QP
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 05:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab0AEEOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 23:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280Ab0AEEOn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 23:14:43 -0500
Received: from peff.net ([208.65.91.99]:38237 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab0AEEOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 23:14:42 -0500
Received: (qmail 26575 invoked by uid 107); 5 Jan 2010 04:19:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 23:19:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 23:14:38 -0500
Content-Disposition: inline
In-Reply-To: <36FEB8A0-968D-4B43-AEFB-9B0E227A1F88@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136157>

[cc'd Junio: there is a question of path limiters versus pathspecs near
the bottom].

On Mon, Jan 04, 2010 at 07:43:10PM +0100, Wincent Colaiuta wrote:

> Just ran "git add -i <path>" with "<path>" pointing to a subdirectory
> which happens to have a bunch of files in it (about 7k) and it barfed
> thusly:
> 
>   Can't exec "git": Argument list too long at /usr/local/libexec/git-
> core/git-add--interactive line 158.
>   Died at /usr/local/libexec/git-core/git-add--interactive line 158.
> 
> I see that what it's trying to do under the hood is:
> 
>   git diff-index --cached --numstat --summary HEAD -- <7,000+ paths...>

Yep, and there is a similar diff-files call after that.

> Sure, we could divide the paths into smaller groups, run multiple
> invocations of "git diff-index", and concatenate the results. But it
> would be nicer if there was some other way that we could get at the
> same information without having to pass 7,000 paths explicitly on the
> command line; is there any which I am overlooking?

No, I don't think there is way to do it with the current code short of
breaking up the output.

> The enormous file list is the result of passing <path> into "git ls-
> files -- <path>". Would it be worth:
> 
> - either, modifying "git diff-index" to accept a list of paths over
> stdin so that we could at least pipe the output from "git ls-files"
> into "git diff-index"

We could do that. It would also need a patch for diff-files. And
unfortunately it makes their interface somewhat inconsistent then with
diff-tree, which already has a --stdin but uses it for a list of
tree-ishes.

> - or, preferably, teach "git diff index" to recurse into directories
> rather than expect a list of paths-of-blobs (possibly with a command
> line switch to activate the behaviour if it were deemed a dangerous
> default)

Doesn't it already do this? If I say "git diff index subdir" it
will limit the diff only to things inside subdir/.

In fact, it is tempting to do this:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index bfd1003..a8b3e30 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -275,15 +275,6 @@ sub list_modified {
 	my ($only) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
-	my @tracked = ();
-
-	if (@ARGV) {
-		@tracked = map {
-			chomp $_;
-			unquote_path($_);
-		} run_cmd_pipe(qw(git ls-files --), @ARGV);
-		return if (!@tracked);
-	}
 
 	my $reference;
 	if (defined $patch_mode_revision and $patch_mode_revision ne 'HEAD') {
@@ -295,7 +286,7 @@ sub list_modified {
 	}
 	for (run_cmd_pipe(qw(git diff-index --cached
 			     --numstat --summary), $reference,
-			     '--', @tracked)) {
+			     '--', @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
@@ -320,7 +311,7 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
+	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			$file = unquote_path($file);

but note that the pathspecs given to ls-files and the path limiters
given to diff are not quite the same. So "git add -i '*.c'" will
currently find "subdir/foo.c", but would not with the above patch. Is
that what you meant when you said "recurse into directories"?

I seem to recall Junio noting in the past the inconsistencies in git
about what is a path and what is a pathspec. Is this one of those
inconsistencies, and would it be a positive thing to fix it?

-Peff
