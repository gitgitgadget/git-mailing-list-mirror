From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-describe: Die early if there are no possible
	descriptions
Date: Wed, 5 Aug 2009 08:34:12 -0700
Message-ID: <20090805153411.GG1033@spearce.org>
References: <20090805141740.GA16846@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 17:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYiVS-00073x-CF
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbZHEPeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 11:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755778AbZHEPeM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:34:12 -0400
Received: from george.spearce.org ([209.20.77.23]:51125 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbZHEPeL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:34:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 18494381FD; Wed,  5 Aug 2009 15:34:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090805141740.GA16846@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124914>

Bj?rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> If we found no refs that may be used for git-describe with the current
> options, then die early instead of pointlessly walking the whole history.
> 
> Signed-off-by: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
> ---
> In git.git with all the tags dropped, this makes "git describe" go down
> from 0.244 to 0.003 seconds for me. This is especially noticeable with
> "git submodule" which calls describe with increasing levels of allowed
> refs to be matched. Without tags, this means that it walks the whole
> history in the submodule twice (first annotated, then plain tags), just
> to find out that it can't describe the thing anyway.
> 
> I'm not particularly sure about found_names actually counting the found
> names, it was just out of the thought that maybe the walking code could
> make use of it, but I didn't actually check that and ran out of time, so
> I'm sending this version, hoping that it doesn't suck too much.

This seems reasonable to me.  Really you don't need found_names
to be a counter, but could just always set it to 1 every time the
add_to_known_names function is called.  All you care about is that
add_to_known_names was invoked at least once.

Also, I really think that first paragraph after the --- should
have been part of the commit message.  The message above doesn't
justify the change, even if it is fairly trivial, without that
additional explanation.

> @@ -39,6 +40,8 @@ static void add_to_known_names(const char *path,
>  			       const unsigned char *sha1)
>  {
>  	struct commit_name *e = commit->util;
> +	if (!e)
> +		found_names++;
>  	if (!e || e->prio < prio) {
>  		size_t len = strlen(path)+1;
>  		free(e);

-- 
Shawn.
