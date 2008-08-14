From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH v2 2/3] strbuf: Add method to convert byte-size to
	human readable form
Date: Fri, 15 Aug 2008 00:34:29 +0200
Message-ID: <20080814223429.GC10544@machine.or.cz>
References: <1218752308-3173-1-git-send-email-marcus@griep.us> <1218752308-3173-2-git-send-email-marcus@griep.us> <1218752308-3173-3-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlQ6-0005x9-Ps
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbYHNWed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYHNWec
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:34:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37455 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbYHNWeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:34:31 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 67C9E3939B56; Fri, 15 Aug 2008 00:34:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218752308-3173-3-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92425>

On Thu, Aug 14, 2008 at 06:18:27PM -0400, Marcus Griep wrote:
> Takes a strbuf as its first argument and appends the human-readable
> form of 'value', the second argument, to that buffer.
> 
> Argument 3, 'maxlen', specifies the longest string that should
> be returned. That will make it easier for any pretty-ish formatting
> like `ls` and `du` use. A value of 0 is unlimited length.

Frankly, I doubt this has too much value, and it complicates the code _a
lot_. If you can't fit your stuff into pretty column, it's better to
just print whatever you have to and disrupt the columns instead of
_failing_, isn't it?

> 'scale' specifies a boundary, above which 'value' should be
> reduced, and below which it should be reported. Commonly this is
> 1000.  If 0, then it will find a scale that best fits into 'maxlen'.
> If both 'maxlen' and 'scale' are 0, then scale will default to 1000.
> 
> 'suffix' is appended onto every formatted string.  This is often
> "", "B", "bps", "objects" etc.
> 
> 'flags' provides the ability to switch between a binary (1024)
> and an si (1000) period (HR_USE_SI).  Also, adding a space between
> number and unit (HR_SPACE).
> 
> On success, returns 0.  If maxlen is specified and there is not
> enough space given the scale or an inordinately large value, returns
> -n, where n is the amount of additional length necessary.
> 
> e.g. strbuf_append_human_readable(sb, 1012, 0, 0, "bps", HR_SPACE)
> produces "0.9 Kbps".

Shouldn't pretty much all of this be documented in the code too?

> Also, add in test cases to ensure it produces the expected output
> and to demonstrate what different arguments do.
> 
> Signed-off-by: Marcus Griep <marcus@griep.us>

My point still stands - in case of binary units, we should always
consistently use the i suffix. So having an example in the commit
message that advertises "bps" is simply wrong when it should read "iB/s"
(like it does with the current progress.c code).

I may sound boring, but it seems to me that you're still ignoring my
point quitly without proper counter-argumentation and I think it's an
important want, and since it's so hard to keep things consistent across
the wide Git codebase, we should do all we can to keep it.

> +int strbuf_append_human_readable(struct strbuf *sb,
> +				double val,
> +				int maxlen, int scale,
> +				const char *suffix,
> +				int flags)
> +{
> +	const int maxscale = 7;
> +
> +        char *hr_prefixes[] = {
> +		"", "K", "M", "G", "T", "P", "E", "Z", "Y", NULL
> +	};
> +        char **prefix = &hr_prefixes[0];

Whitespace damage? Also at a lot of other places in your patch.

> +	int period = 1024;
> +	int sign = val < 0 ? -1 : 1;
> +	/* Baselen is (sign, if needed) (digit) (space, if needed)
> +			(prefix) (suffix) */
> +	int baselen = (val < 0 ? 1 : 0) + 1 + (flags & HR_SPACE ? 1 : 0)
> +			+ 1 + strlen(suffix);
> +
> +	val *= sign;
> +
> +	if (flags & HR_USE_SI) {
> +		period = 1000;
> +		hr_prefixes[1] = "k";

Hmmm. We could have

+        char *hr_prefixes[] = {
+		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi", NULL
+	};
+        char *hr_si_prefixes[] = {
+		"", "k", "M", "G", "T", "P", "E", "Z", "Y", NULL
+	};

;-)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
