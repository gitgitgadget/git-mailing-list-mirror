From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: [DOC BUG] git tag uses GIT_COMMITTER_DATE, not GIT_AUTHOR_DATE
Date: Mon, 11 Feb 2008 10:38:23 +0200
Message-ID: <87ir0vc2gw.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 09:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUBy-000349-Ef
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYBKIhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYBKIhr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:37:47 -0500
Received: from 82-128-242-48-Rajakyla-TR1.suomi.net ([82.128.242.48]:57454
	"EHLO Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751919AbYBKIhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:37:46 -0500
X-Greylist: delayed 716 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2008 03:37:45 EST
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1JOUBD-0000yf-HN
	for git@vger.kernel.org; Mon, 11 Feb 2008 10:38:23 +0200
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73483>

In Git v1.5.4.1, Documentation/git-tag.txt advises:

> To set the date used in future tag objects, set the environment
> variable GIT_AUTHOR_DATE to one or more of the date and time.  The
> date and time can be specified in a number of ways; the most common
> is "YYYY-MM-DD HH:MM".

But this does not work because git tag uses GIT_COMMITTER_DATE instead.
In builtin-tag.c:

> 	header_len = snprintf(header_buf, sizeof(header_buf),
> 			  "object %s\n"
> 			  "type %s\n"
> 			  "tag %s\n"
> 			  "tagger %s\n\n",
> 			  sha1_to_hex(object),
> 			  typename(type),
> 			  tag,
> 			  git_committer_info(IDENT_ERROR_ON_NO_NAME));

i.e. it does not call git_author_info.

The backdating section was added to git-tag.txt in 5040beff,
and builtin-tag.c already used git_committer_info at that time.
The older git-tag.sh used tagger=$(git-var GIT_COMMITTER_IDENT).
Thus it seems the bug is in the documentation, not in the code.
