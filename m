From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] builtin/receive-pack.c: use parse_options API
Date: Tue, 01 Mar 2016 18:22:30 +0100
Message-ID: <vpq60x62jvt.fsf@anie.imag.fr>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Sidhant Sharma \[\:tk\]" <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:22:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aao0P-0000iF-5E
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbcCARWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:22:37 -0500
Received: from mx2.imag.fr ([129.88.30.17]:34112 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbcCARWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:22:36 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u21HMRsL019031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 1 Mar 2016 18:22:28 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u21HMUDS018296;
	Tue, 1 Mar 2016 18:22:30 +0100
In-Reply-To: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com> (Sidhant
	Sharma's message of "Tue, 1 Mar 2016 21:06:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Mar 2016 18:22:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u21HMRsL019031
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457457751.76741@8bq7OpCKkOijEQjvnIfVqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288042>

Hi,

Thanks for your patch.

"Sidhant Sharma [:tk]" <tigerkid001@gmail.com> writes:

> This patch makes receive-pack use the parse_options API,

We usually avoid saying "this patch" and use imperative tone: talk to
your patch and give it orders like "Make receive-pack use the
parse_options API ...". Or just skip that part which is already in the
title.

> @@ -45,12 +48,12 @@ static int unpack_limit = 100;
>  static int report_status;
>  static int use_sideband;
>  static int use_atomic;
> -static int quiet;
> +static int quiet = 0;

static int are already initialized to 0, you don't need this explicit "=
0". In the codebase of Git, we prever omiting the initialization.

> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("quiet")),
> +		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
> +		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
> +		/* Hidden OPT_BOOL option */
> +		{
> +			OPTION_SET_INT, 0, "reject-thin-pack-for-testing", &fix_thin, NULL,
> +			NULL, PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0,
> +		},

After seeing the patch, I think the code would be clearer by using
something like

	OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL)

and then use !reject_thin where the patch was using fix_thin. Turns 5
lines into one here, and you just pay a ! later in terms of readability.

Starting from here, the patch is a bit painful to read because the diff
heuristics grouped hunks in a strange way. You may try "git format-patch
--patience" or --minimal or --histogram to see if it gives a better
result. The final commit would be the same, but it may make review
easier.

(Not blaming you, just pointing a potentially useful hint, don't worry)

>  	packet_trace_identity("receive-pack");
>
> -	argv++;
> -	for (i = 1; i < argc; i++) {
> -		const char *arg = *argv++;
> +	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
>
> -		if (*arg == '-') {
> -			if (!strcmp(arg, "--quiet")) {
> -				quiet = 1;
> -				continue;
> -			}
> +	if (argc > 1)
> +		usage_msg_opt(_("Too many arguments."), receive_pack_usage, options);
> +	if (argc == 0)
> +		usage_msg_opt(_("You must specify a directory."), receive_pack_usage, options);

Before that, the loop was ensuring that service_dir was assigned once
and only once, and now you check that you have one non-option arg and
assign it unconditionally:

> +	service_dir = argv[0];

... so isn't this "if" dead code:

>  	if (!service_dir)
> -		usage(receive_pack_usage);
> +		usage_with_options(receive_pack_usage, options);

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
