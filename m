From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/7] Teach fetch/pull the on-demand mode and make it the
 default
Date: Tue, 01 Mar 2011 23:59:28 +0100
Message-ID: <4D6D7A50.5090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYYW-0000YD-JD
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 00:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829Ab1CAW7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 17:59:45 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:42613 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab1CAW7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:59:34 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id CEA3418A516F8;
	Tue,  1 Mar 2011 23:59:32 +0100 (CET)
Received: from [93.240.102.247] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuYXU-0007KR-00; Tue, 01 Mar 2011 23:59:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+tF9R5lgHdieur7FK7/GWhhhnO5rUDhUtbVBjq
	dfclpWDnwUhvIjAWVKWTjWNGRRvgojS4jpJMUHb1wIH/FJhU4Z
	+SkhRb7NbroKwoAZu0IQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168273>

So here is version 2 of the on-demand recursive fetch for submodules.

Changes since the last version:

*) Add a name parameter to parse_fetch_recurse_submodules_arg()
*) Enhance description of the "--submodule-default" fetch option
*) Free the changed_submodule_paths string_list at the end of
   fetch_populated_submodules() to aid libification and to make
   valgrind happy
*) Add a comment for the while loop in check_for_new_submodule_commits()
*) Use "--all" instead of "--branches" and "--remotes" for rev-list to
   include tags too
*) Compute the argc value properly instead of hard coding it in
   check_for_new_submodule_commits()
*) Change size_t casts to intptr_t where appropriate
*) Use "rev-list --not --all" when checking if a submodule commit exists
   instead of a simple lookup/rev-parse to make sure they are not only
   present but are reachable from a ref
*) Describe that fetch and pull only work on populated submodules for
   now in the BUGS section of their man pages (done in a separate commit
   because this doesn't belong to a special commit in this series but
   also to the functionality that has already been merged)

Thanks to Jonathan an Junio for the feedback that lead to these changes.

Issues that were raised but not addressed yet:

*) Should this option be called "on-demand" or "changed" or maybe even
   "updated"?
   I have no strong feelings about this, me just thinks the name should
   tell somehow that only submodules where new commits are recorded in
   the superproject which aren't already present locally will be fetched.
   Opinions?
*) Check the remote tracking refs in the submodule in tests instead of
   the output of the fetch command


Jens Lehmann (7):
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
  fetch/pull: Describe --recurse-submodule restrictions in the BUGS
    section

 Documentation/config.txt        |   12 ++-
 Documentation/fetch-options.txt |   27 ++++-
 Documentation/git-fetch.txt     |    9 ++
 Documentation/git-pull.txt      |   11 ++-
 Documentation/gitmodules.txt    |    4 +-
 builtin/fetch.c                 |   47 ++++++--
 git-pull.sh                     |    3 +
 git-submodule.sh                |    5 +-
 submodule.c                     |  152 +++++++++++++++++++++--
 submodule.h                     |   11 ++-
 t/t5526-fetch-submodules.sh     |  255 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 t/t7406-submodule-update.sh     |   20 +++
 13 files changed, 521 insertions(+), 37 deletions(-)

-- 
1.7.4.1.291.g6060
