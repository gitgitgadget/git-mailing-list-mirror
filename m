From: Paolo Giarrusso <p.giarrusso@gmail.com>
Subject: Re: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed, 9 Oct 2013 14:03:24 +0200
Message-ID: <CAAcnjCQCJYbYUkTK+ZM6xFe=u1mj9iHetaG--yg3Qzn0_Ty0hg@mail.gmail.com>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
 <CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com>
 <CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com>
 <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com> <vpqy562y9b8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 09 14:03:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTsUa-0002Wi-T5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 14:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab3JIMDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 08:03:48 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:33295 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab3JIMDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 08:03:47 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so579251lab.22
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hsGw/+3GQy2BtADz2GjiQufp882ctlh0zqSOLXEp8jI=;
        b=gm0ge8HYDGlDPF0+OiXoxpmcjMgTyUrkN9OdYj4iBzG6vcECCX3aukOCwEGNHDouIX
         GgWQcQsGLbvWgeXM9BfrE6VPWddsnLT31djSPyyue2Q7jfRwlqejlF58UfeOrvRmZh10
         wnzcBA0ewZNJDVP4p6LCkmh/7fgbDhE80TiMwQMjm5BsJQu8uBgU6XvDzCGHAg32mSc9
         ff5841J94fZX+mVNwfU7M+dCLTnRf1biEuojisvOEw2t0mIIPhUAN8XxrsQj02sUFKjG
         DPdwpmGgCkq9w5S7M3sOtaPS5EA2Io7kCT5nZ14ihG2YAWiOM+6tA8e6XbLNNGsFY1UM
         CiMA==
X-Received: by 10.112.168.35 with SMTP id zt3mr6966705lbb.11.1381320225722;
 Wed, 09 Oct 2013 05:03:45 -0700 (PDT)
Received: by 10.112.190.102 with HTTP; Wed, 9 Oct 2013 05:03:24 -0700 (PDT)
In-Reply-To: <vpqy562y9b8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235808>

On Wed, Oct 9, 2013 at 1:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Paolo Giarrusso <p.giarrusso@gmail.com> writes:
>
>> Otherwise, one could
>> change say to use printf, but that's more invasive.
>
> "invasive" in the sense that it impacts indirectly more callers, but are
> there really cases where "echo" is needed when calling "say"? Aren't
> there other potential bugs when arbitrary strings are passed to "say",
> that would be fixed by using printf once and for all?

(1) Changing the implementation of say to use printf "%s\n" would be
trivial, and I think would address your concerns.

But I was concerned about code duplication; one could additionally
make say reusable in this single call site, instead of inlining and
customizing it by replacing the "\n" with "\r". But for that, you need
to either
(2) add an explicit \n to all callers (invasive & error prone), or
(3) make `say` parse the `-n` option and conditionally add "\n" to the
format string or to a final argument, if -n is not specified; this
would affect no current caller, but complicate the implementation of
say. Doing that for just one call site has too much potential for
breakage, so I'm not sure I'd do it. (I'm not even sure on what should
`say` do when `-n` is not the first argument).

Options (1), (2) and (3) are mutually alternative; my favorite is (1).

I can see your points about opportunity, especially after looking at
the commit message of the patch of yours you linked.

> The patch would look like the one I did in 89b0230a20 (Wed Aug 7 2013,
> die_with_status: use "printf '%s\n'", not "echo").

I see your point. But note that using printf like in die_with_status
after that commit wouldn't be reusable here in all call sites, because
it always prints a newline.

Cheers,
-- 
Paolo G. Giarrusso - Ph.D. Student, Philipps-University Marburg
http://www.informatik.uni-marburg.de/~pgiarrusso/
