From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] Make branch merging aware of underlying
 case-insensitive filsystems
Date: Sat, 22 Mar 2008 23:13:09 -0700
Message-ID: <7v7ifueznu.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 07:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdJTC-0002Dn-69
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 07:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbYCWGNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 02:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbYCWGNX
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 02:13:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYCWGNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 02:13:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3617124E;
	Sun, 23 Mar 2008 02:13:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E95EC124D; Sun, 23 Mar 2008 02:13:13 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sat, 22 Mar 2008 10:38:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77868>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> @@ -540,6 +556,16 @@ static int verify_absent(struct cache_entry *ce, const char *action,
>  		int dtype = ce_to_dtype(ce);
>  		struct cache_entry *result;
>  
> +		/*
> +		 * It may be that the 'lstat()' succeeded even though
> +		 * target 'ce' was absent, because there is an old
> +		 * entry that is different only in case..
> +		 *
> +		 * Ignore that lstat() if it matches.
> +		 */
> +		if (ignore_case && icase_exists(o, ce, &st))
> +			return 0;
> +

It may well be the case that this lstat() returning success was caused by
a ghost match with a file with different case, and I think it is the right
thing to say "no, it does not exist" if that is the case.

I wonder what happens when the file with the same case does exist that we
are trying to make sure is missing?

As far as I can tell, icase_exists() does not ask "does a file with this
name in different case exist, and a file with this exact case doesn't?"
but asks "does a file with this name, or another name that is different
only in case, exist?".
