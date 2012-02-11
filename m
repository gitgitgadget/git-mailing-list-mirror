From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git pull" doesn't know "--edit"
Date: Sat, 11 Feb 2012 12:07:40 -0800
Message-ID: <CA+55aFwLqvVyMipun4DM4CnbO97Dota3LCM2VPFfLq1LS5a4aQ@mail.gmail.com>
References: <alpine.LFD.2.02.1202111016340.28503@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 21:08:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwJEt-00029w-GP
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 21:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab2BKUIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 15:08:01 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48994 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2BKUIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 15:08:00 -0500
Received: by pbcun15 with SMTP id un15so3409085pbc.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 12:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=QrrQcGPzXrNB27jKsQwZM5JcaWfmcKJIvmee/tKlCBw=;
        b=XyBm5AeIFRAeHPVdPHR9G4ibSHMbhFWA7evwA8aff2TbGnupJLzQ7H6Wa6gk3NICrQ
         lpjNh6sXREH1AL/eAaipOJs8GUcsk6ay/YYYLdTU0CroBMC9l8MvbWlR2GyWTI9C95NY
         a2FUVehJyM1/WyLUcMTAE8XZawAUh1igx0cQ4=
Received: by 10.68.73.4 with SMTP id h4mr30385119pbv.27.1328990880307; Sat, 11
 Feb 2012 12:08:00 -0800 (PST)
Received: by 10.143.59.21 with HTTP; Sat, 11 Feb 2012 12:07:40 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1202111016340.28503@i5.linux-foundation.org>
X-Google-Sender-Auth: CGrBI6nyWAw5WjCCY45W7E4ua-Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190534>

On Sat, Feb 11, 2012 at 10:21 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, so now "git merge" defaults to editing when interactive - lovely. But
> when testing that,

Ok, I found another thing that seems to be a buglet, or at least an
undocumented surprise.

In the docs, the "GIT_MERGE_AUTOEDIT=no" thing is mentioned as the way
to get the legacy behavior, which (at least to me) implies that
setting it to "yes" gets the modern behavior.

But try this:

    .. create test branch that can be merged ..
    export GIT_MERGE_AUTOEDIT=yes
    git merge test < /dev/null

and notice how the "GIT_MERGE_AUTOEDIT=yes" will actually *override*
the automatic merge thing, and will try to start an editor even for
non-interactive sessions.

Maybe this is intentional, and not a bug? But it does seem a bit odd -
the name is "AUTOEDIT", not "FORCEDEDIT". And  at least my default
editor gets confused by the redirected input, although obviously if
you have a graphical editor in its own window this may well be what
you want.

Anyway, maybe the "return v" in default_edit_option() should be

    if (!v)
        return 0;

instead - so that if AUTOEDIT it set to true, it does what the "auto"
in the name implies.

Of course, the current behavior *can* actually be useful, exactly as
that way to force the editor to come up. So maybe it's just that my
expectations that are wrong, and the behavior that "yes" causes a
forced editor should just be documented instead.

Or maybe the thing could extend the notion of the current boolean to
be a tri-state instead: in addition to the traditional true/yes/on and
false/no/off have a "force" mode that is that "always force it on
regardless".

And maybe this is just a "nobody cares" situation - "Don't do that then".

                    Linus
