From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: git submodule output on invalid command
Date: Fri,  5 Sep 2008 18:16:10 +0200
Message-ID: <1220631370-19777-1-git-send-email-pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 18:21:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbe0G-0001RC-Qu
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 18:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbYIEQQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 12:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755196AbYIEQQS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 12:16:18 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:8123 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbYIEQQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 12:16:17 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id 74CE31C0008A
	for <git@vger.kernel.org>; Fri,  5 Sep 2008 18:16:15 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id 279091C00086
	for <git@vger.kernel.org>; Fri,  5 Sep 2008 18:16:10 +0200 (CEST)
X-ME-UUID: 20080905161615162.279091C00086@mwinf6001.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95022>

If you give git submodule an invalid commands, it outputs nothing.
For example:

	Vienna:git pieter$ git submodule satsus
	Vienna:git pieter$

This is because the default command is 'status' and status accepts paths to
limit the output.

I tried to find a fix for this, but git-submodule also allows a syntax
like

	git submodule --cached status
and
	git submodule --cached

so you can't just look at the first argument to see if a command is valid.
Similarly, the default command is 'status', so something like

	Vienna:bonnenteller pieter$ git submodule vendor/
	ef38bc83b7ff4b290a6b1f4d82df03585fbb7529 vendor/plugins/will_paginate (2.3.2)

is also valid. Using that line of reasoning, something like 'git submodule satsus'
is valid and should return nothing, because there are no submodules in
the 'satsus' path. However, I still feel this should produce a warning.

I'm sure there is a nicer way to alert the user than my patch below, which
warns if the user did not supply any valid paths. Anyone else got a more
satisfying approach?

- Pieter

diff --git a/git-submodule.sh b/git-submodule.sh
index 1c39b59..3aae746 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -59,7 +59,12 @@ resolve_relative_url ()
 #
 module_list()
 {
-       git ls-files --stage -- "$@" | grep '^160000 '
+       git ls-files --stage -- "$@" | grep '^160000 ' ||
+       if test -z "$@"; then
+               die "This repository contains no submodules"
+       else
+               die "Could not find any submodules in paths $@"
+       fi
 }
 
 #
