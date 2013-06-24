From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 13:28:09 +0530
Message-ID: <CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com> <1372048388-16742-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1fq-0007x0-9K
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab3FXH6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:58:50 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58472 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab3FXH6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:58:49 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so24328018iec.27
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=amSVBI39/GczRBX+4ba7KbSVeAzoK4nlApGtVex2jbs=;
        b=UuMxGACwynnbRMINVqpYOWkIoblzq0siPOaYLxKLL+nE620p9mqYkiAN9TW9BrF/YD
         hTVjAGMo3YqSupH2HkHADpypVAvDu9JassIMWzIm3zzkY/tkkDji4+5zZbwvf5NcJV0q
         mzbip6zpXzkqeQjM4N95P8X1Lq+dmS8uv/xUqNfNYgKKJt1V2dvgMC3eWrzAjXR4+0fq
         4TQswUPzVMgBAADBWsVcKSSn6tj6DJSme1D06mkK4u1tX+fLJAhaSQPSHAuESPPj6n8E
         9SDDR/dcsz1HNKwq4GmiQn3rsXaBD1qgqYoVHuxJtFD7m8F3vRk3YV1YpaXnYiNFxQU6
         9rNQ==
X-Received: by 10.50.107.65 with SMTP id ha1mr4816294igb.50.1372060729291;
 Mon, 24 Jun 2013 00:58:49 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 00:58:09 -0700 (PDT)
In-Reply-To: <1372048388-16742-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228790>

Junio C Hamano wrote:
> @@ -194,7 +203,14 @@ static int is_workflow_triagular(struct remote *remote)
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
>         struct branch *branch = branch_get(NULL);
> -       int triangular = is_workflow_triagular(remote);
> +       int triangular;
> +
> +       if (branch->push_name) {
> +               setup_per_branch_push(branch);
> +               return;
> +       }

The most obvious question comes first: what result can I expect when
this interacts with remote.<name>.push?

Why did you design this feature like this?  Will the user _not_ want
refspec mapping except when pushing out the current branch with a
plain "git push"?

Also, you managed to throw out all safety out the window.  What
happens when the user does:

  # on branch master, derived from origin
  $ git push ram

And branch.master.push is set to next?  Will you let her shoot herself
in the foot like this?
