From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] commit encoding: store it in commit header rather than mucking with NUL
Date: Sun, 24 Dec 2006 16:13:42 -0800
Message-ID: <7v3b74q1c9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612241505290.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612241643440.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Dec 25 01:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GydTP-00085H-He
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 01:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWLYANo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 19:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbWLYANn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 19:13:43 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49225 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbWLYANn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 19:13:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225001342.JXPS2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Dec 2006 19:13:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2oDv1W00x1kojtg0000000; Sun, 24 Dec 2006 19:13:56 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612241643440.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 24 Dec 2006 16:44:50 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35377>

Thanks for paying a very close attention to what is in 'pu'.
The series was a work in progress not yet ready for publication,
which I merged by mistake because I was way too sleepy.

There are three reasons (and a half -- it was not even compile
tested) that I did not mean to merge it yet.

 - I did not want to break existing git implementations, but
   hadn't audited the commit header parsers to see if they do
   not get upset when they see unrecognized header fields in
   commit objects.  The 'trailer' was just a quick hack to have
   something working for me to test the output conversion code.
   I've looked at the code since then and I think it is Ok to
   add new ones after author/name fields like you did.

   If we _were_ to do this, I think it is preferable to make it
   a header, not a trailer like I did.

 - I was not sure if the "assume the whole commit->buffer is in
   the local encoding and recode it into UTF-8" is correct.  The
   message body ought to be in i18n.commitencoding from the
   repository the commit comes from, which is now recorded in
   the trailer (or the header as in your patch), but what I was
   unsure about was the encoding in which author and committer
   names are recorded.  I think they are set either by the
   environment variables or user.name to be consistent with
   i18n.commitencoding in the repository the commit is made, so
   it is Ok after all.

 - Existing Porcelains such as gitk know i18n.commitencoding is
   a hint to them by the core, and expect the core to give them
   output in the local encoding.  With the change, the core
   feeds UTF-8 to the caller, unless the Porcelain gets the log
   with plumbing "cat-file".  This means they either have to
   lose code to do their own recoding (which is probably a good
   thing in the long run), or we would need to have a flag for
   them to tell the core not to do the conversion.  But a new
   flag to ask for older behaviour is always a wrong way of
   transitioning across backward incompatibility.

   I think the output conversion from the log should be more
   explicitly asked for it, than just a mere configuration
   variable that cannot be overriden by gitk and friends.
