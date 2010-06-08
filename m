From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] Add optional parameters to the diff option "--ignore-submodules"
Date: Tue, 08 Jun 2010 18:30:47 +0200
Message-ID: <4C0E7037.8080403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:30:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1hW-0006Xf-Pp
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab0FHQau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:30:50 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40900 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0FHQat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:30:49 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 210E2154D0865;
	Tue,  8 Jun 2010 18:30:48 +0200 (CEST)
Received: from [80.128.58.232] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OM1hQ-0004Ib-00; Tue, 08 Jun 2010 18:30:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/fW0Elqy7wtzmag2JSibVBsHdhQeK/mRj2Moot
	Qw3Bp23OwfLvTA8V5dVfojlsbsf0HlMLYMYiO1xvCPueN/gZ0I
	zLYKCIdlqYoZqQ6rKzug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148688>

After thinking some time about peoples expectations and troubles
with the recursive scanning of submodules, I came up with this:

What about expanding the "--ignore-submodules" option of the git diff
family with three parameters:

--ignore-submodules=all : Same behavior as "--ignore-submodules",
  submodules show never up as modified.

--ignore-submodules=untracked : Don't consider submodules as modified
  when they only contain untracked files, but do if the commits in the
  superproject are different or tracked content is modified.

--ignore-submodules=dirty : Don't consider submodules as modified
  when their work tree is dirty, no matter why. This is the pre 1.7.0
  behavior and doesn't recurse into submodules at all.

The first patch is just a resend of a test case rename, the second
contains the implementation.


To make that more useful the default could be controlled by the
.git/config or .gitmodules file. So you could have two submodules:

[submodule "sub1"]
	path = sub1
	url = /home/me/sub1.git/
	ignore = dirty
[submodule "sub2"]
	path = sub2
	url = /home/me/sub2.git/
	ignore = untracked

Where sub1 will not be scanned for work tree modifications by "git
diff" and "git status" and for sub2 any untracked files inside the
submodule will be ignored. And then "git status" should learn the
"--ignore-submodule" option too. With a fourth parameter "none" it
would be possible to override the defaults from the configuration
anyway you want.

Opinions?


Jens Lehmann (2):
  git diff: rename test that had a conflicting name
  Add optional parameters to the diff option "--ignore-submodules"

 Documentation/diff-options.txt                     |   10 ++-
 diff-lib.c                                         |    1 +
 diff.c                                             |   11 +++-
 diff.h                                             |    1 +
 t/t4027-diff-submodule.sh                          |   20 ++++-
 ...submodule.sh => t4041-diff-submodule-option.sh} |   81 ++++++++++++++++++++
 6 files changed, 118 insertions(+), 6 deletions(-)
 rename t/{t4041-diff-submodule.sh => t4041-diff-submodule-option.sh} (74%)
