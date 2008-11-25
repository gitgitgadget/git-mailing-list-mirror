From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into
 a git work-dir
Date: Mon, 24 Nov 2008 21:54:41 -0800
Message-ID: <492B9321.8090706@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org> <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org> <m31vx3l94x.fsf@localhost.localdomain> <49290203.7060808@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 25 06:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4qu4-0003cm-2l
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 06:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbYKYFyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 00:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYKYFyq
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 00:54:46 -0500
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:43647 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751413AbYKYFyp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 00:54:45 -0500
Received: (qmail 69303 invoked from network); 25 Nov 2008 05:54:44 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp116.sbc.mail.sp1.yahoo.com with SMTP; 25 Nov 2008 05:54:44 -0000
X-YMail-OSG: ox8SHIsVM1mqukIdFn5WHZvuYiggTSBqOn0wc1fSyG6euorO24NKW6LV4WKiln62YZ45ocEP9xX.lJi4j9O7Vqop7VoK6F.MhWymIAauhQOkM0_NLwbOGSwVdFYtgqse2aEhoCRxO4JnOOO5_r6nJXzAk8FjnI6SxJBqgA1ACtcu4kWqJfM-
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L4qsl-0000Me-28; Mon, 24 Nov 2008 21:54:43 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <49290203.7060808@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101646>

> AFAIR, it was introduced to make test-builds of really large projects in
> really deep directories with a ton of symlinks leading to the path work a
> lot faster.

Andreas,

I see value in keeping Git very fast.  That is, after all, why I chose
Git over Mercurial.  Do you know where that discussion was, if was in
the archives?  I found these reasons to avoid absolute paths in the git
archives:

* paths with more components are slower to work with (in the context of
  add and diff, which deal with many many paths)
* absolute paths may exceed PATH_MAX while relative ones didn't
* getcwd() will fail if parent directories are not executable, or on
  some platforms, if parent directories are not readable

My impression is that the performance issue is probably not significant
for cd_to_toplevel since it's not in a tight inner loop, and dito for
other potential callers of --show-cdup.  The PATH_MAX seems to be a
restriction elsewhere in the code already.

Even if there were a scenario that put --show-cdup in a tight loop, I
wonder whether current implementation provides much performance benefit,
at least when bash is the calling language: bash seems to make the
relative path absolute anyway inside the "cd" builtin.

The commit (5f94c730) that introduces that code doesn't mention
performance.  It compares to:

  git rev-parse --show-prefix | sed -e 's|[^/][^/]*|..|g'


I also noticed that this failure case with "--show-cdup" in a symlinked
directory has come up more than once before.
http://marc.info/?l=git&m=122452534912000&w=2
http://marc.info/?l=git&m=121613416212958&w=2
https://kerneltrap.org/mailarchive/git/2007/4/25/244653/thread

Marcel
