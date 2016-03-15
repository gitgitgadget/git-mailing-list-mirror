From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 19/19] hack: watchman/untracked cache mashup
Date: Tue, 15 Mar 2016 19:31:00 +0700
Message-ID: <CACsJy8DGEQJmhxZpX3Zd=tGk_9T0n+ZhcaaEahaqFuh6NRvgSQ@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-20-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 13:32:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afo9g-0000rI-7a
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 13:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbcCOMcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 08:32:54 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34072 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcCOMcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 08:32:51 -0400
Received: by mail-lb0-f171.google.com with SMTP id k12so20471579lbb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sfOnGIbOxPfL6hJlkIXpP9+C4YMcOxZfkCU/42Bs1eU=;
        b=xOoQOqtTgDCI73sXY+q9P/pC90ZV7rAdvbw0y8olzmfN//wsbEsLNHYC5rlstlxeJ2
         yDh9LaROD5Kmh4lKI0ue6awjIususYiwAzPP7bL3AqKG6mqdaorvmEQ+U05K4wRoPgep
         BFl2pnaspm6EHnSL+NSkrNViD+za9RO66WrEYv/xMJt1/7TGiwuxbmnFyvOLw9Ydgyh+
         QtceAlHZ/wqUG7Tam0ZTMkBvPQFUpdOuTowvFkSAPQ2jTikAK9P2RNATxnHo8MS2zHfu
         1do/ybZj/N3pN9iTa05YSnotNH7RV2XQF82jWNpKAr0wMQSLvvV0QggSYgu44FAJrAVx
         CTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sfOnGIbOxPfL6hJlkIXpP9+C4YMcOxZfkCU/42Bs1eU=;
        b=iklOm8t1uifx2DaiOdHjtI7VIb55/E/fkN+2Ed8e0myE6TL4YCrLJ+L+5s0cHzpkbD
         lDup228U1aMnsvE/jtT+It1nPb9GjnaG0+kacOKWfo1ro25BDYhgTHa1tNm9fdrxSWfx
         otTqSBrjiEO7Kbda/Dkco2RHFk9cercIKgY0b8kb7rwk9fqnSHCkm77b920yypt6vsmM
         v5WMVWZiMD6zno/Q1lYCNDCMue6hnHnvjg70dYHUoB0McjHmGDPIsYXbVwOta0d7dIeB
         Ju6rYfwbYlwQN1efQz/Y0fpeB3S2VjDsaPADxH2I1HAvL/mzG9yQwW4Wp/1X1XkLLy1Z
         NRqg==
X-Gm-Message-State: AD7BkJLyChndg2RWB+KFxefSWE1xUet0vF1waULZpiywtFnpTB28cVtC4RjIMl2Lu3QlJ0YaSeRdWq37oRvwQg==
X-Received: by 10.112.150.133 with SMTP id ui5mr9538009lbb.12.1458045090088;
 Tue, 15 Mar 2016 05:31:30 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 15 Mar 2016 05:31:00 -0700 (PDT)
In-Reply-To: <1457548582-28302-20-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288852>

On Thu, Mar 10, 2016 at 1:36 AM, David Turner <dturner@twopensource.com> wrote:
>  static struct watchman_query *make_query(const char *last_update)
> @@ -60,8 +61,24 @@ static void update_index(struct index_state *istate,
>                         continue;
>
>                 pos = index_name_pos(istate, wm->name, strlen(wm->name));
> -               if (pos < 0)
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
>                         continue;
> +               }

So if we detect an updated file that's not in the index, we are
prepared to invalidate that path, correct? We may invalidate more than
necessary if that's true. Imagine a.o is already ignored. If it's
rebuilt, we should not need to update untracked cache.

What I had in mind (and argued with watchman devs a bit [1]) was
maintain the file list of each clock and compare the file list of
different clocks to figure out what files are added or deleted. Then
we can generate invalidation list more accurately. We need to keep at
least one file list corresponds to  the clock saved in the index. When
we get the refresh request, we get a new file list (with new clock),
do a diff then save the invalidation list as an extension. Once we
notice that new clock is written back in index, we can discard older
file lists. In theory we should not need to keep too many file lists,
so even if one list is big, it should not be a big problem.

I have a note with me about race conditions with this approach, but I
haven't remembered exactly why or how yet.. My recent thoughts about
it though, are race conditions when you do "git status" is probably
tolerable. After all if you're doing some I/O when you do git-status,
you're guaranteed to miss some updates.

[1] https://github.com/facebook/watchman/issues/65
-- 
Duy
