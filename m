From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (preview) Renaming push.
Date: Wed, 03 Aug 2005 18:02:51 -0700
Message-ID: <7vmzny5xac.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508031908.22562.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
	<7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 03:08:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0UDL-0005Sr-Fh
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 03:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVHDBGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 21:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVHDBE0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 21:04:26 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14826 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261738AbVHDBCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 21:02:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804010253.OUJC8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 21:02:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508031641270.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 16:48:13 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Well, I pushed it out, although I do agree that we should be
able to give anything get_sha()-able on the source side of the
push.  Probably a revised version should have the following
semantics:

    $ git-send-pack [--all] <remote> [<ref>...]

 - When no <ref> is specified:

   - with '--all', it is the same as specifying the full refs/*
     path for all local refs;

   - without '--all', it is the same as specifying the full
     refs/* path for refs that exist on both ends;

 - When one or more <ref>s are specified:

   - a single token <ref> (i.e. no colon) must be a pattern that
     tail-matches refs/* path for an existing local ref.  It is
     an error for the pattern to match no local ref, or more
     than one local refs.  The matching ref is pushed to the
     remote end under the same name.

   - <src>:<dst> can have different cases.  <src> is first tried
     as the tail-matching pattern for refs/* path.

     - If more than one matches are found, it is an error.

     - If one match is found, <dst> must either match no remote
       ref and start with "refs/", or match exactly one remote
       ref.  That remote ref is updated with the sha1 value
       obtained by the <src> sha1.

     - If no match is found, it is given to get_extended_sha1();
       it is an error if get_extended_sha1() does not find an
       object name.  If it succeeds, <dst> must either match
       no remote ref and start with "refs/" or match exactly
       one remote ref.  That remote ref is updated with the sha1
       value.
