From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 30 Jun 2015 03:34:10 -0400
Message-ID: <CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	<1435609076-8592-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 09:34:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9q3e-0002QX-9K
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 09:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbbF3HeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 03:34:13 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33288 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbF3HeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 03:34:11 -0400
Received: by ykdv136 with SMTP id v136so1442277ykd.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XoE6YzvN+hN74h4sS1AgSrzXE8yvHYUUarm8njvGirw=;
        b=ItEnOlU5JN3YZ6NmzDgzgEg6T3FZQWN1UbDervQqTJmqHJNFsDjTcLQV+yVzk4RV73
         VQ2u+w+GWmZ0WWJPeL85rXgxqPBJFke+CKp0w4UUYSbgYsy/baXETtuzcbbGB/jCw+Sk
         GWyaVIscsf0jKzLnRUMnIUdlX3N+VkgeG/TjBDE63WvuEtNRiGaKPC6NNr4xYD24Ta69
         QMSvF93kASQdugdMqgbsuCAzy3x/9ckaCZfFWkR4vqRRsbEuYAWEJPFCmvcjUSVHgqLd
         rNjoWZOGvh5nNVBsCYEl4cJFQWrk91lSDCg/nIU/u4VphRvkEZlyZpI+CT+d/L+u3cwx
         oKSQ==
X-Received: by 10.170.97.9 with SMTP id o9mr23597245yka.84.1435649650846; Tue,
 30 Jun 2015 00:34:10 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 00:34:10 -0700 (PDT)
In-Reply-To: <1435609076-8592-7-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: gJ0sW39zlte5L5qXPR3G814KUdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273033>

On Mon, Jun 29, 2015 at 4:17 PM, David Turner <dturner@twopensource.com> wrote:
> These are necessary because alternate ref backends might store reflogs
> somewhere other than .git/logs.  Code that now directly manipulates
> .git/logs should instead go through git-reflog.
>
> In a moment, we will use these functions to make git stash work with
> alternate ref backends.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index c2eb8ff..3080865 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -13,6 +13,10 @@ static const char reflog_expire_usage[] =
> +static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
> +{
> +       int i, status = 0, start = 0;
> +       struct strbuf err = STRBUF_INIT;
> +
> +       for (i = 1; i < argc; i++) {
> +               const char *arg = argv[i];
> +               if (!strcmp(arg, "--")) {
> +                       i++;
> +                       break;
> +               }
> +               else if (arg[0] == '-')
> +                       usage(reflog_create_usage);
> +               else
> +                       break;
> +       }
> +
> +       start = i;
> +
> +       if (argc - start < 1)
> +               return error("Nothing to create?");
> +
> +       for (i = start; i < argc; i++) {
> +               if (check_refname_format(argv[i], REFNAME_ALLOW_ONELEVEL))
> +                       die("invalid ref format: %s", argv[i]);
> +       }
> +       for (i = start; i < argc; i++) {
> +               if (safe_create_reflog(argv[i], &err, 1)) {
> +                       error("could not create reflog %s: %s", argv[i],
> +                             err.buf);
> +                       status = 1;
> +                       strbuf_release(&err);

This feels a bit dirty. While it's true that the current
implementation of strbuf_release() re-initializes the strbuf (so
you're not technically wrong by re-using it), that's an implementation
detail; and indeed, the strbuf_release() documentation says:

    Release a string buffer and the memory it used. You should not
    use the string buffer after using this function, unless you
    initialize it again.

Alternatives would be strbuf_reset() or declaring and releasing the
strbuf within the for-loop scope.

> +               }
> +       }
> +       return status;
> +}
