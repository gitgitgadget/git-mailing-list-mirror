From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 12:39:52 -0700
Message-ID: <xmqq4mkupss7.fsf@gitster.dls.corp.google.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
	<20150723180846.GB18686@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:40:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIMLZ-0003XV-7R
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 21:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbbGWTj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 15:39:57 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35788 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbbGWTj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 15:39:56 -0400
Received: by pabkd10 with SMTP id kd10so1038285pab.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zkSUujQOu32HMpn/s9rmsfdlZxxY4Rm3HSWLePBbMKk=;
        b=IFRm84yYcRvmH2M87gNDVlsIc3QV1p/REQQlKgYKNGA9dkkkyMfJP4iraPk6nJ1GJN
         GqqVuP/oqfVXIO7EmBJk3pcfkWcmK49J8ZM8dy7Eq4gTsuioAfKqo+y3wgN45jhO2Ezs
         1KxW64rG2IIQnIg9jdYtW4tyMI63W8aDjwP6vhac49xcwmvEKUztNOHWTTHwuwbLmiTR
         qh76+MMnzuFaZAFRlQyxNO4WKKkUnuXyJdVSwJn6T8LfkubbdMMyWo3aKvwNwOqQxp68
         fUFob3VeH8jENM1eAo7GGO62ELU73OlHJdF1tYDYfq2bh3PzemZlHV/Gc7/Q1DCdWN9W
         oxkQ==
X-Received: by 10.70.37.169 with SMTP id z9mr21721222pdj.123.1437680395624;
        Thu, 23 Jul 2015 12:39:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id ph4sm10415293pdb.43.2015.07.23.12.39.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 12:39:54 -0700 (PDT)
In-Reply-To: <20150723180846.GB18686@peff.net> (Jeff King's message of "Thu,
	23 Jul 2015 11:08:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274521>

Jeff King <peff@peff.net> writes:

> I have not been following the thread closely, but I do not recall seeing
> anyone mention that the reason for the sha1-output is handing
> only a single commit-ish to diff-tree is what puts it into its log-like
> mode. Actually asking for a two-endpoint tree diff:
>
>   git diff-tree --quiet --ignore-space-change $commit^ $commit
>
> will do what you want.

Yeah, if we were living in an ideal world equipped with a time
machine, I would redesign "git diff-tree $commit" so that it does
not show the commit object name in its output at all, with or
without "--quiet".

In "git rev-list ... | git diff-tree --stdin" output, the commit
object name is absolutely necessary, with or without --quiet, as it
serves as the sign that the output switched to talk about a
different commit.

But the case that feeds a single commit to the command, used as a
poor-man's "git show $commit", does not need one---the caller knows
exactly which commit the output is about.

It is an unfortunate historical accident that a single commit usage
is defined to be a degenerate case of feeding a sequence of commits
to the command and the length of the sequence happens to be one.
"diff-tree $commit" could instead have been defined as a short-hand
for "diff-tree $commit^ $commit", but (1) we do not live in an ideal
world, and (2) it ignores $commit^2 and later parents.

This is a tangent, but I suspect that the current implementation of
"diff-tree --stdin --quiet" may be buggy and does not consistently
show the commits that touch the given path.

 $ git rev-list master..jc/rerere | git diff-tree --stdin -s rerere.h

gives what is expected (shows the commit object names, but being
silent on the differences), while s/-s/--quiet/ seems to omit every
other commit from the output, or something silly like that.

I haven't dug into why that happens, but possible ways to fix that
are to make "--quiet" output all (making it consistent with "-s") or
no (making the command totally silent) output at all ;-).
