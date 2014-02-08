From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] builtin/blame.c::prepare_lines: fix allocation size of sb->lineno
Date: Sat, 08 Feb 2014 10:49:40 +0100
Message-ID: <87lhxmc4sr.fsf@fencepost.gnu.org>
References: <1391851166-10393-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 10:49:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC4Xn-0001S2-4C
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 10:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaBHJto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 04:49:44 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:40893 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaBHJtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 04:49:41 -0500
Received: from localhost ([127.0.0.1]:39936 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WC4Xc-0002KU-KY
	for git@vger.kernel.org; Sat, 08 Feb 2014 04:49:40 -0500
Received: by lola (Postfix, from userid 1000)
	id 25262E12E5; Sat,  8 Feb 2014 10:49:40 +0100 (CET)
In-Reply-To: <1391851166-10393-1-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Sat, 8 Feb 2014 10:19:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241831>

David Kastrup <dak@gnu.org> writes:

> If we are calling xrealloc on every single line, the least we can do
> is get the right allocation size.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
> This should be less contentious than the patch in
> <URL:http://permalink.gmane.org/gmane.comp.version-control.git/241561>,
> Message-ID: <1391550392-17118-1-git-send-email-dak@gnu.org> as it
> makes no stylistic decisions whatsoever and only fixes a clear bug.
>
> builtin/blame.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e44a6bb..29eb31c 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1779,7 +1779,7 @@ static int prepare_lines(struct scoreboard *sb)
>  	while (len--) {
>  		if (bol) {
>  			sb->lineno = xrealloc(sb->lineno,
> -					      sizeof(int *) * (num + 1));
> +					      sizeof(int) * (num + 1));

But please note that since sb->lineno originally comes from a zeroed
memory area and is passed to xrealloc, this requires that after

int *p;
memset(&p, 0, sizeof(p));

the equivalence

((void *)p == NULL)

will hold.  While this is true on most platforms, and while the C
standard guarantees the slightly different
((void *)0 == NULL)
is true, it makes no statement concerning the memory representation of
the NULL pointer.

I have not bothered addressing this non-compliance with the C standard
as it would be polishing a turd.  A wholesale replacement has already
been proposed, and it's likely that this assumption is prevalent in the
Git codebase elsewhere anyway.

-- 
David Kastrup
