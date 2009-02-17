From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 12:14:29 -0500
Message-ID: <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
	 <7veixxaale.fsf@gitster.siamese.dyndns.org>
	 <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
	 <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
	 <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
	 <7vy6w5795h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:16:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTYd-00086D-1c
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbZBQROc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbZBQROc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:14:32 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:23395 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbZBQROb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:14:31 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1590766rvb.5
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8ZHBR+DRKU1ppCC1IEEAmGmzF4GejJSBuGKiMGUvUfc=;
        b=IIVqEwQJR8lkZfJAgfUM42rO5jcpqJlCw0KC3r4mXeSY3q9H3/Xs16HppW/vMe69qX
         XRUQ6yxuWgRTXiVzaL+s2F/do9gHNFErTNzcNeQ0WrEFjPtU+ZCXpdcEDqCSGa9qHVsT
         QStZT6exU4I1YAl/2kcZCdSo74nH23Tw/eZ3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DrLqzQdOjvIjEdVc9HNAXLEbjVanMsOFwnzXhNq9RM5jKkawd0SgEjiMba+VOWjwnv
         8IEcGLcV5psINweZEibFuiBXCFc+TXqY0dXtrymHwhy09Rsn1LXnZwhPTxDqLGEHXarl
         3ZNi0Ax07AffpsLt9s/Hq4EQNBgzw4LqvC+MU=
Received: by 10.141.115.6 with SMTP id s6mr3386244rvm.124.1234890870049; Tue, 
	17 Feb 2009 09:14:30 -0800 (PST)
In-Reply-To: <7vy6w5795h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110415>

On Tue, Feb 17, 2009 at 3:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Now to something totally useless.
>
> After reading the builtin-merge.c and original git-merge.sh (now in
> contrib/examples) script, I think it could have done something entirely
> different.
>
> It could have done this instead.
>
>        sed -e '/       not-for-merge   /d'
>
> to learn the commits and their human-readable origins, and it could have
> tried to reproduce what "git pull" did when it invoked git-merge using
> that information.  Then you could use this workflow:
>
>        $ git pull <possibly with arguments>
>        ... oops, conflicted and is very messy.
>        ... I tried to resolve, but failed and made the mess even worse.
>        ... Let's start over.
>        $ git reset --hard
>        ... FETCH_HEAD knows which refs are for merging
>        $ git merge FETCH_HEAD
>
> That is, no matter what the arguments were for the initial "git pull",
> what should be merged is recorded in FETCH_HEAD, and that is how you can
> retry the merge without refetching over the network.
>
> But such a change makes FETCH_HEAD different from what it traditionally
> meant, and does that only to "git merge", making the result very
> inconsistent.  For example, "git log ..FETCH_HEAD" will still use the
> object name on the first line, and it won't be a way to convince yourself
> that the changes are sensible and it is Ok to run "git merge FETCH_HEAD"
> anymore.  So I do not think such a change will be an improvement.

Unless dwim_ref() is updated to handle FETCH_HEAD specially, and
return not the first SHA1, but the one not marked "not-for-merge".
Then the UI would at least be consistent, but this would not be
backward compatible.

j.
