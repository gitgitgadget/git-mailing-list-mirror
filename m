From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 0/2] Two new remote helpers
Date: Mon, 28 Jun 2010 10:11:49 +0300
Message-ID: <1277709111-11230-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 09:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT8UW-0006sb-54
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 09:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab0F1HKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 03:10:46 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:38168 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab0F1HKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 03:10:46 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 2EF7313B6E6
	for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:10:44 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0328B2507D; Mon, 28 Jun 2010 10:10:44 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 0EFF6E51A2
	for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:10:43 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149815>

The first helper (fd) is meant for frontends that want to override
how transport link is created. Currently this would require hacks based
on either GIT_SSH or GIT_PROXY (see tortoiseplink). It works by reflecting
the smart transport stream to specified file descriptors.

The second one (ext) invokes specified command, reading/writing smart
transport stream (with optional git://-style request) to its stdin/stdout.
It is meant for situations where one wants unusual kind of transport link.
It can be ssh connection with one-off parameters[1], things like rsh (if
you have to use it because some absolutely incomprehensible reason,
hopefully its really krb5-rsh)[2], wrapping git:// in TLS[3], accessing
servers on unix domain sockets[4], etc...

Changes from last time:
- This cover letter.
- Support \G and \V which are for sending git:// style request in-channel.[5]

[1] "ext::ssh -i somekey user@host.example \S /path/to/repo.git"
[2] "ext::rsh -l user host.example \S /path/to/repo.git"
[3] Don't ask me how, especially not how to get connection to git-daemon2
that way.
[4] "ext::socat - ABSTRACT-CONNECT:/tmp/gits \G/gitolite-admin"
[5] "ext::nc host.example 9418 \G/repo.git \Vfoo.host.example" (with vhost)
or "ext::nc host.example 9418 \G/repo.git" (without vhost).

Ilari Liusvaara (2):
  New remote helper git-remote-fd
  New remote helper: git-remote-ext

 Makefile             |    2 +
 builtin.h            |    2 +
 builtin/remote-ext.c |  300 ++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/remote-fd.c  |   88 +++++++++++++++
 git.c                |    2 +
 transport-helper.c   |  130 ++++++++++++++++++++++
 transport.h          |    1 +
 7 files changed, 525 insertions(+), 0 deletions(-)
 create mode 100644 builtin/remote-ext.c
 create mode 100644 builtin/remote-fd.c
