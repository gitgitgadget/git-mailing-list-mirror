From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] refs: Break out check for reflog autocreation
Date: Fri, 26 Jun 2015 15:01:14 -0700
Message-ID: <xmqqpp4iruxh.fsf@gitster.dls.corp.google.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
	<1435278548-3790-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8bgZ-0002RU-Jl
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbbFZWBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 18:01:19 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36760 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbbFZWBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 18:01:16 -0400
Received: by igbiq7 with SMTP id iq7so21938521igb.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JcDLvsx/XXeLfmEU6gyujbW7xoC99SdGUkI/ciTrXLs=;
        b=ecpm/NM/caRtgvDpLDWKsxUWRx51SczfwmCf7eGxlyE4wKkfzq5eO/LCl2TuSakufd
         k/HhNXSTSXLiT4xWyirGeIW//PjvVYQkF3tEFwuvul2/USAngcnw+CoPBwXoDYr4vwhs
         IQvP5US+1ZDzZ3JPk+EUhLmoZz3lbKkwV2NqjE1aLabHAGVkYtD0QcC6uc9FE7n+MeFZ
         BgA27huJKHRkwNWdb/mEhyCQyk4gksKBA10kbZes61aIGoslDlYd96t4k3/hgVTQpKPc
         cl6FO3B7Op36ZwntsJWFcWo0rEIChi4CEe/9qB8uwiEQoMEFtlr+sE9r6LgiC3aUw0de
         YbIw==
X-Received: by 10.107.169.16 with SMTP id s16mr4945007ioe.74.1435356076361;
        Fri, 26 Jun 2015 15:01:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id e3sm109790igq.21.2015.06.26.15.01.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 15:01:15 -0700 (PDT)
In-Reply-To: <1435278548-3790-4-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 20:29:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272833>

David Turner <dturner@twopensource.com> writes:

> This is just for clarity.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index b34a54a..dff91cf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3118,6 +3118,14 @@ static int copy_msg(char *buf, const char *msg)
>  	return cp - buf;
>  }
>  
> +static int should_autocreate_reflog(const char *refname)
> +{
> +	return starts_with(refname, "refs/heads/") ||
> +		starts_with(refname, "refs/remotes/") ||
> +		starts_with(refname, "refs/notes/") ||
> +		!strcmp(refname, "HEAD");
> +}
> +
>  /* This function will fill in *err and return -1 on failure */
>  int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
>  {
> @@ -3128,11 +3136,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
>  	logfile = sb_logfile->buf;
>  	/* make sure the rest of the function can't change "logfile" */
>  	sb_logfile = NULL;
> -	if (log_all_ref_updates &&
> -	    (starts_with(refname, "refs/heads/") ||
> -	     starts_with(refname, "refs/remotes/") ||
> -	     starts_with(refname, "refs/notes/") ||
> -	     !strcmp(refname, "HEAD"))) {
> +	if (log_all_ref_updates && should_autocreate_reflog(refname)) {

This makes me wonder if "log_all_ref_updates &&" part should also be
inside the helper.  The use of the new helper in 5/7 tells me that
it is the case, I would say.

Besides, the answer to the question "should we auto-create reflog?"
is "if we are told to log all, and then the thing is one of these,
then we should:", so it is natural from the name of the new helper
that "log_all_ref_updates &&" should be in there ;-)
