From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 2/3] submodule: implement `name` as a builtin helper
Date: Tue, 1 Sep 2015 15:01:16 -0400
Message-ID: <CAPig+cTqJwx27s7bNdn7g2m5UOK28JdnXcWWvkduQiuMyDZo1g@mail.gmail.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
	<1441131869-29474-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqo6-00056m-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 21:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbbIATBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 15:01:18 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33691 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbIATBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 15:01:17 -0400
Received: by qkdv1 with SMTP id v1so55898853qkd.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aP6scp8S7afJhYOGFkKGzw0dvWWBUFF9WbW8vN6GvmQ=;
        b=PHq7hXMZS1aZUoqhs5zjBYHLOqA8d3Ax7KbF4L91GcOKeQAJfNpQFcYiQK5SNMUAGX
         DM8ttzm/r1W1KvLrHfwhg7I4B6zce4bmYPmFeVrDb7romidQGEyuOgpcj/qZpM15Ru3g
         hZdKbvK1rYDfcKaj1vtkILvnNlZgKmcueNWFYIQVw9UoQfbHQNijUb5K1uy9dv7fLo5D
         wQdz/UDVBT2kEK629PPBYuMeZTDLLzVKz+0Q78yM1VCOUOjuXCradvxDfj3ljphcirqr
         Neuaj4cqvPM9duJb+vXERad74pWO95FZfUJMcVMZAYx/zHeDq2KnxwMKHmZpQOT0aShC
         R9Xw==
X-Received: by 10.13.201.130 with SMTP id l124mr30609659ywd.39.1441134076628;
 Tue, 01 Sep 2015 12:01:16 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Tue, 1 Sep 2015 12:01:16 -0700 (PDT)
In-Reply-To: <1441131869-29474-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: HvPnZ_2BjN2mRbYjy9YJgAuaE_I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277029>

On Tue, Sep 1, 2015 at 2:24 PM, Stefan Beller <sbeller@google.com> wrote:
> This implements the helper `module_name` in C instead of shell,

You probably want s/module_name/name/ or state more explicitly:

    Reimplement `module_name` shell function in C as `name`.

or something.

> yielding a nice performance boost.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 16d9abe..f5e408a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -102,6 +105,24 @@ static int module_list(int argc, const char **argv, const char *prefix)
> +static int module_name(int argc, const char **argv, const char *prefix)
> +{
> +       const struct submodule *sub;
> +
> +       if (argc != 2)
> +               usage("git submodule--helper module_name <path>\n");

Mentioned previously[1]:

usage(_("..."));
s/module_name/name/
s/\\n//

[1]: http://article.gmane.org/gmane.comp.version-control.git/276965

> +       gitmodules_config();
> +       sub = submodule_from_path(null_sha1, argv[1]);
> +
> +       if (!sub)
> +               die(N_("No submodule mapping found in .gitmodules for path '%s'"),
> +                   argv[1]);

s/N_/_/
s/No/no/

> +       printf("%s\n", sub->name);
> +
> +       return 0;
> +}
>
>  struct cmd_struct {
>         const char *cmd;
> @@ -110,6 +131,7 @@ struct cmd_struct {
>
>  static struct cmd_struct commands[] = {
>         {"list", module_list},
> +       {"name", module_name},
>  };
