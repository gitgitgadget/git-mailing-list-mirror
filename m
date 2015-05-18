From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/14] pull: error on no merge candidates
Date: Mon, 18 May 2015 20:56:00 +0200
Organization: gmx
Message-ID: <5c9746a0a2ce12b200c472bc534fd770@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:56:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQCy-0007j2-A3
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbbERS4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:56:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:55825 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525AbbERS4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:56:06 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M81vR-1Z85D62dgP-00vfqS; Mon, 18 May 2015 20:56:01
 +0200
In-Reply-To: <1431961571-20370-6-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:YCbUmbXc4MAoHfoRx4pLYLEiTNb/bColMlHGo4BwKguA5hLcF2U
 J86Dhg3MKlBALU2mDsPkjX1AvomBxki0nLbJo3JI+wVtvOta9jQ2P+38IpWelXjQk4XCsqH
 VjTXEz/9suXyd7leDByUGWb6jdtl9An8Zb1HO87FVCog5Vh0+J3NAHK3a2n21DJ6GDTufNP
 9zR/guFY6oXGZJ9nnxuiQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269299>

Hi Paul,

On 2015-05-18 17:06, Paul Tan wrote:
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 07ad783..8982fdf 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -207,6 +209,130 @@ static void argv_push_force(struct argv_array *arr)
>  		argv_array_push(arr, "-f");
>  }
>  
> +struct known_remote {
> +	struct known_remote *next;
> +	struct remote *remote;
> +};
> +
> +/**
> + * Use this callback with for_each_remote() to get the configured remotes as
> + * a singly linked known_remote list. cb_data must be a pointer to a
> + * struct known_remote*, which must be initialized to NULL. For example,
> + * For example:
> + *
> + *     struct known_remote *list = NULL;
> + *     for_each_remote(add_known_remote, &list);
> + */
> +static int add_known_remote(struct remote *remote, void *cb_data)
> +{
> +	struct known_remote **list = cb_data;
> +	struct known_remote *item;
> +
> +	item = xmalloc(sizeof(*item));
> +	item->remote = remote;
> +	item->next = *list;
> +	*list = item;
> +	return 0;
> +}

My first reaction to this was: let's use an array and `ALLOC_GROW()` to make this look nicer. But then I saw that there is only one user:

> +static void NORETURN die_no_merge_candidates(const char *repo, const
> char **refspecs)
> +{
> [...]
> +	} else if (!curr_branch->merge_nr) {
> +		struct known_remote *remotes = NULL;
> +		const char *remote_name = "<remote>";
> +
> +		for_each_remote(add_known_remote, &remotes);
> +		if (remotes && !remotes->next)
> +			remote_name = remotes->remote->name;
> +
> [...]

How about this instead:

static int get_only_remote(struct remote *remote, void *cb_data)
{
	const char **p = cb_data;

	if (*p)
		return -1;

	*p = remote->name;
	return 0;
}

[...]
		const char *remote_name = NULL;

		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
			remote_name = "<remote>";

Ciao,
Dscho
