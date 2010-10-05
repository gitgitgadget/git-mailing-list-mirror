From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Tue, 05 Oct 2010 22:43:11 +0200
Message-ID: <4CAB8DDF.8080004@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:43:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3EMA-0006zy-BR
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab0JEUnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:43:14 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:52045 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab0JEUnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:43:13 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id C919B16C2FB57;
	Tue,  5 Oct 2010 22:43:11 +0200 (CEST)
Received: from [93.246.38.65] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P3ELv-0006US-00; Tue, 05 Oct 2010 22:43:11 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/d5M+BqJyqmTl8lad9QeKKXd5uvC0Eam5rTVT2
	DNT960bpdxIQi20Vsty79/XVxgZKICo8y+oqUl6aNeGxZsp920
	ZSIYvPlsrXCCSmwdEkiQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158239>

So here is the next iteration of the recursive fetching for submodules.

Changes to the first patchset and its fixes:

* Squashed all fixes into the first patch
* Added the new config setting 'fetch.recursive' to set the default
  for all submodules

IMO this patchset should replace the one currently in pu.


Still unresolved issues:

1) Performance

   Kevin reported the fetch time went up from 1.5s to 20s for him
   because of the recursion. Kevin, could you please test the branch
   "parallel-submodule-fetch" from my github repository:

      http://github.com/jlehmann/git-submod-enhancements.git

   It has these three patches based on next plus a preliminary
   commit fetching submodules in parallel (but note that a limit
   of 128 submodules is hardcoded and the output might be mixed
   between the fetch threads, I'll fix that when you confirm the
   performance benefit I expect).

   (It took me some time to get that working, the DNS server in my
   DSL router seems to silently drop IPv6 requests. This lead to a
   15 second timeout in getaddrinfo() when forking fetch commands
   in quick succession, turning the intended speedup into a
   massive slowdown. If you happen to run into the same issue,
   please try the "broken-dns-server-hack" branch which contains a
   workaround for that issue).


2) The proper default

   Kevin argues that submodule fetching should only happen when new
   commits for the submodule have been fetched (which is kind of
   similar to what "git submodule update" does now), while I argue
   that submodules should always be fetched by default, no matter
   if new commits from submodules are committed inside the
   superproject or not.

   Ok, lets look at the basic ways you can run the fetch command and
   look at possible defaults:

   a) "git fetch --all"

      The user wanted to fetch new commits from all remotes. I think
      git should also fetch all submodules then, no matter if new
      commits from them are fetched in the superproject, as the user
      explicitly said he wants everything. Objections?

   b) "git fetch [<repository>]"

      The user wants to fetch from the default [or a single repo]. I
      think all submodules should be fetched too, Kevin thinks this
      should happen only when it is necessary (at least for his 'H'
      repository). While I think fetching all submodules too is
      consistent with the fact that you get all branches in the
      superproject too, whether you need them or not, we can't seem
      to agree on this one (also see my proposal below).

   c) "git fetch [<repository>] <refspec>"

      If the user wants to fetch only commits from a certain refspec,
      I think that it is sane to let git fetch only those submodules
      where new commits were fetched in the superproject as he was
      explicitly asking only for a subset of available commits.

   Assuming we agree on a) and - the still to be implemented - c), It
   looks like we need a new config setting for 'fetch.recursive' and
   'submodule.<name>.fetch', say 'changed'? This would allow Kevin to
   set 'submodule.H.fetch' to 'changed' in the .gitmodules describing
   it. Then "git fetch" would only then recurse further when new
   commits from 'H' have been used in the commits fetched in its
   superproject. Would that be an acceptable solution?


Jens Lehmann (3):
  fetch/pull: Recursively fetch populated submodules
  Submodules: Add the new "fetch" config option for fetch and pull
  Add the 'fetch.recursive' config setting

 Documentation/config.txt        |   10 ++
 Documentation/fetch-options.txt |   15 +++
 Documentation/gitmodules.txt    |    8 ++
 builtin/fetch.c                 |   58 ++++++++---
 git-pull.sh                     |   10 ++-
 submodule.c                     |   91 +++++++++++++++++-
 submodule.h                     |    3 +
 t/t5526-fetch-submodules.sh     |  209 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 9 files changed, 388 insertions(+), 18 deletions(-)
 create mode 100755 t/t5526-fetch-submodules.sh

-- 
1.7.3.1.108.gb6303
