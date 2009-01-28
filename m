From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v1 2/6] remove some memcpy() and strchr() calls
 inside create_directories()
Date: Wed, 28 Jan 2009 12:36:57 -0800
Message-ID: <7vd4e7np5i.fsf@gitster.siamese.dyndns.org>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-3-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSHCe-0008BP-I9
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 21:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963AbZA1UhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 15:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756777AbZA1UhF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 15:37:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620AbZA1UhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 15:37:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB08694E41;
	Wed, 28 Jan 2009 15:37:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6839A94E3E; Wed,
 28 Jan 2009 15:36:59 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B3C88F0-ED7B-11DD-A11B-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107572>

Kjetil Barvik <barvik@broadpark.no> writes:

> OK, maybe I instead should have tried to merge the function
> create_directories() with the safe_create_leading_directories() and
> *_const() functions?  What do pepople think?

Strictly speaking, the safe_create_leading_* functions are meant to work
on paths inside $GIT_DIR and are not meant for paths inside the work tree,
which is this function is about.  Their semantics are different with
respect to adjust_shared_perm().

Which means that you would either have two variants (one for work tree
paths, and another for paths inside $GIT_DIR), or a unified function that
has an argument to specify whether to run adjust_shared_perm().

HOWEVER.

That is only "strictly speaking".

A non-bare repository that is shared feels like an oximoron, but perhaps
there is a valid "shared work area" workflow that may benefit from such a
setup.

I see existing (mis)uses of the safe_create_leading_* in builtin-apply.c,
builtin-clone.c (the one that creates the work_tree, the other one is Ok),
merge-recursive.c (both call sites) that are used to touch the work tree,
but all places that create regular files in the work tree do not run
adjust_shared_perm() but simply honor the user's umask.

If we _were_ to support a "shared work area" workflow, having a unified
"create leading directory" function that always calls adjust_shared_perm()
may make sense (note that adjust_shared_perm() is a no-op in a non-shared
repository).  We then need to also call adjust_shared_perm() for codepaths
that create regular files as well, though (e.g. write_entry() in entry.c,
but there are many others).

> diff --git a/entry.c b/entry.c
> index 05aa58d..c2404ea 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -2,15 +2,19 @@
>  #include "blob.h"
>  #include "dir.h"
>  
> -static void create_directories(const char *path, const struct checkout *state)
> +static void
> +create_directories(int path_len, const char *path, const struct checkout *state)

Please do not split the line like this.

The existing sources are not laid out to allow "grep ^funcname(", nor are
we going to reformat all the files to support such a use case.

When we pass <string, length> pair to functions, I think we pass them in
the order I just wrote in all the other functions.

The micro-optimization itself makes sense to me, though.
