From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated submodules
Date: Wed, 14 Sep 2011 20:27:48 +0200
Message-ID: <4E70F224.2080401@web.de>
References: <20110912195652.GA27850@sigill.intra.peff.net> <7vr53l5u7h.fsf@alter.siamese.dyndns.org> <20110912224934.GA28994@sigill.intra.peff.net> <4E6FAB46.30508@web.de> <20110913221745.GB24549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:28:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uBl-0005Tm-Ss
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab1INS15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:27:57 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:43931 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261Ab1INS14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:27:56 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7237D19732957;
	Wed, 14 Sep 2011 20:27:48 +0200 (CEST)
Received: from [79.247.251.231] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R3uBY-0005Ij-00; Wed, 14 Sep 2011 20:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <20110913221745.GB24549@sigill.intra.peff.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18kKhWEfSG3CJrQIQC0wKJl7nWDca/+mtf6DypV
	r+AvHEmi7zWUqDs/FapvfYJlBOxEmZ51ZoCuRPpnVZfPylHVt+
	/U1sQ5MxoRgWzbheJOkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181373>

Am 14.09.2011 00:17, schrieb Jeff King:
> One thing that could make it slightly less expensive (but I wouldn't
> worry about implementing until it becomes an issue): you do a full diff
> and collect any changed GITLINK entries, and then compare the paths we
> get with the submodule config. Couldn't you instead do something like
> this:
> 
>   - let S = set of submodule paths that we care about, from the config
>   - start the "git rev-list $new --not $old" traversal, as we do now
>   - for each commit
>     - diff using a pathspec of S
>     - for each changed entry
>       - add it to the set of changed submodules
>       - remove it from S
>     - if S is empty, break
> 
> That has two advantages:
> 
>   1. We limit the diff by pathspec, which means we can avoid looking at
>      irrelevant parts of the tree (we don't do this yet, but hopefully
>      we will in the future).
> 
>   2. You can break out of the traversal early if you already know you
>      have changes in each submodule of interest.

I think this would work for the functionality which is implemented right
now. But with Frederik's gitfile work I hope to enable git to support
submodules being moved around in the work tree rather soonish. Then we
would be blind for any changes in the new location. Until it hurts us
I'd prefer to stay with the correct version, even if it is a bit slower.

> Out of curiosity, what happens if we don't have such a commit? I know
> you said that your policy is never to rewind a submodule's commit that
> has been published in a superproject, and I think that's the only sane
> thing to do. But it's not enforced by git itself, and I wonder how badly
> we break if it does happen (i.e., I'm hoping the answer is "you can't
> diff or checkout superproject revisions that reference the missing bit"
> and not "git log crashes when it gets to that point in history").

No worries, nothing bad happens in that case.
