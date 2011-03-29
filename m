From: Jeff King <peff@peff.net>
Subject: Re: suggestion: git status = restored
Date: Tue, 29 Mar 2011 17:28:44 -0400
Message-ID: <20110329212844.GA23510@sigill.intra.peff.net>
References: <imil67$oec$1@dough.gmane.org>
 <20110329145818.GC10771@sigill.intra.peff.net>
 <4D92179D.6050102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:28:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4gT6-0000dd-Ib
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 23:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab1C2V2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 17:28:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab1C2V2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 17:28:46 -0400
Received: (qmail 540 invoked by uid 107); 29 Mar 2011 21:29:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 17:29:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 17:28:44 -0400
Content-Disposition: inline
In-Reply-To: <4D92179D.6050102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170328>

On Tue, Mar 29, 2011 at 12:32:13PM -0500, Neal Kreitzinger wrote:

> I see your point about the current worktree/index/HEAD.  I'm not a
> git developer, but my idea is based on the concept that the sha-1 of
> the content already exists in the object store regardless of its
> path(s). I'm talking about identical blob sha-1's, not "similar"
> content.  It seems like the loose object directory would be easy
> enough the check for duplicate blob sha-1's, but the the pack would
> probably be more difficult (i'm not sure how you could do that).  If
> this capability doesn't fit well into fast default behavior, maybe
> there could be an option to --find-restores-harder.

Ah, I see. Yes, that is extremely cheap to calculate for loose or packed
objects (see has_sha1_file in sha1_file.c). But by the time you run
status, it is too late. When you "git add" the file, it will write the
sha1 into the object db. So by definition, if you are tracking a file
for commit, it will exist in the object db. You could check the
timestamp on the object file to see if it has been around "for a while",
but that is very hack-ish and may or may not return useful results.

> That being said, I see how it may not be feasible for git-status to
> do that extra work.  Git-status runs against "what you just did" so
> hopefully I should know in my mind that I just checked something out
> to restore it.  However, for analyzing history it would be nice for
> git-log or git-diff to be able to do that extra work of finding
> restores when asked.
> 
> In our workflow it would be useful because we have a utility
> directory of mostly obsolete programs that needs to be deleted to
> eliminate noise, but we're sure some of them will get restored once
> we realize they're still needed.  An interrogation command with
> --name-status --find-restores-harder would give an accurate picture
> of what was really added (new content) and what was simply restored
> (old content revived).

I think you just want:

  git log -1 -- "$file"

to see if any commits had that path previously. Or if you really care
about finding the same content somewhere in history at any path, you can
look for the blobs with something like:

  git rev-list HEAD |
  git diff-tree -r -m --stdin |
  perl -e '
    # Make an index of blob sha1s pointing back to the file
    # they name.
    foreach my $file (@ARGV) {
      my $sha1 = `git hash-object $file`;
      chomp $sha1;
      $files{$sha1}->{file} = $file;
    }

    # Now look at the traversal history, noting the first time
    # we hit each blob, and remember its commit.
    while (<STDIN>) {
      if (/^[0-9a-f]{40}$/) {
        $commit = $&;
      }
      else {
        while (/[0-9a-f]{40}/g) {
          next unless exists $files{$&};
          next if exists $files{$&}->{commit};
          $files{$&}->{commit} = $commit;
        }
      }
    }

    # And then report the result, which is the most recent commit
    # that blob was found in, either being deleted, added, or modified.
    foreach my $v (sort { $a->{file} cmp $b->{file} } values(%files)) {
      if ($v->{commit}) {
        print "$v->{file} $v->{commit}\n";
      }
      else {
        print "$v->{file} was never mentioned\n";
      }
    }
  ' `git diff-index HEAD --name-only --diff-filter=A`

-Peff
