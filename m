From: Johannes Sixt <j6t@kdbg.org>
Subject: =?utf-8?Q?Re=3A_=22fatal=3A_index-pack_failed=22_on_git-clone?=
Date: Thu, 09 Jul 2009 10:06:30 +0200 (CEST)
Message-ID: <mtranet.20090709100630.408099298@telekom.at>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:06:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOoeW-0001zV-0G
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbZGIIGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbZGIIGg
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:06:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:36722 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756248AbZGIIGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:06:34 -0400
Received: from telekom.at (lbmbmn02.lix.bon.at [172.18.12.147])
	by bsmtp.bon.at (Postfix) with SMTP id A0F751001F;
	Thu,  9 Jul 2009 10:06:30 +0200 (CEST)
Content-ID: <mtranet.1247126790.1493999485@telekom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122941>

Jeff King schrieb:
> Subject: [PATCH] Makefile: install 'git' in execdir
> 
> When a git command executes a subcommand, it uses the "git
> foo" form, which relies on finding "git" in the PATH.
> Normally this should not be a problem, since the same "git"
> that was used to invoke git in the first place will be
> found.  And if somebody invokes a "git" outside of the PATH
> (e.g., by giving its absolute path), this case is already
> covered: we put that absolute path onto the front of PATH.
> 
> However, if one is using "sudo", then sudo will execute the
> "git" from the PATH, but pass along a restricted PATH that
> may not contain the original "git" directory. In this case,
> executing a subcommand will fail.
> 
> To solve this, we put the "git" wrapper itself into the
> execdir; this directory is prepended to the PATH when git
> starts, so the wrapper will always be found.

I'd love to see this change justified not only by sudo, because
this also helps another use-case where it avoids that between
different vintages of git is switched:

Assume you have a git installed in prefix /usr and another one
in prefix /home/j6t. PATH is /usr/bin:/bin. Consider this command:

   $ git --exec-path=/home/j6t/libexec/git-core gc

Then:

1. It runs /usr/bin/git with builtin gc.

2. It set PATH=/home/j6t/libexec/git-core:/usr/bin:/bin

3. builtin-gc runs git repack (no dash). It picks git-repack
   from /home/j6t. (PATH remains unchanged)

4. git-repack runs git pack-objects.

5. This picked /usr/bin/git and its builtin pack-objects

See how this switches from the version in /usr to /home/j6t
and back to /usr?

With this change it switches from /usr to /home/j6t and
remains there, which is "more correct", IMO (at least
less surprising).

Notice that the problem is not only with --exec-path, but
also with GIT_EXEC_PATH if somebody has it exported
in .profile.

-- Hannes
