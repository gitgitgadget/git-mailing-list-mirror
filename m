From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v16 05/14] ref-filter: introduce match_atom_name()
Date: Sun, 6 Sep 2015 15:52:27 -0400
Message-ID: <CAPig+cSN1s6qAj7p_+qG9W52X2L-7eBR+-j+918vfycADvUyWw@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
	<1441479135-5285-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 21:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYfzN-00060P-3Q
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 21:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbbIFTw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 15:52:29 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36858 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbIFTw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 15:52:27 -0400
Received: by ykcf206 with SMTP id f206so64136265ykc.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TIdy6A/An99YSkKHSHcuWGWqf/3nb809994bpp59fPE=;
        b=lDGsoWes+gfj+aKdgsdq59REyr9/2FWKQ6fBOP0HUVwQOzXMz1PTAMRQnoVZRPZoor
         4RCxdqqRkDDmnR1DZzJalesNoXZKAOVqgHnKs40Un+6Ls6mNelK3WZxGBeqBPwImvfa4
         8o8NppPPYrWeWvr4mkojjQwiLLuUXTZ9ONa88b3TlCvosPpIdMPHzHtiwcjYmFwo50UJ
         qiEal9ULsW1YGTqlGTyCdKmaqK7rhjjqHzdEj+nxkmdJvhaZvVA1FYAa28swVaxmfIbN
         rXvUvocRFNCAqa3BfXeeSiaIQijpGrdW3yf9vQFpiWSWhl3Ki0M3OzK6kUXC1AWQHkZp
         X6OA==
X-Received: by 10.129.92.8 with SMTP id q8mr16464385ywb.163.1441569147271;
 Sun, 06 Sep 2015 12:52:27 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 6 Sep 2015 12:52:27 -0700 (PDT)
In-Reply-To: <1441479135-5285-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: vBMpTUdsnejlI7HkMvlWRa2hHWM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277437>

On Sat, Sep 5, 2015 at 2:52 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce match_atom_name() which helps in checking if a particular
> atom is the atom we're looking for and if it has a value attached to
> it or not.
>
> Use it instead of starts_with() for checking the value of %(color:...)
> atom. Write a test for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index a993216..e99c342 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> +static int match_atom_name(const char *name, const char *atom_name, const char **val)
> +{
> +       const char *body;
> +
> +       if (!skip_prefix(name, atom_name, &body))
> +               return 0; /* doesn't even begin with "atom_name" */
> +       if (!body[0] || !body[1]) {
> +               *val = NULL; /* %(atom_name) and no customization */
> +               return 1;

If this is invoked as match_atom_name("colors", "color", ...), then it
will return true (matched, but no value), which is not correct at all;
"colors" is not a match for atom %(color). Maybe you meant?

    if (!body[0] || (body[0] == ':' && !body[1])) {

But, that's getting ugly and complicated, and would be bettered
handled by reordering the logic of this function for dealing with the
various valid and invalid cases. However...

> +       }
> +       if (body[0] != ':')
> +               return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
> +       *val = body + 1; /* "atomname:val" */
> +       return 1;
> +}

It's not clear why this function exists in the first place. It's only
purpose seems to be to specially recognize instances of atoms which
should have a ":" but lack it, so that the caller can then report an
error.

But why is this better than the more generic solution of merely
reporting an error for *any* unrecognized atom? How does it help to
single out these special cases?

There is a further inconsistency in that you are only specially
recognizing %(color) and %(align) lacking ":", but not
%(content:lines) lacking "=" in patch 8/14. Why do %(color:...) and
%(align:...) get special treatment but %(content:lines=...) does not?
Such inconsistency again argues in favor of a generic "unrecognized
atom" detection and reporting over special case handling.

>  /*
>   * In a format string, find the next occurrence of %(atom).
>   */
> @@ -721,10 +738,12 @@ static void populate_value(struct ref_array_item *ref)
>                         refname = branch_get_push(branch, NULL);
>                         if (!refname)
>                                 continue;
> -               } else if (starts_with(name, "color:")) {
> +               } else if (match_atom_name(name, "color", &valp)) {
>                         char color[COLOR_MAXLEN] = "";
>
> -                       if (color_parse(name + 6, color) < 0)
> +                       if (!valp)
> +                               die(_("expected format: %%(color:<color>)"));
> +                       if (color_parse(valp, color) < 0)
>                                 die(_("unable to parse format"));
>                         v->s = xstrdup(color);
>                         continue;
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..c4f0378 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,8 @@ test_expect_success 'filtering with --contains' '
> +test_expect_success '%(color) must fail' '
> +       test_must_fail git for-each-ref --format="%(color)%(refname)"
> +'
> +
>  test_done
> --
> 2.5.1
