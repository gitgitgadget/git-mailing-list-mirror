From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] add mode parameter to get_sha1
Date: Sat, 21 Apr 2007 11:42:15 -0700
Message-ID: <7vps5xtvqw.fsf@assigned-by-dhcp.cox.net>
References: <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Apr 21 20:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfKXc-0006eF-HO
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 20:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbXDUSmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 14:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXDUSmR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 14:42:17 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:45618 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbXDUSmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 14:42:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421184216.CQDN1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 21 Apr 2007 14:42:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id puiF1W00Q1kojtg0000000; Sat, 21 Apr 2007 14:42:16 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45189>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> If the mode parameter is not NULL, get_sha1 will store
> the mode of the object in it.

Most existing callers pass NULL to this.  Wouldn't it be cleaner
to have a new get_sha1_with_mode() function, and convert the
callers that care about mode to use it, like this?

int get_sha1(const char *str, unsigned char sha1[20]) {
	unsigned discard;
        return get_sha1_with_mode(str, sha1, &discard);
}

That way, your patch would be much easier to review and would
have less chance of getting it wrong.  I wonder if [2/4] can be
made less impact using a similar trick.  Most of the existing
callers that place objects in object_array do not know the mode.
Only some do.

+/* unknown mode */
+#define S_IFINVALID    0320000
+

This hunk does not belong to [1/4]; it is part of [2/4].

Typically S_IF$TYPE macros are masked with S_IFMT (0170000)
before being used, so the above value is *obviously* invalid,
but it also risks our code would treat it as a symlink, we do
the masking before comparison.  I wonder if defining it to
S_IFMT mask itself might be a safer option.
