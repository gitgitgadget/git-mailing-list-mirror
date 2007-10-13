From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a simple option parser.
Date: Sat, 13 Oct 2007 21:16:55 +0200
Message-ID: <20071013191655.GA2875@steel.home>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 21:17:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgmU2-0001Ob-Kt
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 21:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbXJMTQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 15:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbXJMTQ7
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 15:16:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:29922 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbXJMTQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 15:16:58 -0400
Received: from tigra.home (Fc8ce.f.strato-dslnet.de [195.4.200.206])
	by post.webmailer.de (fruni mo6) (RZmta 13.4)
	with ESMTP id z02e33j9DD7C4K ; Sat, 13 Oct 2007 21:16:56 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 35DB5277AE;
	Sat, 13 Oct 2007 21:16:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DE19A56D22; Sat, 13 Oct 2007 21:16:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1192282153-26684-2-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0sy8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60753>

Pierre Habouzit, Sat, Oct 13, 2007 15:29:03 +0200:
> +static int opterror(struct option *opt, const char *reason, int flags)

"const struct option *opt"? You never modify the struct option itself,
only the values under the pointers it contains. Using const here will
allow the compiler to reuse string constants (not that there will be
much of the opportunity, but anyway) in the option arrays.

> +static int get_value(struct optparse_t *p, struct option *opt, int flags)

"const struct option *opt"?

> +static int parse_short_opt(struct optparse_t *p, struct option *options, int count)

"const struct option *options"?

> +int parse_options(int argc, const char **argv,
> +                  struct option *options, int count,
> +				  const char * const usagestr[], int flags)

"const struct option *options"?

> +void make_usage(const char * const usagestr[], struct option *opts, int cnt)

"const struct option *opts"?

Why not "const char *const *usagestr"? Especially if you change
"usagestr" (the pointer itself) later. "[]" is sometimes a hint that
the pointer itself should not be changed, being an array.

And you want make opts const.

BTW, it does not "make" usage. It calls the usage() or prints a usage
description. "make" implies it creates the "usage", which according to
the prototype is later nowhere to be found.

> +{
> +	struct strbuf sb;
> +
> +	strbuf_init(&sb, 4096);
> +	do {
> +		strbuf_addstr(&sb, *usagestr++);
> +		strbuf_addch(&sb, '\n');
> +	} while (*usagestr);

This will crash for empty usagestr, like  "{ NULL }". Was it
deliberately? (I'd make it deliberately, if I were you. I'd even used
cnt of opts, to force people to document all options).

> +     strbuf_addf(&sb, "\n%*s%s\n", USAGE_OPTS_WIDTH + USAGE_GAP, "",
> +		    opts->help);
...
> +	usage(sb.buf);

BTW, if you just printed the usage message out (it is about usage of a
program, isn't it?) and called exit() everyone would be just as happy.
And you wouldn't have to include strbuf (it is the only use of it),
less code, too. It'd make simplier to stea^Wcopy your implementation,
which I like :)
