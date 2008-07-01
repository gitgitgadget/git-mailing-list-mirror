From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 1 Jul 2008 05:51:18 -0400
Message-ID: <20080701095117.GC5853@sigill.intra.peff.net>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 11:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcX4-00059F-28
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYGAJvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbYGAJvV
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:51:21 -0400
Received: from peff.net ([208.65.91.99]:1857 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbYGAJvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:51:20 -0400
Received: (qmail 17203 invoked by uid 111); 1 Jul 2008 09:51:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 01 Jul 2008 05:51:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2008 05:51:18 -0400
Content-Disposition: inline
In-Reply-To: <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87018>

On Mon, Jun 30, 2008 at 06:49:25PM -0400, Adam Brewster wrote:

> Git-basis is a perl script that remembers bases for use by git-bundle.
> Code from rev-parse was borrowed to allow git-bundle to handle --stdin.

I don't use bundles myself, so I can't comment on how useful this is for
a bundle-based workflow. But it seems like a sensible idea in general.

A few comments:

> --- a/bundle.c
> +++ b/bundle.c
> @@ -227,8 +227,26 @@ int create_bundle(struct bundle_header *header,
> const char *path,
> 
>        /* write references */
>        argc = setup_revisions(argc, argv, &revs, NULL);
> -       if (argc > 1)
> -               return error("unrecognized argument: %s'", argv[1]);
> +
> +       for (i = 1; i < argc; i++) {
> +               if ( !strcmp(argv[i], "--stdin") ) {

When a new feature depends on other, more generic improvements
to existing code, it is usually split into two patches. E.g.,

  1/2: add --stdin to git-bundle
  2/2: add git-basis

with the advantages that:

 - it is slightly easier to review each change individually
 - it is easier for other features to build on the generic improvement
   without requiring part 2, especially if part 2 is questionable

As it happens in this case, I think in this case the change was already
easy to read, being logically separated by file, so I am nitpicking
somewhat. But splitting changes is a good habit to get into.

> +                               if (len && line[len - 1] == '\n')
> +                                       line[--len] = 0;

Style: we usually spell NUL as '\0'.

> diff --git a/git-basis b/git-basis
> new file mode 100755

This should be git-basis.perl, with accompanying Makefile changes.

> +if ( ! -d "$d/bases" ) {
> +    system( "mkdir '$d/bases'" );
> +}

Yikes. This fails if $d contains an apostrophe. You'd want to use
quotemeta to properly shell out. But there's no need at all to shell out
here, since perl has its own mkdir call.

> +if ( $#ARGV == -1 ) {
> +    print "usage: git-basis [--update] basis1...\n";
> +    exit;

Usage should probably go to STDERR.

> +    my %new = ();
> +    while (<STDIN>) {
> +       if (!/^^?([a-z0-9]{40})/) {next;}
> +       $new{$1} = 1;
> +    }

Why make a hash when the only thing we ever do with it is "keys %new"?
Shouldn't an array suffice?

> +    foreach my $f (@ARGV) {
> +       my %these = ();
> +       open F, "<$d/bases/$f" || die "Can't open bases/$f: $!";

Style: I know we are not consistent within git, but it is usually better
to use local variables for filehandles these days. I.e.,

  open my $fh, "<$d/bases/$f"

> +       open F, ">>$d/bases/$f" || die "Can't open bases/$f: $!";

So the basis just grows forever? That is, each time we do a bundle and
basis update, we add a line for every changed ref, and we never delete
any lines. But having a commit implies having all of its ancestors, so
in the normal case (i.e., no rewind or rebase) we can simply replace old
objects if we know they are a subset of the new ones (which you can
discover with git-merge-base). For the rewind/rebase case, probably
these lists should get pruned eventually for non-existent objects.

But maybe it is not worth worrying about this optimization at first, and
we can see if people complain. In that case, it is perhaps worth a note
in the 'Bugs' section (or 'Discussion' section) of the manpage.

> +       print F "\#" . `date`;

I don't think there are any portability issues with 'date' (especially
since it appears to be just a comment here, so we don't really care
about the format), but in general I think it is nicer to use perl's date
functions just for consistency's sake.

> --
> 1.5.5.1.211.g65ea3.dirty

Notably absent: any tests.

-Peff
