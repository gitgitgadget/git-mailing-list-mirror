From: Mike Hommey <mh@glandium.org>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Wed, 26 Nov 2014 21:30:57 +0900
Message-ID: <20141126123057.GA14275@glandium.org>
References: <20141126004242.GA13915@glandium.org>
 <20141126010051.GA29830@peff.net>
 <20141126012448.GA11183@peff.net>
 <20141126022553.GA16199@glandium.org>
 <20141126044642.GA15252@peff.net>
 <CALKQrgftttSpuw8kc+jC6E5RBet39wHKy3670Z5iG=KQSmrCAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 13:31:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtbkm-0006fy-2g
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 13:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbaKZMbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 07:31:23 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:53603 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbaKZMbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 07:31:21 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XtbkH-0003rV-9i; Wed, 26 Nov 2014 21:30:57 +0900
Content-Disposition: inline
In-Reply-To: <CALKQrgftttSpuw8kc+jC6E5RBet39wHKy3670Z5iG=KQSmrCAw@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260280>

On Wed, Nov 26, 2014 at 12:46:20PM +0100, Johan Herland wrote:
> (First of all, thanks to both for great investigation and analysis)
> 
> On Wed, Nov 26, 2014 at 5:46 AM, Jeff King <peff@peff.net> wrote:
> > On Wed, Nov 26, 2014 at 11:25:53AM +0900, Mike Hommey wrote:
> >
> >> Now, looking at the notes tree reflog, I see that at some point, some
> >> notes were added at the top-level of the tree, without being nested,
> >> which is strange.
> >
> > That's somewhat expected. The fanout is dynamic based on the number of
> > notes, so early on I think some notes may be found at the top of the tree.
> >
> >> And it looks like it's related to how I've been adding them, through
> >> git-fast-import. I was using notemodify commands, and was using the
> >> filemodify command to load the previous notes tree instead of using the
> >> from command because I don't care about keeping the notes history.
> 
> I'd very much like to see this fast-import stream (or a script
> generating it). I'm assuming that it roughly follows along these lines:
> 
>  - Start a new commit from a clean slate (no 'from')
> 
>  - Do a single filemodify to "load" the previous notes tree.
>    Exactly what does this filemodify command look like? I'm
>    guessing you're using the root tree object from the previous
>    notes tree as <dataref>, and an empty <path>, i.e.:
> 
>      M 040000 $previous_notes_tree_root_sha1 \n
> 
>  - Do a series of notemodify commands for the notes being added in
>    this commit.
> 
>  - End of commit.

That's exactly the scenario.

<snip>
> >   commit=$(echo "final notes tree" | git commit-tree refs/notes/foo^{tree})
> >   git update-ref refs/notes/foo $commit
> 
> I agree that this is probably the best workaround for now.

Indeed, that's about what I had in mind when I said I could easily work
around (except I use the ls command in fast-import), and what I
implemented.

Mike
