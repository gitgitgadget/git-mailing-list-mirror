From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 4/4] allow recovery from command name typos
Date: Fri, 27 Jul 2012 01:08:34 +0800
Message-ID: <CALUzUxp91zubHEkWMC1z2xp7kJCRYrtznQS_=pVSZoNkZMihig@mail.gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
	<1343232982-10540-1-git-send-email-rctay89@gmail.com>
	<1343232982-10540-2-git-send-email-rctay89@gmail.com>
	<1343232982-10540-3-git-send-email-rctay89@gmail.com>
	<1343232982-10540-4-git-send-email-rctay89@gmail.com>
	<1343232982-10540-5-git-send-email-rctay89@gmail.com>
	<7vtxwvbu5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuRYH-0000j6-BF
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab2GZRIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:08:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45069 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab2GZRIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:08:35 -0400
Received: by pbbrp8 with SMTP id rp8so3498579pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f2Sd2uXbs8+dCkL9ZwGuJino7nXqGv+hkh64AkDCxoA=;
        b=WvBqCAuF5O8y3704qWGzEW4saxn69UM/REpfQD9DwV0OLsA2Cp7alagp4R/zRjxERx
         d4MxRvl4Hfv22cCBrAthfNxxlukPmX8Crmwbu2nneAL9PgUe5Wf2qj6/7gvk0IbB94XL
         l3NQq/iHdgGjM2T8S6yOmivRU9YoKcyJauPawg+tFOrPezSAmkthGSI/EJrS2bX8Wdu+
         CJM9OTuSVjpJueN0m4WsgZlc8YxtSRSfnR5LwqPz2D8UsgwpOaV24c0YrwaKDIWG3kA3
         mh9b9B2812wDpi7j+ivM6/Z2397fxUHm1zT3J0h8dCNm/KUPtwF0ziPrXIvx8aPg+Xaw
         3dpw==
Received: by 10.68.222.103 with SMTP id ql7mr6938134pbc.48.1343322514884; Thu,
 26 Jul 2012 10:08:34 -0700 (PDT)
Received: by 10.68.71.170 with HTTP; Thu, 26 Jul 2012 10:08:34 -0700 (PDT)
In-Reply-To: <7vtxwvbu5s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202278>

On Thu, Jul 26, 2012 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
> > If suggestions are available (based on Levenshtein distance) and if the
> > terminal isatty(), present a prompt to the user to select one of the
> > computed suggestions.
>
> The way to determine "If the terminal is a tty" used in this patch
> looks overly dangerous, given that we do not know what kind of "git"
> command we may be invoking at this point.

Indeed, it should also have considered stdin's tty-ness.

> Perhaps we should audit "isatty()" calls and replace them with a
> helper function that does this kind of thing consistently in a more
> robust way (my recent favorite is Linus's somewhat anal logic used
> in builtin/merge.c::default_edit_option()).

Any specific callers to isatty() you have in mind? A quick grep shows
that a significant portion of the "offenders" are isatty(2) calls to
determine whether to display progress, I think those are ok.

The credential helper has some prompting functionality that is close
to what I intend to do here, but I think it can make some assumptions
about stdin/stdout that we can't, as you have pointed out. So that
leaves merge-edit and this patch as the beneficiaries of a
builtin/merge.c::default_edit_option() refactor. That's just off the
top of my head.

Perhaps the helper function could be named "git_can_prompt()" and
placed in prompt.c?

--
Cheers,
Ray Chuan
