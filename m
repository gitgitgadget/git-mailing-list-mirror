From: Johan Herland <johan@herland.net>
Subject: Re: [RFD/PATCH 3/5] checkout: Use remote refspecs when DWIMming
 tracking branches
Date: Sat, 20 Apr 2013 10:05:55 +0200
Message-ID: <CALKQrgcWdUxauU2rAGSVggE-QjBW2PMXCdr6xg4habqyA6rj=g@mail.gmail.com>
References: <1366352442-501-1-git-send-email-johan@herland.net>
	<1366352442-501-4-git-send-email-johan@herland.net>
	<7vzjwuz4ov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 10:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTSol-0005KR-Kp
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 10:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab3DTIGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 04:06:08 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:53820 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387Ab3DTIGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 04:06:03 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UTSo3-0001OB-Nm
	for git@vger.kernel.org; Sat, 20 Apr 2013 10:05:59 +0200
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UTSo3-0005cl-HO
	for git@vger.kernel.org; Sat, 20 Apr 2013 10:05:59 +0200
Received: by mail-ob0-f173.google.com with SMTP id wn14so4181047obc.18
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 01:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8AVFHolnyYaRPAmqLRn0quFFFdK/lDVUOpOFbDdzOI4=;
        b=Ou+GmliVps2VNzz/pbTnCuO7yfXdpgqxMQEjo4b8xnSsVSgMek7bpMQetkfU/N2QYx
         9ttzZTzdRLXERXi/1jNN7l6hdi/7EezsU7MhUYtyrb5LkBOyflIL78az8gqa0t2NdOr5
         JrQn7bqKTjZqQiic/LwFiCnsESWnlzOK5T+kmMJoTcVqIGSmZnVXkvBZoTDfagxSnOfV
         M+dDzNPMHdBfB5ZBCeOGQIfAf+12Mj0uYc/ndU8ySLZ/H9P6G32bS9IqwPX5akGIqMr6
         7a+je6hewQVgjKT38mB8j3hLzEClnZov3INOLd2oKUA/u09E76TW117A6edobBU3YeOq
         4tLg==
X-Received: by 10.60.169.237 with SMTP id ah13mr2594745oec.41.1366445155989;
 Sat, 20 Apr 2013 01:05:55 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Sat, 20 Apr 2013 01:05:55 -0700 (PDT)
In-Reply-To: <7vzjwuz4ov.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221838>

On Fri, Apr 19, 2013 at 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am _guessing_ that you mean a case like this:
>
>         [remote "origin"]
>                 fetch = refs/heads/*:refs/remotes/origin/*
>         [remote "xyzzy"]
>                 fetch = refs/heads/*:refs/remotes/xyzzy/nitfol/*
>         [remote "frotz"]
>                 fetch = refs/heads/*:refs/remotes/frotz/nitfol/*
>
> and refs/remotes/origin/foo or refs/remotes/frotz/nitfol/foo do not
> exist but refs/remotes/xyzzy/nitfol/foo does.  And the user says
> "git checkout foo".  Instead of finding a remote ref that matches
> "refs/remotes/*/foo" pattern (and assuming the part that matched *
> is the name of the remote), you can iterate the RHS of the refspecs
> to see if there is a unique match.
>
> Then the new branch can unambiguously find that its upstream is
> xyzzy's foo.

Correct. I will try to phrase the problem better in the next iteration.

> I think it makes sense to update the semantics like that.
>
> Wouldn't the traditional case (i.e. without "nitfol/" in the
> xyzzy/frotz remotes above) be a mere special case for this new
> logic?

Yes.

> You mentioned there is a regression caught by existing tests
> if you go this route, but I do not see how that happens.

It's technically a regression since it breaks existing tests, but as you
observe in your reply to patch #5, it is really the test that relies on
current implementation details.


...Johan


--
Johan Herland, <johan@herland.net>
www.herland.net
