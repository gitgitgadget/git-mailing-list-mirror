From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Wed, 1 May 2013 21:22:28 -0500
Message-ID: <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
	<7va9oe5y6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 04:22:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXjAJ-0008Bx-BM
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 04:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758771Ab3EBCWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 22:22:31 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59411 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758255Ab3EBCWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 22:22:30 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so102532wgh.29
        for <git@vger.kernel.org>; Wed, 01 May 2013 19:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ylLGuea1/j2S2aNhk0cEJvpVtP2uZsfM03yEPrijE38=;
        b=p83thGF6uPKLabfEwtNErz4SPSzt008CZ7JUIOLAfTJkedPJqMVABxf2BmzuAoJ2nU
         fo+ml4w3iTVm0FxfZ/90cXKb/srFoxw27C8KsTnRV1nXXXNDiOHOJlHqtlyiVpmB56q6
         ttNFEKzbbxHf+029y6KSmqi7mL8Ag9JtM18xsZ2mIzYrfC3TENbktF2JJxYa8TrATaHw
         2xi24zMA5QmV9dWuQFVkZPpDFIprTOzJZQOn6825XJcaTCXdk812azkAZP8e/FC+CCbj
         zi3wkm+Cr+7uYU9ork6P98Fa8sMoERBmkyb7J6nN5QENoGykGHlcSdUnWwcWMbRJGECh
         NmSQ==
X-Received: by 10.195.12.228 with SMTP id et4mr496990wjd.59.1367461348969;
 Wed, 01 May 2013 19:22:28 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Wed, 1 May 2013 19:22:28 -0700 (PDT)
In-Reply-To: <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223173>

On Wed, May 1, 2013 at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:

> As you and Felipe seem to be aiming for the same "Let's allow users
> to say '@' when they mean HEAD", I'll let you two figure the best
> approach out.
>
> One productive way forward might be to come up with a common test
> script pieces to document what constructs that spell @ in place of
> HEAD should be supported, and much more importantly, what constructs
> that happen to have @ in them should not mistakenly trigger the new
> machinery.

The difference is basically that my approach is less intrusive; it
only touches code that is relevant for revision parsing. This means
the scope and side-effects are known; the same as @{-N}.

Ramkumar's approach has no precedent, so it's not clear what
side-effects could there be. His approach relies on modifying
branch_get() a function that barely has been touched since 2007, and
has other side-effects, plus there isn't even a proper patch with the
isolated change, and an explanation why it makes sense.

While it might or might not make sense to teach branch_get() to accept
symbolic refs, it's not needed to achieve the desired functionality,
either on my approach, or his.

Moreover, the symbolic-ref 'HEAD' is quite special, it's mentioned
everywhere in the documentation, and the code has special cases for
it. It's not reasonable to expect all relevant places to be updated
for this functionality, and certainly 'Documentation/revisions.txt' is
not the only one.

For example, in Ramkumar's approach:

 % git branch -u master @

Would replace '@' with HEAD, however:

 % git branch --edit-description @

Would not. These inconsistencies are not due to Ramkumar's code, but
why would the user expect '@' to be replaced with anything if 'git
branch' documentation doesn't mention any revision parsing, which is
the only place where the '@' shortcut is documented.

In my opinion, if 'git branch X @{-1}' doesn't work, neither should
'git branch X @', and that's what my approach does.

My approach is isolated to revision parsing, which means we minimize
the potential for surprises and unintended consequences.

Cheers.

-- 
Felipe Contreras
