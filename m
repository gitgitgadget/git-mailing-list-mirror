From: Jeff King <peff@peff.net>
Subject: Re: git-cherry filter
Date: Tue, 14 Feb 2012 16:44:00 -0500
Message-ID: <20120214214400.GB23649@sigill.intra.peff.net>
References: <jhcnfc$aec$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:44:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQAU-0000F7-OX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473Ab2BNVoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:44:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388Ab2BNVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:44:04 -0500
Received: (qmail 11968 invoked by uid 107); 14 Feb 2012 21:51:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 16:51:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 16:44:00 -0500
Content-Disposition: inline
In-Reply-To: <jhcnfc$aec$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190764>

On Mon, Feb 13, 2012 at 10:20:59PM -0600, Neal Kreitzinger wrote:

> Is there a way to add a pre-git-patch-id filter to git-cherry?

Not directly, but see below.

> (a) perform "keyword contraction" to the patch before generating the 
> git-patch-id.
> 
> e.g.  I want to run a git-cherry to see if two patches are identical other 
> than keyword expansion values like $User: foo$ vs. $User: bar$.  (I would 
> have to tell git-cherry which keyword formats to "contract".)

Shouldn't these be contracted already in the canonical versions in the
repo?

> (b) ignore comments in the source code.

This one is tough, because you are talking about arbitrary
transformation of the diff.

> (c) exclude certain files from the diff (ie., binaries, comment files, 
> etc.).

This one is perhaps easier, and git-cherry could learn to use the
regular pathspec-limiting when generating patch-ids.


In any case, git-cherry is basically just comparing the set of patch ids
in one set to the patch-ids in the other set. So you could do all of
the above transformations by hacking together something like:

  merge_base=`git merge-base $upstream $head`
  get_patch_ids() {
    git rev-list $merge_base..$1 |
      git diff-tree --stdin -p -- $path_limiters |
      munge_your_diff_however_you_like |
      git patch-id
  }
  get_patch_ids $head >head
  get_patch_ids $upstream | cut -d' ' -f1 >upstream
  perl -l <<-\EOF
  open(my $head, '<', 'head');
  open(my $upstream, '<', 'upstream');
  my %upstream = map { $_ => 1 } <$upstream>;
  while (<$head>) {
          chomp;
          my ($patch, $commit) = split;
          print exists($upstream{$patch}) ? '+' : '-',
                ' ',
                $commit;
  }
  EOF

-Peff
