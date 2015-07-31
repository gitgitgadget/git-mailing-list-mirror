From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] worktrees: add die_if_shared_symref
Date: Fri, 31 Jul 2015 15:35:18 -0400
Message-ID: <CAPig+cTX0Wav2QSFi734uLVpjdmwFKzcesgkpmVKCPomMB_HyA@mail.gmail.com>
References: <1438369297-4838-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 21:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLG5U-0005Av-8V
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 21:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbbGaTfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 15:35:20 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35378 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbGaTfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 15:35:19 -0400
Received: by ykdu72 with SMTP id u72so67304242ykd.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WyPdCQTJgcTLnaFiPKHRTjmSAiS4qlrB+C5cfLM62zY=;
        b=vd4KeTSdh9MwCjwJj1afJFHTrfG1egDUXNR1CjIinv2KRQVJhL7PtJzPgR7k9EfqON
         Xsm+TQPZDVKwDQBLkPeTeFDklW6JOQ0BXO3kfpmDe88vJWLyhxyrx/vNROuyLlMGrIhr
         KhTSfHgUL3t3eEXqf4xj7AEpgz/xV5ohp6zbuMIayXHzspW7i8BXy3Xly2OBLq0lX6Yj
         QKndKN7SV1FdFjM1NwUK3hYtCbvPDrE4nlRVzcZt1OydpoUMsSZNbs1+0sQAHsAniYUt
         wTuQSDqsLGsfW1YNoYm3AScNwtYOXW2To5PChZ7eg3XWtMLnhPGXlv+rZ5rYGXnvowD0
         /Wdg==
X-Received: by 10.170.63.196 with SMTP id f187mr5554246ykf.82.1438371318766;
 Fri, 31 Jul 2015 12:35:18 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 31 Jul 2015 12:35:18 -0700 (PDT)
In-Reply-To: <1438369297-4838-1-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: MLQNGFhkOLpBdqmDM1GxcpQ_jDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275072>

On Fri, Jul 31, 2015 at 3:01 PM, David Turner <dturner@twopensource.com> wrote:
> Add a new function, die_if_shared_symref, which works like
> die_if_checked_out, but for all references.  Refactor
> die_if_checked_out to work in terms of die_if_shared_symref.
>
> Soon, we will use die_if_shared_symref to protect notes merges in
> worktrees.

I wonder if the diagnostic:

    'blorp' is already checked out at '/path/name/'

emitted by check_linked_checkout() needs to be adjusted for this
change. It still makes sense for die_if_checked_out(), but sounds odd
for die_if_shared_symref().

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/branch.h b/branch.h
> index 58aa45f..b2fca30 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -59,4 +59,11 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
>   */
>  extern void die_if_checked_out(const char *branch);
>
> +/*
> + * Check if a symref points to a branch in the main worktree or any linked
> + * worktree and die (with a message describing its checkout location) if
> + * it is.

Ditto here. This is still talking about "branch" and "checkout",
whereas it's actually checking if a symref in some worktree already
references the given referent.

> + */
> +extern void die_if_shared_symref(const char *symref, const char *branch);

s/branch/referent/ or something?
