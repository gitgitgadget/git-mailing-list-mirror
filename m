From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/8] revert: report fine-grained errors from insn parser
Date: Wed, 11 Jan 2012 06:44:32 -0600
Message-ID: <20120111124432.GF32173@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 13:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkxSv-0006OI-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 13:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab2AKMjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 07:39:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab2AKMjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 07:39:36 -0500
Received: by iabz25 with SMTP id z25so1067795iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 04:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O0cK2Y53nV4uoQTxMUqmq9SlKzAcS59381FxXpJ5Rnc=;
        b=XOJMzGJI53uTOUQ+bA21Vi2ywu41b/8+5wBuwGTmI4iVk0AgFMZUOpYwCJS2ni/npm
         q1xLLkxn1k54QdZnSm7RSVijcqQ9iWb/XN6ysSKot0eWN7EgPZJV5pCrWYVgWcWjhTG5
         nAMkOVH0LRjQnjUoQ8Ltd2ufW6CvIkAnawWFw=
Received: by 10.50.170.35 with SMTP id aj3mr7172272igc.2.1326285575879;
        Wed, 11 Jan 2012 04:39:35 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id py9sm2623286igc.2.2012.01.11.04.39.35
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 04:39:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326212039-13806-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188360>

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -732,7 +732,22 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
>  	return 0;
>  }
>  
> -static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
> +static int parse_error(const char *message, const char *file,
> +		int lineno, char *error_line)
> +{
> +	const char *suffix = "";
> +	int error_len = strcspn(error_line, " \t\n");
> +
> +	if (error_len > 20) {
> +		error_len = 20;
> +		suffix = "...";
> +	}
> +	return error(_("%s:%d: %s: %.*s%s"), file, lineno, message,
> +		error_len, error_line, suffix);

Since the snippet used in an error message is a single word,
why is it called error_line?  (And why is the signature written
in a way that implies we might modify it, by the way?)

Missing /* TRANSLATORS: ... */ comment.

[...]
> @@ -757,11 +773,13 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
>  	*end_of_object_name = saved;
>  
>  	if (status < 0)
> -		return -1;
> +		return parse_error(_("malformed object name"),
> +				git_path(SEQ_TODO_FILE), lineno, bol);

This is the message I'll get if I misspell "master" as "mister" or try
to cherry-pick HEAD~100000 when the history is not that deep.  When I
read "malformed object name", I'll look for syntax errors and be
confused.  (They are valid syntax denoting commits that just happen
not to exist.)
