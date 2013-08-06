From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [[TIG][PATCH] 1/3] Add log_select function to find commit from
 context in log view
Date: Mon, 5 Aug 2013 23:54:00 -0400
Message-ID: <CAFuPQ1+5O+dBCjHYu2soAtNKiNxofAuWSVEeKBj=yu+kRGggCw@mail.gmail.com>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in> <1375489399-11618-2-git-send-email-a.kumar@alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Tue Aug 06 05:54:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6YLr-0006at-4a
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 05:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453Ab3HFDyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 23:54:22 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:54814 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab3HFDyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 23:54:21 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so8011451oag.38
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=5vNjiMAgeCVNwGKxwOCmLecGAhXHrTc+D9sDYDVx58I=;
        b=lt05p2FTETUP6TeBVp/A4myQz1/WbjGQ7kCxnO0sJjY8peHO2UxIgzk0qMeXCFFvkm
         03ZnZC3KjgoctBnUpeQVgGPmxo8Zi2pk8NLlIY6YWl6xcOeiBuPwaVsmlY85ZMxi1Y6y
         yJtT/Q7azHOIHURH3YtIt32pGSiIrewD4poP4u4sTDjFV9knwu/D0ykr2HvgdMoWG9Uu
         znohVo4grmNwUTVrBbnkM9TXBHZuFNObCjbvJTY/d0F+v+2qWql5yeu5JgAxEmc7jzN1
         9ZdfoOTZUwjxQFwH07CKNJA9bD/S7gWzX1Mcnx2uxZQn/ufTDOzCTtf5o6lL/L4ThgIl
         +gmg==
X-Received: by 10.182.43.138 with SMTP id w10mr16176307obl.82.1375761260498;
 Mon, 05 Aug 2013 20:54:20 -0700 (PDT)
Received: by 10.76.69.169 with HTTP; Mon, 5 Aug 2013 20:54:00 -0700 (PDT)
In-Reply-To: <1375489399-11618-2-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Google-Sender-Auth: bU5ezTuSpnhZCXuz37-JDGKCVnw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231715>

On Fri, Aug 2, 2013 at 8:23 PM, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> diff --git a/tig.c b/tig.c
> index 72f132a..dd4b0f4 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -4427,11 +4454,30 @@ log_open(struct view *view, enum open_flags flags)
>  static enum request
>  log_request(struct view *view, enum request request, struct line *line)
>  {
> +       struct log_state *state = (struct log_state *) view->private;
> +
>         switch (request) {
>         case REQ_REFRESH:
>                 load_refs();
>                 refresh_view(view);
>                 return REQ_NONE;
> +
> +       case REQ_MOVE_UP:
> +       case REQ_PREVIOUS:
> +               if (line->type == LINE_COMMIT && line->lineno > 1) {
> +                       /* We are at a commit, and heading upward. We
> +                          force log_select to find the previous
> +                          commit above, from the context. */
> +                       state->update_commit_ref = TRUE;
> +               }
> +               return pager_request(view, request, line);
> +
> +       case REQ_MOVE_PAGE_UP:
> +       case REQ_MOVE_PAGE_DOWN:
> +               /* We need to figure out the right commit again. */
> +               state->update_commit_ref = TRUE;
> +               return pager_request(view, request, line);
> +
>         default:
>                 return pager_request(view, request, line);
>         }

I forgot to mention there is one use case this doesn't currently
handle, namely jumping to a specific line using ':<number>'. Other
than detecting this by tracking the current line number in log_state I
haven't come up with a good way to detect that a recalculation is
required.
