From: Junio C Hamano <gitster@pobox.com>
Subject: [Funky] "git -p cmd" inside a bare repository
Date: Thu, 13 Dec 2007 17:29:23 -0800
Message-ID: <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
References: <20071129122139.GA11176@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 02:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2zNS-00047O-RR
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 02:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbXLNB3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 20:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528AbXLNB3r
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 20:29:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbXLNB3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 20:29:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E55F082E9;
	Thu, 13 Dec 2007 20:29:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F6E82E4;
	Thu, 13 Dec 2007 20:29:25 -0500 (EST)
In-Reply-To: <20071129122139.GA11176@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message
	of "Thu, 29 Nov 2007 19:21:39 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68209>

If you have a bare repository and try this there:

	$ PAGER=head git show HEAD:gcc/ChangeLog

it works as expected, but if you explicitly ask for pagination, like
this:

	$ PAGER=head git -p show HEAD:gcc/ChangeLog

you would get a very funky error message:

	fatal: ambiguous argument 'HEAD:gcc/ChangeLog': unknown revision or path not in the working tree.
	Use '--' to separate paths from revisions

as if we are working with a repository with working tree.

I originally noticed this with ls-tree.  The symptom is a bit different:

	$ git -p ls-tree HEAD
	fatal: Not a valid object name HEAD



I _think_ what is happening is that setup_pager() tries to run
git_config(), which runs setup(), and then RUN_SETUP set for "ls-tree"
(or "show") internal command runs setup again.  HEAD is given to
resolve_ref() and git_path("%s", ref) makes it to ".git/HEAD", even
though in a bare repository git_dir should be set to ".", and of course
we cannot find such a path in the git directory.
