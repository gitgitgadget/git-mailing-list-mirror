From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program" over SSH connection
Date: Tue, 24 Jun 2008 23:45:38 -0400
Message-ID: <20080625034538.GW11793@spearce.org>
References: <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org> <20080624233236.GI29404@genesis.frugalware.org> <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLy1-0007DS-Cb
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYFYDpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbYFYDpt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:45:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:32885 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbYFYDps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:45:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBLwl-0002wt-On; Tue, 24 Jun 2008 23:45:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AF11A20FBAE; Tue, 24 Jun 2008 23:45:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86211>

Junio C Hamano <gitster@pobox.com> wrote:
> The daemon expects to see the dashed form and we cannot change older
> servers.  But when invoking programs on the remote end over SSH, the
> command line the client side build is under client's control.
...
> diff --git a/connect.c b/connect.c
> index e92af29..fd1da26 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -589,6 +589,10 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
>  	conn = xcalloc(1, sizeof(*conn));
>  
>  	strbuf_init(&cmd, MAX_CMD_LEN);
> +	if (protocol != PROTO_GIT && !strncmp(prog, "git-", 4)) {
> +		strbuf_addstr(&cmd, "git ");
> +		prog += 4;
> +	}

Nack on that implementation.

I think this is a problem for systems based on say gitosis,
or some pattern like it.  Day-job doesn't use gitosis, but
has switched to a Perl based forced ssh tool that smells a
lot like gitosis.  Gitosis is popular.

github probably uses something similar.  But nobody knows (or
probably cares) since they don't release their source.

gitosis is likely looking for "$git-upload-pack '(.*)'$" to be
in the $SSH_ORIGINAL_COMMAND environment variable, if you send
"git upload-pack 'path.git'" I think its going to reject.

What's really bad about your patch is you cannot work around it as a
user by setting --upload-pack on the command line, or in the config,
because down at the very deepest level you are switching the "git-"
to "git " and ignoring what the user has supplied you.

Sorry, but I think this change needs to go higher up, to the default
values that --upload-pack and remote.$name.uploadpack override,
so the user can at least work around it when we break her ability
to use github, gitosis, or anything like it.

-- 
Shawn.
