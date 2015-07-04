From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] log --count: added test
Date: Fri, 03 Jul 2015 17:54:53 -0700
Message-ID: <xmqqd2084u8y.fsf@gitster.dls.corp.google.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
	<vpqwpyh4rup.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>, git@vger.kernel.org,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 04 02:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBjc-00078j-So
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbbGDAy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:54:58 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36948 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbGDAy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:54:56 -0400
Received: by igblr2 with SMTP id lr2so85175400igb.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PYgzXjZRV214ErWDFbUPwueSCm5OTv3W0rQ4HEG2GkQ=;
        b=iCEtXVMHDe9Ky/y9Qa3Y6e6HQXIS3g4nqXyW3e8mwAyuqjqmN8R5zYA6GXoNDyq9Nl
         fOUb3VC8xEjiouVg8Cd8kbd3MK6vdXTGj1wqAa2JgQCRgexHNFyqEXmN6C9jxLxOYlmf
         f5X7a4j6EBW2FX0zqOYHP08HT6a16qDOP5sHqhImknoIIUfciYL0SlnNwNiOb3L9Fb4z
         aqWMoD1sMAb7omQreuz2JQt59TUOopR1hLUT0EoRRiVi8S3JLVUHgqbEn6y1YYRITxQb
         hbWSbWVR4x4zl7AcgE9c8D+fs7hwWy1OrTboVHobd+29xFgmIOydlzxH8AfBXlp21z4G
         AtOg==
X-Received: by 10.50.142.67 with SMTP id ru3mr53524851igb.16.1435971296018;
        Fri, 03 Jul 2015 17:54:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by smtp.gmail.com with ESMTPSA id bf10sm4572493igb.12.2015.07.03.17.54.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 17:54:54 -0700 (PDT)
In-Reply-To: <vpqwpyh4rup.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	03 Jul 2015 09:34:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273338>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Also, some revision-limiting options can reduce the count like
>
> git log --grep whatever
>
> and you should check that you actually count the right number here.
>
> (I don't know this part of the code enough, but I'm not sure you
> actually deal with this properly)

Yes, "rev-list", when the revision range is "limited" (with or
without pathspec), can give "--count" once limit_list() finishes,
but "log" filters the result of limit_list() further with at least
three separate phases.

 - options in the "grep" family (--grep/--author/etc.) lets you skip
   commits based on the contents of the commit object;

 - options in the "diff" family (-w/-b/etc.) may let "git log"
   consider a commit because the pathspec limit thought two blobs
   were different at byte-by-byte level, but after running "diff"
   with these "looser" comparison, "git log" may realize that there
   weren't any interesting change introduced by the commit [*1*];

 - and finally, of course "log --max-count=20" may further limit the
   maximum number of commits that are shown.  This of course is not
   interesting in the context of "--count" in the sense that "git
   log --count -20 --grep=foo maint..master" may not be immediately
   a sensible thing to do (but we never know.  Perhaps your user may
   be asking "do we have 20 or more commits that say 'foo' in the
   range?")

An implementation of "--count" to take the first and the third ones
in account may not be too hard, but I am fairly familiar with the
codepath for the second one and I think it would be very tricky.

Note that these additional things "log" does over "rev-list" *DO*
justify addition of "--count" to "log" (because "rev-list --count"
cannot emulate these); I am however not sure if it is worth the
additional complexity we need to add to the codepath (especially for
the second phase).  I'd need to take another look at the codepaths
involved myself to be sure, but I suspect the damage to the codepath
for the second may end up to be extensive when we do decide to fix
the possible bug in it.


[Footnote]

*1* They may still show the log message in such a case where "-b/-w"
was asked and commit had only whitespace changes, but I think we
should consider that a bug.
