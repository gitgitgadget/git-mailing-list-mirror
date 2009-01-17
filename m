From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 3/5] sha1_name: support @{-N} syntax in get_sha1()
Date: Sat, 17 Jan 2009 11:37:36 -0800
Message-ID: <7v63kd7mgv.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 20:39:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOH0l-0004bh-28
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 20:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763709AbZAQThr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 14:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763580AbZAQThr
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 14:37:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762118AbZAQThq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 14:37:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0952F910D5;
	Sat, 17 Jan 2009 14:37:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B80AA910D4; Sat,
 17 Jan 2009 14:37:38 -0500 (EST)
In-Reply-To: <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Sat, 17 Jan 2009 17:09:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 502940A4-E4CE-11DD-B6B5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106096>

Thomas Rast <trast@student.ethz.ch> writes:

> Let get_sha1() parse the @{-N} syntax, with docs and tests.
>
> Note that while @{-1}^2, @{-2}~5 and such are supported, @{-1}@{1} is
> currently not allowed.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ...
> @@ -324,6 +326,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  		return -1;
>  
>  	if (!len && reflog_len) {
> +		struct strbuf buf = STRBUF_INIT;
> +		int ret;
> +		/* try the @{-N} syntax for n-th checkout */
> +		ret = interpret_nth_last_branch(str+at, &buf);
> +		if (ret > 0) {
> +			/* substitute this branch name and restart */
> +			return get_sha1_1(buf.buf, buf.len, sha1);
> +		} else if (ret == 0) {
> +			return -1;
> +		}

What are the possible failure cases, and what do we want to tell the
end-user?

 - You asked for 3rd but there weren't that many switches yet, and ask
   "git rev-parse --verify @{-3}".

   Are we Ok with "fatal: Needed a single revision" from rev-parse?  Do we
   want to show "fatal: @{-3}: not that many branch switches yet"?

   What happens to "git checkout @{-3}" in this case?  Having checkout say
   "fatal: invalid reference: @{-3}" would be fine in this case, I think.

 - You try "git checkout @{-3}", you were on "frotz" branch back then, but
   the branch does not exist anymore.

   I think you will get "fatal: invalid reference: frotz" from checkout,
   which should be fine.

There also is a case where nth_last_branch() may find something that is
not a branch (e.g. "git checkout HEAD^"), but I am hoping we can label
that as a bug in nth_last_branch() and fix it later.
