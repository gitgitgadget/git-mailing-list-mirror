From: Junio C Hamano <junkio@cox.net>
Subject: Re: clarifying two tree merge semantics
Date: Mon, 06 Jun 2005 12:59:58 -0700
Message-ID: <7voeajp875.fsf@assigned-by-dhcp.cox.net>
References: <7v64wrvpt4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506060748390.1876@ppc970.osdl.org>
	<7vbr6jtiqi.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506061210490.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:00:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfNkF-0004t3-1Q
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 21:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVFFUBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 16:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFFUBL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 16:01:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16276 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261656AbVFFUA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 16:00:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050606200000.WKQH16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Jun 2005 16:00:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506061210490.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 6 Jun 2005 12:15:38 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

By the way, there is one case that you need to keep an eye on if
you are making further fixes to "git-read-tree -m $H $M",
especially now we are talking about keeping what we slurp from
stage0 sometimes:

 (1) index has DF (file)
 (2) $H has DF (file); the index matches it.
 (3) $M has DF/DF (file), implicitly making DF a directory.

For path DF, this rule from the earlier matrix applies:

  exists          exists (index=$H)       no such path        *2*
  * path is removed.

For path DF/DF, this rule from the earlier matrix applies:

  no such path    no such path            exists
  * take $M without complaining.

Thanks to *2*, the current code gets it right and we do not end
up with a cache that records both DF and DF/DF at the same time.
I cannot tell if it is by design or by accident :-).

There is a safety valve at the end of write-tree to refuse to
write out such a nonsensical tree but as Pasky argued back then
(a similar problem was discussed and resolved when you were
away, around the beginning of May, involving update-cache), when
that safety valuve was added, the damage has already been done
if we allow such a cache entry to be created in the first place.

