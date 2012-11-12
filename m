From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 12 Nov 2012 17:28:28 +0100
Message-ID: <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:28:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXwsN-0002b7-BT
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 17:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab2KLQ23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 11:28:29 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57051 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab2KLQ22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 11:28:28 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6402574oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=djQqSA4UQjAGS3toOv7+nlTmEj1u+Y7msfSqZvw+AwA=;
        b=miztbh1ExkTPkOdc3zVt3Kk60WOpSs8z2ten76fYFBBF1xzBX9egvoRGjoUxdRjKp3
         a0Jh8r9C+rgmw4B/RHiMgIyG3nVLL26DrevZDk+mo2wJU1rQYuWnbyjHEM7rjKCPAU8X
         4UBdgEMQXWibFXGernyby94WvwIEu/DMmURIZNqIcoYuqb30Ayt4F/JVe2Cf/Bb23F97
         HCQPNrel4xY0FA5Rww6oRJgyQBxjZmn400D5na4tLgnjZj3Cw8mZaF/Qd9R/as2Rjdmb
         ERYTcVqG8bUlDJEonE1mowHFuLwQqt0k7zZOP7gzRoyGbwmrTQXMLLhikDYAvH+uaiks
         5zDg==
Received: by 10.182.38.101 with SMTP id f5mr15819559obk.80.1352737708213; Mon,
 12 Nov 2012 08:28:28 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 08:28:28 -0800 (PST)
In-Reply-To: <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209483>

On Sun, Nov 11, 2012 at 2:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> They have been marked as UNINTERESTING for a reason, lets respect that.
>
> Currently the first ref is handled properly, but not the rest, so:
>
>  % git fast-export master ^master
>
> Would currently throw a reset for master (2nd ref), which is not what we
> want.
>
>  % git fast-export master ^foo ^bar ^roo
>  % git fast-export master salsa..tacos
>
> Even if all these refs point to the same object; foo, bar, roo, salsa,
> and tacos would all get a reset, and to a non-existing object (invalid
> mark :0).
>
> And even more, it would only happen if the ref is pointing to exactly
> the same commit, but not otherwise:
>
>  % git fast-export ^next next
>  reset refs/heads/next
>  from :0
>
>  % git fast-export ^next next^{commit}
>  # nothing
>  % git fast-export ^next next~0
>  # nothing
>  % git fast-export ^next next~1
>  # nothing
>  % git fast-export ^next next~2
>  # nothing
>
> The reason this happens is that before traversing the commits,
> fast-export checks if any of the refs point to the same object, and any
> duplicated ref gets added to a list in order to issue 'reset' commands
> after the traversing. Unfortunately, it's not even checking if the
> commit is flagged as UNINTERESTING. The fix of course, is to do
> precisely that.
>
> The current behavior is most certainly not what we want. After this
> patch, nothing gets exported, because nothing was selected (everything
> is UNINTERESTING).
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

And here's yet another reason why this is obviously correct that I just found:

% git fast-export --use-done-feature
--{import,export}-marks=.git/hg/origin/marks-git
^refs/hg/origin/branches/default ^refs/hg/origin/bookmarks/test6
refs/heads/test6 ^refs/hg/origin/bookmarks/master
^refs/hg/origin/bookmarks/test
feature done
reset refs/hg/origin/bookmarks/test
from :4

reset refs/heads/test6
from :14

done

What is that refs/hg/origin/bookmarks/test doing there?

transport-helper does use a fast-export command like that to specify
precisely what refs should be *IGNORED*, and yet fast-export will
throw a reset for a ref that has been marked as UNINTERESTING. So, the
receiving end in the helper will see a reset for a ref that it
explicitly said was marked as outside it's refspec realm:

refspec refs/heads/*:refs/hg/origin/bookmarks/*

What is remote-hg supposed to do with 'refs/hg/origin/bookmarks/test'?
There's nothing that can be done, it's a bug in fast-export that such
a thing was exported in the first place. And the reason it happens is
that another ref happens to be pointing to the same object, (in this
case refs/hg/origin/branches/default)

So yeah, the patch is good.

Of course, transport-helper shouldn't even be specifying the negative
(^) refs, but that's another story.

Cheers.

-- 
Felipe Contreras
