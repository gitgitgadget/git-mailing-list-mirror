From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 3/4] bundle: don't leak an fd in case of early return
Date: Wed, 30 Mar 2016 13:41:16 -0400
Message-ID: <CAPig+cSE5wVNNwiwkYoOXnfDKUO3tBKqUUbqBHPCTA5ibj-kNg@mail.gmail.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:41:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alK7T-0007RT-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbcC3RlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:41:19 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36496 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbcC3RlR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:41:17 -0400
Received: by mail-vk0-f50.google.com with SMTP id z68so70795375vkg.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=PnbEj5QX1Ag8lTjtF46or0yG63Zd1LUz/Onjr6m9Usg=;
        b=uIRi5BOfqH6wCzgHqahxdCiScav7VeF/aKi33rkODxadf5zWdejyj2bvUucagbYppp
         1W7DUdMEaSZwekjj/U0Y12PTr5eGIFFAOaK85UpQfOv5mHt2ABk9Qru1zjEXi8XdapaT
         CSTdx8dAuvbf+5AM6fiOxPH0VrVB60JygjOx9szecF2Ee7LQIFkjAZ7lo3SHfnwGK97D
         wRCqQiOUpbf4dj4L3SsOWEsDfJFEF2bWuecMcnZ+qoyUtbiEEvJG2Vw8ireCNU6Fb/vY
         6IzZTk8k/dtu6ycXFM6IbOLZffAImTYSPwZ0rx5sUifQAJxZpU2PmlXtVf01cdTFit5m
         34Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PnbEj5QX1Ag8lTjtF46or0yG63Zd1LUz/Onjr6m9Usg=;
        b=ZoTjuJhtlHs6dPBHqSMloxO9OExJO2mJrOz7xmFwcb4dxMaWjTbzxIx0RR+46NN8ee
         QsMQz6OOLb14Q22/mWy5aNLw3Oqn0y6ehYKVlNwtcF79UTpkvt8Z4eJLgC53C8ZOKhCD
         aJe/XH58tmhgU/DUtE5ZkSsojhQMoZPGoHBHFKG9YvRJ1+8fK853ccNrAM2kFoC/FXwu
         eH1Xfm5PQvLk85pVSFv/l+uKnMMRv/oNU02G0JtaQfKj6RMn6odxs0gDfxmge1OKfbIz
         iUJjJRkwjZQoWnZOcoc30hfwOroDD+WS1Bp3B1jDXnQSWnVZUU6SccNtfqcvLqyErv5S
         e7rw==
X-Gm-Message-State: AD7BkJKDvv2eY9vWAY8CSZJPDeNDn382XrKrASpMxSvU+cGe2mfRQP2lGBEsO46P09pZVwJVpBB1uVNp6HRgtQ==
X-Received: by 10.159.38.49 with SMTP id 46mr5567043uag.139.1459359676722;
 Wed, 30 Mar 2016 10:41:16 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 30 Mar 2016 10:41:16 -0700 (PDT)
In-Reply-To: <1459357518-14913-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: FD5EmZ0nWGEp_kWVRpWbR_aRslk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290331>

On Wed, Mar 30, 2016 at 1:05 PM, Stefan Beller <sbeller@google.com> wrote:
> In successful operation `write_pack_data` will close the `bundle_fd`,
> but when we exit early, we need to take care of the file descriptor
> as well as the lock file ourselves. The lock file may be deleted at the
> end of running the program, but we are in library code, so we should
> not rely on that.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/bundle.c b/bundle.c
> @@ -435,30 +436,40 @@ int create_bundle(struct bundle_header *header, const char *path,
>
>         /* write prerequisites */
>         if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
> -               return -1;
> +               goto err;
>
>         argc = setup_revisions(argc, argv, &revs, NULL);
>
> -       if (argc > 1)
> -               return error(_("unrecognized argument: %s"), argv[1]);
> +       if (argc > 1) {
> +               ret = error(_("unrecognized argument: %s"), argv[1]);
> +               goto err;
> +       }
>
>         object_array_remove_duplicates(&revs.pending);
>
>         ref_count = write_bundle_refs(bundle_fd, &revs);
>         if (!ref_count)
>                 die(_("Refusing to create empty bundle."));
> -       else if (ref_count < 0)
> -               return -1;
> +       else if (ref_count < 0) {
> +               if (!bundle_to_stdout)
> +                       close(bundle_fd);

Why is this close() here considering that it gets closed by the 'err' path?

> +               goto err;
> +       }
>
>         /* write pack */
>         if (write_pack_data(bundle_fd, &revs))
> -               return -1;
> +               goto err;
>
>         if (!bundle_to_stdout) {
>                 if (commit_lock_file(&lock))
>                         die_errno(_("cannot create '%s'"), path);
>         }
>         return 0;
> +err:
> +       if (!bundle_to_stdout)
> +               close(bundle_fd);
> +       rollback_lock_file(&lock);
> +       return ret;
>  }
