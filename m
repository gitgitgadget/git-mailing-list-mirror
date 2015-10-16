From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] stripspace: Use parse-options for command-line parsing
Date: Fri, 16 Oct 2015 10:07:34 -0700
Message-ID: <xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-3-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn8Tu-0003UB-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbbJPRHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:07:38 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33704 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbbJPRHg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:07:36 -0400
Received: by pabrc13 with SMTP id rc13so125745718pab.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=teAJae6A6AbvCHiFuDux42q78+DqIIAaDoacm4XA43o=;
        b=GgSTYD7xinCRDQwVQx4Heu4kTzKBwG6OLQS7eU1FDW3J8UitYy6BUnr6nVo/MqJC9O
         TgB8d/pTeOn7nBcTdNJa9TAetLaWNQkuBYckEtyUoHK9DjkPIseja3nWjX7meRxpqtWG
         NvgB4Iu9jlqG6BWuj1UAKBrSCT+uB3S/jDBrq9rKQuB9WAFw/mH/rxjjWlWX6sogcXQa
         81RNpwUl0r6iEhcsBnmM0Ke55/SoSQ31SLxzEHBByrSzzJerbh10B5E/6qf4EgWLa7JN
         CE1QM3JzQBIY/NWQ9VxYag28DseUYudfpVB6e35RV3zpP49Lh1uK11O8ZVOhm5H53Un9
         w0Kw==
X-Received: by 10.68.200.167 with SMTP id jt7mr17637298pbc.83.1445015255771;
        Fri, 16 Oct 2015 10:07:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id hq1sm10610278pbb.43.2015.10.16.10.07.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 10:07:35 -0700 (PDT)
In-Reply-To: <1445008605-16534-3-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Fri, 16 Oct 2015 17:16:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279754>

Tobias Klauser <tklauser@distanz.ch> writes:

> Use parse-options to parse command-line options instead of a
> hand-crafted implementation.
>
> This is a preparatory patch to simplify the introduction of the
> --count-lines option in a follow-up patch.

The second paragraph is probably of much lessor importance than one
thing you forgot to mention: the users can now use a unique prefix
of the option and say "stripspace --comment".

> +enum stripspace_mode {
> +	STRIP_DEFAULT = 0,
> +	STRIP_COMMENTS,
> +	COMMENT_LINES
> +};
>  
>  int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	int strip_comments = 0;
> -	enum { INVAL = 0, STRIP_SPACE = 1, COMMENT_LINES = 2 } mode = STRIP_SPACE;
> -
> -	if (argc == 2) {
> -		if (!strcmp(argv[1], "-s") ||
> -		    !strcmp(argv[1], "--strip-comments")) {
> -			strip_comments = 1;
> -		} else if (!strcmp(argv[1], "-c") ||
> -			   !strcmp(argv[1], "--comment-lines")) {
> -			mode = COMMENT_LINES;
> -		} else {
> -			mode = INVAL;
> -		}
> -	} else if (argc > 1) {
> -		mode = INVAL;
> -	}
> -
> -	if (mode == INVAL)
> -		usage(usage_msg);

When given "git stripspace -s blorg", we used to set mode to INVAL
and then showed the correct usage.  But we no longer have a check
that corresponds to the old INVAL thing, do we?  Perhaps check argc
to detect presence of an otherwise ignored non-option argument
immediately after parse_options() returns?

> -	if (strip_comments || mode == COMMENT_LINES)
> +	enum stripspace_mode mode = STRIP_DEFAULT;
> +
> +	const struct option options[] = {
> +		OPT_CMDMODE('s', "strip-comments", &mode,
> +			    N_("skip and remove all lines starting with comment character"),
> +			    STRIP_COMMENTS),
> +		OPT_CMDMODE('c', "comment-lines", &mode,
> +			    N_("prepend comment character and blank to each line"),
> +			    COMMENT_LINES),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, stripspace_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);

What is the point of keep-dashdash here?
