From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/13] "git prune" is safe now
Date: Sat, 24 Aug 2013 20:59:54 -0700
Message-ID: <xmqqsixyl8sl.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<1590776724.1091303.1377329872606.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us, peff@peff.net
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 06:00:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRUh-00051h-JH
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 06:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700Ab3HYD76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:59:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416Ab3HYD75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:59:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E543E2C5D9;
	Sun, 25 Aug 2013 03:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JmC4aem8uVzGHZudOJYNawpjCeg=; b=G4uCvT
	fuKflgpQ3+/ehrR0IIM7b/E38zn0UdpVDvBXspV7ks7PBuzheuzwEiEWvT9EnlP6
	8sxLmBdFloxlQNv3fS+T8wTn73rzPMjSXcP6sVD5L4VgCT0AIT7rzGHP1qKLbQjp
	TgkZTDZSAG0VEOwHbuMpeCNt7XTtAkFOiKBP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQJyIKXWOvI+OzmPtoSnEZNAFiY0NvGH
	NqZf/z8uYOfgcOrKnGgW497vsMk+GBWh1ZkB30RHPewFKqBLqNOOynfOT3LnTpWV
	LvzvS/FOxONY/fmk5ewT+Vqv63+1nb9sUl0BR+iGrpK0aS0WUmDhDDO+1V7SYBve
	NE93WXRTV/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8F8C2C5D6;
	Sun, 25 Aug 2013 03:59:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E6642C5D4;
	Sun, 25 Aug 2013 03:59:56 +0000 (UTC)
In-Reply-To: <1590776724.1091303.1377329872606.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:37:52 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CDCD581C-0D3A-11E3-9A01-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232908>

Thomas Ackermann <th.acker@arcor.de> writes:

> According to the man-pages of "git prune" and "git fsck",
> both are safe nowadays.

Safe does not have much to do with the latter.  "git fsck" has
always been safe in that it would not alter the object store, and if
you run it while you are actively creating (or pruning for that
matter) objects, it _will_ get confused.

For that matter, running "prune", even though we designed it to be
safe from concurrent accesses, deliberately on a non-quiescent
repository is not a good idea, either.  It may be a good idea to
weaken the phrasing used to discourage it, but discouraging itself
is not a bad idea.

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 08d8c91..29945d9 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3283,17 +3283,7 @@ state, you can just prune all unreachable objects:
>  $ git prune
>  ------------------------------------------------
>  
> -and they'll be gone. But you should only run `git prune` on a quiescent
> -repository--it's kind of like doing a filesystem fsck recovery: you
> -don't want to do that while the filesystem is mounted.
> -
> -(The same is true of `git fsck` itself, btw, but since
> -`git fsck` never actually *changes* the repository, it just reports
> -on what it found, `git fsck` itself is never 'dangerous' to run.
> -Running it while somebody is actually changing the repository can cause
> -confusing and scary messages, but it won't actually do anything bad. In
> -contrast, running `git prune` while somebody is actively changing the
> -repository is a *BAD* idea).
> +and they'll be gone. 
>  
>  [[recovering-from-repository-corruption]]
>  Recovering from repository corruption
