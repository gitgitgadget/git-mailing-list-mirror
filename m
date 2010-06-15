From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] common_prefix: be more careful about pathspec bounds
Date: Tue, 15 Jun 2010 20:04:01 +0200
Message-ID: <201006152004.01507.trast@student.ethz.ch>
References: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch> <7v8w6g8hfx.fsf@alter.siamese.dyndns.org> <7v4oh48elm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 20:04:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOaUp-0001uA-5K
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 20:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab0FOSES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 14:04:18 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:52861 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014Ab0FOSER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 14:04:17 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 15 Jun
 2010 20:04:14 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 15 Jun
 2010 20:04:01 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <7v4oh48elm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149212>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Isn't it more intuitive to structure the loop by saying 'Ok, if "path" up
> > to the currently proposed "prefix" is too long to match, let's shorten it
> > by one path component and try again'?
> 
> Another way of saying this, which probably needs less number of scans,
> would be to shorten prefix to what is known to match --- use of memcmp()
> discards this information.
[...]
> 	while ((next = *++pathspec) != NULL) {
> 		int len, last_matching_slash = -1;
> 		for (len = 0; len < prefix && next[len] == path[len]; len++)
> 			if (next[len] == '/')
> 				last_matching_slash = len;
> 		if (len == prefix)
> 			continue;
> 		if (last_matching_slash < 0)
> 			return 0;
> 		prefix = last_matching_slash + 1;
> 	}
> 	return prefix;
> }

I really didn't like the two-interleaved-loops version in your last
mail, but this one is way more readable than even the original.

(Why did you wrap the for loop? It's only 76 chars.)

Maybe you could add a comment like

> 	slash = strrchr(path, '/');
> 	if (!slash)
> 		return 0;
	/* The first 'prefix' characters of 'path' always include the
	   trailing slash of the prefix directory */
> 	prefix = slash - path + 1;

to clean up any doubts about the correctness of the matching.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
