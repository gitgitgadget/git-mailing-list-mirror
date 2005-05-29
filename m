From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adjust diff-helper to diff-tree -v -z changes.
Date: Sun, 29 May 2005 13:21:52 -0700
Message-ID: <7vmzqdlr4v.fsf@assigned-by-dhcp.cox.net>
References: <42971EB4.2050403@oberhumer.com>
	<Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org>
	<7vfyw8zg1w.fsf@assigned-by-dhcp.cox.net>
	<7vvf54xael.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291129520.10545@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 22:33:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcUGW-0007wv-Ie
	for gcvg-git@gmane.org; Sun, 29 May 2005 22:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVE2UWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 16:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVE2UWS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 16:22:18 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31666 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261429AbVE2UV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 16:21:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529202152.SIWN23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 16:21:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505291129520.10545@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 29 May 2005 11:31:05 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I think this is really a bug in your "read_line()" interface.
LT> You should include the terminating character in the line count.

What the patch changed:

    You give me a non diff-raw material "foo\nbar\n" when you
    are not doing -z.  I read that without -z.  read_line()
    drops the EOL so I get "foo" and "bar" on separate lines,
    both of which I spit out with my own '\n' using "%s\n".

    You give me "foo\nbar\n\0" to express the same under -z, and
    I read that with -z.  I get "foo\nbar\n" after read_line()
    drops the EOL.  I should spit it out without my own '\n',
    i.e. not using "%s\n" but "%s".

If read_line() interface changes to include EOL, then...

    You give me "foo\nbar\n" without -z.  I read that without
    -z.  Fixed read_line() retains the EOL and I get "foo\n" and
    "bar\n", and I do not have to add my own '\n' anymore; I
    just do fputs().

    You give me "foo\nbar\n\0" under -z, and I read that with
    -z.  Fixed read_line() retains the EOL so I get
    "foo\nbar\n\0".  I just do fputs() and it would drop the
    '\0'.

What the last sentence does feels a bit hacky, but does the
right thing.  It's a good fix.

Please discard the patch you are responding to unless you
already have applied it.



