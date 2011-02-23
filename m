From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/6] Teach fetch/pull the on-demand mode and make it the default
Date: Wed, 23 Feb 2011 21:33:41 +0100
Message-ID: <4D656F25.5090007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 21:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsLQ9-00070X-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 21:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab1BWUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 15:34:45 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:50460 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab1BWUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 15:34:44 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 90AF818933EB6;
	Wed, 23 Feb 2011 21:33:41 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsLP3-00023V-00; Wed, 23 Feb 2011 21:33:41 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18wAsGhjeocAcQnlIxNQCrd2d001NIZ15sbpZsx
	ho8rYzOtqNbon1j+K6ImSyWod+VWXpy4E9Hdd3Bu+Cxm5pqDTT
	lNuwassSwVJP8TwwwpRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167721>

So here is my patch series to implement the new default "on-demand"
fetch mode and let "git submodule update" only fetch submodules when
the commit to check out is not already present in the submodule.
This is only done for populated submodules and prepares them for
disconnected operation without having to think about doing a
recursive fetch before going on a plane and having to add the '-N'
option to "git submodule update" while on it. Also merging submodule
commits in the superproject and "git diff --submodule" (which is
used by git gui and gitk) depend on the presence of those commits
referenced by the superproject to work.

The last commit is slightly orthogonal as it would be useful without
on-demand fetch too. With it rewinding a submodule to a commit that
is already present (e.g. because it was checked out earlier) will be
done without issuing a fetch even in current git. Together with the
other patches "git submodule update" won't have to fetch a submodule
at all anymore (at least unless the new "on-demand" default is
disabled through the also added configuration options).

Changes since the last version:
(see http://article.gmane.org/gmane.comp.version-control.git/163429)

*) Added the "on-demand" value to the "--recurse-submodules" command
   line option and the "submodule.<name>.fetchRecurseSubmodules" and
   "fetch.recurseSubmodules" config options.
*) The fetch is only done when the recorded submodule commit isn't
   already present.
*) Added test cases.

There are two things that could be optimized, but that can be the
topic of other patches:

*) The submodule fetches could be done in parallel.
*) It might be expensive to compute the newly fetched commits. If
   the transport helper could be asked for the list commits it just
   fetched that would go away.

I tend to think that this is suited for 1.7.5 but don't have any
objections against holding it back until 1.8.0 either. What do
others think?

Jens Lehmann (6):
  fetch/pull: recurse into submodules when necessary
  fetch/pull: Add the 'on-demand' value to the --recurse-submodules
    option
  config: teach the fetch.recurseSubmodules option the 'on-demand'
    value
  Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule'
    option
  fetch/pull: Don't recurse into a submodule when commits are already
    present
  submodule update: Don't fetch when the submodule commit is already
    present

 Documentation/config.txt        |   12 ++-
 Documentation/fetch-options.txt |   24 +++-
 Documentation/git-pull.txt      |    2 +-
 Documentation/gitmodules.txt    |    4 +-
 builtin/fetch.c                 |   49 ++++++--
 git-pull.sh                     |    3 +
 git-submodule.sh                |    2 +-
 submodule.c                     |  124 +++++++++++++++++--
 submodule.h                     |   11 ++-
 t/t5526-fetch-submodules.sh     |  255 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 t/t7406-submodule-update.sh     |   20 +++
 12 files changed, 471 insertions(+), 37 deletions(-)

-- 
1.7.4.1.190.g13e20
