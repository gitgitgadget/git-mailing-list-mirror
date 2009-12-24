From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 0/2] Report remote helper exec failures
Date: Thu, 24 Dec 2009 19:49:29 +0200
Message-ID: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 18:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNroi-0000Y9-Ak
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 18:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbZLXRtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 12:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbZLXRtf
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 12:49:35 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:44490 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZLXRte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 12:49:34 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 0AB9D18CFF3
	for <git@vger.kernel.org>; Thu, 24 Dec 2009 19:49:33 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A027C2C49DA; Thu, 24 Dec 2009 19:49:32 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id EA7DC27D98
	for <git@vger.kernel.org>; Thu, 24 Dec 2009 19:49:31 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135657>

Actually give useful error messages if executing git remote helper fails
for some reason.

The previous error message was:

git: 'remote-fail' is not a git-command. See 'git --help'

This changes the error message to:

'Unable to find remote helper for "nonexistent"'

or

'Unable to run helper HelperThatGetsEACCESS: Permission denied' 
(or whatever the errno is).


Patch series is based on v1.6.6.

One of the changes is adjacent to changes in external helper dispatch
support change and gets merge conflict. Here's how I resolved that
conflict for testing:

        helper->argv[2] = remove_ext_force(transport->url);
        helper->git_cmd = 0;
        if (start_command(helper)) {
                if (errno == ENOENT)
                        die("Unable to find remote helper for \"%s\"",
                                data->name);
                else
                        die("Unable to run helper %s: %s", helper->argv[0],
                                strerror(errno));
        }

The first line in that comes from dispatch support and the rest come from
exec failure reporting.


Ilari Liusvaara (2):
  Report exec errors from run-command
  Improve transport helper exec failure reporting

 run-command.c      |   72 +++++++++++++++++++++++++++++++++++++++++++++++++--
 transport-helper.c |   14 +++++++---
 2 files changed, 79 insertions(+), 7 deletions(-)
