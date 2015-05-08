From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri, 8 May 2015 15:45:24 -0400
Message-ID: <CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	<1431108819-6831-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 08 21:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoDC-00074c-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbbEHTp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 15:45:26 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34836 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbbEHTpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 15:45:25 -0400
Received: by igbyr2 with SMTP id yr2so29968131igb.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Fw8LNh6lla352xu6QmvAieVAgy6DuybO7xZOCbulwG8=;
        b=zRQnpbNTquyAuxt1ZHOjKqQlU+vaSDbdIU4zTao+0HU43NdbiNXdNvA83xACdMlL6i
         XxHnXsg15hAxOpaZDgqjE5Zf+o1apACW6X3y8L1HVqjGe/EbpOwS0Z7S0NMdQfR8MuI/
         vDrA54XCngzJ93OdtO83FHQfwlzPFuJ0bZZbU6+8b/wk8Rw7LMXFbd92BH3h2HjY8UUT
         xG3qBvpG6wdrYDdUqOvvO83QhfDPzxQLkNSqoBnPLfxhSteyMcKCeaSOKHDw3UmHBVKw
         ZMwYasrWtxWm+qN9Mt77nf6EhhH2x4bgJ3twNp0zO372H3AIhu1/aokvgUEEzymXaRei
         JZXQ==
X-Received: by 10.50.85.43 with SMTP id e11mr904780igz.15.1431114324608; Fri,
 08 May 2015 12:45:24 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 12:45:24 -0700 (PDT)
In-Reply-To: <1431108819-6831-2-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: 8-Lh7He3ouvzVq4m_3e1W2qwAUo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268652>

On Fri, May 8, 2015 at 2:13 PM,  <dturner@twopensource.com> wrote:
> Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
> when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
> is incompatible with G_S_ONLY_TO_DIE because the diagnosis that
> ONLY_TO_DIE triggers does not consider symlinks.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
> diff --git a/sha1_name.c b/sha1_name.c
> index 6d10f05..23863f7 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1434,6 +1434,12 @@ static int get_sha1_with_context_1(const char *name,
>                         new_filename = resolve_relative_path(filename);
>                         if (new_filename)
>                                 filename = new_filename;
> +                       if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
> +                               ret = get_tree_enty_follow_symlinks(tree_sha1,
> +                                       filename, sha1, oc->path, &oc->mode);
> +                               free(new_filename);
> +                               return ret;
> +                       }
>                         ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
>                         if (ret && only_to_die) {
>                                 diagnose_invalid_sha1_path(prefix, filename,
> @@ -1469,5 +1475,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
>
>  int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
>  {
> +       if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
> +               die(_("internal error: bad flags for get_sha1_with_context"));

There may not be much value in marking an "internal error" string for
translation.

>         return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
>  }
