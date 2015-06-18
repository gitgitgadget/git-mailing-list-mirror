From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship with git-mailinfo
Date: Thu, 18 Jun 2015 14:10:03 -0700
Message-ID: <xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:10:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5h4d-0007zn-85
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbbFRVKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:10:06 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35705 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbbFRVKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:10:05 -0400
Received: by iefd2 with SMTP id d2so6690303ief.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nVkECNV9w9s5CI+17v++uPpVShbnbJi1kXWtuQtkBp0=;
        b=Omop7irxyPhz6TgVyNs1wAxJ6CDXafmrJbNCEayEIR3peiCPx/GMcU03T5ao5GrSK+
         USBeY5E2ekGNkd3hn6rchUF84A1/2yoUz9hcdxZF23BiLcIcU4YqNhhn9ZdrdMJmze6K
         lYDrocselXS7qE4KrvQ1wZ/j2yeC0RCJ3NS+GYWvDDGWzxoaxqk7ijEIx59x5VAXdllB
         69AFCA9Kef6xomRobKozgkkVoRVE4tTj9A796+B+Ob4FiXg3Gmrj5ewGqZStn/b+uwTd
         2ufFlXMQh0ZJyPlOZrLGzJCbPs+bcG46bi5PzRysMoKoq9dWU8GNT8wks+wCbNMFOY2e
         GEGw==
X-Received: by 10.43.14.65 with SMTP id pp1mr8053564icb.40.1434661804900;
        Thu, 18 Jun 2015 14:10:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id d4sm310090igl.1.2015.06.18.14.10.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 14:10:04 -0700 (PDT)
In-Reply-To: <1434626743-8552-8-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Thu, 18 Jun 2015 19:25:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272075>

Paul Tan <pyokagan@gmail.com> writes:

> +	/* commit message and metadata */
> +	struct strbuf author_name;
> +	struct strbuf author_email;
> +	struct strbuf author_date;
> +	struct strbuf msg;

Same comment as "dir" in the earlier patch applies to these.  If the
fields are read or computed and then kept constant, use a temporary
variable that is a strbuf to read/compute the final value, and then
detach to a "const char *" field.  If they are constantly changing
and in-place updates are vital, then they can and should be strbufs,
but I do not think that is the case for these.

For example...

> +/**
> + * Saves state->author_name, state->author_email and state->author_date in
> + * `filename` as an "author script", which is the format used by git-am.sh.
> + */
> +static void write_author_script(const struct am_state *state)
> +{
> +	static const char fmt[] = "GIT_AUTHOR_NAME=%s\n"
> +		"GIT_AUTHOR_EMAIL=%s\n"
> +		"GIT_AUTHOR_DATE=%s\n";
> +	struct strbuf author_name = STRBUF_INIT;
> +	struct strbuf author_email = STRBUF_INIT;
> +	struct strbuf author_date = STRBUF_INIT;
> +
> +	sq_quote_buf(&author_name, state->author_name.buf);
> +	sq_quote_buf(&author_email, state->author_email.buf);
> +	sq_quote_buf(&author_date, state->author_date.buf);

As you use a separate author_name variable here, what gets sq-quoted
that is in *state does not have to be strbuf.

The code to read is the same story:

> +static int read_shell_var(struct strbuf *value, FILE *fp, const char *key)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	char *str;
> +
> +	if (strbuf_getline(&sb, fp, '\n'))
> +		return -1;
> +...
> +	strbuf_reset(value);
> +	strbuf_addstr(value, str);
> +
> +	strbuf_release(&sb);
> +
> +	return 0;
> +}

As you use a separate sb strbuf variable here, there is no need for
"value" to be pointing at a strbuf; it could be "char **" that sb's
contents is detached into.
