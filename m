From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-apply - Add --include=PATH
Date: Sat, 23 Aug 2008 17:54:22 -0700
Message-ID: <7viqtrw7up.fsf@gitster.siamese.dyndns.org>
References: <1219523869.18365.106.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 02:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX3vt-0002qQ-7H
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 02:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbYHXAyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 20:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYHXAyb
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 20:54:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYHXAyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 20:54:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 567116548B;
	Sat, 23 Aug 2008 20:54:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6797165489; Sat, 23 Aug 2008 20:54:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 33B3B6B8-7177-11DD-BEBE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93505>

Joe Perches <joe@perches.com> writes:

> Add similar capability to --exclude=
>
> Allows selection of files to patch from a
> large patchset.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks; I don't see anything fundamentally wrong with what this patch
tries to achieve.

> @@ -2996,10 +2996,16 @@ static struct excludes {
>  	const char *path;
>  } *excludes;
>  
> +static struct includes {
> +	struct includes *next;
> +	const char *path;
> +} *includes;

Now this is ugly.  You can just add a new variable "*includes" that is of
exactly the same type as existing "*excludes" without introducing a new
type.

You should then find it disturbing that the shared type is still called
"struct excludes" even though it is now used for things you would want to
include.  You are right.  You can then either rename it to a more neutral
name, or (even better) use an existing type, such as "string_list".

Which would mean that this patch should be done as two patches:

 [1/2] builtin-apply.c: Use "string_list" for "--excludes".
 [2/2] builtin-apply.c: Add "--includes" option.

The first will be a preparatory step that does not change any externally
visible behaviour.  The only thing it will do is to change the type of
"excludes" to "struct string_list", to update the option parser to use
string_list_append() to add to it, and to update the way "use_patch()" to
iterate over the items in the exclude list.

The second will add a new "includes" variable, and do the moral equivalent
of what your patch did.

The first patch most likely should introduce a new helper function:

  int string_list_has_match(struct string_list *s, const char *path);

so that the update to "use_patch()" that needs to be done in the second
patch can just pass a different string_list to implement the additional
check.
