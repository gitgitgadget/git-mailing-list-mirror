From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] notes.c: replace git_config with git_config_get_string
Date: Wed, 25 Jun 2014 04:06:08 -0400
Message-ID: <CAPig+cR-fdXCe+9e89++KrLPqfPkbSi4FeU_gD=fwfrMnH-a2Q@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-5-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 10:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WziEO-00071k-BP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 10:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbaFYIGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 04:06:52 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:39307 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbaFYIGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 04:06:09 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so938458yho.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 01:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JvDjMagCG+JhKmucZxH3HYUBgQi3vmbRDWPZtJad/54=;
        b=VJX4Thuk/QVlZFXTDp2mHXVvcTpcXBRGdjKfG9m9wlSDo9SfIbWo5X0ErTYizqUzD4
         VxIqOfW8KVgDzkcj6jy736T0X4lMmat5tAKJSPQ3wCA//9YMODVRqtfS8cBFtXJJbMfN
         0s1xvYOmzVsOt/fs5T9G4lWk798sDy1+or0vG1ni7O+wQC+NIV0SYZIh4MJ/n4Qh4+GS
         6PdkTBQrm+HXkDb22jdsyolFPxP9EyQCAX8xvfzjomldwASr+RNA/2KMobXzTDJAqcOW
         8v3auxMXQj218Jg1eH3vE1pwjNT6R80224NHJ4U8LqwJzVNJw1Ia8nVHd2E7rNSXnFCH
         mvoA==
X-Received: by 10.236.13.46 with SMTP id a34mr9514609yha.28.1403683568594;
 Wed, 25 Jun 2014 01:06:08 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Wed, 25 Jun 2014 01:06:08 -0700 (PDT)
In-Reply-To: <1403520105-23250-5-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: _zPUCdCTB2TxV3IAOpQCmaanAzk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252438>

On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Use git_config_get_string instead of git_config to take advantage of
> the config hash-table api which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  notes.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index 5fe691d..fc92eec 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -961,19 +961,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
>         free(globs_copy);
>  }
>
> -static int notes_display_config(const char *k, const char *v, void *cb)
> -{
> -       int *load_refs = cb;
> -
> -       if (*load_refs && !strcmp(k, "notes.displayref")) {
> -               if (!v)
> -                       config_error_nonbool(k);
> -               string_list_add_refs_by_glob(&display_notes_refs, v);
> -       }
> -
> -       return 0;
> -}
> -
>  const char *default_notes_ref(void)
>  {
>         const char *notes_ref = NULL;
> @@ -1041,6 +1028,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs)
>  void init_display_notes(struct display_notes_opt *opt)
>  {
>         char *display_ref_env;
> +       const char *value;
>         int load_config_refs = 0;
>         display_notes_refs.strdup_strings = 1;
>
> @@ -1058,7 +1046,11 @@ void init_display_notes(struct display_notes_opt *opt)
>                         load_config_refs = 1;
>         }
>
> -       git_config(notes_display_config, &load_config_refs);
> +       if (load_config_refs && !git_config_get_string("notes.displayref", &value)) {
> +               if (!value)
> +                       config_error_nonbool("notes.displayref");
> +               string_list_add_refs_by_glob(&display_notes_refs, value);

Although you correctly diagnose a NULL 'value', you then invoke
string_list_add_refs_by_glob() with that NULL, which will result in a
crash.

This is not a new error. It dates back to 894a9d33 (Support showing
notes from more than one notes tree; 2010-03-12), but your rewrite
should not retain the brokenness. Whether you fix it in this patch or
a lead-in fix-up patch, the fix deserves mention in the commit
message.

> +       }
>
>         if (opt) {
>                 struct string_list_item *item;
> --
> 1.9.0.GIT
