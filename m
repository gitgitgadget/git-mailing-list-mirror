From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] builtin-commit: Fix git-commit honoring status.color
Date: Tue, 20 Nov 2007 02:26:59 +0800
Message-ID: <46dff0320711191026l6d749886y4fd3879f555c6107@mail.gmail.com>
References: <1195405834-1469-1-git-send-email-pkufranky@gmail.com>
	 <7vejenuy4i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 19:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuBMO-0002t7-Hv
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 19:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbXKSS1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 13:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXKSS1D
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 13:27:03 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:7512 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466AbXKSS1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 13:27:00 -0500
Received: by py-out-1112.google.com with SMTP id u77so5957978pyb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 10:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i1MmQVjTjGi75kpsKQ0H7xTvzDVhqwNKT/Iz1ZSPkZk=;
        b=PjIBxqriNL7EGvym95Q7Jf4ZKQxYa3CYupKqUgEbsBQSY7bSVtdE40Pah99pOyEqeVJOMZXnHckgXeCH3eG+f8WImnjjN5IDiz8FUSigFRDMAawu5sJnwcLssxbrGAgsk6boMOqHdOzYND1M1lh4rCv34wR12TjEwn6nhshkUPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HrZ3X/79NbZj+QZjZ1aehB56aJBzdxyLVed5rA5DXaLCHg9cevK7oLMTPX4rirIYctgq1jKaC6oM280zxcl9DDpE1Y01aQ4LQPPte1bXRwj+0jKRNK1J2pYGnAzp4UNPiykmgkjuypPBYjd2C6Y9es1cfRLIwlhq6yzHmaBW7WY=
Received: by 10.35.62.19 with SMTP id p19mr6545097pyk.1195496819586;
        Mon, 19 Nov 2007 10:26:59 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 19 Nov 2007 10:26:59 -0800 (PST)
In-Reply-To: <7vejenuy4i.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65482>

>
> Although I admit I do not care much about the "status color", I
> suspect this patch is not quite right.
>
> When prepare_log_message() returns "no committable changes" and
> we are not in merge, the calling cmd_commit() does another
> run_status() to show the status of the index and the work tree
> to the stdout, and at that point, we _do_ want to honor the
> configuration setting you are discarding with this assignment.
>
You're right. I forgot about untracked files when there are 'no
committable changes'
> ---
>
>  builtin-commit.c |    5 ++++-
>  wt-status.h      |    1 +
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 4e2f4aa..058cd32 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -300,7 +300,7 @@ static const char sign_off_header[] = "Signed-off-by: ";
>  static int prepare_log_message(const char *index_file, const char *prefix)
>  {
>         struct stat statbuf;
> -       int commitable;
> +       int commitable, saved_color_setting;
>         struct strbuf sb;
>         char *buffer;
>         FILE *fp;
> @@ -383,7 +383,10 @@ static int prepare_log_message(const char *index_file, const char *prefix)
>         if (only_include_assumed)
>                 fprintf(fp, "# %s\n", only_include_assumed);
>
> +       saved_color_setting = wt_status_use_color;
> +       wt_status_use_color = 0;
>         commitable = run_status(fp, index_file, prefix);
> +       wt_status_use_color = saved_color_setting;
>
>         fclose(fp);
>
> diff --git a/wt-status.h b/wt-status.h
> index f58ebcb..225fb4d 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -27,6 +27,7 @@ struct wt_status {
>  };
>
>  int git_status_config(const char *var, const char *value);
> +int wt_status_use_color;
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
>
>



-- 
Ping Yin
