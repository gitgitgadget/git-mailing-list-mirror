From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 07 Nov 2007 12:42:16 -0800
Message-ID: <7vabppbxef.fsf@gitster.siamese.dyndns.org>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IprjT-00055O-RB
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbXKGUmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 15:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbXKGUmX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:42:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43721 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbXKGUmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 15:42:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DA1DC2F9;
	Wed,  7 Nov 2007 15:42:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 51AFA9301F;
	Wed,  7 Nov 2007 15:42:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63853>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> This replaces git-clean.sh with builtin-clean.c, and moves
> git-clean.sh to the examples.
>
> This also introduces a change in behavior where the -d parameter is
> required to remove an entire directory of untracked files even when
> the directory is passed as a path.

The updated behaviour may be better, but this description at the
first read makes one wonder if it is describing a regression as
if it is a feature.

> ... For example ...
> ...
> if 'dir' only contains untracked files.  This is consistent with the
> old behavior when two or more paths were specified.

I think what you fixed are two inconsistencies in the original
implementation.  If you spelled out the existing inconsistency
and described what your implementation does differently, the
proposal would start looking like a real improvement, like this:

    1. When dir has only untracked files, these two behave differently:

        $ git clean -n dir
        $ git clean -n dir/

    the former says "Would not remove dir/", while the latter would
    say "Would remove dir/untracked" for all paths under it.

    With -d, the former would stop refusing, but the difference in
    reporting is still there.  The latter lists all paths under the
    directory.

    2. When there are more parameters, the latter behave differently:

        $ git clean -n dir/ foo

    refuses to remove dir/.  This is inconsistent.

    My reimplementation changes the behaviour by always
    requiring the -d option with or without the trailing slash.

Having said that, I do not particularly agree with the way the
new implementation resolves the existing inconsistencies.  

Wouldn't it be better to remove "dir" when the user explicitly
told you to clean "dir", with or without the trailing slash?
That's what the user asked you to do, isn't it?
