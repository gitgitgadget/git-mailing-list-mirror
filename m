From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] remote-http: use argv-array
Date: Tue, 9 Jul 2013 08:05:19 +0200
Message-ID: <CAKPyHN0DG0c2vxWtybYtDmFKMo369PZcbqCfDJaXeiRV+PP8pQ@mail.gmail.com>
References: <7vfvvoxqdw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 08:05:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwR3F-0000TG-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 08:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093Ab3GIGFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 02:05:21 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:58215 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3GIGFU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 02:05:20 -0400
Received: by mail-vc0-f172.google.com with SMTP id ib11so4042745vcb.17
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 23:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lsVMhcYwiJdJHNI06VvxNib1naq8EO2tpPgsoj59Y90=;
        b=cJQ3Z785UZLKnJHc5wbuHwCsEqKCTfCcNmaKGcYdGqUxsqhoGqU1Nk7vHnaAphrN1k
         bCykgS4WkGCIPbfPPrRdWaE6vcmy83/YHVEBp3MQjVomVsNXqMNIc2z68S7R9HRiggBv
         EeRPHq23ErIHiBxIVDCnitBXmY73hxZSsJe2gXtEVVg10Vi0ckD3/nSdvlImalBRCfqh
         bdr03G/rpid5XBjvXxCjY3/GeRzuaOFxPS8YI/NI3q37lOGQTkxv0tdAYLWM/+PkBx1J
         yPWOckKcJL3e49wDTlsEUmP0q5HnyOWVkCMM7Vy6hOuoSSUn5Mf0FNY3TGaWsnolWtI9
         GM1g==
X-Received: by 10.58.216.97 with SMTP id op1mr1429136vec.60.1373349919474;
 Mon, 08 Jul 2013 23:05:19 -0700 (PDT)
Received: by 10.220.176.72 with HTTP; Mon, 8 Jul 2013 23:05:19 -0700 (PDT)
In-Reply-To: <7vfvvoxqdw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229918>

On Tue, Jul 9, 2013 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Instead of using a hand-managed argument array, use argv-array API
> to manage dynamically formulated command line.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  remote-curl.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 60eda63..884b3a3 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -7,6 +7,7 @@
>  #include "run-command.h"
>  #include "pkt-line.h"
>  #include "sideband.h"
> +#include "argv-array.h"
>
>  static struct remote *remote;
>  static const char *url; /* always ends with a trailing slash */
> @@ -787,36 +788,34 @@ static int push_dav(int nr_spec, char **specs)
>  static int push_git(struct discovery *heads, int nr_spec, char **specs)
>  {
>         struct rpc_state rpc;
> -       const char **argv;
> -       int argc = 0, i, err;
> +       int i, err;
> +       struct argv_array args;
> +
> +       argv_array_init(&args);
> +       argv_array_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status");

missing NULL sentinel. GCC has the 'sentinel' [1] attribute to catch
such errors. Or use macro magic:

void argv_array_pushl_(struct argv_array *array, ...);
#define argv_array_pushl(array, ...) argv_array_pushl_(array, __VA_ARGS__, NULL)

Bert

[1] http://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html#index-g_t_0040code_007bsentinel_007d-function-attribute-2708
