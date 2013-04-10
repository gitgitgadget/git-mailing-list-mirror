From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] rm: delete .gitmodules entry of submodules removed
 from the work tree
Date: Thu, 11 Apr 2013 03:54:11 +0530
Message-ID: <CALkWK0mzbgFP7JnCP7=NCA1guGg8ayF-mn7WdJEZyYX5hgePFw@mail.gmail.com>
References: <5165E1CC.7090004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>,
	John Keeping <john@keeping.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 00:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ3Rp-0007bb-5c
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 00:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935359Ab3DJWYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 18:24:53 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:39273 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935132Ab3DJWYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 18:24:52 -0400
Received: by mail-ia0-f174.google.com with SMTP id r13so869266iar.33
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=g7FLo3ZwTGA2p30zsBjtbMonYuYdRbdfWAcehg4g+uI=;
        b=s71zZDYQWQ+gc2T/GPj8CtYiD5+Qa2g7YxOfesJQgaMejka0TaZxBkW/6MW4UShVs7
         2mkwl/ANGnOUpOZEvbgYnll/3dzwkrryFOcmjbe2TZwZIou29a28g2Phs33o9GjwaQXb
         OovWQ9AFphmfpNHPq3WsK109Q7MnD4SUyitCPaQLpIc9IUqeqvk9VLaWyyMzf1xIGLy+
         MHispART/6FPYJKzlGviK9ODPn8qCF9f5SIQHV94s0vBW7TahKXDxlM3yp0Pt3+lH4ag
         bMhTDIVBagBhEhMbtGdqaXpo4C+UirFWpsZP35cagC+E721yRzr/yTL8SGl+kY+4Z733
         TUUQ==
X-Received: by 10.50.117.3 with SMTP id ka3mr13799348igb.107.1365632692132;
 Wed, 10 Apr 2013 15:24:52 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 15:24:11 -0700 (PDT)
In-Reply-To: <5165E1CC.7090004@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220789>

Jens Lehmann wrote:
>  builtin/rm.c               | 14 +++++++--
>  submodule.c                | 31 ++++++++++++++++++++
>  submodule.h                |  1 +
>  t/t3600-rm.sh              | 72 ++++++++++++++++++++++++++++++++++++++++++----
>  t/t7400-submodule-basic.sh | 14 +++------
>  t/t7610-mergetool.sh       |  6 ++--
>  6 files changed, 117 insertions(+), 21 deletions(-)

Should be very similar to your mv series, as it's essentially the same
challenge.

> diff --git a/submodule.c b/submodule.c
> index 8ce6a7d..6b01a02 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -63,6 +63,37 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
>         return 0;
>  }
>
> +/*
> + * Try to remove the "submodule.<name>" section from .gitmodules where the
> + * given path is configured.
> + */
> +int remove_path_from_gitmodules(const char *path)
> +{
> +       struct strbuf sect = STRBUF_INIT;
> +       struct string_list_item *path_option;
> +
> +       if (!file_exists(".gitmodules")) /* Do nothing whithout .gitmodules */
> +               return -1;

- Why are you doing this here?  Is there no initialization function?
- Why are you hard-coding ".gitmodules" instead of using a simple #define?
- Why are you returning -1, instead of an error() with a message?

> +       if (gitmodules_is_unmerged)
> +               die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));

Again, no sanity-checking initialization code?

> +       path_option = unsorted_string_list_lookup(&config_name_for_path, path);
> +       if (!path_option) {
> +               warning(_("Could not find section in .gitmodules where path=%s"), path);
> +               return -1;
> +       }

Repetition from your mv series.  Why copy-paste, when you can factor
it out into a function?

Why are you calling warning() and then returning -1? (does return
warning() not work?)  How is it a warning if you just stop all
processing and return?

> +       strbuf_addstr(&sect, "submodule.");
> +       strbuf_addstr(&sect, path_option->util);

What do you have against strbuf_addf()?  I noticed a lot of ugly
addstr() calls in your mv series also.

Why is your variable named "sect"?  Did you mean "section"?

> +       if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {

You hardcoded ".gitmodules" again!

> +               /* Maybe the user already did that, don't error out here */
> +               warning(_("Could not remove .gitmodules entry for %s"), path);
> +               return -1;

Maybe the user already did what?  What happens if she didn't do "it"
and failure is due to some other cause?

Thanks.
