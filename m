From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek() sequence.
Date: Tue, 09 Jan 2007 12:21:55 -0800
Message-ID: <7v1wm4kl24.fsf@assigned-by-dhcp.cox.net>
References: <11683687161816-git-send-email-> <11683687162492-git-send-email->
	<41319.3372231492$1168368741@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 21:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4NTs-0001JU-2f
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbXAIUV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXAIUV5
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:21:57 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37635 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbXAIUV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 15:21:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109202156.DIOV20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 15:21:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 98M51W00e1kojtg0000000; Tue, 09 Jan 2007 15:21:06 -0500
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36391>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> Using cygwin with cygwin.dll before 1.5.22 the system call pread() is buggy.
> This patch introduces NO_PREAD. If NO_PREAD is set git uses a sequence of
> lseek()/xread()/lseek() to emulate pread.
>
> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>

Thanks.

> +# Define NO_PREAD if you have a problem with pread() system call (i.e.
> +# cygwin.dll before v1.5.22).
> +#

I would have preferred e.g. not i.e..

> diff --git a/compat/pread.c b/compat/pread.c
> new file mode 100644
> index 0000000..cd1da87
> --- /dev/null
> +++ b/compat/pread.c
> @@ -0,0 +1,15 @@
> +#include "../git-compat-util.h"
> +
> +ssize_t git_pread(int fd,void *buf,size_t count,off_t offset)

Style: s/,/, /; applies to git-compat-util.h as well.

> +{
> +        off_t current_offset = lseek(fd, 0, SEEK_CUR);
> +
> +        if (lseek(fd, offset, SEEK_SET) < 0)
> +                return EINVAL;
> +
> +        ssize_t rc=xread(fd, buf, count);

Style: please don't have declaration after statement.  Yes, it
is in the more recent ANSI, but the rest of git has avoided it
so far and having the decls upfront makes it easier to read.

I do not think you would want to return EINVAL.

Andy's read_in_full() is now on 'master' so please use it
instead to avoid short read.
