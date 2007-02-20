From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 01:04:25 -0800
Message-ID: <7vlkitxkrq.fsf@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200841.26578.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJQvH-0002ZC-Dv
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbXBTJE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbXBTJE2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:04:28 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:49920 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932705AbXBTJE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:04:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220090425.FTHX21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 04:04:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rl4R1W0021kojtg0000000; Tue, 20 Feb 2007 04:04:26 -0500
In-Reply-To: <200702200841.26578.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 08:41:24 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40214>

Andy Parkins <andyparkins@gmail.com> writes:

> As I've said before, I'm against /any/ special treatment of
> master other than as a default branch name in a newly
> initialised repository.  PATH_REFS_HEADS_MASTER is closer to
> master not being special than without so I'd be in favour of
> that.

Ok.

>> These repeated strncmp(p, X, STRLEN_X) almost makes me wonder if we
>> want to introduce:
>>
>> 	inline int prefixcmp(a, b)
>>         {
>>         	return (strncmp(a, b, strlen(b));
>>         }
>>
>> with clever preprocessor optimization to have compiler do strlen()
>> when b is a string literal.
>
> Wow; that would be clever - regardless of whether this patch
> is acceptable or not.

Actually GCC seems to be clever enough.  It appears that I do
not even have to do prefixcmp_0() below; prefixcmp_1() seems to
generate good code, with GCC 4.1.2 prerelease on my x86_64.

-- >8 --
#include <string.h>
static inline int prefixcmp_0(const char *a, const char *b)
{
	if (__builtin_constant_p(b))
		return strncmp(a, b, sizeof(b) - 1);
	else
		return strncmp(a, b, strlen(b));
}

static inline prefixcmp_1(const char *a, const char *b)
{
	return strncmp(a, b, strlen(b));
}

void foo(const char *s, const char *t, int *a, int *b, int *c, int *d)
{
	*a = prefixcmp_0(s, "abcdefg");
	*b = prefixcmp_0(s, t);
	*c = prefixcmp_1(s, "ABCDEFGH");
	*d = prefixcmp_1(s, t);
}
-- 8< --
