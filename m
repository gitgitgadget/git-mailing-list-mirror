From: John Keeping <john@keeping.me.uk>
Subject: Re: Different diff strategies in add --interactive
Date: Mon, 10 Jun 2013 22:46:38 +0100
Message-ID: <20130610214638.GK22905@serenity.lan>
References: <20130610142825.GI22905@serenity.lan>
 <7v38sphiiw.fsf@alter.siamese.dyndns.org>
 <20130610211140.GD13333@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:46:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9vO-0007nu-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab3FJVqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:46:47 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:39099 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab3FJVqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:46:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B401660650E;
	Mon, 10 Jun 2013 22:46:45 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvMGE8aJtG4z; Mon, 10 Jun 2013 22:46:45 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D6C356064B8;
	Mon, 10 Jun 2013 22:46:40 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130610211140.GD13333@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227390>

On Mon, Jun 10, 2013 at 05:11:41PM -0400, Jeff King wrote:
> On Mon, Jun 10, 2013 at 12:28:55PM -0700, Junio C Hamano wrote:
> > John Keeping <john@keeping.me.uk> writes:
> > 
> > > I think the first thing to do is read the "diff.algorithm" setting in
> > > git-add--interactive and pass its value to the underlying diff-index and
> > > diff-files commands, but should we also have a command line parameter to
> > > git-add to specify the diff algorithm in interactive mode?  And if so,
> > > can we simply add "--diff-algorithm" to git-add, or is that too
> > > confusing?
> > 
> > Making "git add--interactive" read from diff.algorithm is probably a
> > good idea, because the command itself definitely is a Porcelain.  We
> > would probably need a way to defeat the configured default for
> > completeness, either:
> > 
> >     git add -p --diff-algorithm=default
> >     git -c diff.algorithm=default add -p
> > 
> > but I suspect that a new option to "git add" that only takes effect
> > together with "-p" is probably an overkill, only in order to support
> > the former and not having to say the latter, but I can be persuaded
> > either way.
> 
> Worse than that, you would need to add such an option to "checkout -p",
> "reset -p", "stash -p", etc. I think the latter form you suggest is
> probably acceptable in this case.

That's what I'm planning to do at the moment, if anyone wants to extend
it further in the future then that can be built on top.

> Overall, I think respecting diff.algorithm in add--interactive is a very
> sane thing to do. I would even be tempted to say we should allow a few
> other select diff options (e.g., fewer or more context lines). If you
> allowed diff options like this:
> 
>   git add --patch="--patience -U5"
> 
> that is very flexible, but I would not want to think about what the code
> does when you pass --patch="--raw" or equal nonsense.

An alternative would be to permit them to be set from within the
interactive UI.  I'd find it quite useful to experiment with various
diff options when I encounter a hunk that isn't as easy to pick as I'd
like.  I expect it would be very hard to do that on a per-hunk basis,
although per-file doesn't seem like it would be too hard.

I don't intend to investigate that though - respecting diff.algorithm is
good enough for my usage.

> But I cannot off the top of my head think of other options besides -U
> that would be helpful. I have never particularly wanted it for "add -p",
> either, though I sometimes generate patches to the list with a greater
> number of context lines when I think it makes the changes to a short
> function more readable.

--function-context might also be useful, but that's in the same category
as -U.

The patch I'm using is below.  I'm not sure how we can test this though;
it seems fragile to invent a patch that appears different with different
diff algorithms.  Any suggestions?

-- >8 --
 git-add--interactive.perl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d2c4ce6..0b0fac2 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -44,6 +44,8 @@ my ($diff_new_color) =
 
 my $normal_color = $repo->get_color("", "reset");
 
+my $diff_algorithm = ($repo->config('diff.algorithm') or 'default');
+
 my $use_readkey = 0;
 my $use_termcap = 0;
 my %term_escapes;
@@ -731,6 +733,9 @@ sub run_git_apply {
 sub parse_diff {
 	my ($path) = @_;
 	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
+	if ($diff_algorithm ne "default") {
+		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
+	}
 	if (defined $patch_mode_revision) {
 		push @diff_cmd, $patch_mode_revision;
 	}
-- 
1.8.3.779.g691e267
