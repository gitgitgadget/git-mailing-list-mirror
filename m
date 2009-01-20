From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 11:02:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net> <200901192145.21115.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 11:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPDS8-0001Yl-Jv
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 11:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbZATKB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 05:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbZATKB6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 05:01:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:55606 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754907AbZATKB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 05:01:57 -0500
Received: (qmail invoked by alias); 20 Jan 2009 10:01:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 20 Jan 2009 11:01:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/G7BdTv6/H/NH7aJLBqLmpssL/V+RkhrSzFUVlC
	ZIuwppueCGA5TY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901192145.21115.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106461>

Hi,

On Mon, 19 Jan 2009, Boyd Stephen Smith Jr. wrote:

> diff --git a/diff.c b/diff.c
> index 9fcde96..c53e1d1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -23,6 +23,7 @@ static int diff_detect_rename_default;
>  static int diff_rename_limit_default = 200;
>  static int diff_suppress_blank_empty;
>  int diff_use_color_default = -1;
> +static const char *diff_color_words_cfg = NULL;
>  static const char *external_diff_cmd_cfg;

Guess why external_diff_cmd_cfg is not set to NULL?  All variables 
defined outside a function are set to all-zero anyway.

> @@ -92,6 +93,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  	}
>  	if (!strcmp(var, "diff.external"))
>  		return git_config_string(&external_diff_cmd_cfg, var, value);
> +	if (!strcmp(var, "diff.color-words"))

I'd call it diff.wordregex, because that's what it is.

> @@ -1550,6 +1553,8 @@ static void builtin_diff(const char *name_a,
>  				o->word_regex = userdiff_word_regex(one);
>  			if (!o->word_regex)
>  				o->word_regex = userdiff_word_regex(two);
> +			if (!o->word_regex)
> +				o->word_regex = diff_color_words_cfg;

IMHO this is the wrong order.  config should not override attributes, 
which are by definition more specific.

> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 6ebce9d..a207d9e 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -105,7 +105,7 @@ a = b + c<RESET>
>  EOF
>  cp expect.non-whitespace-is-word expect
>  
> -test_expect_failure 'use default supplied by config' '
> +test_expect_success 'use default supplied by config' '

Let's squash the two, okay?

Thanks,
Dscho
