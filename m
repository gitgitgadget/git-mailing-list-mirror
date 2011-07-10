From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] revert: Persist per-session opts
Date: Sun, 10 Jul 2011 10:02:06 +0200
Message-ID: <201107101002.06385.chriscool@tuxfamily.org>
References: <1310226118-10201-1-git-send-email-artagnon@gmail.com> <1310226118-10201-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 10 10:02:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qfoy9-0001x9-3Z
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jul 2011 10:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448Ab1GJICS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 04:02:18 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:59045 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab1GJICR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2011 04:02:17 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3F226A6214;
	Sun, 10 Jul 2011 10:02:08 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1310226118-10201-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176821>

Hi Ram,

On Saturday 09 July 2011 17:41:58 Ramkumar Ramachandra wrote:
> Save the replay_opts struct in .git/sequencer/opts using a simple "key
> = value" format.  Parse it and populate the options structure before
> replaying.

[...]

>  static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
>  			struct replay_opts *opts)
>  {
> @@ -733,6 +759,102 @@ error:
>  	die(_("Malformed instruction sheet: %s"), git_path(SEQ_TODO_FILE));
>  }
> 
> +static char *parse_opt_value(char *p, void *key, enum seq_opt_type type,
> +			parse_opt_cb *cb_function) {
> +	struct option opt;
> +	char *val, *cur, *end;
> +
> +	if (!(val = strchr(p, '=')))
> +		goto error;
> +	if (!*(val + 1))
> +		goto error;
> +	if (!(end = strchr(p, '\n')))
> +		goto error;
> +	val += 2;

It looks like you rely on all lines ending with \n and having a space after 
the '='. It may be a little bit too fragile.

> +	*end = '\0'; /* Remove trailing '\n' */
> +
> +	switch (type) {
> +	case SEQ_OPTION_BOOLEAN:
> +		if (!strncmp(val, "true", strlen("true")))
> +			*(int *)key = 1;
> +		else if (!strncmp(val, "false", strlen("false")))
> +			*(int *)key = 0;
> +		else
> +			goto error;
> +		break;
> +	case SEQ_OPTION_INTEGER:
> +		*(int *)key = strtol(val, NULL, 10);
> +		break;
> +	case SEQ_OPTION_STRING:
> +		*(char **)key = xstrdup(val);
> +		break;
> +	case SEQ_OPTION_CALLBACK:
> +		opt.value = (struct replay_opts **)key;
> +		while (val) {
> +			if ((cur = strchr(val, '|'))) {
> +				*(cur - 1) = '\0';
> +				(*cb_function)(&opt, val, 0);
> +				val = cur + 2;
> +			} else {
> +				(*cb_function)(&opt, val, 0);
> +				break;
> +			}
> +		}
> +		break;
> +	default:
> +		die(_("program error"));
> +	}
> +	return end + 1;
> +error:
> +	die(_("Malformed options sheet: %s"), git_path(SEQ_OPTS_FILE));
> +}

Otherwise it looks good to me.

Thanks,
Christian.
