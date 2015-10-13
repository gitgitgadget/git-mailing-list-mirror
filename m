From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/10] ref-filter: add support for %(upstream:track,nobracket)
Date: Tue, 13 Oct 2015 23:43:45 +0530
Message-ID: <CAOLa=ZRZszOqHqJfOHhFqa-XDZbrcPCuSdvM_zMEYHURv8kW_A@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com> <1444295885-1657-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <Karthik.188@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:14:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm45e-00089J-UL
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 20:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbbJMSOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 14:14:17 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33339 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbbJMSOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 14:14:16 -0400
Received: by vkaw128 with SMTP id w128so15509831vka.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ab3By2/P0Ec6+gPS0Gh52iYbOYtfbnF+aIkVITe324o=;
        b=iiIPKgw8vaEFmqZVOgARUYumNTWL1nw8FmP1qM3MAO+4kSulGJrqUAKzh8wFa5QjxB
         p3mSqRo+qFfrLgUK5QCnnr94K82LqbJTfhSy5RMFhW0P1Dqz6WSKHD9O+2gZdQwEWhc3
         DA2ZsjcgnPQB5Jcwed15qdua1lZNGDTduQJOkZNNdvqM3zbtBDVUI3WPyYYKbd3g9w2b
         Fkv1RutusEmiFQI17DjlfD9bV2wl6JPHafYxwx/reJYikloMGsGeaEqn9Y6a/kwuKB1h
         1NktrLEQEqyOVSljbMpig752jggWTlKkOU3yyab02u4cIpQKwjGsuSlY3llsbAL3dsy/
         ja9w==
X-Received: by 10.31.21.149 with SMTP id 143mr21952368vkv.79.1444760055347;
 Tue, 13 Oct 2015 11:14:15 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 13 Oct 2015 11:13:45 -0700 (PDT)
In-Reply-To: <1444295885-1657-9-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279509>

On Thu, Oct 8, 2015 at 2:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support for %(upstream:track,nobracket) which will print the
> tracking information without the brackets (i.e. "ahead N, behind M").
>
> Add test and documentation for the same.
> ---
>  Documentation/git-for-each-ref.txt |  6 ++++--
>  ref-filter.c                       | 28 +++++++++++++++++++++++-----
>  t/t6300-for-each-ref.sh            |  9 +++++++++
>  3 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index c713ec0..a38cbf6 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -114,8 +114,10 @@ upstream::
>         `refname` above.  Additionally respects `:track` to show
>         "[ahead N, behind M]" and `:trackshort` to show the terse
>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
> -       or "=" (in sync).  Has no effect if the ref does not have
> -       tracking information associated with it.
> +       or "=" (in sync).  Append `:track,nobracket` to show tracking
> +       information without brackets (i.e "ahead N, behind M").  Has
> +       no effect if the ref does not have tracking information
> +       associated with it.
>
>  push::
>         The name of a local ref which represents the `@{push}` location
> diff --git a/ref-filter.c b/ref-filter.c
> index 6a38089..6044eb0 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1112,27 +1112,45 @@ static void populate_value(struct ref_array_item *ref)
>                         if (!strcmp(formatp, "short"))
>                                 refname = shorten_unambiguous_ref(refname,
>                                                       warn_ambiguous_refs);
> -                       else if (!strcmp(formatp, "track") &&
> +                       else if (skip_prefix(formatp, "track", &valp) &&
> +                                strcmp(formatp, "trackshort") &&
>                                  (starts_with(name, "upstream") ||
>                                   starts_with(name, "push"))) {

If you see here, we detect "track" first for
%(upstream:track,nobracket) so although
the idea was to use something similar to %(align:...) I don't see a
good way of going
about this. If we want %(upstream:nobracket,track) to be supported then, I think
we'll have to change this whole layout and have the detection done up where we
locat "upstream" / "push", what would be a nice way to go around this?

What I could think of:
1. Do the cleanup that Junio and Matthieu suggested, where we
basically parse the
atoms and store them into a used_atom struct. I could either work on
those patches
before this and then rebase this on top.
2. Let this be and come back on it when implementing the above series.
After reading Matthieu's and Junio's discussion, I lean towards the latter.

>                                 char buf[40];
> +                               unsigned int nobracket = 0;
> +
> +                               if (!strcmp(valp, ",nobracket"))
> +                                       nobracket = 1;
>
>                                 if (stat_tracking_info(branch, &num_ours,
>                                                        &num_theirs, NULL)) {
> -                                       v->s = "[gone]";
> +                                       if (nobracket)
> +                                               v->s = "gone";
> +                                       else
> +                                               v->s = "[gone]";
>                                         continue;
>                                 }
>
>                                 if (!num_ours && !num_theirs)
>                                         v->s = "";
>                                 else if (!num_ours) {
> -                                       sprintf(buf, "[behind %d]", num_theirs);
> +                                       if (nobracket)
> +                                               sprintf(buf, "behind %d", num_theirs);
> +                                       else
> +                                               sprintf(buf, "[behind %d]", num_theirs);
>                                         v->s = xstrdup(buf);
>                                 } else if (!num_theirs) {
> -                                       sprintf(buf, "[ahead %d]", num_ours);
> +                                       if (nobracket)
> +                                               sprintf(buf, "ahead %d", num_ours);
> +                                       else
> +                                               sprintf(buf, "[ahead %d]", num_ours);
>                                         v->s = xstrdup(buf);
>                                 } else {
> -                                       sprintf(buf, "[ahead %d, behind %d]",
> +                                       if (nobracket)
> +                                               sprintf(buf, "ahead %d, behind %d",
> +                                                       num_ours, num_theirs);
> +                                       else
> +                                               sprintf(buf, "[ahead %d, behind %d]",
>                                                 num_ours, num_theirs);
>                                         v->s = xstrdup(buf);
>                                 }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 4f620bf..7ab8bf8 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -344,6 +344,15 @@ test_expect_success 'Check upstream:track format' '
>  '
>
>  cat >expected <<EOF
> +ahead 1
> +EOF
> +
> +test_expect_success 'Check upstream:track,nobracket format' '
> +       git for-each-ref --format="%(upstream:track,nobracket)" refs/heads >actual &&
> +       test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
>  >
>  EOF
>
> --
> 2.6.0
>



-- 
Regards,
Karthik Nayak
