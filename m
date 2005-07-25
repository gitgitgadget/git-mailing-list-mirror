From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 12:56:01 -0700
Message-ID: <7v1x5mmzhq.fsf@assigned-by-dhcp.cox.net>
References: <20050725064140.95259.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 22:05:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dx9BZ-0001Uy-10
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 22:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVGYUAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 16:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVGYT7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 15:59:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:15791 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261479AbVGYT6N (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 15:58:13 -0400
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j6PJwCf1010877
	for <git@vger.kernel.org>; Mon, 25 Jul 2005 12:58:12 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725195602.TRWZ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 15:56:02 -0400
To: Marco Costalba <mcostalba@yahoo.it>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> writes:

> Peraphs, if the file name of excluded list is the same for each directory, 
> e.g. .gitignore or something similar, instead of --exclude-per-directory
> we can use a concept of file validity 'scope' and just use --exclude-from=<file>.
> If entering in a directory <file> is found its contents are appended and 
> removed when leaving directory. A bad analogy can be with the use of 
> recursive Makefile.

I do not know if you noticed it, but the patch already have the
concept of "scope".  If a pattern has a slash '/' it is scoped
to the named directory by using FNM_PATHNAME.  "The named
directory" for command line --exclude and --exclude-from are
relative to the project top while it is relative to the
directory the file being used is in for --exclude-per-directory
case.

> If we use the 'scope' logic we can just prepend path when adding entries
> and serach with with FNM_PATHNAME flag.

You suggest to always use FNM_PATHNAME by adjusting the pattern
by prefixing the scope.  While that can theoretically be made to
work just as the posted patch does, you need to realize it is a
lot more cumbersome to deal with metacharacters in pathnames
your way.  If the prefix you need to add (because you are now
looking at a path for that directory which has a funny name) is
"foo*bar", you need to add "foo\*bar" to the pattern in order to
make sure that the asterisk is not used to match anything other
than a literal asterisk, for example.

You could argue that nobody should use funny characters in
pathnames, and you could further argue that current Porcelains
do not handle certain characters in pathnames anyway so why
bother.  But ls-files being core, which is "the funny filesystem
layer to build SCM on", I would like to be careful not to be
unnecessarily restrictive.
