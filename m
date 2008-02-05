From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-commit: Refactor creation of log message.
Date: Mon, 04 Feb 2008 20:07:45 -0800
Message-ID: <7vzlugf3la.fsf@gitster.siamese.dyndns.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
	<14fc1ba3f94a773ab2e5b8cdf0c230962f32180d.1200933409.git.bonzini@gnu.org>
	<alpine.LSU.1.00.0802041646461.7372@racer.site>
	<47A747EB.9020909@gnu.org> <7vzluggp0q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:08:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMF79-0003P9-Lq
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 05:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbYBEEIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 23:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbYBEEIG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 23:08:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbYBEEID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 23:08:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0933C28FF;
	Mon,  4 Feb 2008 23:08:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E0A928FE;
	Mon,  4 Feb 2008 23:07:57 -0500 (EST)
In-Reply-To: <7vzluggp0q.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2008 17:39:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72620>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect Dscho was worried about the case where he says "git
> commit", types message and then write-tree finds out that the
> index is still unmerged and the tree cannot be written out.
>
> And I'd be majorly annoyed if the "slight disadvange" was about
> that.
>
>>         discard_cache();
>>         read_cache_from(index_file);
>>         if (!active_cache_tree)
>>                 active_cache_tree = cache_tree();
>>         if (cache_tree_update(active_cache_tree,
>>                               active_cache, active_nr, 0, 0) < 0) {
>>                 rollback_index_files();
>>                 die("Error building trees");
>>         }
>
> I think this _could_ error out if your index is unmerged.

I just tried.  This would annoy me.

It is common to do something like this:

	$ git cherry-pick -n somethingelse
        $ git add this-and-that-path.c
        $ git commit

to get partial changes from somethingelse for paths you only
care about, and commit the result.  And you often get conflicts
to paths that do not matter (think of backporting trivial part
of fixes).  You need to reset the paths you do not care about
that conflicted, but you can forget that before running "git
commit".

With our "git commit", you first get "foo: unmerged" and you do
not see the editor.  With this change, you edit the message and
then see "foo: ummerged".
