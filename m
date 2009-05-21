From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: handle filenames with double slashes better
Date: Thu, 21 May 2009 07:56:10 -0700
Message-ID: <7vd4a2bj3p.fsf@alter.siamese.dyndns.org>
References: <20090521122511.GA31614@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 21 16:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M79gz-0003VW-8L
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 16:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbZEUO4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 10:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbZEUO4K
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 10:56:10 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34399 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbZEUO4J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 10:56:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521145610.CQXM17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 May 2009 10:56:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id uEwA1b0054aMwMQ04EwAfG; Thu, 21 May 2009 10:56:10 -0400
X-Authority-Analysis: v=1.0 c=1 a=YytS7IVUZiMA:10 a=MBz2rtpSkVcA:10
 a=Eqi7vWcb6qFzHn3yT6sA:9 a=0Wl7K0n8f0mpNfOwnOAA:7
 a=1V5vgyLUBE__l6kGL6CJjaWtfCgA:4
X-CM-Score: 0.00
In-Reply-To: <20090521122511.GA31614@sepie.suse.cz> (Michal Marek's message of "Thu\, 21 May 2009 14\:25\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119688>

Michal Marek <mmarek@suse.cz> writes:

> Collapse double slashes to make patches like this work with --index or
> --cached:
>
> git apply --index <<-EOF
> 	--- a/perl//Git.pm
> 	+++ b/perl//Git.pm
> 	@@ -1358,3 +1358,4 @@
>
>
> 	 1; # Famous last words
> 	+# test
> EOF
>
> Signed-off-by: Michal Marek <mmarek@suse.cz>

Hmm, I do not know if this is a good change.

For duplicate slashes in paths, I do not think there is any other sensible
way to handle them other than squashing them together, but naming the
function to do so "canon_name()" would tempt people to add other
not-so-clearly-sensible "canonicalization" such as turning "./a" to "a"
(which we shouldn't --- we should treat "./" as one level so that we keep
behaving in a similar way as "patch -p1" does) or "a/../b" to "b".

Also calling this in find_name() loses information too early in the
processing; how bad would it look if you move the callsite of this
duplicate slash squashing down the callchain where the names are actually
used?
