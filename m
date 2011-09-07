From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v17 1/7] bisect: move argument parsing before state modification.
Date: Wed, 7 Sep 2011 08:16:15 +0200
Message-ID: <201109070816.16655.chriscool@tuxfamily.org>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com> <1312459263-16911-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 08:16:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1BR3-0004bK-9A
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 08:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab1IGGQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 02:16:29 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44115 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab1IGGQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 02:16:27 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2FC3AA6274;
	Wed,  7 Sep 2011 08:16:18 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312459263-16911-2-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180854>

Hi,

On Thursday 04 August 2011 14:00:57 Jon Seymour wrote:
> Currently 'git bisect start' modifies some state prior to checking
> that its arguments are valid.
> 
> This change moves argument validation before state modification
> with the effect that state modification does not occur
> unless argument validations succeeds.

This thread:

http://thread.gmane.org/gmane.comp.version-control.git/180733/

made me wonder if we introduced a bug with this patch.

If we start bisecting like this:

$ git bisect start HEAD HEAD~20

and then we decide that it was not optimum and we want to start again like 
this:

$ git bisect start HEAD HEAD~6

then issuing the latter command might not work as it did before this patch.
 
Before this patch the latter command would do a "git checkout $start_head" 
before the repeated rev=$(git rev-parse -q --verify "$arg^{commit}") to 
convert arguments into sha1. And after this patch the order is reversed.

This means that before this patch "HEAD" in the arguments to "git bisect 
start" would refer to $start_head because the "git checkout $start_head" 
changes HEAD. After this patch "HEAD" in the arguments to "git bisect start" 
would refer to the current HEAD.

For example before this patch, if I issue "git bisect start HEAD HEAD~8" twice 
I get:

$ git bisect start HEAD HEAD~8
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[67c116bb26b4ee31889e5ee15d6a9d3b7e972b7b] Merge branch 'jk/pager-with-
external-command'
$ git bisect start HEAD HEAD~8
Previous HEAD position was 67c116b... Merge branch 'jk/pager-with-external-
command'
Switched to branch 'master'
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[67c116bb26b4ee31889e5ee15d6a9d3b7e972b7b] Merge branch 'jk/pager-with-
external-command'

so the same commit to test is checked out.

After this patch I get:

$ git bisect start HEAD HEAD~8
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[67c116bb26b4ee31889e5ee15d6a9d3b7e972b7b] Merge branch 'jk/pager-with-
external-command'
$ git bisect start HEAD HEAD~8
Previous HEAD position was 67c116b... Merge branch 'jk/pager-with-external-
command'
Switched to branch 'master'
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[e5cfcb04e0acc5f3b51e6d69487028315b33e4c9] Merge branch 'mh/attr'

so a different commit is checked out after the second "git bisect start HEAD 
HEAD~8".

Best regards,
Christian.
