From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH] git-rebase: Print name of rev when using shorthand
Date: Wed, 16 Apr 2014 17:19:41 +0900
Message-ID: <CAN7MxmUikP6pVAj3cpDiSbFxawScTh5zKusPUe8SpkNbH=e6Aw@mail.gmail.com>
References: <1397419474-31999-1-git-send-email-modocache@gmail.com>
	<xmqqwqerogvr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 10:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaL4O-0000Ql-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 10:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbaDPITo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 04:19:44 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:65115 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbaDPITm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 04:19:42 -0400
Received: by mail-ig0-f173.google.com with SMTP id hl10so755266igb.12
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gpPg+z1rbvRPc1nM0cWX/EgPI7KqvJvqXIOVeSNKya4=;
        b=VNyADz8Z6xCaPgdGFVelYhdsI0HNbuEY9h1R8f2jUwHfm8ne5mfCoNQ2dpTgddqCad
         lK9xVova2bU2bgJ/nSvHRF2Ho9/lus99qiXnrFLKutVjuIyY/k/C8192Lt7VYiOjB859
         0ew9txlvZ9AcOTBl3a0a/t3hDB0c9qUWszg0IwE+cxHm9ve0eunnds23f3DcHb396g+A
         OAPYSXe2kS4RiB7h6u0uQf/NGUjdIUvAb3DlC/vKrRqFNTpnyi/KIGefVASvKQ7avPPk
         /nJgr7NRIfdKTtb7HbcXRMtlBLaPJ6K/dpelgmKHSjknv2vsEWbGLwL9/JjDJGGnwi6B
         GbBg==
X-Received: by 10.42.67.130 with SMTP id t2mr2691536ici.17.1397636381593; Wed,
 16 Apr 2014 01:19:41 -0700 (PDT)
Received: by 10.64.55.161 with HTTP; Wed, 16 Apr 2014 01:19:41 -0700 (PDT)
In-Reply-To: <xmqqwqerogvr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246317>

Thank you for the feedback!

> Imagine the case where there are more than one branches
> whose tip points at the commit you came from.
> name-rev will not be able to pick correctly which one to report.

I see. Yes, you're exactly right; the following demonstrates
the problem:

$ git checkout -b xylophone master
$ git checkout -b aardvark master
$ git name-rev --name-only @{-1} # I'd want "xylophone", but this
outputs "aardvark"

So it appears name-rev is not up to the task here.

> I think you would want to use something like:
>
>         upstream_name=$(git rev-parse --symbolic-full-name @{-1})
>         if test -n "$upstream"
>         then
>                 upstream_name=${upstream_name#refs/heads/}
>         else
>                 upstream_name="@{-1}"
>         fi
>
> if the change is to be made at that point in the code.

I agree, I will re-roll the patch to use this approach.

> I also wonder if "git rebase @{-1}" deserve a similar translation
> like you are giving "git rebase -".

Personally, I've been using the "-" shorthand with "git checkout"
for a year or so, but only learned about "@{-1}" a few months ago.
I think those who use "@{-1}" are familiar enough with the concept
that they don't need to have the reference translated to a symbolic
full name. Users familiar with "-" might not be aware of "@{-1}",
however, so I'd prefer not to output it as we are currently.

Furthermore, were we to translate "@{-1}", does that mean we
should also translate "@{-2}" or prior? I don't think that's the case,
but then only translating "@{-1}" would seem inconsistent.
From that point of view I'd prefer to simply translate "-",
not "@{-1}".

- Brian Gesiak
