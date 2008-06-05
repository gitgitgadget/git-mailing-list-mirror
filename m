From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Wed, 4 Jun 2008 21:46:18 -0400
Message-ID: <20080605014618.GA27381@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net> <200806010241.51464.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 05 03:47:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K44ZQ-0008W3-Pb
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 03:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbYFEBqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 21:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbYFEBqX
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 21:46:23 -0400
Received: from peff.net ([208.65.91.99]:4342 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbYFEBqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 21:46:22 -0400
Received: (qmail 23421 invoked by uid 111); 5 Jun 2008 01:46:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 04 Jun 2008 21:46:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jun 2008 21:46:18 -0400
Content-Disposition: inline
In-Reply-To: <200806010241.51464.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83844>

On Sun, Jun 01, 2008 at 02:41:48AM +0200, Thomas Rast wrote:

> The current implementation rejects edits that break the (whole) patch
> (thanks Junio for pointing out --check...), but it does help the user
> in one aspect: @ lines are edited to reflect their hunk contents, even
> inferring the starting line numbers from the last hunk if they are
> missing.  This means you can insert a line consisting just of an @,
> and it will silently be fixed to start a new hunk at that point.

Overall, I think this patch is reasonable. I have a few complaints, but
I'm not sure that there are better alternatives. See below.

> - Perhaps the instructions should go to the bottom, but then the odds
>   are they would not be visible in many cases.

They are at the bottom in "rebase -i", and I think there was much
discussion that led to that.

> - Should I try to come up with a unique filename to support concurrent
>   edits?  (git-commit doesn't...)

I think it makes sense to; there isn't really a downside.

> +my ($diff_plain_color) =
> +	$diff_use_color ? (
> +		$repo->get_color('color.diff.plain', ''),
> +	) : ();
> +my ($diff_old_color) =
> +	$diff_use_color ? (
> +		$repo->get_color('color.diff.old', 'red'),
> +	) : ();
> +my ($diff_new_color) =
> +	$diff_use_color ? (
> +		$repo->get_color('color.diff.new', 'green'),
> +	) : ();

Yuck. I was hoping we could avoid doing anything with diff colors here.
I had envisioned this as the user editing the hunk, and we would just
match up the lines. That is, they would only be deleting lines, and we
would simply read back each line, comparing against the original hunk.
Any lines which were removed by the user would become no-ops in the
hunk.

But that being said, I think your approach is much more powerful, since
you are allowing arbitrary editing of the hunk (as much as that is
possible). And in that case, I think the re-coloring is necessary, since
we can't just match the lines up to their previously colored versions
anymore.

> +sub edit_hunk_manually {
> +	my @oldtext;
> +	for (@_) {
> +		push @oldtext, @{$_->{TEXT}};
> +	}

I think this might be more readable as:

  my @oldtext = map { @{$_->{TEXT}} } @_;

I like to declare and initialize values in the same expression, so you
know that they have that value in all code paths. But that is a nit.

> +	# use a .diff file to help editors with highlighting
> +	my $editpath = $repo->repo_path() . "/ADDP_HUNK_EDIT.diff";
> +	my $fh;
> +	open $fh, '>', $editpath
> +		or die "failed to open hunk edit file for writing: " . $!;
> +	print $fh <<EOF;

Use File::Temp here to get a unique name.

> +# MANUAL HUNK EDIT MODE
> +#
> +# You can change the hunk to your heart's content, but it will be
> +# refused if the end result (the entire patch including your edited
> +# hunk) does not apply cleanly.

This paragraph can probably be omitted if we want to make the
instructions smaller (but I think just putting it at the end will be
fine).

> +# To remove '-' lines, make them ' ' lines (context).
> +# To remove '+' lines, delete them.

This makes perfect sense if you understand editing diffs, but is maybe a
little scary for less clueful users. I wonder if we could detect removed
'-' lines and munge them into context lines on behalf of the user.
Though that requires comparing old and new, which kind of goes against
the feature's "do whatever you want, and we will try to apply it" model.

So perhaps manual hunk editing is simply something for advanced users
who are comfortable with the patch format.

> +# Empty lines and lines starting with # will be removed.

What about lines starting with characters besides -, +, space, or @?
They will normally be ignored by diff.

> +	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor")
> +		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
> +	system('sh', '-c', $editor.' "$@"', $editor, $editpath);

I think there are a few other perl spots that figure out the editor.
Maybe this should be refactored into Git.pm?

> +	open $fh, '<', $editpath
> +		or die "failed to open hunk edit file for reading: " . $!;
> +	my @newtext;
> +	while (<$fh>) {
> +		push (@newtext, $_) unless /^#/ || /^$/;
> +	}
> +	close $fh;

Again, I might do:

  my @newtext = grep { !/^$/ && !/^#/ } <$fh>;

Though I wonder if what you really want is:

  grep { /^[@ +-]/ }

since other lines are generally ignored in patches.

> +	my @heads = ();
> +	my ($o_ofs, $n_ofs);
> +	my $o_cnt = 0;
> +	my $n_cnt = 0;
> +	my ($guess_o_ofs, undef, $guess_n_ofs, undef) = parse_hunk_header($oldtext[0]);
> +	for (my $i = 0; $i < @newtext; $i++) {
> +		if ((scalar @heads) == 0 && $newtext[$i] =~ /^[ +-]/) {
> +			splice @newtext, $i, 0, $oldtext[0];
> +			push @heads, $i;
> +		}

You can just say "@heads == 0" (or !@heads) here; the "==" implies
scalar context.

So it looks like we are restoring the old hunk header if they deleted it
for some reason. I guess this is a reasonable precaution. However, it
took me a minute to figure out what was going on. Maybe a comment is in
order.

> +		elsif ($newtext[$i] =~ /^@/) {
> +			if (@heads > 0) {
> +				# fix up the previous header first
> +				($o_ofs, undef, $n_ofs, undef)
> +					= parse_hunk_header($newtext[$heads[-1]]);
> +				$o_ofs = $guess_o_ofs unless defined $o_ofs;
> +				$n_ofs = $guess_n_ofs unless defined $n_ofs;
> +				$newtext[$heads[-1]] = (
> +					"@@ -$o_ofs" . (($o_cnt != 1) ? ",$o_cnt" : '')
> +					. " +$n_ofs" . (($n_cnt != 1) ? ",$n_cnt" : '')
> +					. " @@\n");
> +				$guess_o_ofs = $o_ofs + $o_cnt;
> +				$guess_n_ofs = $n_ofs + $n_cnt;
> +			}
> +			$o_cnt = 0;
> +			$n_cnt = 0;
> +			push @heads, $i;
> +		}
> +	}

I think this is right, but it would be nice to have a few testcases in
t3701 with some basic sanity checks and covering the border cases.

> +	($o_ofs, undef, $n_ofs, undef)
> +		= parse_hunk_header($newtext[$heads[-1]]);
> +	$o_ofs = $guess_o_ofs unless defined $o_ofs;
> +	$n_ofs = $guess_n_ofs unless defined $n_ofs;
> +	$newtext[$heads[-1]] = (
> +		"@@ -$o_ofs" . (($o_cnt != 1) ? ",$o_cnt" : '')
> +		. " +$n_ofs" . (($n_cnt != 1) ? ",$n_cnt" : '')
> +		. " @@\n");

Hmm. Repeating this chunk is a bit ugly. I wonder if the whole loop
might be a bit more readable in two sections: first parse into a list of
hunks, and then fixup each hunk.

> +	push @heads, (scalar @newtext);

Is that right? Before, heads referred to the "$i" of our loop; but
"scalar @newtext" is one _past_ the final element.

> +	my (@hunks) = ();
> +	for (my $i = 0; $i < @heads-1; $i++) {

A nicer way of spelling this is:

  $i < $#heads

> +		my @hunktext = @newtext[$heads[$i]..$heads[$i+1]-1];

Again, I think this might be more clear if you munged newtext into its
constituent hunks.

> +		my @hunkdisplay = ();
> +		for (@hunktext) {
> +			if (/^@/) {
> +				push @hunkdisplay, (colored $fraginfo_color, $_);
> +			}
> +			elsif (/^\+/) {
> +				push @hunkdisplay, (colored $diff_new_color, $_);
> +			}
> +			elsif (/^-/) {
> +				push @hunkdisplay, (colored $diff_old_color, $_);
> +			}
> +			else {
> +				push @hunkdisplay, (colored $diff_plain_color, $_);
> +			}
> +		}

Again, perhaps map instead of a series of pushes is more readable:

  my @hunkdisplay = map {
    colored
      /^@/  ? $fraginfo_color :
      /^\+/ ? $diff_new_color :
      /^-/  ? $diff_old_color :
              $diff_plain_color,
      $_;
  } @hunktext;

> +		my $fh;
> +		open $fh, '| git apply --cached --check';
> +		for my $h ($head,
> +			   $ix > 0 ? @$hunks[0..$ix-1] : (),
> +			   @newhunks,
> +			   $ix < (scalar @$hunks)-2 ? @$hunks[$ix+1..@$hunks] : ()) {
> +			for (@{$h->{TEXT}}) {
> +				print $fh $_;
> +			}
> +		}
> +		if (!close $fh) {
> +			# didn't apply cleanly

Another style nit: I think the edit_hunk_loop function would be much
more readable if this chunk became 'sub diff_applies'.

> +			while (1) {
> +				print colored $prompt_color, "Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? ";
> +				my $line = <STDIN>;
> +				if ($line =~ /^y/) {

Probably should be "/^y/i".

> +				elsif ($line =~ /^n/) {

Ditto.

Overall, I think it looks reasonable. My complaints are:

 - Minor fixups and style comments. All of my style comments are "I
   would have done it as..." and not "Oh God, this is horrible" so I
   don't think any block acceptance.

 - The interface is a little less user-friendly, but a little more
   powerful than I was envisioning. However, nobody has said much, so I
   think the best thing might be to cook in next for a while and see if
   people find it useful.

 - I'd really like to see a few testcases before that, though.

-Peff
