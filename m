From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] git_odb_open ckeck for valid path to database
Date: Mon, 09 Nov 2009 19:16:15 +0000
Message-ID: <4AF86A7F.1010500@ramsay1.demon.co.uk>
References: <1257510729-6803-1-git-send-email-kde@mosehansen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: ae@op5.com, git@vger.kernel.org
To: Esben Mose Hansen <kde@mosehansen.dk>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7a16-0008Dt-Sl
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 20:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbZKITe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 14:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbZKITe5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 14:34:57 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:41461 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbZKITe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 14:34:56 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1N7a0z-0004lx-k5; Mon, 09 Nov 2009 19:35:01 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1257510729-6803-1-git-send-email-kde@mosehansen.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132510>

Esben Mose Hansen wrote:
> diff --git a/src/odb.c b/src/odb.c
> index 6d646a4..89d6d03 100644
> --- a/src/odb.c
> +++ b/src/odb.c
> @@ -30,6 +30,10 @@
>  #include "hash.h"
>  #include "odb.h"
>  
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +

None of these #includes should be necessary (they are not for me).
Also, "#include <unistd.h>" breaks on windows ;-)

>  #define GIT_PACK_NAME_MAX (5 + 40 + 1)
>  struct git_pack {
>  	git_odb *db;
> @@ -1023,6 +1027,15 @@ int git_odb_open(git_odb **out, const char *objects_dir)
>  		free(db);
>  		return GIT_ERROR;
>  	}
> +	struct stat objects_dir_stat;

This should be declared at the head of the function (or generally at the start of
a block/scope); ie we don't use this C99 facility. This breaks MSVC, which does
not understand C99.

> +	if (stat(db->objects_dir, &objects_dir_stat)) {
> +		free(db);
> +		return GIT_EOSERR;
> +	}
> +	if (!S_ISDIR(objects_dir_stat.st_mode)) {

This breaks on MSVC, since the MS headers do not define S_ISDIR. It's not difficult
to add; it's on my TODO list. (Andreas, I can add this later if you like)

However, I suspect it may be useful to add an gitfo_is_directory() function, or
something like it. Maybe. Andreas?

Thank you for the patch.

(I think Andreas would prefer to see libgit2 somewhere in the subject, perhaps
like [LIBGIT2 PATCH], otherwise he may miss you email)

ATB,
Ramsay Jones
