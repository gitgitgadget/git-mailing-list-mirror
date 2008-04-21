From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mark parsing in fast-import
Date: Sun, 20 Apr 2008 20:26:27 -0400
Message-ID: <20080421002626.GJ29771@spearce.org>
References: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de> <20080414232958.GE20979@spearce.org> <20080420234438.GC12865@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 21 02:27:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnjsO-0002lb-HY
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 02:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbYDUA0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 20:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYDUA0d
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 20:26:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53796 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbYDUA0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 20:26:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JnjrO-0002au-Ra; Sun, 20 Apr 2008 20:26:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9133320FBAE; Sun, 20 Apr 2008 20:26:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080420234438.GC12865@alea.gnuu.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80006>

Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > 
> > Uh, that's a bug in fast-import.  ":4abc" is _not_ a mark if you
> > read the language specification.  Only ":4" is a mark.  So we are
> > accepting crap and reading it in odd ways.  Not good.
> 
> What about this:
> 
> diff --git a/fast-import.c b/fast-import.c
> index 73e5439..f60e4ab 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1690,10 +1690,31 @@ static void skip_optional_lf(void)
>  		ungetc(term_char, stdin);
>  }
>  
> +static inline int parse_mark(const const char *str, uintmax_t* mark,
> +	char **after_mark)
> +{
> +	if (!str || str[0] != ':' || !isdigit(str[1]))
> +		return 1;
> +
> +	char *am;

Although we conform to mostly C99 style, variables should be
declared at the top of the scope and not after a statement.

> +	const uintmax_t m = strtoumax(&str[1], &am, 10);
> +	if (errno == 0) {
> +		*mark = m;
> +		*after_mark = am;
> +		return 0;
> +	}
> +	return 1;
> +}
> +
>  static void cmd_mark(void)
>  {
> -	if (!prefixcmp(command_buf.buf, "mark :")) {
> -		next_mark = strtoumax(command_buf.buf + 6, NULL, 10);
> +	uintmax_t mark = 0;
> +	char *after_mark = NULL;
> +
> +	if (!prefixcmp(command_buf.buf, "mark ") &&
> +		parse_mark(&command_buf.buf[5], &mark, &after_mark) &&

Hmm.  Shouldn't this be ! parse_mark given that it returns 0
on success and 1 on failure?


-- 
Shawn.
