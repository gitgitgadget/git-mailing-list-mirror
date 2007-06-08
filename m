From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain an empty line
Date: Thu, 07 Jun 2007 22:17:50 -0700
Message-ID: <7vmyzbm3cx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 07:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwWrI-0006gD-VI
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 07:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbXFHFRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 01:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758216AbXFHFRw
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 01:17:52 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60156 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbXFHFRv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 01:17:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608051752.YFQS5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 01:17:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8tHq1X00B1kojtg0000000; Fri, 08 Jun 2007 01:17:50 -0400
In-Reply-To: <Pine.LNX.4.64.0706072338260.4046@racer.site> (Johannes
	Schindelin's message of "Thu, 7 Jun 2007 23:40:12 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49432>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The first empty line in a tag object separates the header from the
> message. If the tag object has no empty line, do not crash, but
> complain loudly instead.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	I have no idea how this tag crept into one of my repos, but it is 
> 	no good to crash for git-fsck.

Absolutely.  git-fsck is to find suspicious data and should not
crash on them.

Thanks.

But it _does_ make me wonder how.  Recent git-tag does this

    ( printf 'object %s\ntype %s\ntag %s\ntagger %s\n\n' \
	"$object" "$type" "$name" "$tagger";
      cat "$GIT_DIR"/TAG_FINALMSG ) >"$GIT_DIR"/TAG_TMP

so even if TAG_FINALMSG (which is -m or edited message after
filtering out the comments and git-stripspace) is empty, you
would have the two LFs at the end of the header.  Ancient
"git-tag-script" did this, which is a moral equivalent with echo
and has the same effect:

  ( echo -e "object $object\ntype $type\ntag $name\ntagger $tagger\n";
    cat .tagmsg ) > .tmp-t

Did this tag come from cvsimport (or svnimport) perhaps?  We are
in the process of updating its use of git-mktag to git-tag, but
they use git-mktag and do not leave a blank line after the
header (and they do not add any body).

I notice that gitk creates lightweight tag by hand (it directly
goes to the filesystem)  It should probably use git-tag as well.

I agree with you that if something does not have body, we should
not require an empty trailing line after the header.
