From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] submodule: implement `module_clone` as a builtin
 helper
Date: Thu, 27 Aug 2015 14:36:08 +0200
Organization: gmx
Message-ID: <92ffde8a07de2a4d50f79ecb7350dbb3@www.dscho.org>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
 <1440636766-12738-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
	gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 14:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUwPk-0000Q5-EU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 14:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbbH0MgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 08:36:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:52415 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbbH0MgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 08:36:15 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MPDeK-1ZQYgt14fQ-004Vms; Thu, 27 Aug 2015 14:36:11
 +0200
In-Reply-To: <1440636766-12738-2-git-send-email-sbeller@google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:p/IOBxIJALZYPLxClwm+LJHmFFUuvp0MWyLSn3fVoXQ55e5XLWW
 sty9Mu+Lk/H5XRLL6pafvecKnKzV0Ish1Cw0uGIobgBn+EV3Z+9AYHV93PaKUbB/NFLn85K
 oSqORloTMuldgh0oVkLumLwnymgkl5L2uf1ciylQHJq7GGnqiYT3BvRotc6qSZDETPgAGwf
 mV0R50CbAX/yWE7Q2SvIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zn9+bhFJxGQ=:FyW4+sAIa7j6iypHjOvdI6
 UF3JOgDoLpWoiZSdQuEZ31xVDo8vcy5o80QUPuWYHo1S4e5QeZjSxVes3LBW8T/OAorSNLo/T
 qlLWaNIq8JSPZOFNaR424EFQIPHHCQ9aGG499RIF0RAhAEv3kQgWOrbVHsLNcdW4FqAQmB0oR
 Shk87vZbuW7SMQ0fPOFI11uSTUS2AzRx0FDOPNd6G8kGIqzIJ1USwRMVZzVwX+W/RGTRrSQPQ
 cweGQjPdG5UcyZ0lFfoxnhjOj2+1addJi4QUl+jlzXPnL4ICMXQPLB/UW3RmSkdTW5uQNIvb5
 gWOMSesaKRlpHB/K+e4VBvdzC92xcXjodfM0CDQV8vKcvw3UpR8R0OPltkt555304aj8LjHTy
 f4n6j7vbrN+UyeyHu8LTJrLSJOWp7iOyUaBbEVFxcWKPgkFHnD7JPc/efk43abZglEkLLGqQI
 1GIimzrVbtX7ql2Gwc2Y3gGjgsX/YmoWNSthjOGwYhPRYnebzEL5gS3qe484tdrSrD9uTPO0p
 JdSFJCDIEigc8R6fomQWJdpb2MGqU+YNhPEzTIXER2dev3yPEZokZYefu+zD3BB/U8UTOcXGi
 bgPngWtWVWjZIJDY3q1ntYMlKwZ6fWjyBtUWK6isXeCZMYmtPFFNsohSYbUF0Ac1RFJfa43/i
 0FUaNfiy3Xrq1j/M7DRICjD+UP0ioB+5ui703eQHGkPI3Qw4jIkVoniEcCOpaA1mTCkf622YU
 y307CxRMFjEh5eTGMzaRJAPNZjGdFY5Uc6QCcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276666>

Hi Stefan,

thank you so much for doing this. `git submodule` is really, really slow on Windows...

On 2015-08-27 02:52, Stefan Beller wrote:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4b32a3c..f11fb9c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> [...]
> +
> +/*
> + * Clone a submodule
> + *
> + * $1 = submodule path
> + * $2 = submodule name
> + * $3 = URL to clone
> + * $4 = reference repository to reuse (empty for independent)
> + * $5 = depth argument for shallow clones (empty for deep)

I think this description is now safely obsolete and can be deleted: you introduced explicit options like --depth to avoid the "magic" of positional parameters.

> +static int module_clone(int argc, const char **argv, const char *prefix)
> +{
> +	const char *path = NULL, *name = NULL, *url = NULL, *reference =
> NULL, *depth = NULL;

This line is a little long ;-)

> @@ -135,6 +290,9 @@ int cmd_submodule__helper(int argc, const char
> **argv, const char *prefix)
>  	if (!strcmp(argv[1], "module_name"))
>  		return module_name(argc - 2, argv + 2, prefix);
>  
> +	if (!strcmp(argv[1], "module_clone"))
> +		return module_clone(argc - 1, argv + 1, prefix);
> +
>  usage:
> -	usage("git submodule--helper [module_list module_name]\n");
> +	usage("git submodule--helper [module_list module_name module_clone]\n");

Was the convention not to use ( ... | ... | ... )?

Thanks,
Dscho
