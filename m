From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] upload-pack: Optionally allow fetching reachable sha1
Date: Tue, 12 May 2015 18:01:10 -0400
Message-ID: <CAPig+cQe3=Y15+RBZCxry7-78kbNL6H0PfdYs=OV_DMifOWxaA@mail.gmail.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
	<1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
	<1431465265-18486-3-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 00:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsIEm-0005rm-QJ
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 00:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbbELWBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 18:01:12 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33604 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933987AbbELWBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 18:01:11 -0400
Received: by igbpi8 with SMTP id pi8so103559162igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/oCstNU1xhsKBR8wbdrc3p/wVhudSOn/CkoQdG0TW7o=;
        b=NY+dpcqGmQk+3ANB6lKrWbsh4PZgxrhniM4R5joJPdjhzRt3G4zjkNgPij8RKvyags
         34dw4vF6tyfGPjmuATIYHm8Jbt3Hhuue6zp6vT6gD0D9sOaPbC4j2Gq9Teg6913/G9lE
         4ey/8QKTKy2CZdjibjFejmHoOHFXy6o6i1qPP3rsByKvWnSGPp9d9a1OLRoxxIBZ0dcw
         xzn2zjhf1+0iNHAkqrB8QQ4FEhaNnTa0O70O+oNrSOebXCv6xSy1bsZAQzKajEOGk6H/
         uz2NQq2epdt9i5jkNpnZ659+bEJmfVkq3flhkZzpiWDcbKfIUjTqkMVAHTMu7rc1g0RW
         9caQ==
X-Received: by 10.42.146.202 with SMTP id k10mr5573838icv.34.1431468071011;
 Tue, 12 May 2015 15:01:11 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 12 May 2015 15:01:10 -0700 (PDT)
In-Reply-To: <1431465265-18486-3-git-send-email-fredrik.medley@gmail.com>
X-Google-Sender-Auth: v1xaOzP6iWI3MItFJEFbP43JIEI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268899>

On Tue, May 12, 2015 at 5:14 PM, Fredrik Medley
<fredrik.medley@gmail.com> wrote:
> With uploadpack.allowReachableSHA1InWant configuration option set on the
> server side, "git fetch" can make a request with a "want" line that names
> an object that has not been advertised (likely to have been obtained out
> of band or from a submodule pointer). Only objects reachable from the
> branch tips, i.e. the union of advertised branches and branches hidden by
> transfer.hideRefs, will be processed. Note that there is an associated
> cost of having to walk back the hstory to check the reachability.

Mentioned previously[1]: s/hstory/history/

> This feature can be used when obtaining the content of a certain commit,
> for which the sha1 is known, without the need of cloning the whole
> repository, especially if a shallow fetch is used. Useful cases are e.g.
> repositories containing large files in the history, fetching only the
> needed data for a submodule checkout, when sharing a sha1 without telling
> which exact branch it belongs to and in Gerrit, if you think in terms of
> commits instead of change numbers. (The Gerrit case has already been
> solved through allowTipSHA1InWant as every Gerrit change has a ref.)
>
> Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2b86fe6..ffc4cf4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2538,6 +2538,12 @@ uploadpack.allowTipSHA1InWant::
>         of a hidden ref (by default, such a request is rejected).
>         see also `uploadpack.hideRefs`.
>
> +uploadpack.allowReachableSHA1InWant::
> +       Allow `upload-pack` to accept a fetch request that asks for an
> +       object that is reachable from any ref tip. However, note that
> +       calculating     object reachability is computationally expensive.

Mentioned previously[1]: s/\s+/ /

> +       Defaults to `false`.
> +
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 77174f9..6c63d8e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -545,7 +547,7 @@ static void filter_refs(struct fetch_pack_args *args,
>         }
>
>         /* Append unmatched requests to the list */
> -       if (allow_request_with_bare_object_name & ALLOW_TIP) {
> +       if (allow_request_with_bare_object_name & (ALLOW_TIP | ALLOW_REACHABLE)) {

Wrap this in extra parentheses to avoid compilation warnings:

    if ((foo & (bar | baz))) {

>                 for (i = 0; i < nr_sought; i++) {
>                         unsigned char sha1[20];
>

[1]: http://article.gmane.org/gmane.comp.version-control.git/268428
