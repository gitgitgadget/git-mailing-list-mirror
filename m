From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Wed, 14 Jan 2009 14:20:07 +0100
Message-ID: <vpqwscy81o8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:44:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN62w-0008LD-1R
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760149AbZANNnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759528AbZANNnR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:43:17 -0500
Received: from imag.imag.fr ([129.88.30.1]:40378 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759055AbZANNnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:43:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n0EDK7UT012083
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Jan 2009 14:20:08 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LN5fD-00053h-PS; Wed, 14 Jan 2009 14:20:07 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LN5fD-0003MZ-ND; Wed, 14 Jan 2009 14:20:07 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 14 Jan 2009 14:20:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105627>

Hi,

Just found a bug in builtin-mv.c. Here's a script to reproduce:

mkdir git
cd git
git init
touch controled
git add controled && git commit -m "init"
touch foo1 foo2
mkdir dir
git mv -k foo* dir/

The output is the following:

Initialized empty Git repository in /tmp/git/.git/
[master (root-commit)]: created 694563b: "init"
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 controled
git: builtin-mv.c:216: cmd_mv: Assertion `pos >= 0' failed.
./bug.sh: line 10: 12919 Aborted                 git mv -k foo* dir/

Apparently, this happens when using "git mv -k" with more than one
unversionned file. The code ignores the first one, but still goes
through this

	for (i = 0; i < argc; i++) {
		const char *src = source[i], *dst = destination[i];
		enum update_mode mode = modes[i];
		int pos;
		if (show_only || verbose)
			printf("Renaming %s to %s\n", src, dst);
		if (!show_only && mode != INDEX &&
				rename(src, dst) < 0 && !ignore_errors)
			die ("renaming %s failed: %s", src, strerror(errno));

		if (mode == WORKING_DIRECTORY)
			continue;

		pos = cache_name_pos(src, strlen(src));
		assert(pos >= 0); /* <----- this is the one */
		if (!show_only)
			rename_cache_entry_at(pos, dst);
	}

for the second, and it crashes on the assertion (gdb says "pos" here
is an unversionned file name).

If anyone has time to fix this ...

Thanks,

-- 
Matthieu
