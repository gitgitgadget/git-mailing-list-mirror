From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently processed
Date: Mon, 17 Jun 2013 13:44:25 +0100
Message-ID: <CA+39Oz7niTiaNfhaL3pi6=sDGpkpJ++1W6eKb1zdHxAm6r_hSw@mail.gmail.com>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 14:44:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoYnd-00054i-Sr
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 14:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201Ab3FQMom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 08:44:42 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:38470 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab3FQMol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 08:44:41 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz10so2049891veb.17
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Ojar+KNASmr3X3dM8329od1t5tFhBlqie6/I3AYwWmg=;
        b=ZqQQHLL5T6cWFp0A5Ehb0eEisgE8tTLxoX3aDONcvLhzcNBhjX6GU2RJsax4qWjwhz
         BOuI7Zqn148254qcVGW4a4TItLnkBGkmnXHvn5Qmo7gp61d4QiqkZ8A753r8JppHElA4
         gIGwoWNypzTlQapxALIpWY4abxnIDvzuYcvaysVEZ0Jib1n6e2UDC16B/e5nu4wR6KS6
         wQYhgF+8TVeUur6FBV6eTzBQG9f39+4Ie9RYbtiLgYnHoqjvx3y+Qlpi57a3cdwaxRGO
         Tx7mXlUSCEHE1gqN3rtHvn51Vo49Pld9C2w4cLy3mirdwYWl16NYBSKuPeTc/RA0jfx1
         cyXQ==
X-Received: by 10.220.159.208 with SMTP id k16mr3485272vcx.92.1371473080610;
 Mon, 17 Jun 2013 05:44:40 -0700 (PDT)
Received: by 10.220.106.208 with HTTP; Mon, 17 Jun 2013 05:44:25 -0700 (PDT)
In-Reply-To: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-Google-Sender-Auth: cLtqafWZ6rSu6ya7QdYxmvDa5EE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228063>

Hi,

[I rarely do reviews on this list, so feel free to ignore this.]

On 17 June 2013 13:10, Mathieu Lienard--Mayor
<Mathieu.Lienard--Mayor@ensimag.imag.fr> wrote:
> diff --git a/wt-status.c b/wt-status.c
> index bf84a86..5f5cddf 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -885,8 +885,19 @@ static void show_rebase_in_progress(struct wt_status *s,
>                                 struct wt_status_state *state,
>                                 const char *color)
>  {
> +       char *stopped_sha = read_line_from_git_path("rebase-merge/stopped-sha");
> +       int must_free_stopped_sha = 1;
>         struct stat st;
>
> +       /*
> +        * If the file stopped-sha does not exist
> +        * we go back to the old output saying "a commit"
> +        * instead of providing the commit's SHA1.
> +        */
> +       if (!stopped_sha) {
> +               stopped_sha = "a commit";
> +               must_free_stopped_sha = 0;
> +       }

Rather than having to assign a toggle of deciding when to free
stopped_sha, how much overhead would be introduced by just doing:

    if (!stopped_sha)
        stopped_sha = strdup("a commit");

And then at the end just do:

free (stopped_sha);

Just a thought.

-- Thomas Adam
