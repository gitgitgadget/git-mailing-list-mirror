X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 03:00:35 -0700
Message-ID: <7v7iyno0qk.fsf@assigned-by-dhcp.cox.net>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3b9bpgvs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 10:00:45 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v3b9bpgvs.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 26 Oct 2006 02:26:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30175>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd22T-0007vn-VW for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423099AbWJZKAi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423103AbWJZKAh
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:00:37 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37507 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1423099AbWJZKAh
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:00:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026100036.PTBD12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 06:00:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ey0K1V0011kojtg0000000 Thu, 26 Oct 2006
 06:00:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>> BTW what happened to the builtin shortlog? It is the last Perl script I 
>> use regularly... (should make people happy who are stuck with Activision 
>> Perl...)
>
> Yeah, I was wondering about it too, when I was looking for
> something readily mergeable to "next" today.  I must have
> misplaced it.

I looked at the code again.

This is a prime demonstration that it makes more sense to keep
script version until we flush out configurability issues.

The built-in mailmap list is easily overridden with ".mailmap"
which presumably projects would want to keep under version
control, so it is less of an issue, but not everybody would
necessarily want to name that file ".mailmap".

There is a "dot3" merge source shortening logic that is very
specific to the kernel, and this cannot be customized per
project.  If it were kept as Perl script, each project could
limp along with a copy of this script, modified for their needs,
without making the script itself customizable.  Rewriting it
into C does not _forbid_ that kind of use, but certainly it
makes it more cumbersome to do so.

First I'd probably ask kernel folks to maintain their own
copy of .mailmap at the toplevel of their source tree, so that
we can remove this kernel specific built-in mailmap from
shortlog (I'd even do so before switching from the Perl
version).

The dot3 logic is probably best substituted with config, a
version controllable file similar to .mailmap, or command line
parameters, but I am not sure which one is the best way to go.
Whatever mechanism is used, It essentially is to define a
mapping from a long string to its abbreviation (currently there
is one hardcoded one, that replaces /pub/scm/linux/kernel/git/
to /.../), to be applied to the first line of log message body.
Presumably other projects could have more than one "popular"
prefixes that appear often, so (if we take command line
approach, which I think is the worst of the three possibilities)
the "slightly more generalized" version would look something
like this perhaps?

  git-shortlog --mailmapfile=.mailmap \
  	--abbrev=/pub/scm/linux/kernel/git/,/.../ \
        --abbrev=/pub/scm/,/.../../

We could even define the --abbrev stuff as 's/from/to/' but that
would make it harder for us to shake Perl off, and in practice
this is to shorten the merge source repository name, so
deliberately limiting its feature to simple string replace like
the above might make more sense.


