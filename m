From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] git-apply: fix rubbish handling in --check case
Date: Wed, 23 Nov 2011 12:44:52 -0600
Message-ID: <CA+sFfMf2+XJGtQACeh=J4BA1rGP=KsFDnzw0UECjmTPp2-ZUzQ@mail.gmail.com>
References: <1322065563-3651-1-git-send-email-dedekind1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 19:45:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTHoa-00070B-29
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 19:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab1KWSoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 13:44:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46062 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab1KWSox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 13:44:53 -0500
Received: by yenq3 with SMTP id q3so1724070yen.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KbMTiOY/Ft6h1LenXtpk+i1OPueT59aYWU29xCVsg2Q=;
        b=r9ABAt9Eb6K9bItlTLooaIuDNh46dNbGE8mMhwyvPERgvXo7hNZgahs4r45hEKftPh
         XHr47XTY6s/so9Z1Y/xgLXuAsovLwVO+MxnfqGBtSBYlcvTeO/z06dx+XgS37Xzi7i0R
         qj5FpBohhQ7y7Xe1V8ZlV8pDXOeX0CcUPuf5c=
Received: by 10.182.2.164 with SMTP id 4mr8828027obv.49.1322073892854; Wed, 23
 Nov 2011 10:44:52 -0800 (PST)
Received: by 10.182.188.104 with HTTP; Wed, 23 Nov 2011 10:44:52 -0800 (PST)
In-Reply-To: <1322065563-3651-1-git-send-email-dedekind1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185861>

On Wed, Nov 23, 2011 at 10:26 AM, Artem Bityutskiy <dedekind1@gmail.com=
> wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

> $ git apply --check /bin/bash
> $ echo $?
> 0
>
> Not exactly what I expected :-) The same happnes if you use an empty =
file.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>
> Note, I did not extensively test it!
>
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0builtin/apply.c | =C2=A0 =C2=A08 +++++---
> =C2=A02 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 84a8a0b..2d6862a 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3596,9 +3596,6 @@ static int write_out_results(struct patch *list=
, int skipped_patch)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int errs =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct patch *l;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!list && !skipped_patch)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("No c=
hanges");
> -

I think write_out_results() can lose the skipped_patch parameter now.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (phase =3D 0; phase < 2; phase++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l =3D list;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (l) {
> @@ -3741,6 +3738,11 @@ static int apply_patch(int fd, const char *fil=
ename, int options)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!apply_with_reject)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);
>
> + =C2=A0 =C2=A0 =C2=A0 if (!list && !skipped_patch) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("No changes"=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);

You can use die() instead of error followed by exit.

Also, I don't see any reason why this check shouldn't be moved up so
that it is performed immediately after the while loop, avoiding any
unnecessary work.

btw. die'ing like this affects diffstat, numstat, summary etc. too
since now they will report an error instead of just displaying an
informational message describing zero changes when passed a bogus
patch. But that seems correct to me.

I would have also suggested changing the error message to something
more descriptive than "No changes", but apparently apply is a plumbing
command.  It seems kind of an "in-between plumbing and porcelain"
command.

It still seems like the correct behavior change with respect to
diffstat, numstat et al that I mentioned above after rethinking from a
plumbing perspective. git apply should error out if it cannot
recognize its input.

-Brandon
