From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Tue, 25 Aug 2009 14:45:25 -0400
Message-ID: <20090825184525.GC23731@coredump.intra.peff.net>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Tom Werner <mojombo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg11Q-0005IO-F7
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 20:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbZHYSp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755714AbZHYSp0
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 14:45:26 -0400
Received: from peff.net ([208.65.91.99]:50534 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755602AbZHYSpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 14:45:25 -0400
Received: (qmail 18262 invoked by uid 107); 25 Aug 2009 18:45:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 14:45:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 14:45:25 -0400
Content-Disposition: inline
In-Reply-To: <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127039>

On Tue, Aug 25, 2009 at 10:43:57AM -0700, Tom Werner wrote:

> On Tue, Aug 18, 2009 at 12:04 AM, Tom Preston-Werner<tom@mojombo.com> wrote:
> > A post-upload-pack hook is desirable for Git hosts that need to
> > collect statistics on how many clones and/or fetches are made
> > on each repository.
> >
> > The hook is called with either "clone" or "fetch" as the only
> > argument, depending on whether a full pack file was sent to the
> > client or not.
> 
> I was hoping to get some feedback on this patch, either positive or
> negative. Since we'll be applying this patch for our use of the Git
> Daemon on GitHub, it would be great to see it in core, so we don't
> have to maintain custom debian builds forever. I'd imagine that other
> Git hosting sites would find this hook useful as well. Thanks!

I expect it didn't get any response because nobody here cared one way or
the other. Not too surprising, since I think not many people are running
a GitHub-sized hosting site that cares about such statistics. ;) So I
think following up as you are doing is the right thing.

As for the hook itself, the concept certainly seems sane to me. It
passes the "hook" test defined here:

  http://thread.gmane.org/gmane.comp.version-control.git/70781/focus=71069

because it is a remote trigger.

But a few comments on the patch:

> ---
>  upload-pack.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

It needs at least a mention in Documentation/githooks.txt.

> +static void run_post_upload_pack_hook(int create_full_pack)
> +{
> +	const char *fetch_type;
> +	fetch_type = (create_full_pack) ? "clone" : "fetch";
> +	run_hook(get_index_file(), "post-upload-pack", fetch_type);
> +}

Does it really need an index file? This operation in question seems to
be totally disconnected from the index (and indeed, most bare
repositories won't even have one). Probably it should pass NULL as the
initial argument to run_hook.

Is there any other information that might be useful to other non-GitHub
users of the hook? The only thing I can think of is the list of refs
that were fetched. I don't want to over-engineer it, but nor do I want
to be left with the mess of retro-fitting more information onto an
existing hook later. Maybe others can comment on whether they would find
more information useful.

-Peff
