From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Wed, 6 Sep 2006 15:04:40 +0200
Message-ID: <200609061504.40725.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 06 15:05:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx4u-0004wa-VR
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWIFNE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWIFNE0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:04:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:31651 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750775AbWIFNEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 09:04:25 -0400
Received: by nf-out-0910.google.com with SMTP id o25so203251nfa
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 06:04:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z1iM2CyRhPXeg7mxRDUf6VftqERF+I5mjAXt7JzbAmPvjWj26PDLTnv1UNApiqEvhZPOVDADHNys031jxRXW1KBQ6gDuNCvK64wnzfKO7lFSmO/mdie9PD0lgDIVL37bima+AGF3ZBMPjQLuu3mPtRDj7sbNELi2q0qwThBsrCo=
Received: by 10.49.8.10 with SMTP id l10mr846592nfi;
        Wed, 06 Sep 2006 06:04:23 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id 36sm538832huc.2006.09.06.06.04.22;
        Wed, 06 Sep 2006 06:04:22 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26521>

This series of patches tries to improve gitweb speed somewhat.

Patch 1/7 makes possible to easily enable/disable pickaxe search
('pickaxe:' operator), by making pickaxe search a feature. 

Patch 2/7 paginates history output, which makes "history" view
for files with longer history appear much faster. Patch 7/7 fixes
omission in pagination of history output. This patch is updated
to newer mod_perl compatibile gitweb version, and corrected version
of previous patch with the same title.

Patch 3/7 makes it easy to make history output faster, if changing
the output (making output backward-incompatibile), by making it easy
to remove '--full-history' option and/or add '--remove-empty' option.

Patches 4/7, 5/7, 6/7 tries to make gitweb faster by eliminating
calls to git-rev-list, combining generating list of revision and
commit parsing into one subroutine, using one call to git-rev-list.
Unfortunately, git-rev-list is broken: 'git rev-list <commit> 
--full-history --parents -- <filename>' shows all merges in addition
to what 'git rev-list <commit> --parents -- <filename>' and 
'git rev-list <commit> --full-history -- <filename>' shows, see
"git-rev-list --full-history --parents doesn't respect path limit 
and shows all merges" thread
  Message-ID: <edmabt$3tc$1@sea.gmane.org>
  http://permalink.gmane.org/gmane.comp.version-control.git/26514
So probably those patches should be dropped or put in freezer until
git-rev-list is corrected.


Benchmark:
First column is the patch number (0 means state before first patch),
columns 2 to 4 are results of running gitweb from command line,
using /usr/bin/time -f "%e %U %s", columns 5 to 8 are taken from
ApacheBench 2.0.41-dev, run with -n 10 option, 5 and 6 for mod_cgi,
7 and 8 for mod_perl (probably not configured correctly, as it is
slower than CGI version).
 
# 1:gitweb/new~n 2:%e 3:%U 4:%s 5:ab-n10_cgi_time[ms] 6:[+/-sd] 7:ab-n10_perl_time[ms] 8:[+/-sd]
0 11.38 9.66 0 11350.681   96.8 11950.143  546.3
1 11.37 9.71 0 18150.842 4327.8 14535.352 3149.1
2 3.61  2.16 0  3719.344  261.9  3975.663  219.6
3 3.62  2.20 0  3576.822   41.2  3929.396  201.6
4 3.61  2.13 0  3620.246  188.3  3943.111  184.1
4 3.61  2.13 0  3622.156  172.6  3716.499   53.0  
#5 0/0   0/0 0/0     0/0    0/0       0/0    0/0
6 2.60  1.56 0  2809.344  369.5  2823.286  245.9
7 2.59  1.53 0  2621.073  234.2  2742.230   96.6

Shortlog:
 [PATCH 1/7] gitweb: Make pickaxe search a feature
 [PATCH 2/7] gitweb: Paginate history output
 [PATCH 3/7] gitweb: Use @hist_opts as git-rev-list parameters
             in git_history
 [PATCH 4/7] gitweb: Add parse_rev_list for later use
 [PATCH 5/7] gitweb: Use parse_rev_list in git_shortlog and git_history
 [PATCH 6/7] gitweb: Assume parsed revision list in git_shortlog_body
             and git_history_body
 [PATCH 7/7] gitweb: Set page to 0 if it is not defined, in git_history

Diffstat:
---
gitweb/gitweb.perl |  180 +++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 141 insertions(+), 39 deletions(-)-

P.S. Is putting diffstat in such a series of patches actually usefull?
-- 
Jakub Narebski
ShadeHawk on #git
Poland
