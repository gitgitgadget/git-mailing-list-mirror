From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace differences
Date: Thu, 02 Jul 2009 11:27:29 -0700
Message-ID: <7vvdmb6ium.fsf@alter.siamese.dyndns.org>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 20:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMR0U-0002xb-W5
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 20:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbZGBS12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbZGBS11
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 14:27:27 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53199 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZGBS11 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 14:27:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702182730.CZVZ17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Jul 2009 14:27:30 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id B6TW1c0024aMwMQ036TWn9; Thu, 02 Jul 2009 14:27:30 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=SK8bdSSw-t4A:10 a=pGLkceISAAAA:8
 a=VDHlJhB3SuTdyCJzZ68A:9 a=Wpl5jC4eHMZ8QcIbKv_8D87ApiIA:4 a=MSl-tDqOz04A:10
 a=YG-BfwFBfczvAJXl:21 a=LDgFQ7vZayP8pzAM:21
X-CM-Score: 0.00
In-Reply-To: <1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com> (Giuseppe Bilotta's message of "Thu\,  2 Jul 2009 19\:48\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122663>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> +static int memcmp_ignore_whitespace(const char *s1, size_t n1, const char *s2, size_t n2)
> +{
> +	const char *stop1 = s1 + n1;
> +	const char *stop2 = s2 + n2;
> +	int result;
> +
> +	if (!(n1 | n2))
> +		return 0;
> +
> +	do {
> +		if (isspace(*s1) && isspace(*s2)) {
> +			while (isspace(*s1)) {
> +				s1++;
> +			}
> +			while (isspace(*s2))
> +				s2++;
> +		}
> +		/* Check here instead of in the while because
> +		   the whitespace discarding might have moved us
> +		   past the end */
> +		if ((s1 >= stop1) || (s2 >= stop2))
> +			break;

If s1 is longer than s2 (or vice versa) but one is a prefix of the other,
you will return "they match", because previous round compared *s1 and *s2
and found them the same?

> +/*
> + * Returns true if the given lines (buffer + len) match
> + * according to the ignore_whitespace setting
> + */
> +static int lines_match(const char *s1, size_t n1, const char *s2, size_t n2)
> +{
> +	if (ignore_whitespace)
> +		return !memcmp_ignore_whitespace(s1, n1, s2, n2);
> +	else
> +		return (n1 == n2) && !memcmp(s1, s2, n1);
> +}
> +

I think this still is an abstraction at the wrong level.  For one thing,
if ignore-whitespace is set, you do not even need nor want to do the "fix
only the ws breakages we are going to fix anyway according to the ws_rule"
transformation applied to the preimage.

I think the handling of correct_ws_error in the caller should also be
moved here.  IOW, shouldn't this function look like this?

	lines_match()
        {
        	/* if the user wants fuzz, so be it */
        	if (ignore_whitespace)
                	return compare_lines_wo_ws();
		/* most common case: matches without fuzzing */
		if (length matches && !memcmp())
                	return 1;
		/* we are done, if we are not correcting */
		if (ws_error_action != correct_ws_error)
                	return 0;
		... apply configured ws fix to preimage ...;
                /* does it apply with ws breakage in its context fixed? */
                if (length now matches && !memcmp(fixed preimage, postimage)
			return 1;
		/* noop, this won't apply */
		return 0;
	}

which would make the large-ish loop near the end of match_fragment() to
something like:

	for (i = 0; i < preimage->nr; i++) {
        	... set up arguments to lines_match ...;
		match = lines_match();
		if (!match)
                	goto unmatch_exit;
		... adjust for next iteration ...;
        }
