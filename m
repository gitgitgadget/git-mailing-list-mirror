From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 0/2] Imporove remote helper exec failure reporting
Date: Sat,  9 Jan 2010 15:45:55 +0200
Message-ID: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 14:46:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTbdu-0002WI-34
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 14:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab0AINqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 08:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197Ab0AINqD
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 08:46:03 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:46430 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0AINqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 08:46:01 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 22C93EF440
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 15:46:00 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A006821555A; Sat, 09 Jan 2010 15:46:00 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id EEDEC27D89
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 15:45:58 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136530>

(This is newer than updated patch v3).

I decided to go on a bit further with new features, and that's why this
is back as RFC.

Diffrences from first RFC round:

- Split loop-over-close to its own function and warn but not retry on
  bizarre error codes (basically anything except EBADF and EINTR).
- Don't rely on pipe(2) to preserve the fd array on failure.
- Add some testcases.
- Fix buggy behaviour if report pipe read end winds up as fd #0.
- Set silent_exec_failure on executing remote helper.
- Make exec reporting in presence of preexec_cb controlled by flag to
  solve pager deadlock problems without preventing using preexec_cb
  with exec reporting entierely (the way pager is invoked is just
  fundamentially incompatible with exec reporting).
- Add flag to make run-command give different code for exec failing due to
  ENOENT than for other failures (including other ways to get ENOENT).
- change chdir failure to be reported as error (and pass error code back).
  BTW: Nothing seems to use that chdir feature, aside of new testcase.
- Report errors to parent's stderr.
- Don't retry waitpid on bizarre error codes (basically anything except
  EINTR).
- Make run_command actually complain about exec failing (as API docs
  say).

Ilari Liusvaara (2):
  Report exec errors from run-command
  Improve transport helper exec failure reporting

 Documentation/technical/api-run-command.txt |    2 +
 Makefile                                    |    1 +
 run-command.c                               |  196 +++++++++++++++++++++++++--
 run-command.h                               |    2 +
 t/t0061-run-command.sh                      |   20 +++
 test-run-command.c                          |   74 ++++++++++
 transport-helper.c                          |   27 +++-
 7 files changed, 305 insertions(+), 17 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c
