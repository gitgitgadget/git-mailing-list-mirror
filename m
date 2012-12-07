From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 12:44:53 -0500
Message-ID: <50C22B15.1030607@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 18:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th25e-00047u-9I
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 18:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423563Ab2LGRvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 12:51:42 -0500
Received: from smtp112.dfw.emailsrvr.com ([67.192.241.112]:50559 "EHLO
	smtp112.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423541Ab2LGRvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 12:51:41 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2012 12:51:41 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp21.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 54F72241798
	for <git@vger.kernel.org>; Fri,  7 Dec 2012 12:45:16 -0500 (EST)
X-Virus-Scanned: OK
Received: from smtp130.ord.emailsrvr.com (smtp130.ord.emailsrvr.com [173.203.6.130])
	by smtp21.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 3DF78241772
	for <git@vger.kernel.org>; Fri,  7 Dec 2012 12:45:16 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 670671980E4;
	Fri,  7 Dec 2012 12:44:44 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1C805198110;
	Fri,  7 Dec 2012 12:44:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211182>

Hi all,

This is with git 1.8.0.1 on all the machines involved.

One of our build machines is having trouble with "git submodule":

	$ git submodule init external/openssl
	No submodule mapping found in .gitmodules for path ''

(.gitmodules and other aspects of the repo are fine -- the submodules work
perfectly on other machines.)

The problem seems to be in cmd_init() with the construct

	module_list "$@" |
	while read mode sha1 stage sm_path
	do
		...

Explicitly setting IFS before the call to module_list makes it work:

	IFS=" "
	module_list "$@" |
	while read mode sha1 stage sm_path
	do
		...

If IFS is unset, the "while read" loop ends up with everything in the $mode
variable, and the other 3 variables are empty.

If I isolate module_list() and a simple "while read" loop into a standalone
script, like this:

	module_list()
	{
		...
	}

	module_list "$@" |
	while read mode sha1 stage sm_path
	do
		echo - $mode - $sha1 - $stage - $sm_path -
	done

It works -- each individual variable is set properly.

It seems that the problem only occurs inside git-submodule.sh.

Any ideas?

		M.
