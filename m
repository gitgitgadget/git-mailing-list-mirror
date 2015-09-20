From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 7/8] branch.c: use 'ref-filter' APIs
Date: Sun, 20 Sep 2015 21:24:24 +0200
Message-ID: <vpqmvwgevx3.fsf@anie.imag.fr>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
	<1442772627-25421-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 21:24:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdkDy-0002Qt-Qw
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 21:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbbITTYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 15:24:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42619 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755343AbbITTYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 15:24:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJOM1a007752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Sep 2015 21:24:22 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJOOpW009381;
	Sun, 20 Sep 2015 21:24:24 +0200
In-Reply-To: <1442772627-25421-8-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 20 Sep 2015 23:40:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 20 Sep 2015 21:24:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8KJOM1a007752
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443381863.44443@CinApnExNBgJLNgDdtk+hA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278261>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -231,6 +231,13 @@ start-point is either a local or remote-tracking branch.
>  	The new name for an existing branch. The same restrictions as for
>  	<branchname> apply.
>  
> +--sort=<key>::
> +	Sort based on the key given. Prefix `-` to sort in descending
> +	order of the value. You may use the --sort=<key> option
> +	multiple times, in which case the last key becomes the primary
> +	key. The keys supported are the same as those in `git
> +	for-each-ref`. Sort order defaults to sorting based on branch
> +	type.

The last sentence is no longer true. Perhaps something like:

Sort order defaults to sorting based on the full refname (including
`refs/...` prefix). This lists detached HEAD (if present) first, then
local branches and finally remote-tracking branches.

> -static void print_ref_list(struct ref_filter *filter)
> +static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
>  {
>  	int i;
>  	struct ref_array array;
> -	struct ref_filter_cbdata data;
>  	int maxwidth = 0;
>  	const char *remote_prefix = "";
> -	struct rev_info revs;
> +	struct ref_sorting def_sorting;
> +	const char *sort_type = "refname";

You are using refname without special-casing HEAD at all. So, this is
relying on the fact that HEAD comes alphabetically before refs/..., and
that we are only listing refs/... and HEAD.

As I mentionned earlyer, if we ever allow branch to list e.g.
FETCH_HEAD, then the detached HEAD will come in the middle. I first
thought that this was too fragile, but after thinking about it, I think
this is actually sensible. After all, if we ever allow FETCH_HEAD, then
keeping the alphabetical order still makes sense.

So, your code is OK, but a bit too subtle to my taste: you should add a
comment explaining why sorting according to refname is sufficient (I
would use a comment, but a better commit message may be OK too).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
