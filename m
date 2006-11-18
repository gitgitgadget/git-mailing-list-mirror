X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Fri, 17 Nov 2006 20:39:34 -0800
Message-ID: <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net>
References: <20061118041137.6064.75827.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 04:39:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118041137.6064.75827.stgit@machine.or.cz> (Petr Baudis's
	message of "Sat, 18 Nov 2006 05:11:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31752>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlHzP-00030r-Iq for gcvg-git@gmane.org; Sat, 18 Nov
 2006 05:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753872AbWKREjg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 23:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755959AbWKREjf
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 23:39:35 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19160 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1753872AbWKREjf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 23:39:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118043934.HXIG21630.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 23:39:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o4fh1V00r1kojtg0000000; Fri, 17 Nov 2006
 23:39:41 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Some of the ref manipulation tools (git-for-each-ref and git-show-ref in
> particular) would not handle hidden (~ /^\./) refs.

refs.c::check_ref_format() seems to suggest that any ref whose
path component begins with a dot is invalid (since October last
year), so I am a bit surprised you are bringing this up now.  Do
you know of specific examples where this is not enforced?  It
could even be argued that the places in the system that allow
such a ref are buggy.

I do not recall why we decided that this particular restriction
was needed (I do understand the other three restrictions --- see
commit log of 03feddd6), although I do think this is not a
gratuitous change but comes from a list discussion.  I suspect
it was to avoid confusion with ".." operator ("..." was added
much later in July this year), but it is not consistent that we
do not forbid the ones that end with a dot.

Maybe we should have found this inconsistency and added "names
that end with a dot" to the forbidden category when we
introduced the symmetric difference, but apparently nobody
noticed.  Right now foo...bar is seriously ambiguous.  Even
though it cannot be "foo" .. ".bar" (because ".bar" is not a
valid refname), it can be "foo." .. "bar" or "foo" ... "bar",
and worse yet spelling longhand form "refs/heads/foo." does not
help to disambiguate this.

