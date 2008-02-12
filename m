From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Tue, 12 Feb 2008 09:44:06 -0600
Message-ID: <47B1BEC6.6080906@nrlssc.navy.mil>
References: <47B156CD.1010209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 12 16:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOxNJ-0007vd-R2
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 16:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYBLPsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 10:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYBLPsO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 10:48:14 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41061 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbYBLPsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 10:48:14 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1CFi7Av002060;
	Tue, 12 Feb 2008 09:44:08 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Feb 2008 09:44:07 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47B156CD.1010209@op5.se>
X-OriginalArrivalTime: 12 Feb 2008 15:44:07.0530 (UTC) FILETIME=[1A5F5CA0:01C86D8E]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--13.865600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDIzNi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNjI5MC03MDQ3NDctNzEwNTcxLTcwMzk2NS03?=
	=?us-ascii?B?MDIzNzktNzAxNTk0LTcwMjkwMC03MDU1ODEtNzAzMTc5LTcwMDc1?=
	=?us-ascii?B?Ni03MDIwNTctNzAzNzg4LTcwMDQ1NC03MDcxNjMtNzA0OTI3LTcw?=
	=?us-ascii?B?MjExOC03MDMyODMtNzA3NDUxLTE4ODE5OS03MDEwMDUtMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73668>

Andreas Ericsson wrote:

> @@ -1861,7 +1858,7 @@ static int git_pack_config(const char *k, const
> char *v)
>     }
>     if (!strcmp(k, "pack.threads")) {
>         delta_search_threads = git_config_int(k, v);
> -        if (delta_search_threads < 1)
> +        if (delta_search_threads < 0)
>             die("invalid number of threads specified (%d)",
>                 delta_search_threads);
> #ifndef THREADED_DELTA_SEARCH

	if (delta_search_threads != 1)
		warning("no threads support, ignoring %s", k);

I changed this to '!= 1' since that is the only time the user gets what they
asked for when THREADED_DELTA_SEARCH is not enabled. If the user requested
nthreads == ncpus by setting delta_search_threads = 0, I think we should
let the user know that thread support is not enabled, and we are ignoring
their request.

> @@ -2076,6 +2073,9 @@ int cmd_pack_objects(int argc, const char **argv,
> const char *prefix)
>     if (!pack_compression_seen && core_compression_seen)
>         pack_compression_level = core_compression_level;
> 
> +    if (!delta_search_threads)    /* --threads=0 means autodetect */
> +        delta_search_threads = online_cpus();


This is in the wrong place. It should be _after_ command line arguments are
processed to handle --threads=0


> +
>     progress = isatty(2);
>     for (i = 1; i < argc; i++) {
>         const char *arg = argv[i];
> @@ -2130,7 +2130,8 @@ int cmd_pack_objects(int argc, const char **argv,
> const char *prefix)
>         if (!prefixcmp(arg, "--threads=")) {
>             char *end;
>             delta_search_threads = strtoul(arg+10, &end, 0);
> -            if (!arg[10] || *end || delta_search_threads < 1)
> +
> +            if (!arg[10] || *end || delta_search_threads < 0)
>                 usage(pack_usage);
> #ifndef THREADED_DELTA_SEARCH
>             if (delta_search_threads > 1)

Same comment as above about warning when delta_search_threads != 1.

-brandon
