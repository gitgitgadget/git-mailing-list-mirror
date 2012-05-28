From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] exclude: do strcmp as much as possible before fnmatch
Date: Mon, 28 May 2012 08:03:42 +0700
Message-ID: <CACsJy8ApRn65_Okeg+T41+fLv_Z4tMMUGrGMZN979q=JaYmogg@mail.gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <1338035474-4346-3-git-send-email-pclouds@gmail.com> <7vk3zyp14i.fsf@alter.siamese.dyndns.org>
 <CACsJy8DOz30GD_zv9yO7KD55+=H0t=+q_5qRtt51nOoYXwOBBQ@mail.gmail.com> <7v8vgd7ap9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 28 03:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYoNg-0007U1-3q
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 03:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab2E1BEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 May 2012 21:04:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64307 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2E1BEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 21:04:14 -0400
Received: by weyu7 with SMTP id u7so1644260wey.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=V6tLcO+bxUDgPCrw7IaCphlT21TwLNuui8zPDeGyHAo=;
        b=D3Iy8MAKf9bfSpV56YMc+oMV1rT5EZCy+J5lI/RqimDcxFqfqqq29i5KrfS/5b6bUM
         graGpPA4x5yq980b61mLIdZG+02XziGKjPiR0fiWClA8A2L9sRNjDmF1zPczEXb6e8n+
         mYn3R1u19Lgoig2R0/FLrelF/YcvAN5O4q4PcniAT9XJxb4jzB7aqdwVbzMFLXiiKzrn
         oO902uDb4W+jgvWKBSVki5DMPZt1xOFhC0cIKqW0CY9RZccMeFFGWlR1LnGQZzdKWvx9
         bcZ8sw7ggXLpNiVsQ9Qk+O5qfibrnmi+NSTknFxY3Eeuib23NKNGT00UrDoHU9VtWdcV
         QyEg==
Received: by 10.216.194.196 with SMTP id m46mr2646398wen.197.1338167053169;
 Sun, 27 May 2012 18:04:13 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sun, 27 May 2012 18:03:42 -0700 (PDT)
In-Reply-To: <7v8vgd7ap9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198621>

On Mon, May 28, 2012 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Actually I was referring to the exclude_stack.
>
> Suppose you have .gitignore file at the top that lists /foo/bar/*.c
> (among other millions of patterns anchored to specific directory),
> and another in the foo/bar directory. =C2=A0When you are looking at a
> path in the top-level, currently the exclude_stack would have one
> element, per-directory one for .gitignore at the top, that has
> millions of patterns that would never match. =C2=A0And then when you
> descend into foo/bar directory, prep_exclude would link two elements
> (one for foo/ directory which may be empty, another for foo/bar
> directory) to this, and then you check paths you see in foo/bar
> directory using all the elements that appear in the exclude_stack.
>
> What I was suggesting was that you could choose not to add
> /foo/bar/*.c entry in the exclude_stack element for the top-level
> (but remember you did so), and then inside prep_exclude() when you
> look at different directory, e.g. foo/bar, notice that higher level
> (i.e. toplevel in this example) has such a deferred patterns that
> applies to the new directory. =C2=A0Then instead of adding /foo/bar/*=
=2Ec
> at the top-level, you can pretend as if /*.c appeared in .gitignore
> file in the deeper level in the hierarchy.
>
> And this does not happen per path you check; exclude_stack used by
> excluded() is designed to take advantage of the access pattern that
> we tend to check paths from the same directory together, so such an
> adjustment will be per directory switching (i.e. it will be part of
> the prep_exclude() overhead that is amortized over paths you walk).

That's perhaps a better approach. Two points (for myself to think
again after work):

 - that involves reordering the stack to make sure we always have
gitignore "files" in root dir first, then 1st level... after we split
some patterns from top-level file to deeper level, so that popping
works without major change
 - the implication due to pattern reordering (probably keep the order
as we currently have. Suppose we checking in "sub", then sub/...
patterns from top-level go first, then from sub/.gitignore)
--=20
Duy
