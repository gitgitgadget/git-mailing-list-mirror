From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: display first bad commit without forking a new process
Date: Wed, 27 May 2009 21:07:52 +0200
Message-ID: <200905272107.52095.chriscool@tuxfamily.org>
References: <20090527052354.3824.22018.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 21:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9OTy-0007Xr-H4
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 21:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759363AbZE0TIA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 15:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758146AbZE0TH7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 15:07:59 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:47395 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757326AbZE0TH7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 15:07:59 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 21D3CD4815C;
	Wed, 27 May 2009 21:07:54 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id F3E40D4820C;
	Wed, 27 May 2009 21:07:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090527052354.3824.22018.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120095>

Le Wednesday 27 May 2009, Christian Couder a =E9crit :
> Previously "git diff-tree --pretty COMMIT" was run using
> "run_command_v_opt" to display information about the first bad
> commit.
>
> The goal of this patch is to avoid a "fork" and an "exec" call
> when displaying that information.
>
> To do that, we manually setup revision information as
> "git diff-tree --pretty" would do it, and then use the
> "log_tree_commit" function.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  bisect.c |   30 +++++++++++++++++++++++++++---
>  1 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index c43c120..e94a77b 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -7,6 +7,7 @@
>  #include "quote.h"
>  #include "sha1-lookup.h"
>  #include "run-command.h"
> +#include "log-tree.h"
>  #include "bisect.h"
>
>  struct sha1_array {
> @@ -27,7 +28,6 @@ struct argv_array {
>  	int argv_alloc;
>  };
>
> -static const char *argv_diff_tree[] =3D {"diff-tree", "--pretty", NU=
LL,
> NULL}; static const char *argv_checkout[] =3D {"checkout", "-q", NULL=
,
> "--", NULL}; static const char *argv_show_branch[] =3D {"show-branch"=
,
> NULL, NULL};
>
> @@ -816,6 +816,31 @@ static void check_good_are_ancestors_of_bad(cons=
t
> char *prefix) }
>
>  /*
> + * This does "git diff-tree --pretty COMMIT" without one fork+exec.
> + */
> +static void show_diff_tree(const char *prefix, struct commit *commit=
)
> +{
> +	static struct rev_info opt;

Oops, "static" can be removed, it's a copy-paste error, sorry.

Thanks,
Christian.
