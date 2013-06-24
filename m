From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] push: give early feedback
Date: Tue, 25 Jun 2013 00:12:16 +0530
Message-ID: <CALkWK0=d1wkKWngH+6gBd-2svj7r_tgC5=+zUbgJRDfUCzupSw@mail.gmail.com>
References: <1372095662-24527-1-git-send-email-artagnon@gmail.com> <20130624182809.GA15296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:43:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBjB-000734-9P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab3FXSm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:42:57 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53230 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab3FXSm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:42:56 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so26107493iea.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QSskmsS213gh86lDecllExHSt/fFJnUVJZNb9TWQYMw=;
        b=MF4SdnCpQZea6sRrs+OiAOFs94t/zPgMtTnP+zDncpJQTNq6vfCmfPYDVWKwhjxp5N
         Wb4RqyCfU0eEQw5Dkv+2hjLrrJ4uCi4ErXcKnDK3iHWSPR7Om87YZjPUmVqVQXXsgl5G
         tEes20+ZY5tA7XYPYRStLR29h41cf1tJaeaFdCKD1VgVdLO83yEB5rVLBJ4qCVOIp7w5
         H00e6J7Tyn04L40fZN9EEsAIwFDXvqhxd2WaYqDqgrVlq+9Owd/Ft00S93ttwFAQmzFR
         OUctHN2qkxZHnCEiCkChre8qavhP6t1jA/rXavxT4IM4L4nzOf0NBZsrqXrqA41W5jKa
         ZfJw==
X-Received: by 10.50.66.130 with SMTP id f2mr6334515igt.55.1372099376317; Mon,
 24 Jun 2013 11:42:56 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 11:42:16 -0700 (PDT)
In-Reply-To: <20130624182809.GA15296@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228895>

Jeff King wrote:
> If your intent is to let people stop disastrous pushes before they
> complete, I think there are two failings:
>
>   1. It does not tell very much about how the refspecs are expanded or
>      what is going to happen. "git push --dry-run" gives a much more
>      complete view of what will be pushed.

Yes.

  $ git push
  # pushing refspecs ':' to ram

Completely useless.

On the other hand, if I implement it at the transport layer like
TRANSPORT_PUSH_DRY_RUN, it takes *way* too long to say anything
useful; the whole "early" part has been thrown out the window.  The
issue is again related to the same nightmare I'm having: not being
able to implement @{push} refspec because the transport API is so
tangled up; I can't call into the refspec-pattern-expander from
anywhere else.

>   2. You are creating a race with the user to hit ^C. It will probably
>      work if there are a lot of objects to be pushed. But not if the
>      push is small, or even has no pack at all (e.g., only deletions, or
>      moving refs to existing history). As an added bonus, since push
>      prints its output after receiving commitment from the server, it is
>      possible for the server to commit a change, have the user hit ^C,
>      thinking they beat the race, only to find out that the server did
>      indeed accept the change.

Yes, ^C is a hack, but it's useful in practice (there is ofcourse no
guarantee): I've been saved many times by it.  The only way to prevent
the race is to wait (either indefinitely for some user-input or for N
seconds), but I don't want to trade of speed.

>   http://thread.gmane.org/gmane.comp.version-control.git/128426

A TRANSPORT_PUSH_CONFIM.  Cute.

> As discussed in the top thread, this could also be used for "interactive
> push" where you could examine and confirm the changes for each proposed
> ref change.

Overkill, I think.  I don't want to bolt on very heavy safety
features: just help the user help themselves with feedback.
