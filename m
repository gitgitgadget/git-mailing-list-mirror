From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 0/2] Teach "git status" the "--ignore-submodules" option
Date: Fri, 25 Jun 2010 16:55:07 +0200
Message-ID: <4C24C34B.20403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 25 16:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSAJI-0003ER-Vo
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 16:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab0FYOzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 10:55:11 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:43436 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab0FYOzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 10:55:10 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 33F6916161A55;
	Fri, 25 Jun 2010 16:55:08 +0200 (CEST)
Received: from [80.128.126.113] (helo=[192.168.178.26])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OSAJA-00071I-00; Fri, 25 Jun 2010 16:55:08 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+qwZUaYQEMrw401pPjrRtI1CCyiRFeORqKXWYA
	WrHJjGRUEDQ5cR3aR7U5ELIArOIj0SB0HRK8x80xoVEwADP0vy
	4xJJCBOiwxd5hkyzDBxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149689>

The first patch in this series lets "git submodule summary" and "git
submodule status" ignore dirty submodules. I thought about teaching
them a "--ignore" option too, but didn't for two reasons: First, the
output of those commands is pretty much focused on commits. Second,
when using "git status" with the config option 'status.submodulesummary'
the submodule tree is scanned twice, once for "git status" and then
again for "git submodule summary". With this patch the second run is
gone, which is a big gain for users of 'status.submodulesummary' with
large submodules.

The second patch teaches "git status" the same "--ignore-submodules"
option that "git diff" recently learned. Ignoring all changes also
suppresses the output of "git submodule summary" when
'status.submodulesummary' is set.

After this series I am planning to add a config option 'ignore' to
.gitmodules, which can be set for each submodule to either "all",
"dirty", "untracked" or "none" (the default). "git diff" and "git
status" will use that config value for each submodule. Using
"--ignore-submodule" overrides this default (and the new parameter
"none" will be added there to able to override the config settings).
And to avoid having to do "git submdule sync" every time that option
changes, I would like to search for it in .git/config first. If it
is not found there, it will be taken from .gitmodules, if present.
So users can override the setting but if they don't, upstream can
change it easily (e.g. when a submodules .gitignore has been updated
so that "ignore=untracked" is no longer necessary anymore it can be
removed). Also switching branches will have an effect instantly if
the 'ignore' entry in .gitmodules is different between branches.


Opinions?


Jens Lehmann (2):
  git submodule: ignore dirty submodules for summary and status
  Add the option "--ignore-submodules" to "git status"

 Documentation/git-status.txt |   11 ++++
 builtin/commit.c             |    7 ++-
 diff.c                       |   15 +----
 git-submodule.sh             |    6 +-
 submodule.c                  |   13 ++++
 submodule.h                  |    3 +
 t/t7508-status.sh            |  127 ++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  |   10 +++-
 wt-status.h                  |    1 +
 9 files changed, 177 insertions(+), 16 deletions(-)

-- 
1.7.1.757.g0ad3c.dirty
