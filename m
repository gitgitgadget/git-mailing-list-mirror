From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 08/16] Add watchman support to reduce index refresh cost
Date: Sun, 17 Apr 2016 12:36:32 +0700
Message-ID: <CACsJy8CbQfFdv8+v769zxzySTfkUcneakMLzzxNWFpKS-nF4gA@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com> <1460507589-25525-9-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.co>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 07:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arfOW-00020q-DN
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 07:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbcDQFhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 01:37:05 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33444 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbcDQFhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 01:37:04 -0400
Received: by mail-lf0-f54.google.com with SMTP id e190so185033834lfe.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OD7bS7H+cdhd0UXy3QgHw9uUcuu3fmmvOuy5F39mo7o=;
        b=OcwW1NQmMFMSUhV4tl6sU4gf77IyXeh6OOnuG46iHA87R1bd6RQePtT41DOBNoyfNg
         FPaC0/4LyEAubRqCFOhhreEOs365Y7310V9OIYi/Ih6YiUiiwMLbWMmZPxPA7Z2yxklF
         Nb2VxXQazkr87zmrOYQhyX4FTRDw2wAKi++hwIp4D/aJ5/3BKg9FYdSTW9JSbq2gE2Pc
         eT+DL5i+7CgNtqZ9aw4trE/IxOWZjvLkaryxgh3gdGmZ0JbPKBevo75WrvnV3En6O+s8
         wAKzmWjt0PGMvbL77T0X+M0tUtR5FB0QHfXui5ALQdFOA0hXBgqRLhn51NK1+JZtcXsW
         l3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OD7bS7H+cdhd0UXy3QgHw9uUcuu3fmmvOuy5F39mo7o=;
        b=TFk5KF0ZZUDquAhUwtTIuDWYESmxZ6FxC3rX8w7Y0jb+5Ssg8cIqcM0bwoje7tpvLu
         z9ZeOgvEGKkEcnX6QL8+us7BhPBCM+K4FOtitH24cNaKI8mAaHPlC+WJSr8xOKllAynG
         JqcIjvsfBStd1nf0aK843/U0zLu+e5/So9hGn/vsyvgqBgJaGc7M/5ggnMbGv2WzXsH+
         yj3CW5rLgNxDmnK8vvL8Lt5evayx5vf0jv/XurrRm5U+TOsbZBMvf/QniGzSJWdZ1dbR
         lfJAY7P6d0RzMVLlaSTcgdRqbLJTFpGiF7TVBM7Y7IUn8Lr8UBhjK2liy5+IJCePUGvz
         V1IA==
X-Gm-Message-State: AOPr4FWfPOw8cDPIvjxmY+XaA1Rq/RhZS5Fb0gSmKlcVa212dsAQjBrC26YobHx4RsWWqTNfjdEPoy6l0pttWA==
X-Received: by 10.25.152.147 with SMTP id a141mr12187832lfe.83.1460871422020;
 Sat, 16 Apr 2016 22:37:02 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sat, 16 Apr 2016 22:36:32 -0700 (PDT)
In-Reply-To: <1460507589-25525-9-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291744>

On Wed, Apr 13, 2016 at 7:33 AM, David Turner <dturner@twopensource.com> wrote:
> +static void update_index(struct index_state *istate,
> +                        struct watchman_query_result *result)
> +{
> +       int i;
> +
> +       if (result->is_fresh_instance) {
> +               /* let refresh clear them later */
> +               for (i = 0; i < istate->cache_nr; i++)
> +                       istate->cache[i]->ce_flags |= CE_WATCHMAN_DIRTY;
> +               goto done;
> +       }
> +
> +       for (i = 0; i < result->nr; i++) {
> +               struct watchman_stat *wm = result->stats + i;
> +               int pos;
> +
> +               if (S_ISDIR(wm->mode) ||
> +                   !strncmp(wm->name, ".git/", 5) ||
> +                   strstr(wm->name, "/.git/"))
> +                       continue;
> +
> +               pos = index_name_pos(istate, wm->name, strlen(wm->name));
> +               if (pos < 0) {
> +                       if (istate->untracked) {
> +                               char *name = xstrdup(wm->name);
> +                               char *dname = dirname(name);
> +
> +                               /*
> +                                * dirname() returns '.' for the root,
> +                                * but we call it ''.
> +                                */
> +                               if (dname[0] == '.' && dname[1] == 0)
> +                                       string_list_append(&istate->untracked->invalid_untracked, "");
> +                               else
> +                                       string_list_append(&istate->untracked->invalid_untracked,
> +                                                          dname);
> +                               free(name);
> +                       }
> +                       continue;
> +               }
> +               /* FIXME: ignore staged entries and gitlinks too? */
> +
> +               istate->cache[pos]->ce_flags |= CE_WATCHMAN_DIRTY;
> +       }
> +
> +done:
> +       free(istate->last_update);
> +       istate->last_update    = xstrdup(result->clock);

I made a note in private that, because we update this field every
time, the index must be rewritten every time with new WAMA extension,
which results in worse performance when the index file is big and
update cost is really high (SHA-1 hashing again).

What I did not notice was, if we detect no changes since the last
clock here (result->nr == 0 _or_ no new entries marked DIRTY), we
could skip this clock update here. That results in no changes in index
(on read-cache side), so no index update, no hashing cost.
-- 
Duy
