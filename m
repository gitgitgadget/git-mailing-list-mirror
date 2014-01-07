From: Brodie Rao <brodie@sf.io>
Subject: Re: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs
 is false
Date: Mon, 6 Jan 2014 19:35:04 -0800
Message-ID: <CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 07 04:35:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0NRg-0007mX-IH
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 04:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbaAGDfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 22:35:06 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64095 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbaAGDfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 22:35:05 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so18983499pde.13
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 19:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sf.io; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sKnG+sP4Tg5up6p1iXQjOooc6P4mxMsotEMvtkYwMYg=;
        b=rIvlexWEok/E9/CXDd7t/pNtsEExrGWca8aKsTAhC90R3M+QOQqFFzDPTBxLd06ePT
         93qoxroRKPK9DGdyqr86hZOw+SGSMNUHacK+ULL9Gd1XI90lsb3GtuPswnGtiU4JHdKd
         5q3aLD+xgg9Q9FECMQJ12O4QyTf4HJufwfs6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sKnG+sP4Tg5up6p1iXQjOooc6P4mxMsotEMvtkYwMYg=;
        b=XIV1hSk3mVFxGc1mhH7EolkbbwabFCxPa8/vNfoFSIX+NHE+TLvTiM840nlnbgON5W
         WeW+TbW6C+0hH/KsIMIdiYlpFCyQ/pWhb8qlBacQ9OHP4Y2Au6pB12FrReM8ZGcC4QXj
         aE2zNo9hZBk+FX8E7sdyVxWPhCGLdap8ht6VbSpLn0nW26yqIv+s0d6otZQSB+w7o5aH
         ni9/PUk/AEwkQ1LPtyQMfrZo4r9f27LkxEJHFfu97jUdzQ+U4cqfErGsrF0P/1qUUtlw
         bUnxnllqS6wZZlRtH6unUK3ENIm5fYDpmPBMIGSk85pYVzk+HaXQAZy5liMV41MIPUKi
         JRUQ==
X-Gm-Message-State: ALoCoQk8L9WEU9PtBg5z78kthdBmZE4yKY6+d/Us4hheyokzoU1ZMETmePySrX4gC9oNLvYt1rb7
X-Received: by 10.66.248.227 with SMTP id yp3mr2234871pac.116.1389065704191;
 Mon, 06 Jan 2014 19:35:04 -0800 (PST)
Received: by 10.68.96.228 with HTTP; Mon, 6 Jan 2014 19:35:04 -0800 (PST)
X-Originating-IP: [12.250.157.102]
In-Reply-To: <1389065521-46331-1-git-send-email-brodie@sf.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240096>

On Mon, Jan 6, 2014 at 7:32 PM, Brodie Rao <brodie@sf.io> wrote:
> This change ensures get_sha1_basic() doesn't try to resolve full hashes
> as refs when ambiguous ref warnings are disabled.
>
> This provides a substantial performance improvement when passing many
> hashes to a command (like "git rev-list --stdin") when
> core.warnambiguousrefs is false. The check incurs 6 stat()s for every
> hash supplied, which can be costly over NFS.

Forgot to add:

Signed-off-by: Brodie Rao <brodie@sf.io>

> ---
>  sha1_name.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index e9c2999..10bd007 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -451,9 +451,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         int at, reflog_len, nth_prior = 0;
>
>         if (len == 40 && !get_sha1_hex(str, sha1)) {
> -               if (warn_on_object_refname_ambiguity) {
> +               if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
>                         refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
> -                       if (refs_found > 0 && warn_ambiguous_refs) {
> +                       if (refs_found > 0) {
>                                 warning(warn_msg, len, str);
>                                 if (advice_object_name_warning)
>                                         fprintf(stderr, "%s\n", _(object_name_msg));
> --
> 1.8.3.4 (Apple Git-47)
>
