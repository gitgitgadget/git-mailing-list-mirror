From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Fri, 17 May 2013 18:13:13 +0530
Message-ID: <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 14:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdK0s-0004JD-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 14:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab3EQMny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 08:43:54 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51085 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab3EQMny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 08:43:54 -0400
Received: by mail-ia0-f174.google.com with SMTP id r13so2920089iar.19
        for <git@vger.kernel.org>; Fri, 17 May 2013 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=a27VH/36m2ER6PGYMSi/tzjNW75IGMmSxq/HiUlVqdg=;
        b=VTHnnYRCxM8pFhx93JyHjnvNCbGOJtAtvscIqcaLNQzPnuizBa43tFZxPEZ/XA5N4G
         3xhcZDg3uYb27rEE4B4HpKH0MLr6XtBAuUsfm+u8IDlJNO+FK0fwKalmM9tOLxVHChcg
         V5iokEM0klfEoeSYBc1urEcdGTSz6PjXeEjIGdUZ5Ttq9qfH9ibgC5aj8fVXdaCMKZnb
         DogLNbCDNI6WlF8UGtoHH15WYybj0+94y91/vP8p51tuM2WlkGukUu3ZIrUwAECvLdCV
         2yTcDJ9zilvKh0ndQF4apxidrAvt5gqUHua1sAYl2xxfePKCyRH5dkaNzQHUznOSXrhO
         iROg==
X-Received: by 10.50.147.71 with SMTP id ti7mr13000007igb.49.1368794633544;
 Fri, 17 May 2013 05:43:53 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 17 May 2013 05:43:13 -0700 (PDT)
In-Reply-To: <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224687>

Junio C Hamano wrote:
> Actually, I suspect that you shouldn't even need to do that
> pros-and-cons analysis, because the 'single' thing should cover as a
> natural extension of the existing infrastructure.  You should only
> need to have something like this:

Which is the exact argument I presented on the other thread.  However,
Felipe has a point: we shouldn't cripple @{f} (I think "fork" is a
good name for it) in the name of generality.  Think of what
remote.<name>.push and branch.<name>.push are actually going to be
used for:

remote.<name>.push are most probably going to be used with wildcards
(like in the Gerrit case): I don't mind if @{f} is not able to tell me
where my branch will go (and it's probably even a pseudo-ref, in which
case the answer is really meaningless).  The limitation doesn't affect
remote.<name>.fetch, because @{u} only operates between remote
branches and local branches, not at the ref-mapping level.

branch.<name>.push cannot be used with wildcards, and @{f} is pretty
straightforward to determine in this case.  When the information is
easily available for end-user consumption, why would we _not_ want to
expose it by stuffing branch.<name>.push into remote.<name>.push
configuration?

So, I think the way forward is:

1. Introduce @{f[ork]} to show $(branch.<name>.pushremote or
remote.pushdefault)/$(HEAD).  We can update 'git status' to show this
information as well: the ahead/ behind with @{f} is no less important.

2. (optional) Make remote.<name>.fetch non-mandatory.  Currently, a
lot of git-core breaks unless this is present, and this is an annoying
wart.

3. Introduce remote.<name>.push.  Make it clear that it is intended
for the Gerrit-user.  @{f} cannot be determined with this [*1*].

4. Introduce branch.<name>.push for a branch-specific override to
remote.<name>.push.  @{f} can be determined when this is in effect.

[Footnotes]

*1* Do we want to do some magic wildcard-expansion to get/set @{f}
anyway?  In which case, branch.<name>.push is really not necessary.
Which approach is less ugly?
