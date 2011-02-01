From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [1.8.0] Handle submodule config options consistently in diff plumbing
Date: Tue, 01 Feb 2011 22:41:11 +0100
Message-ID: <4D487DF7.8060109@web.de>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:41:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNyU-0003rI-Ui
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab1BAVlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:41:17 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:60086 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab1BAVlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:41:16 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4FE60195AFD5E;
	Tue,  1 Feb 2011 22:41:14 +0100 (CET)
Received: from [93.246.39.219] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PkNyM-0007ZT-00; Tue, 01 Feb 2011 22:41:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19znXWTou7V/DHvwnrGXPN1EA8+KxamwOO6GWwf
	Dy4/mk7idVKmPfq9i6Tam0Bqt7E7jTwFzaSeJCNVl/1z4Prs/S
	2dH8cEPHEJikJZYP7llQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165863>

Proposal:

Handle the submodule options "diff.ignoreSubmodules" and
"submodule.<name>.ignore" consistently in diff plumbing.

I see two basic ways to change the behavior of the plumbing diff
commands:

a) Let them use the "diff.ignoreSubmodules" configuration too.

b) Don't let them use the "submodule.<name>.ignore" entries either.
   But if we go that way, we might have to revert the default of
   recursing into populated submodules too, as it might cause
   unexpected behavior when all configuration options introduced
   to control that recursion are just ignored unless explicitly
   told otherwise.


History:

When the submodule recursion for the diff commands was introduced,
all diff commands - including plumbing - learned to recurse into
submodules by default. This was done to mark submodules with
uncommitted changes as dirty so no user could accidentally forget
to commit his changes there before pushing in the superproject.

Some time after that "--ignore-submodules" learned some values to
achieve more control over what conditions mark a submodule dirty.
Then the "submodule.<name>.ignore" option was added to .git/config
and the .gitmodules file to to be able to specify these values for
one or more submodules. In a later commit the "diff.ignoreSubmodules"
option was added, but the plumbing diff commands weren't taught to
use that config option.


Risks:

a) Those scripts which depend on the plumbing commands to ignore
   the setting from "diff.ignoreSubmodules" will break.

b) All scripts written or changed since 1.7.0 which depend on the
   current behavior to recurse into submodules and use the
   "submodule.<name>.ignore" entries will be broken.

Me thinks the risks are much smaller when doing a), as people who
learned to use the recursive behavior since 1.7.0 will see that
changed under their feet when we do b) and I expect much more code
to rely on the recursion than on the "diff.ignoreSubmodules"
setting. And doing a) would fix a real life problem too, see [1].


Migration plan:

a) During the 1.7.x series a new "noconfig" value is added for the
   "--ignore-submodules" command line option for people who don't
   want user configuration to interfere with the recursion, e.g. in
   scripts (turning off the recursion is already implemented, just
   use the "--ignore-submodules" option). And then starting with
   1.8.0 "diff.ignoreSubmodules" will be used by diff plumbing.

b) During the 1.7.x series a new value for "--ignore-submodules"
   called "porcelain" is added which enables recursion and also
   tells diff plumbing use all configuration settings. Then all
   relevant call sites (like git gui, gitk and PS1 from completion
   and others) are changed to use this option. Changing the default
   behavior to ignore "submodule.<name>.ignore" and to not recurse
   anymore will be done in the 1.8.0 release.

Personally I'm in favor of solution a), but lets hear what other
people say.


[1] http://thread.gmane.org/gmane.comp.version-control.git/164166/focus=164172
