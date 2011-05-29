From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sun, 29 May 2011 09:14:50 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105290850340.28815@debian>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vpqn2psjv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 29 15:19:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQfuJ-0005F0-Ez
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 15:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab1E2NOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 09:14:55 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34565 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab1E2NOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 09:14:55 -0400
Received: by qyg14 with SMTP id 14so1591767qyg.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=1D1N441O/IIydjQdfbfH21ncpMo7xBQpeLQsTVlHU/Y=;
        b=PKT5YG7BVfNWrJjjy5PlYkS4DPjPKaTd/a7wY1jEry9E/ZdmHNL/siCQ6Jt4ROWjaW
         AV2bq0qPUuoosaPOywbgwq4qWKJzg9YmhUSHhBx5EEr3nEScP31nKlCdcDU5ONpkQpjO
         0nRSoshE2JYZfVN2KZxxxGUrpYzuWS+oLnesA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=eXaOVXqWwg7fdyQHoidFUubcrFbJe6sl7eq3+p8i0P2ZOel+DuvqPrqRjJWwx28OKO
         biMj1VbqYxr+mEmB7WbKfYAiBCJGiT5gekEdYRIOeX0VIU3yBtyXwFuui9tgkFzHJPHy
         u4aDIz68NlIdHKi9GyVP3gAyA8g39ADr5jQRI=
Received: by 10.224.210.8 with SMTP id gi8mr2870957qab.292.1306674893184;
        Sun, 29 May 2011 06:14:53 -0700 (PDT)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id m16sm2252267qck.28.2011.05.29.06.14.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 06:14:52 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vpqn2psjv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174689>

On Sat, 28 May 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > ... I think Junio then
> > hinted that he sometimes wished that he could abort rebase without
> > moving to anywhere else at all, which is what this patch implements.
> 
> I am not opposed to this particular patch, but thinking about a bigger
> picture, I am not sure if we want to solve it this way.
> 
> We have multiple "sequence" operations that want to do things in multiple
> steps, each of which can stop and give control back to the user, while
> leaving some information in the .git directory for it to know where it was
> when resuming. I think "am" knows about what "rebase" does (and
> vice-versa) so it can detect an attempt to run it while "rebase" is in
> still progress and refuse to continue to limit the damage, but if we have
> N such "sequence" commands that want to refrain from interfering with each
> other, and want to offer an advice to abort the in-progress operation
> initiated by other commands, that would mean we would need N * N pieces of
> logic to detect other's in-limbo state and offer advices, which would not
> scale.

Makes sense. I think someone once suggested to have a .git/inprogress
directory that would contain some basic information that could be used
to diagnose in a generic way what operation might be in progress.

> A user who is given back the control from a "sequence" operation may be
> confused either (1) immediately after such an event (often some sort of
> merge conflict) or (2) much later after first abandoning the working tree
> altogether and taking a walk and then coming back to continue working
> while forgetting what he was doing. Such a user may want to say "I know I
> am in a strange state, give me a state that I can work from, at this point
> I do not care about continuing what I was originally doing". The user may
> probably not know if "git rebase" was in progress or "git cherry-pick"
> was.

Maybe the recent patch [1] about adding information to git status
about any ongoing operation would help. I'm not sure, but I think I
would personally be a bit hesitant to cancel the current sequence
operation without first checking what it was. OTOH, if I don't even
remember starting a rebase operation, maybe knowing whether it was a
rebase or an am operation might not help much. But if the message from
git status would actually say something like "rebase in progress:
[2/3] War on nbsp: a bit of retreat", then that might help more in
making a decision to cancel or not.


 [1] http://thread.gmane.org/gmane.comp.version-control.git/172919
