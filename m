From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH v2 0/6] add support for git send-email
Date: Tue,  1 Dec 2009 17:46:00 -0700
Message-ID: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 01:46:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFdMO-0005kv-Ts
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbZLBAqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbZLBAqG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:46:06 -0500
Received: from g1t0029.austin.hp.com ([15.216.28.36]:21665 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbZLBAqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:46:05 -0500
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id B63673800D;
	Wed,  2 Dec 2009 00:46:11 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 51A231410B;
	Wed,  2 Dec 2009 00:46:01 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 27983CF000A;
	Tue,  1 Dec 2009 17:46:01 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlUc5pWv4PHu; Tue,  1 Dec 2009 17:46:01 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 13722CF0007;
	Tue,  1 Dec 2009 17:46:01 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id E7A1226160; Tue,  1 Dec 2009 17:46:00 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
User-Agent: StGit/0.15-6-gc6f39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134273>

This is v2 of the series that starts teaching stg mail how to
call git send-email.

I made all the changes that Karl recommended, and made sure to
run the t1900-mail.sh test at every point in the series (passes
successfully).

I also experimented with adding another test case for --git
mode, basically duplicating t1900-mail.sh, and then adding the
--git argument wherever it made sense.

However, that resulted in failure of the last 3 test cases,
which is due to the fact that we no longer parse To/Cc/Bcc
command line args in --git mode, and the resulting mbox file was
missing the expected recipient addresses.

I played around with that for a while, thinking that I could use
git send-email --dry-run to do something equivalent, but then
realized that git send-email's run-run mode is definitely not
analogous to stg mail's --mbox mode.

The upshot is that in stg mail, --git and --mbox don't interact
well, and the resulting mbox file will lack the recipients. This
might be fixed in the future if we teach git send-email how to
generate mbox files, but then we introduce a versioning problem.

So let's just accept this wart for now, and say, if you want an
mbox file generated, don't use --git. That seems reasonable to
me.

This mail was sent with the following command line:

	./stg mail --git -a -e --auto -v v2 --prefix=StGit
	--to=catalin.marinas@gmail.com --cc=git

Note that the --cc= contains an alias for the git mailing list
that I defined in my ~/.mutt.aliases file (and specified in
.gitconfig -> sendemail.aliasesfile and sendemail.aliasfiletype.

Thanks,
/ac

---

Alex Chiang (6):
      stg mail: Refactor __send_message and friends
      stg mail: reorder __build_[message|cover] parameters
      stg mail: make __send_message do more
      stg mail: factor out __update_header
      stg mail: add basic support for git send-email
      stg mail: don't parse To/Cc/Bcc in --git mode


 stgit/commands/mail.py |  196 +++++++++++++++++++++++++++---------------------
 1 files changed, 112 insertions(+), 84 deletions(-)
