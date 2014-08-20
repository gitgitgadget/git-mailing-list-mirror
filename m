From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Tue, 19 Aug 2014 19:39:35 -0700
Message-ID: <CAPc5daXKwW-T6PeYtFYdHYuBzvsDXWyYdNOYXXG867KGgHMKwA@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 04:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJvof-0006HQ-Ub
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 04:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbaHTCj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 22:39:58 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:53628 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaHTCj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 22:39:57 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so6575196lab.6
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 19:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=1nRtjJdilvmh0SE9dI1fSqTe7CzVMtKJLTn9yR/GUL4=;
        b=hO+rP5vn7rU0+G3WxSyewKGhPtxeYQtyyD0I1YDET7PZ5qjIKpUvxE4etZDIXwHQMl
         oaQC8udJzeRqufzNy927H1ezv4VKa9k40KyKuhsXBV12sPXvXv0to6QAtHzWtTWAPG/c
         V7/Rip+IoK2W4G/ks0nI3H4+dSelOT6R5Ab8QH1fGL78LXrtaSnCXf/rZAH6/CapSObY
         egAqwjgUUCcYg9poxXI3p6Xom9/H7qHdhwW4dGU4kc9JmpNaVk9YmSGSREYc42IdHXP1
         YAajZWqxGj2OXSEjA0RcLMsA8LEo3f45gg9vz0tdb33pXPGO9oWMgQhESsLwh7TdDPxZ
         i4Rw==
X-Received: by 10.112.1.136 with SMTP id 8mr38658135lbm.55.1408502396005; Tue,
 19 Aug 2014 19:39:56 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Tue, 19 Aug 2014 19:39:35 -0700 (PDT)
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: 6Svo9YECoHmt2p5nMsZomfJsLz0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255547>

On Tue, Aug 19, 2014 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If the server's GPG keychain and pre-receive hook are properly set
> up, a "git push --signed" over an unauthenticated and unencrypted
> communication channel (aka "git daemon") can be made as secure as,
> and even more secure than, the authenticated "git push ssh://".
>
> With the signed push certificate, together with the connectivity
> check done when the server accepts the packed data, we are assured
> that the trusted user vouches for the history leading to the
> proposed tips of refs (aka "new-sha1"s), and a man-in-the-middle
> would not be able to make the server accept an update altered in
> transit.

The above was written long after the series was done, but rethinking
about it within that frame of mind helped me find one nit in the push
certificate design.

We would need a PKT-LINE("pushed-to" SP URL LF) in the header
part to prevent the certificate and the same set of refs from getting
replayed. Otherwise, a different repository that happens to have the
same set of refs with same set of old-sha1 values can be made to
accept a push that the signer never intended to make to it by replaying
an earlier push to a different site the signer did make.
