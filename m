From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git mv: Support moving submodules
Date: Fri, 12 Sep 2008 15:19:07 -0700
Message-ID: <7vprn9m2hw.fsf@gitster.siamese.dyndns.org>
References: <20080912210908.31628.50439.stgit@localhost>
 <20080912214129.14829.53058.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 13 00:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeH01-0005Q5-D5
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600AbYILWTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756694AbYILWTN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:19:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbYILWTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 18:19:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 421307E10A;
	Fri, 12 Sep 2008 18:19:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA92B7E108; Fri, 12 Sep 2008 18:19:08 -0400 (EDT)
In-Reply-To: <20080912214129.14829.53058.stgit@localhost> (Petr Baudis's
 message of "Fri, 12 Sep 2008 23:42:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D3BDC738-8118-11DD-AA66-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95781>

Petr Baudis <pasky@suse.cz> writes:

> diff --git a/builtin-mv.c b/builtin-mv.c
> index 4f65b5a..2970acc 100644
> --- a/builtin-mv.c
> +++ b/builtin-mv.c
> @@ -9,6 +9,7 @@
>  #include "cache-tree.h"
>  #include "string-list.h"
>  #include "parse-options.h"
> +#include "submodule.h"
>  
>  static const char * const builtin_mv_usage[] = {
>  	"git mv [options] <source>... <destination>",
> @@ -49,6 +50,24 @@ static const char *add_slash(const char *path)
>  	return path;
>  }
>  
> +static int ce_is_gitlink(int i)
> +{
> +	return i < 0 ? 0 : S_ISGITLINK(active_cache[i]->ce_mode);
> +}

This interface itself is ugly (why should a caller pass "it is unmerged or
does not exist" without checking?), and it also makes the hunk that begins
at 84/105 ugly.  Why not "path_is_gitlink(const char*)" and run
cache_name_pos() here instead?

The interface, even if it is internal, should be done with a better taste
than that, even though I understand that you wanted to reuse the cache_pos
for the source one while you check.

Oh, by the way, what should happen when you have an unmerged path in the
index and say "git mv path elsewhere" (this question is *not* limited to
submodules).  Compared to that, what _does_ happen with the current code,
and with your patch?
