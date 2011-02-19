From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Sat, 19 Feb 2011 17:59:19 +0100
Message-ID: <4D5FF6E7.8090104@web.de>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 18:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqqAx-0004tu-BA
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 18:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1BSRAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 12:00:41 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56197 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab1BSRAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 12:00:41 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6E38418954C90;
	Sat, 19 Feb 2011 17:59:19 +0100 (CET)
Received: from [93.246.50.213] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pqq9P-0001vM-00; Sat, 19 Feb 2011 17:59:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+m1YSd/m3Gm6Vm2yp8JLdivDF5hCiDcyeBu4p7
	CCuqHFXl4TZbzfdV5n2ZsHzr6xx8/5MQq0LxTXuf64EkokJLTK
	CcYIXp7td+4biJdUJIzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167302>

Proposal:
When switching branches, merging or resetting the work tree of
populated submodules should be checked out too according to the
commit recorded in the superproject. Make this the default for
porcelain and optional for plumbing.

The same safety precautions that are used for files in the
superproject apply to the changes present in the submodules,
no local modifications may be overwritten unless -f is used.
When the "update" config option is set to "merge" or "rebase"
the submodule will be left unchanged.

The "update" config option will learn a new value "none" to let
the user turn off this behavior for single submodules. A global
config option and the command line parameter "--recurse-submodules"
will also be added. This change will remove the need to call "git
submodule update" for all populated submodules (except those who
use the "update=merge" or "update=rebase" configuration settings).

Advantages:
* This makes submodules behave like the files in the superproject.
  Every time the work tree of the superproject changes, the work
  trees of the populated submodules are updated accordingly.
* This is the least surprising behavior for new submodule users.

Risks:
The commands might run longer, for those users who use submodules
to gain performance by putting large and/or many files into
submodules this may be unacceptable. Also people might be
surprised by submodule work trees changing without explicitly
invoking "git submodule update". These commands will now fail in
the presence of changed submodules where they would have
succeeded before.

Migration plan:
Announce the change in behavior and document how to easily configure
the old behavior when needed and enable this functionality in 1.8.0.
