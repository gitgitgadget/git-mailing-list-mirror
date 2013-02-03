From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Sun, 3 Feb 2013 19:06:21 +0000
Message-ID: <20130203190621.GT1342@serenity.lan>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <CALUzUxowrh53g50ZxkXSjLfOrSgX-YiZEB2MJXbLwxmwNB187A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U24ty-0008RK-GU
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 20:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab3BCTGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 14:06:31 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:38602 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab3BCTGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 14:06:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4CA3BCDA4DF;
	Sun,  3 Feb 2013 19:06:29 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mk04Qw3NP-F5; Sun,  3 Feb 2013 19:06:28 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C1166CDA590;
	Sun,  3 Feb 2013 19:06:23 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CALUzUxowrh53g50ZxkXSjLfOrSgX-YiZEB2MJXbLwxmwNB187A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215323>

On Mon, Feb 04, 2013 at 02:20:06AM +0800, Tay Ray Chuan wrote:
> On Sun, Feb 3, 2013 at 10:37 PM, John Keeping <john@keeping.me.uk> wrote:
> > When compiling combine-diff.c, clang 3.2 says:
> >
> >     combine-diff.c:1006:19: warning: adding 'int' to a string does not
> >             append to the string [-Wstring-plus-int]
> >                 prefix = COLONS + offset;
> >                          ~~~~~~~^~~~~~~~
> >     combine-diff.c:1006:19: note: use array indexing to silence this warning
> >                 prefix = COLONS + offset;
> >                                 ^
> >                          &      [       ]
> >
> > Suppress this by making the suggested change.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  combine-diff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/combine-diff.c b/combine-diff.c
> > index bb1cc96..dba4748 100644
> > --- a/combine-diff.c
> > +++ b/combine-diff.c
> > @@ -1003,7 +1003,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
> >                 offset = strlen(COLONS) - num_parent;
> >                 if (offset < 0)
> >                         offset = 0;
> > -               prefix = COLONS + offset;
> > +               prefix = &COLONS[offset];
> >
> >                 /* Show the modes */
> >                 for (i = 0; i < num_parent; i++) {
> 
> Hmm, does
> 
>                prefix = (const char *) COLONS + offset;
> 
> suppress the warning?

It does, but it turns out that the following also suppresses the
warning:

-- >8 --

diff --git a/combine-diff.c b/combine-diff.c
index bb1cc96..a07d329 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -982,7 +982,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	free(sline);
 }
 
-#define COLONS "::::::::::::::::::::::::::::::::"
+static const char COLONS[] = "::::::::::::::::::::::::::::::::";
 
 static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct rev_info *rev)
 {

I think that's a nicer change than the original suggestion.


John
