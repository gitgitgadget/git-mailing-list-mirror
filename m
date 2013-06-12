From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] add--interactive: respect diff.algorithm
Date: Wed, 12 Jun 2013 19:44:10 +0100
Message-ID: <20130612184410.GB23890@serenity.lan>
References: <20130610142825.GI22905@serenity.lan>
 <7v38sphiiw.fsf@alter.siamese.dyndns.org>
 <20130610211140.GD13333@sigill.intra.peff.net>
 <20130610214638.GK22905@serenity.lan>
 <20130610215656.GA28345@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 20:44:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umq1v-0005rW-7i
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 20:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab3FLSoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 14:44:19 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:55135 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757315Ab3FLSoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 14:44:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D4E83606502;
	Wed, 12 Jun 2013 19:44:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eiMf99PvQj02; Wed, 12 Jun 2013 19:44:17 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C6EB66064EF;
	Wed, 12 Jun 2013 19:44:12 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130610215656.GA28345@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227663>

When staging hunks interactively it is sometimes useful to use an
alternative diff algorithm which splits the changes into hunks in a more
logical manner.  This is not possible because the plumbing commands
called by add--interactive ignore the "diff.algorithm" configuration
option (as they should).

Since add--interactive is a porcelain command it should respect this
configuration variable.  To do this, make it read diff.algorithm and
pass its value to the underlying diff-index and diff-files invocations.

At this point, do not add options to "git add", "git reset" or "git
checkout" (all of which can call git-add--interactive).  If a user want
to override the value on the command line they can use:

	git -c diff.algorithm=$ALGO ...

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Mon, Jun 10, 2013 at 05:56:56PM -0400, Jeff King wrote:
> On Mon, Jun 10, 2013 at 10:46:38PM +0100, John Keeping wrote:
> 
> > > Overall, I think respecting diff.algorithm in add--interactive is a very
> > > sane thing to do. I would even be tempted to say we should allow a few
> > > other select diff options (e.g., fewer or more context lines). If you
> > > allowed diff options like this:
> > > 
> > >   git add --patch="--patience -U5"
> > > 
> > > that is very flexible, but I would not want to think about what the code
> > > does when you pass --patch="--raw" or equal nonsense.
> > 
> > An alternative would be to permit them to be set from within the
> > interactive UI.  I'd find it quite useful to experiment with various
> > diff options when I encounter a hunk that isn't as easy to pick as I'd
> > like.  I expect it would be very hard to do that on a per-hunk basis,
> > although per-file doesn't seem like it would be too hard.
> 
> That's an interesting idea, for a subset of options (e.g., "increase
> context for this hunk"). I suspect implementing it would be painful,
> though, as you would have to re-run diff, and you have no guarantee of
> getting the same set of hunks (e.g., the hunk might end up coalesced
> with another).

I think you'd need to re-run the diff over the whole file and then skip
hunks until you reach one that overlaps with the original hunk.  But I
suspect it would end up being quite a lot more complicated than that.

> > diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> > index d2c4ce6..0b0fac2 100755
> > --- a/git-add--interactive.perl
> > +++ b/git-add--interactive.perl
> > @@ -44,6 +44,8 @@ my ($diff_new_color) =
> >  
> >  my $normal_color = $repo->get_color("", "reset");
> >  
> > +my $diff_algorithm = ($repo->config('diff.algorithm') or 'default');
> > +
> >  my $use_readkey = 0;
> >  my $use_termcap = 0;
> >  my %term_escapes;
> > @@ -731,6 +733,9 @@ sub run_git_apply {
> >  sub parse_diff {
> >  	my ($path) = @_;
> >  	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
> > +	if ($diff_algorithm ne "default") {
> > +		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
> > +	}
> >  	if (defined $patch_mode_revision) {
> >  		push @diff_cmd, $patch_mode_revision;
> 
> Yeah, that looks like the sane way to do it to me. As a perl style
> thing, I think the usual way of spelling 'default' is 'undef'. I.e.:
> 
>   my $diff_algorithm = $repo->config('diff.algorithm');
>   ...
>   if (defined $diff_algorithm) {
>           push @diff_cmd, "--diff-algorithm=$diff_algorithm";
>   }

OK.  The "default" is actually "the value that is equivalent to 'myers'
for diff.algorithm" and I was originally going to add --diff-algorithm
to the command line unconditionally.

But I think it's better to add it only when it has been specified so
I've changed it as you suggest.


 git-add--interactive.perl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d2c4ce6..5310959 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -44,6 +44,8 @@ my ($diff_new_color) =
 
 my $normal_color = $repo->get_color("", "reset");
 
+my $diff_algorithm = $repo->config('diff.algorithm');
+
 my $use_readkey = 0;
 my $use_termcap = 0;
 my %term_escapes;
@@ -731,6 +733,9 @@ sub run_git_apply {
 sub parse_diff {
 	my ($path) = @_;
 	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
+	if (defined $diff_algorithm) {
+		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
+	}
 	if (defined $patch_mode_revision) {
 		push @diff_cmd, $patch_mode_revision;
 	}
-- 
1.8.3.779.g691e267
