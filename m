From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Tue, 15 Feb 2011 20:37:47 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102151940140.7843@debian>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com> <AANLkTi=1WkZXBtQu71mELTBc6F7XrfBi+NWNWy-AxS79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 02:38:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpWLG-0006bu-Ae
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 02:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159Ab1BPBh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 20:37:57 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45404 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014Ab1BPBhw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 20:37:52 -0500
Received: by qwa26 with SMTP id 26so707499qwa.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 17:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=fChTm2VrcwQy844JkjCyWFHkTG+2PEBJaXq7Ox+MRJM=;
        b=K+soPo21L8vjXLUogqcnQcNIeTf/ELO+7/QUAavO5XZfar021U0CEDOvLx2h09v8oS
         fgNlTIkpa8yatI4twp7ljK/fpQIqtSuY0prLzPN621Wm2MLgDx4AdTwmrLYdfl1ooNoF
         4hze6+Ssv1RhMhWf77CUfN0dQ3OCXidIBFUFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=oDO6dkEa2DFmmz9YD3IY2bMimG6Uvv2HosKr10u4ttX+mO9sGo4AT41pPc/bTpLZSv
         RA2OhZMIAbiAlUYZGPpmGAKqwk5PjMgpk7ANDdCLhhpwtB/wnva/Qx9QLVsds+OjijnI
         Av58wsYxIyLjgHgPZhisfb3AXxrZOtFLjjnmQ=
Received: by 10.224.37.147 with SMTP id x19mr105623qad.246.1297820271380;
        Tue, 15 Feb 2011 17:37:51 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u6sm3221026vby.17.2011.02.15.17.37.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 17:37:49 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTi=1WkZXBtQu71mELTBc6F7XrfBi+NWNWy-AxS79@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166911>

On Tue, 15 Feb 2011, Santi B?jar wrote:

> On Mon, Feb 14, 2011 at 1:51 PM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
> > It might seem like most of the related code in git-pull.sh can be
> > removed once git-rebase.sh supports reflog walking. Unfortunately, not
> > much of it can be removed, though. The reason is that git-pull.sh
> > simulates one step of "reflog walking" by keeping track of the
> > position of the remote-tracking branch before and after the fetch
> > operation. This does not rely on reflogs. There are at least two cases
> > where the reflog is not used: a) when it is disabled, b) when the
> > remote branch was specified on the command line (as in 'git pull
> > --rebase origin master').  In both of these cases, git-pull.sh
> > remembers the position of the reference before the fetch and uses that
> > as a kind of '$upstream@{1}'.
> 
> I don't agree with point b). In line 190:
> 
> 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> 
> It returns the local tracking branch for repo=origin and branch=master
> and uses its reflog.

Yes, but the local tracking branch is not updated when the
two-argument version of 'git pull' is used [1].
 
> The end result is the same, there is one case where you need the old
> value of the tracking branch, so it should be done in git-pull.

True, case a) is still there. I was just trying to explain why I
didn't just move the code from git-pull.sh to git-rebase.sh, but maybe
it confused more than it clarified...

> But I wonder if it is possible to write a function shared by
> git-pull.sh and git-rebase.sh that computes the branch forking points,
> the number of arguments could detect if it has the old-remote-hash or
> not.

Makes sense. I will have a look at it.

> I think the delay could be much shorter if the computation was not in
> shell, but in C. Or maybe change the algorithm. So I don't think a
> configuration item is the answer here.

It would definitely be nice if we can make it fast enough so we don't
have to make it configurable.


[1] http://thread.gmane.org/gmane.comp.version-control.git/165758
