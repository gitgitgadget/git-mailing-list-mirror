From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Thu, 29 Mar 2012 01:45:58 -0400
Message-ID: <20120329054558.GA27604@sigill.intra.peff.net>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 07:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD8BW-0000eb-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 07:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab2C2FqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 01:46:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36780
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab2C2FqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 01:46:03 -0400
Received: (qmail 27653 invoked by uid 107); 29 Mar 2012 05:46:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 01:46:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 01:45:58 -0400
Content-Disposition: inline
In-Reply-To: <7v62dotltk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194229>

On Wed, Mar 28, 2012 at 03:14:31PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Totally untested, but something along this line...
> >
> > Well, probably along that line but not there.  I think the patch would be
> > a lot cleaner to keep the part I touched intact, and instead add an extra
> > "ls-files -u" that creates %unmerged hash in the way this patch does,
> > immediately before the last for() loop in the function.  And then the loop
> > can use %unmerged hash to filter the elements.
> 
> That is, something like this.

That is way better. Your original one would end up putting every file in
the repo into @tracked, which would then be fed on the command-line to
"diff-index" and company. I suspect on a large repo that could overflow
the command-line limits (plus I recall that at one point we performed
way worse on "git diff $(git ls-files)" than we do on "git diff", but
that may not be the case anymore).

However, I can think of two possible improvements:

> +	my %unmerged;
> +	if ($filter_unmerged) {
> +		for (run_cmd_pipe(qw(git ls-files -u --), @ARGV)) {
> +			chomp $_;
> +			if (/^[0-7]+ [0-9a-f]{40} [0-3]	(.*)/) {
> +				my $path = unquote_path($1);
> +				$unmerged{$path} = 1;
> +			}
> +		}
> +		if (%unmerged) {
> +			for (sort keys %unmerged) {
> +				print colored $error_color, "ignoring unmerged: $_\n";
> +			}
> +		}
> +	}

I like that we are down to a single ls-files invocation here. But can't
we determine from the diff-files output whether an entry is unmerged. In
my simple tests, I see that --numstat will show two lines for such an
entry. Is that reliable?

>  sub patch_update_cmd {
> -	my @all_mods = list_modified($patch_mode_flavour{FILTER});
> +	my @all_mods = list_modified($patch_mode_flavour{FILTER}, 'filter-unmerged');
>  	my @mods = grep { !($_->{BINARY}) } @all_mods;

It seems like a more flexible interface would not be to filter unmerged
entries, but rather to mark them as we do with BINARY. And then the
caller can do as they please, discarding, printing warnings, etc.

Right now, the behavior is to simply skip them. But it would be cool if
we could eventually show a useful presentation of the changes and ask to
stage them. I know from our past discussions it is not quite as feeding
the combined diff to the regular hunk-selector. But I'm sure we can come
up with something reasonable.

Here's the patch that I came up with to do both of those things. Like I
said, I am somewhat unsure of the "detect double mentions as unmerged"
rule. But we could still use the "ls-files -u" output to mark the
unmerged files.

---
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..6204207 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -336,7 +336,14 @@ sub list_modified {
 			else {
 				$change = "+$add/-$del";
 			}
-			$data{$file}{FILE} = $change;
+			# If we see it twice, it's unmerged.
+			if (defined $data{$file}{FILE} &&
+			    $data{$file}{FILE} ne 'nothing') {
+				$data{$file}{FILE} = 'unmerged';
+			}
+			else {
+				$data{$file}{FILE} = $change;
+			}
 			if ($bin) {
 				$data{$file}{BINARY} = 1;
 			}
@@ -1193,6 +1200,10 @@ sub patch_update_cmd {
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
+	print colored $error_color, "ignoring unmerged: $_->{VALUE}\n"
+		for grep { $_->{FILE} eq 'unmerged' } @mods;
+	@mods = grep { $_->{FILE} ne 'unmerged' } @mods;
+
 	if (!@mods) {
 		if (@all_mods) {
 			print STDERR "Only binary files changed.\n";
