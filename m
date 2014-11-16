From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] config: clear the executable bits (if any) on
 $GIT_DIR/config
Date: Sun, 16 Nov 2014 09:06:29 +0100
Message-ID: <54685B05.90007@kdbg.org>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu> <1416122508-30654-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?ISO-8859-15?Q?Torsten_B=F6ge?= =?ISO-8859-15?Q?rshausen?= 
	<tboegi@web.de>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 09:06:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpurA-0001EQ-HQ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 09:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbaKPIGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 03:06:36 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:63365 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754745AbaKPIGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 03:06:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jgQwl4QwYz5tl9;
	Sun, 16 Nov 2014 09:06:31 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BBC1019F7C9;
	Sun, 16 Nov 2014 09:06:29 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1416122508-30654-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.11.2014 um 08:21 schrieb Michael Haggerty:
> @@ -559,9 +562,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		if (given_config_source.blob)
>  			die("editing blobs is not supported");
>  		git_config(git_default_config, NULL);
> -		launch_editor(given_config_source.file ?
> -			      given_config_source.file : git_path("config"),
> -			      NULL, NULL);
> +		config_file = xstrdup(given_config_source.file ?
> +				      given_config_source.file : git_path("config"));
> +		launch_editor(config_file, NULL, NULL);
> +
> +		/*
> +		 * In git 2.1, there was a bug in "git init" that left
> +		 * the u+x bit set on the config file. To clean up any
> +		 * repositories affected by that bug, and just because
> +		 * it doesn't make sense for a config file to be
> +		 * executable anyway, clear any executable bits from
> +		 * the file (on a "best effort" basis):
> +		 */
> +		if (!lstat(config_file, &st) && (st.st_mode & 0111))

At this point we cannot be sure that config_file is a regular file, can
we? It could also be a symbolic link. Wouldn't plain stat() be more
correct then?

> +			chmod(config_file, st.st_mode & 07666);
> +		free(config_file);
>  	}
>  	else if (actions == ACTION_SET) {
>  		int ret;

-- Hannes
