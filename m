From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rewrite bulk-checkin.c:finish_bulk_checkin() using strbuf
Date: Fri, 28 Feb 2014 04:15:50 -0500
Message-ID: <CAPig+cTXK6=LDPDii6RQyO1fiMCq0Rai5uO0JYOzunM=4c_nUw@mail.gmail.com>
References: <1393574305-24015-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJXz-0004O4-Jg
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaB1JPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:15:55 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:40571 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaB1JPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:15:51 -0500
Received: by mail-yh0-f47.google.com with SMTP id c41so362750yho.20
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 01:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5zjf2UhIqNjZSASgu/JUCvzBg4Ou0vQx2jA0RFq6Lrg=;
        b=u8jCzqNmagvNjMfo7uSG9wyglO2Pvd+skItFJ2+MEArpB54LKboIaR6IkuY2OBmyZA
         SkBvASfBzwTq0bZMNNSaGbzFdonwUhRg+jMnIk6RUqOOO0u9Ke9r2dmUNO04UyP/48/K
         JxlDXNCU9xPJ4plnZAtJ7RZLcfe1K5xkSKZ7U7jU29pL+M4DVUy/jaQORqo0rTRQWiM1
         1JY3mZeswNBFYLc/j169oWMMKDZjl1fogMbtUUUEc1wv5iQfNqn8sol8x47YPzUzT3tv
         0oPhYuGJNIRdyT1Cc38TpDNqCBeLmHikVGsSCDH/80feixewvAu/oLUR0rBENtEtT5Bd
         PBZA==
X-Received: by 10.236.87.174 with SMTP id y34mr202302yhe.141.1393578951017;
 Fri, 28 Feb 2014 01:15:51 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Fri, 28 Feb 2014 01:15:50 -0800 (PST)
In-Reply-To: <1393574305-24015-1-git-send-email-faiz.off93@gmail.com>
X-Google-Sender-Auth: EREUzoJlnlmRvSA7u9L9oBXCnlo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242917>

On Fri, Feb 28, 2014 at 2:58 AM, Faiz Kothari <faiz.off93@gmail.com> wrote:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
>
> Notes:
>     I finally got what's happening, and why the errors were caused.
>     packname is supposed to contain the complete path to the .pack file.
>     Packs are stored as /path/to/<SHA1>.pack which I overlooked earlier.
>     After inspecting what is happening in pack-write.c:finish_tmp_packfile()
>     which indirectly modifies packname by appending the SHA1 and ".pack" to packname
>     This is happening in these code snippets:
>         char *end_of_name_prefix = strrchr(name_buffer, 0);
>
>     and later
>         sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
>
>     name_buffer is packname.buf
>     Using const for the first argument of pack-write.c:finish_tmp_packfile()
>     doesnot raise any compile time warning or error and not any runtime errors,
>     since the packname.buf is on heap and has extra space to which more char can be written.
>     If this was not the case,
>         for e.g. passing a constant string and modifying it.
>         This will result in a segmentation fault.
> ---

This notes section is important to the ongoing email discussion,
however, it should be placed below the "---" line so that it does not
become part of the recorded commit message when the patch is applied
via "git am".

>  bulk-checkin.c |    8 +++++---
>  pack-write.c   |    2 +-
>  pack.h         |    2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 118c625..bbdf1ec 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -23,7 +23,7 @@ static struct bulk_checkin_state {
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
>         unsigned char sha1[20];
> -       char packname[PATH_MAX];
> +       struct strbuf packname = STRBUF_INIT;
>         int i;
>
>         if (!state->f)
> @@ -42,9 +42,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>                                          state->offset);
>                 close(fd);
>         }
> +       strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
> +       strbuf_grow(&packname, 40 + 5);

There are several problems with this. First, magic numbers 40 and 5
convey no meaning to the reader. At the very least, they should be
named constants or a comment should explain them. More seriously,
though, this code is fragile since it has far too intimate knowledge
of the inner workings of finish_tmp_packfile(). If the implementation
of finish_tmp_packfile() changes in the future such that it writes
more than 45 additional characters to the incoming buffer, this will
break.

Rather than coupling finish_bulk_checkin() and finish_tmp_packfile()
so tightly, consider finish_tmp_packfile() a black box which just
"does its job" and then propose ways to make things work without
finish_bulk_checkin() having to know how that job is done.

> -       sprintf(packname, "%s/pack/pack-", get_object_directory());
> -       finish_tmp_packfile(packname, state->pack_tmp_name,
> +       finish_tmp_packfile(packname.buf, state->pack_tmp_name,
>                             state->written, state->nr_written,
>                             &state->pack_idx_opts, sha1);
>         for (i = 0; i < state->nr_written; i++)
> diff --git a/pack-write.c b/pack-write.c
> index 605d01b..ac38867 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
>         return sha1fd(fd, *pack_tmp_name);
>  }
>
> -void finish_tmp_packfile(char *name_buffer,
> +void finish_tmp_packfile(const char *name_buffer,

This is misleading and fragile. By specifying 'const',
finish_tmp_packfile() promises not to modify the content of the
incoming name_buffer, yet it breaks this promise by modifying the
buffer through the non-const end_of_name_prefix variable (after
dropping the 'const' via strrchr()).

>                          const char *pack_tmp_name,
>                          struct pack_idx_entry **written_list,
>                          uint32_t nr_written,
