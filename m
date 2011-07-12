From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/17] revert: Save command-line options for continuing
 operation
Date: Tue, 12 Jul 2011 14:52:46 -0500
Message-ID: <20110712195246.GC14909@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:53:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgj0v-00007I-Gx
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab1GLTw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:52:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52975 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab1GLTw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:52:56 -0400
Received: by gyh3 with SMTP id 3so2093209gyh.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i86lb4pNltPyXmi/zn7OACABaO9DCQLtd6hnUAWu5xk=;
        b=VHU7+qGX7ZCZzwU9/Ot2bjDC8m0r0s/3Vyov90AG7wdJeECqvl7YNQwbWPCwVU4Smn
         9JPEBOtAbWXD9T3nIYAaPtWLT5LWeyeQLlV0kN5NHXMkfkpOsk+K6NLhBuQMt3nUIaEU
         8/EAWOxGLOS6twg+K4pWg+rDpbLKurPZ2aK18=
Received: by 10.236.76.193 with SMTP id b41mr495071yhe.71.1310500375659;
        Tue, 12 Jul 2011 12:52:55 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id k8sm4220000yhm.59.2011.07.12.12.52.53
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 12:52:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-13-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176974>

Hi,

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -596,6 +596,32 @@ struct commit_list **commit_list_append(struct commit *commit,
>  	return &new->next;
>  }
>  
> +static void format_opts(struct strbuf *buf, struct replay_opts *opts)
> +{
> +	int i;
> +
> +	if (opts->no_commit)
> +		strbuf_addstr(buf, "no-commit = true\n");
> +	if (opts->edit)
> +		strbuf_addstr(buf, "edit = true\n");
[...]

Somewhat repetitive.  Would it make sense to do something like

	add_opt_bool(buf, "no-commit", opts->no_commit);
	add_opt_bool(buf, "edit", opts->edit);
	add_opt_bool(buf, "signoff", opts->signoff);
	if (opts->mainline)
		add_opt_int(buf, "mainline", opts->mainline);
	add_opt_string(buf, "strategy", opts->strategy);
	add_opt_strings(buf, "strategy-option", opts->xopts, opts->xopts_nr);

> @@ -694,6 +720,184 @@ error:
>  	die(_("Malformed instruction sheet: %s"), git_path(SEQ_TODO_FILE));
>  }
>  
> +static struct strbuf *parse_value(const char *start, char **end_ptr)
> +{
> +	static struct strbuf value = STRBUF_INIT;
> +	int quote = 0;
> +	char *p = (char *)start;

Are all callers passing a modifiable buffer?  If so, why not make the
parameter non-const?  Is it necessary to modify the buffer to parse it?

> +	char *end;
> +
> +	/* Find and strip '\n', '\r' */
> +	if ((end = strchr(start, '\n'))) {

Style:

	end = strchrnul(start, '\n');
	if (*end && end > start && end[-1] == '\r')
		end--;

	for (p = start; p != end; p++) {
		...
	}

> +	for (; *p != '\0'; p ++) {
> +		if (!quote && (*p == ';' || *p == '#'))
> +			/* Ignore comments */
> +			goto ok;
> +		if (*p == '\\') {

What is this syntax?

*thinks*  Oh, this looks eerily similar to config.c::parse_value().
Shouldn't the commit message say so?  Why not factor out a function so
they can share code?

> +			p += 1;
[...]
> +			/* Some pharapters escape as themselves */

Substitution error.

> +static char *parse_opt_value(const char *start, void *key,
> +			enum parse_opt_type type, parse_opt_cb *cb_function)
> +{
> +	struct strbuf *value, *subvalue;
> +	struct option opt;
> +	char *p, *cur, *val, *end;
> +
> +	/* Remove spaces before '=' */
> +	for (p = (char *)start; isspace(*p); p++);

Same questions apply.  Stopping here.

Hope that helps,
Jonathan
