From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: Show a more descriptive error on failure
 when opening a patch
Date: Sun, 13 Apr 2008 12:54:48 -0700
Message-ID: <7vtzi5bkdz.fsf@gitster.siamese.dyndns.org>
References: <1208112991-21598-1-git-send-email-albertito@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 21:55:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl8Ip-0001Mk-O0
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 21:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760143AbYDMTy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 15:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759688AbYDMTy4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 15:54:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759684AbYDMTyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 15:54:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D2FA3139;
	Sun, 13 Apr 2008 15:54:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A71BC3138; Sun, 13 Apr 2008 15:54:50 -0400 (EDT)
In-Reply-To: <1208112991-21598-1-git-send-email-albertito@gmail.com> (Alberto
 Bertogli's message of "Sun, 13 Apr 2008 15:56:31 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79419>

Alberto Bertogli <albertito@gmail.com> writes:

> When a patch can't be opened (it doesn't exist, there are permission
> problems, etc.) we get the usage text, which is not a proper indication of
> failure.
>
> This patch fixes that by simply doing a perror() instead.
>
> Signed-off-by: Alberto Bertogli <albertito@gmail.com>
> ---
>  builtin-apply.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index abe73a0..d80b231 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -3120,8 +3120,11 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
>  			arg = prefix_filename(prefix, prefix_length, arg);
>  
>  		fd = open(arg, O_RDONLY);
> -		if (fd < 0)
> -			usage(apply_usage);
> +		if (fd < 0) {
> +			perror("Error opening patch");
> +			return 1;
> +		}

This makes sense, but I wonder if we want to parrot "arg" back.  The
problem could be that the command and the user are disagreeing which
parameter on the command line is the name of the patch file...

> +
>  		read_stdin = 0;
>  		set_default_whitespace_mode(whitespace_option);
>  		errs |= apply_patch(fd, arg, inaccurate_eof);
> -- 
> 1.5.5.104.ge4331
