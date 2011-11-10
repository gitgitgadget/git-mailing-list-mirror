From: Eric Raible <raible@nextest.com>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Thu, 10 Nov 2011 00:04:38 -0800
Message-ID: <4EBB8596.6040507@nextest.com>
References: <4EB9C7D1.30201@nextest.com> <20111109220128.GA31535@sigill.intra.peff.net> <20111109222032.GB31535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:04:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPcs-000154-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab1KJIEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 03:04:42 -0500
Received: from mail.nextest.com ([12.96.234.114]:47972 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755136Ab1KJIEl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 03:04:41 -0500
Received: from [131.101.151.102] (131.101.151.102) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Thu, 10 Nov 2011 00:04:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111109222032.GB31535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185214>

On 11/9/2011 2:20 PM, Jeff King wrote:
> On Wed, Nov 09, 2011 at 05:01:28PM -0500, Jeff King wrote:
> 
> This patch (which is below) turns out to be absurdly simple. And it
> actually still prints the original commit timestamp, because we end up
> reparsing it out of the commit object during the pretty-print phase.

Sweet!

> So I think the only decision is whether "--since" should respect the
> commit timestamps (and be used as a sort of "grep" filter for
> timestamps), or whether it should be respecting the fake history we
> create when doing a reflog walk.

When -g is specified it seems less surprising for --since to respect
the reflog's fake history.  That's what *I* expected, anyway.

> I think I am leaning towards the latter. It seems to me to be the more
> likely guess for what the user would want. And there is real benefit to
> doing it in git, since we can stop the traversal early. In the
> "grep-like" case, doing it inside git is not really any more efficient
> than filtering in a pipeline, like:
> 
>   git log -g --format='%ct %H' |
>   awk '{ print $2 if $1 < SOME_TIMESTAMP }'

And then the sha would have to be fed back into git to be useful, eh?

> Of course we could still offer both (with a "--reflog-since" type of
> option). We'd also need to turn off the optimization for "--since", and
> then check whether "--until" has a similar bug (and offer
> "--reflog-until").

I don't see the point of --reflog-since.  If the user specifies 'reflog'
(either directly or with -g), then can't we just use the reflog's timestamp?
Note: there might be good reasons, as my use of the reflog (and --since, for
that matter), has been very simplistic so far.

> diff --git a/reflog-walk.c b/reflog-walk.c
> index 5d81d39..2e5b270 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -231,6 +231,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
>  	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
>  	info->last_commit_reflog = commit_reflog;
>  	commit_reflog->recno--;
> +	commit->date = reflog->timestamp;
>  	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
>  	if (!commit_info->commit) {
>  		commit->parents = NULL;

Is this something you'd be willing to turn into a real patch?
I'm certainly not qualified.

Thanks - Eric
