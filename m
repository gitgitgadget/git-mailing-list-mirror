From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Thu, 17 Jan 2013 11:00:08 +0000
Message-ID: <20130117110008.GD4574@serenity.lan>
References: <20130116182449.GA4881@sigill.intra.peff.net>
 <1358376443-7404-1-git-send-email-apelisse@gmail.com>
 <1358376443-7404-2-git-send-email-apelisse@gmail.com>
 <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, git <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 12:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvnDH-0005Ci-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 12:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab3AQLAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 06:00:25 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50314 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab3AQLAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 06:00:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3619C19803F;
	Thu, 17 Jan 2013 11:00:21 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIlbfc8PBRLu; Thu, 17 Jan 2013 11:00:20 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 1F22C19801B;
	Thu, 17 Jan 2013 11:00:19 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 12AA8161E556;
	Thu, 17 Jan 2013 11:00:19 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V2oHM57ofm7l; Thu, 17 Jan 2013 11:00:18 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B1CE0161E560;
	Thu, 17 Jan 2013 11:00:09 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213848>

On Thu, Jan 17, 2013 at 11:32:39AM +0100, Antoine Pelisse wrote:
> John, could you confirm that you trigger the -Wtautological-compare
> warning with your version of clang ?

Yes, the warning is still there with both 3.2 and a recent trunk build
but this patch squelches it.

> And that this patch makes clang compilation warning-free (with the
> very latest clang) ?

There is one remaining warning on pu which hasn't been discussed in this
thread as far as I can see.  I'll send a patch shortly.

There's also a warning that triggers with clang 3.2 but not clang trunk, which
I think is a legitimate warning - perhaps someone who understands integer type
promotion better than me can explain why the code is OK (patch->score is
declared as 'int'):

builtin/apply.c:1044:47: warning: comparison of constant 18446744073709551615
    with expression of type 'int' is always false
    [-Wtautological-constant-out-of-range-compare]
        if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~


> On Wed, Jan 16, 2013 at 11:47 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> > Create a GREP_HEADER_FIELD_MIN so we can check that the field value is
> > sane and silent the clang warning.
> >
> > Clang warning happens because the enum is unsigned (this is
> > implementation-defined, and there is no negative fields) and the check
> > is then tautological.
> >
> > Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> > ---
> > I tried to consider discussion [1] and this [2] discussion on clang's list
> >
> > With these two patches and the patch from Max Horne, I'm finally able to
> > compile with CC=clang CFLAGS=-Werror.
> >
> >  [1]: http://thread.gmane.org/gmane.comp.version-control.git/184908
> >  [2]: http://clang-developers.42468.n3.nabble.com/Possibly-invalid-enum-tautology-warning-td3233140.html
> >
> >  grep.c | 3 ++-
> >  grep.h | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/grep.c b/grep.c
> > index 4bd1b8b..bb548ca 100644
> > --- a/grep.c
> > +++ b/grep.c
> > @@ -625,7 +625,8 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
> >         for (p = opt->header_list; p; p = p->next) {
> >                 if (p->token != GREP_PATTERN_HEAD)
> >                         die("bug: a non-header pattern in grep header list.");
> > -               if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
> > +               if (p->field < GREP_HEADER_FIELD_MIN ||
> > +                   GREP_HEADER_FIELD_MAX <= p->field)
> >                         die("bug: unknown header field %d", p->field);
> >                 compile_regexp(p, opt);
> >         }
> > diff --git a/grep.h b/grep.h
> > index 8fc854f..e4a1df5 100644
> > --- a/grep.h
> > +++ b/grep.h
> > @@ -28,7 +28,8 @@ enum grep_context {
> >  };
> >
> >  enum grep_header_field {
> > -       GREP_HEADER_AUTHOR = 0,
> > +       GREP_HEADER_FIELD_MIN = 0,
> > +       GREP_HEADER_AUTHOR = GREP_HEADER_FIELD_MIN,
> >         GREP_HEADER_COMMITTER,
> >         GREP_HEADER_REFLOG,
> >
> > --
> > 1.8.1.1.435.g20d29be.dirty
> >
