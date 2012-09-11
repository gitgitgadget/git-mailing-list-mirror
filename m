From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] clear_child_for_cleanup must correctly manage children_to_clean
Date: Tue, 11 Sep 2012 17:30:31 +0200
Message-ID: <CABPQNSYEiw2hw-S5x5YYJWrWYR6hNWBqudvHR=fxoHf0380jsA@mail.gmail.com>
References: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: David Gould <david@optimisefitness.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 17:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSQv-0008JE-69
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 17:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756Ab2IKPbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 11:31:14 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:44915 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2IKPbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 11:31:13 -0400
Received: by vcbfy27 with SMTP id fy27so768923vcb.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qJdO7U//5+EU92Vsx7NlXOWRG+01KVhKNZiAn/6YVv4=;
        b=Em/UoAm6h2quHYmB2zAxAnPvsIPsHKilwXDkTl+PGg5ErRImSMHdI8THHFLwDPiNrN
         D3dFZWexrdRyqq9Ftg+tYqIe+NT42rKcUKqyTL1bTgy0OI+QAVn7MVrfm2OSKCWysmvW
         4k6lCx4Ywk441HeFQ/jI8faiY9/al1L367wG6NafRdC1nAd8B/55ioUEMbfUFiBYLwiO
         I3GWeeNjSP7h5y7BWlhZASXcpEDJvtcwaTcQEsClybaG/aiNUfd/yLGtOgMXpV+1EIz4
         v5X4laEOKCYWWE84h9UXIkSunz9PSrYLr8wwC7ckr3eMEgDWvvhxBbcmcZNb9o6fDV77
         4h3g==
Received: by 10.220.150.15 with SMTP id w15mr26126795vcv.68.1347377472124;
 Tue, 11 Sep 2012 08:31:12 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Tue, 11 Sep 2012 08:30:31 -0700 (PDT)
In-Reply-To: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205236>

On Tue, Sep 11, 2012 at 4:32 PM, David Gould <david@optimisefitness.com> wrote:
> Iterate through children_to_clean using 'next' fields but with an
> extra level of indirection. This allows us to update the chain when
> we remove a child and saves us managing several variables around
> the loop mechanism.
> ---
>  run-command.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index f9922b9..c42d63b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -53,13 +53,13 @@ static void mark_child_for_cleanup(pid_t pid)
>
>  static void clear_child_for_cleanup(pid_t pid)
>  {
> -       struct child_to_clean **last, *p;
> +       struct child_to_clean **pp;
>
> -       last = &children_to_clean;
> -       for (p = children_to_clean; p; p = p->next) {
> -               if (p->pid == pid) {
> -                       *last = p->next;
> -                       free(p);
> +       for (pp = &children_to_clean; *pp; pp = &(*pp)->next) {
> +               if ((*pp)->pid == pid) {
> +                       struct child_to_clean *clean_me = *pp;
> +                       *pp = clean_me->next;
> +                       free(clean_me);
>                         return;
>                 }
>         }
> --
> 1.7.9.5
>

Looks good to me. Thanks :)
