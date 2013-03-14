From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] difftool --dir-diff: symlink all files matching the
 working tree
Date: Thu, 14 Mar 2013 09:36:17 +0000
Message-ID: <20130314093617.GM2317@serenity.lan>
References: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
 <cover.1363206651.git.john@keeping.me.uk>
 <796eafb6816b302c87873c8f4a1bd2225ce40c55.1363206651.git.john@keeping.me.uk>
 <CAJDDKr5M4pqmd9HSVT8hDJB9AxgV2RexN6B6v6ccTS6raWY_Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 10:37:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG4aw-0000CM-MG
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 10:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616Ab3CNJgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 05:36:36 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47364 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608Ab3CNJgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 05:36:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2565ACDA585;
	Thu, 14 Mar 2013 09:36:33 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQP+P50zPezp; Thu, 14 Mar 2013 09:36:26 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 93CF8CDA599;
	Thu, 14 Mar 2013 09:36:19 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr5M4pqmd9HSVT8hDJB9AxgV2RexN6B6v6ccTS6raWY_Qg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218123>

On Wed, Mar 13, 2013 at 08:41:29PM -0700, David Aguilar wrote:
> On Wed, Mar 13, 2013 at 1:33 PM, John Keeping <john@keeping.me.uk> wrote:
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index eb1d3f8..8102ce1 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -370,6 +370,20 @@ test_expect_success PERL 'difftool --dir-diff' '
> >         echo "$diff" | stdin_contains file
> >  '
> >
> > +write_script .git/CHECK_SYMLINKS <<\EOF &&
> 
> Tiny nit.  Is there any downside to leaving this file
> at the root instead of inside the .git dir?

I followed what some of the other uses of write_script (in other tests)
did.  I think putting it under .git is slightly better because it won't
show up as untracked in the repository but that shouldn't matter here,
so I'm happy to change it in a re-roll.

> > +#!/bin/sh
> > +test -L "$2/file" &&
> > +test -L "$2/file2" &&
> > +test -L "$2/sub/sub"
> > +echo $?
> > +EOF
> > +
> > +test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
> > +       result=$(git difftool --dir-diff --symlink \
> > +               --extcmd "./.git/CHECK_SYMLINKS" branch HEAD) &&
> > +       test "$result" = 0
> > +'
> > +
> 
> How about something like this?
> 
> +       echo 0 >expect &&
> +       git difftool --dir-diff --symlink \
> +               --extcmd ./CHECK_SYMLINKS branch HEAD >actual &&
> +       test_cmp expect actual
> 
> (sans gmail whitespace damage) so that we can keep it chained with &&.

I hadn't considered using test_cmp, if we go that way I wonder if we can
do slightly better for future debugging.  Something like this perhaps?

+write_script .git/CHECK_SYMLINKS <<\EOF &&
+for f in file file2 sub/sub
+do
+	echo "$f"
+	readlink "$2/$f"
+done >actual
+EOF
+
+test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
+	cat <<EOF >expect &&
+file
+$(pwd)/file
+file2
+$(pwd)/file2
+sub/sub
+$(pwd)/sub/sub
+EOF
+       git difftool --dir-diff --symlink \
+               --extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
+	test_cmp actual expect
+'

> Ah.. it seems your branch is based on master, perhaps?
>
> There's stuff cooking in next for difftool's tests.
> I'm not sure if this patch is based on top of them.
> Can you rebase the tests so that the chaining is done like it is in 'next'?

Yes it is based on master.  The cleanup on next looks good, I'll base
the re-roll on that.


John
