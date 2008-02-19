From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Mon, 18 Feb 2008 21:19:43 -0500
Message-ID: <76718490802181819o4cf742edi92bbcd9039f0cdac@mail.gmail.com>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 03:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRI5l-0007Uj-I0
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 03:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263AbYBSCTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 21:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbYBSCTp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 21:19:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:6242 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbYBSCTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 21:19:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3143367wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 18:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=r4spqUrrx6WdtforaiFogWlayHNtn18bxAT+VhbwyqM=;
        b=dVGKkgj8hxCRW7BVLsjYQ9sfLJgjCsJMJbRsaZw1l2irZDOwu68JEzR29y9bqZGW7h9N0QzwzObjb0YR/ba/hWLzEKKXDQ6NAfH3tUW+u36f1pbTuxXWOdn9Qeg3XPR/XxdJO2DmAEGjQ2z2IIKrsyVA2zmIT2qM8kllnyb2MjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pmJAXIT3T9cK3jye1m5e3IV05uQ2zw8SKeUBA8PvUu84IIQpJSTQ7qYEIHoX0YaMYaSZPpAB8Ai7XsYA2mHws4Z2+VUVq5mxzryoFAal7ft3I8OgsKuDCktvmiAnSdRfIvhZERYcXps5nLCqELCptu6VC0RlB3Dgo0FhlX1WD7Y=
Received: by 10.114.177.1 with SMTP id z1mr2927967wae.144.1203387583913;
        Mon, 18 Feb 2008 18:19:43 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Mon, 18 Feb 2008 18:19:43 -0800 (PST)
In-Reply-To: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74366>

On Feb 18, 2008 9:07 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> diff --git a/branch.c b/branch.c
> index 1fc8788..9d7585e 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -37,7 +37,8 @@ static int find_tracked_branch(struct remote *remote, void *priv)
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
>   * config.
>   */
> -static int setup_tracking(const char *new_ref, const char *orig_ref)
> +static int setup_tracking(const char *new_ref, const char *orig_ref,
> +                          enum branch_track track)
>  {
>         char key[1024];
>         struct tracking tracking;
> @@ -48,10 +49,14 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
>
>         memset(&tracking, 0, sizeof(tracking));
>         tracking.spec.dst = (char *)orig_ref;
> -       if (for_each_remote(find_tracked_branch, &tracking) ||
> -                       !tracking.matches)
> +       if (for_each_remote(find_tracked_branch, &tracking))
>                 return 1;
>
> +       if (!tracking.matches && track == BRANCH_TRACK_ALWAYS) {
> +               tracking.matches = 1;
> +               tracking.src = xstrdup(orig_ref);
> +       }
> +

Well that's obviously wrong (though it causes no problems, setup_tracking()
would return 0 when it should return 1, but its return value is currently
ignored). I changed it to:

	if (!tracking.matches) {
		if (track != BRANCH_TRACK_ALWAYS)
			return 1;
		tracking.matches = 1;
		tracking.src = xstrdup(orig_ref);
	}

j.
