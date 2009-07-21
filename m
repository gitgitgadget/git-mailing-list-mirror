From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] configure: use AC_SEARCH_LIBS instead of AC_CHECK_LIB
Date: Tue, 21 Jul 2009 10:04:14 -0500
Message-ID: <6WnEB0at_uuAu9kicWjrHLsBbTv58WtCNOANkKzk-SqTgqjuWyh8WA@cipher.nrlssc.navy.mil>
References: <m34ot9c67t.fsf_-_@localhost.localdomain> <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>, David Syzdek <david@syzdek.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTGti-0008R3-G1
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbZGUPEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754332AbZGUPEo
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:04:44 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46495 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbZGUPEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:04:42 -0400
Received: by mail.nrlssc.navy.mil id n6LF4FR7030765; Tue, 21 Jul 2009 10:04:15 -0500
In-Reply-To: <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr>
X-OriginalArrivalTime: 21 Jul 2009 15:04:15.0088 (UTC) FILETIME=[833C6F00:01CA0A14]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123661>


After actually reading the autoconf documentation, don't some of the
tests have the [action-if-found] and [action-if-not-found] actions
backwards?

AC_CHECK_LIB has the form:

   AC_CHECK_LIB (library, function, [action-if-found], [action-if-not-found], [other-libraries])

The test I added (which I blindly copied from the NEEDS_RESOLV test) looks like:

   AC_CHECK_LIB([gen], [basename], [NEEDS_LIBGEN=], [NEEDS_LIBGEN=YesPlease])
   AC_SUBST(NEEDS_LIBGEN)
   test -n "$NEEDS_LIBGEN" && LIBS="$LIBS -lgen"

Won't this check whether a program which calls basename() successfully links with -lgen?
If it successfully links, then it will perform NEED_LIBGEN= and if not it will set
NEEDS_LIBGEN=YesPlease, right?  Isn't that the opposite of what should be done?

If that is correct, then the NEEDS_RESOLV and NEEDS_LIBGEN tests are wrong and they
may still be wrong even if AC_SEARCH_LIBS is used instead of AC_CHECK_LIB.


A question about AC_SEARCH_LIBS:

With AC_SEARCH_LIBS, which of [action-if-found] or [action-if-not-found]
is executed if the function is found in the standard c library i.e. "calling
`AC_LINK_IFELSE([AC_LANG_CALL([], [function])])' first with no libraries"?
Is the answer neither?  If the answer is [action-if-found], won't the
NEEDS_LIBGEN=YesPlease be set when the function is found in the c library?
Assuming the NEEDS_LIBGEN test is made to look like this:

   AC_SEARCH_LIBS([basename], [gen], [NEEDS_LIBGEN=YesPlease], [NEEDS_LIBGEN=])

Depending on the answer to that question, we either will want to use
AC_SEARCH_LIBS, or stick with AC_CHECK_LIB but correct the [action] fields,
or maybe even stick with AC_CHECK_LIB but rework the NEEDS_RESOLV and
NEEDS_LIBGEN tests to look like the NEEDS_SOCKET test.

-brandon
