From: Teemu Likonen <tlikonen@iki.fi>
Subject: Patterns work unexpectedly with "git log" commit limiting
Date: Thu, 17 Jul 2008 10:47:06 +0300
Message-ID: <20080717074706.GA5392@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 09:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJODk-0003Wl-Oi
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 09:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbYGQHrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 03:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754922AbYGQHrK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 03:47:10 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:51350 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759780AbYGQHrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 03:47:09 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 487B42D6001E1F43 for git@vger.kernel.org; Thu, 17 Jul 2008 10:47:07 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KJOCg-0001ab-Tu
	for git@vger.kernel.org; Thu, 17 Jul 2008 10:47:06 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88813>

It looks to me that some commit limiting options used with "git log"
work a bit buggyish or unexpectedly. Please don't take this as a rant;
I only mean to express some unexpected behaviour in the user interface.
You can be sure that I don't understand the plumbing stuff and
implementation details.

 1. Option order changes the behaviour. "git log" with

	-E --author=pattern

    interprets "pattern" as _basic_ regexp. To have it interpreted as
    extended regexp the order must be

	--author=pattern -E
    
    BUT the "pattern" in

	--author=non-matching-nonsense -E --author=pattern

    is interpreted as extended regexp. So -E's behaviour depens on the
    preceding options.

 2. Internally --author= and --committer= fields contain more stuff than
    just person's name and email address. I mean user might expect

	--author='@iki.fi>$'

    to match all authors with this email host/domain. It took quite some
    time for me to realise that the (usually hidden) raw author field
    contains also date information, such as "1216023662 +0300". Well,
    not a big deal but certainly unexpected in the context of commit
    limiting by author.

 3. What is the supposed behaviour of -F (--fixed-strings) when combined
    with --author= ?

	--author=pattern -F

    doesn't seem to match anything. I also tried putting the entire raw
    author field (i.e. including the raw date) but no match. With -F
    before the --author= it behaves like no -F at all.

    "--grep=fixedstring -F" seems to work, though.

 4. Logical AND/OR operation. I realised that several commit limiting
    options combined together do not limit commits more but the
    opposite. So it seems like a logical OR operation between the
    limiting options. It's fine. It's just that I'd have expected that
    more limiting options means limiting more (i.e. the AND operation,
    just like in the "find" command normally).
    
    Well, unexpected but I'll survive. Shouldn't this be mentioned under
    the title "Commit Limiting" in the man page? (My English is not
    really manual-writing quality but I could try to come up with
    a patch.)
