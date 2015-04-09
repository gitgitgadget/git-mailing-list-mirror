From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] grep: correctly initialize help-all option
Date: Thu, 09 Apr 2015 23:55:01 +0200
Message-ID: <5526F535.4020407@web.de>
References: <1428586916-22679-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 23:55:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgKQ1-0002xg-PB
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 23:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbbDIVzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2015 17:55:21 -0400
Received: from mout.web.de ([212.227.15.4]:54537 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbbDIVzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 17:55:20 -0400
Received: from [192.168.178.27] ([79.253.182.74]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MarZy-1YzWEE3HsA-00KSZB; Thu, 09 Apr 2015 23:55:12
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1428586916-22679-1-git-send-email-ps@pks.im>
X-Provags-ID: V03:K0:TbeR+XkCo0Eb8sQdIdLZr1jGb3Zk/6511qLVtilhjy6E+FJxZt7
 /CLFL0MGSQ382j/bIFNiRBjc880HgQLxH49WN+yE03DV1OOxV4EbF9djlwzht6Sc6dJHxJ9
 d6qN2hcWOKbuLernQUFDVp92ilRUJAozuxc1XG7TUMSPWgopUOMWoJGp+MGd0/XhrGQOLOq
 lnkst+fY78YALso4esfGA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267002>

Am 09.04.2015 um 15:41 schrieb Patrick Steinhardt:
> The "help-all" option is being initialized with a wrong value.
> While being semantically wrong this can also cause a gcc
> segmentation fault on ARMv7 hardfloat platforms with a hardened
> toolchain. Fix this by initializing with the correct value.

Thanks for your report and patch.  A few comments:

Sign-off?  (See "Sign your work" in Documentation/SubmittingPatches)

> ---
>   builtin/grep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index abc4400..c0bf005 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>   			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
>   		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
>   			 N_("allow calling of grep(1) (ignored by this build)")),
> -		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage")=
,
> +		{ OPTION_CALLBACK, 0, "help-all", &opt, NULL, N_("show usage"),
>   		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
>   		OPT_END()
>   	};

help_callback() returns -1 immediately, IOW the value pointer is never=20
used anyway.  So why does your change make a difference?  *puzzled*

We could pass NULL instead, as in builtin/show-ref.c, which would make=20
it clear that the pointer is just a dummy.

Q: Why does the callback exist in the first place?  A: parse_options()=20
handles -h and --help-all automatically by showing the list of availabl=
e=20
options.  This is good for most commands for consistency's sake, but ba=
d=20
for commands that want to use -h for something else.  That's why it can=
=20
be turned off with the flag PARSE_OPT_NO_INTERNAL_HELP, but that flag=20
disables the long option as well.  It's added back by grep and show-ref=
=20
explicitly, to at least provide --help-all consistently across all comm=
ands.

We could solve this problem centrally by checking for -h and --help-all=
=20
only after looking through the struct option list supplied to=20
parse_options_step() instead of before and getting rid of the then=20
unneeded callbacks for --help-all in grep and show-ref.  Are there any=20
downsides to that approach?

Ren=E9
