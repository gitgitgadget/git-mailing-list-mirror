From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/18] revert: Save command-line options for continuing operation
Date: Sun, 31 Jul 2011 13:42:11 +0200
Message-ID: <201107311342.12547.chriscool@tuxfamily.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com> <1311871951-3497-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 13:42:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUPw-0006Zy-U2
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 13:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab1GaLmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 07:42:24 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:58351 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131Ab1GaLmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 07:42:22 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BDED1A6203;
	Sun, 31 Jul 2011 13:42:14 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1311871951-3497-12-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178236>

On Thursday 28 July 2011 18:52:24 Ramkumar Ramachandra wrote:
>
> +static void save_opts(struct replay_opts *opts)
> +{
> +	const char *opts_file = git_path(SEQ_OPTS_FILE);
> +	struct strbuf buf = STRBUF_INIT;
> +	int i;
> +
> +	if (opts->no_commit)
> +		git_config_set_in_file(opts_file, "options.no-commit", "true");
> +	if (opts->edit)
> +		git_config_set_in_file(opts_file, "options.edit", "true");
> +	if (opts->signoff)
> +		git_config_set_in_file(opts_file, "options.signoff", "true");
> +	if (opts->record_origin)
> +		git_config_set_in_file(opts_file, "options.record-origin", "true");
> +	if (opts->allow_ff)
> +		git_config_set_in_file(opts_file, "options.allow-ff", "true");
> +	if (opts->mainline) {
> +		strbuf_reset(&buf);

It is not necessary to reset &buf here.

> +		strbuf_addf(&buf, "%d", opts->mainline);
> +		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
> +	}

And perhaps it would be clearer if it was:

+       if (opts->mainline) {
+               struct strbuf buf = STRBUF_INIT;
+               strbuf_addf(&buf, "%d", opts->mainline);
+               git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+               strbuf_release(&buf);
+       }

> +	if (opts->strategy)
> +		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
> +	if (opts->xopts) {

Other nit: maybe you could put "int i" here, instead of at the beginning of 
the function.

> +		for (i = 0; i < opts->xopts_nr; i++)
> +			git_config_set_multivar_in_file(opts_file,
> +							"options.strategy-option",
> +							opts->xopts[i], "^$", 0);
> +	}
> +
> +	strbuf_release(&buf);
> +}

Thanks,
Christian.
