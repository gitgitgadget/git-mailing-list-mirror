From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: make '--always' fallback work after '--exact-match' failed
Date: Fri, 21 Aug 2015 08:55:32 -0700
Message-ID: <xmqqwpwo7i17.fsf@gitster.dls.corp.google.com>
References: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
	<xmqqegix7qjk.fsf@gitster.dls.corp.google.com>
	<20150821134039.Horde.wW7OPRQO28gZidreZRgP7g2@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 21 17:55:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSofM-0000d2-VX
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 17:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbbHUPzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 11:55:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34748 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbbHUPzf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 11:55:35 -0400
Received: by padfo6 with SMTP id fo6so9839464pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=k7axFoI2jIy96IqwDku1fRnHuf+SBjUweqLJfGYR6zo=;
        b=gzdj3I79tsGVvE8qCwzpoiSvRdIGbWmiTzInIE5mx4JRFGq3jNq2pq47W1SOhGiner
         2DKS0jm7mQ1FD2T0SdbqvPKCQ33cq0AFbSeV6e9EsbFLbSf2EKbt93g3TexVx3XGnfrh
         OqbRm/XDmFDnVodcd3jBZPN7+wvMZoPGLc+TsJp3pwRbNr16T1XtZUmTnCQTGuaSOByU
         fMh9ss0awOnNCoqVeVQFBGv0X/Eoks90mOEcfwR4eKYRq1lkVuA8asAyDpOTaivHryfI
         X9y+tB/ibDM7m10mcFKNTlKpoYeAWx9Ysrr4cm2b8rVVyroV6KnOeGpVncZt+DrLbcLC
         FJSw==
X-Received: by 10.66.190.99 with SMTP id gp3mr12263323pac.113.1440172535129;
        Fri, 21 Aug 2015 08:55:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id b6sm8273796pdo.63.2015.08.21.08.55.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 08:55:33 -0700 (PDT)
In-Reply-To: <20150821134039.Horde.wW7OPRQO28gZidreZRgP7g2@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 21 Aug 2015 13:40:39
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276305>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Well, that can be argued both ways.
> ...
>
> 'git describe' errors out by default if it can't describe the given
> commit.

Yes.  "describe" always fails when it cannot produce an acceptable
description.

And "--always" and "--exact-match" are two incompatible ways for
users to change what is considered an acceptable description.

 - With "--exact-match" and "--always", the definition of
   "acceptable" changes: by default, only a name based on some
   anchor point is acceptable.

   - "--always" loosens the definition and also allows an
     abbreviated commit object name as acceptable.

   - "--exact-match" tightens the definition.  In addition to "only
     a name based on some anchor point is acceptable", it requires
     that "based on" to be "0 distance from the anchor point".  The
     help text says succinctly: "*ONLY* output exact matches".

If you allow a request with "--exact-match" to show something that
is not an exact match, that no longer is "--exact-match".  Allowing
to mix "--always" to that option breaks it, as what the command does
no longer is to "only outputs exact matches".

 - One option "--exact-match" says that it is wrong to show anything
   but exact matches.

 - The other option "--always" says it is willing to show a name
   that is not an exact match. =20

These are competing goals.  You give preference to the latter, but
that is not the only valid point of view.

And that is why I said it can be argued both ways.  I think these
two are fundamentally incompatible.


[Footnote]

*1* Other parts of "'describe' only considers a name based on some
    anchor point as acceptable." are also modified by various
    options:

    - With "--contains", the definition of "based on" changes
      direction: a commit may be described as somewhere ahead of an
      anchor point by default, but can be described as somewhere behind
      of an anchor point.

    - With "--all" and "--tags", the definition of "anchor point"
      changes: by default, only annotated tags are possible anchor
      points.
