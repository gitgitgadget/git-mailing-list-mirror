From: Stephen Bash <bash@genarts.com>
Subject: Re: pre-commit to reject EOL changes
Date: Mon, 6 Jun 2011 09:05:58 -0400 (EDT)
Message-ID: <28970272.49953.1307365558925.JavaMail.root@mail.hq.genarts.com>
References: <m37h92rq4p.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Neal Kreitzinger <neal@rsss.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:06:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTZVa-0004dR-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 15:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897Ab1FFNGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 09:06:10 -0400
Received: from hq.genarts.com ([173.9.65.1]:21898 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756782Ab1FFNGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 09:06:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 46467EA22D7;
	Mon,  6 Jun 2011 09:06:06 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMebUDZcrw3H; Mon,  6 Jun 2011 09:05:59 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 0065315C8001;
	Mon,  6 Jun 2011 09:05:59 -0400 (EDT)
In-Reply-To: <m37h92rq4p.fsf@localhost.localdomain>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175121>

----- Original Message -----
> From: "Jakub Narebski" <jnareb@gmail.com>
> Sent: Saturday, June 4, 2011 3:52:06 AM
> Subject: Re: pre-commit to reject EOL changes
> 
> > I see that the pre-commit.sample reject introduction of lines with
> > trailing whitespaces. Is there a way to have it reject changes in 
> > EOL format (CRLF vs LF)?
> 
> Well, from description of relevant config variable, namely 
> `core.whitespace` it looks like by default `trailing-space` with 
> `cr-at-eol` not enabled (default) treats adding CR in LF -> CR LF 
> change as whitespace error.
> 
> I don't think there is anything *canned* (out of the box) for the
> change in reverse direction.

We recently had issues with flip-flopping line endings, so I wrote the following update hook for our central repo to stop major whitespace changes on push.  It's currently only lightly tested, and while the comments imply it'll work for merges I'm not absolutely convinced of that.  YMMV.

Please excuse the long lines, this was thrown together rather quickly...

HTH,
Stephen


#!/usr/bin/env python

import sys
from subprocess import Popen, PIPE

GIT_PATH = '/usr/local/bin/git'
MAX_DIFFS = 7

def call_git(*args):
    return Popen([GIT_PATH] + list(args), stdout=PIPE).communicate()[0]

if len(sys.argv) != 4:
    print 'Usage: %s refname oldsha newsha'%sys.argv[0]
    sys.exit(1)

refname = sys.argv[1]
oldsha = sys.argv[2]
newsha = sys.argv[3]

if oldsha == '0'*40 or newsha == '0'*40:
    # New or deleted ref, nothing to do
    # The deleted ref is obvious, but new ref is a bit tricky.  Arguably someone could create
    # a new branch, change some line endings, commit and push, at which point this hook will
    # ignore the change because there's no oldsha to compare to.  This script will catch 
    # merges that introduce EOL changes, but that's much later (the idea is to make commiters
    # as aware of EOL changes as possible as early as possible).  So for now just ignore this
    # case...
    sys.exit(0)

print 'Checking %s for EOL changes...'%refname
sys.stdout.flush()

# List all changed files between oldsha and newsha
changed_blobs = call_git('diff-tree', '-r', oldsha, newsha)
for change_line in changed_blobs.split('\n'):
    if len(change_line) > 0 and change_line[0] == ':':
        # Get old/new blob ID for each changed file
        (oldmode, newmode, oldblob, newblob, action, extra) = change_line.split(None,5)
        if action in ['A', 'D']:
            # Added or deleted file, nothing to diff
            continue

        # Diff the old and new blobs
        # Could use -z to terminate fields with '\0', but the add/del fields are still
        # tab separated, so that doesn't help much
        raw_diffstat = call_git('diff', '--numstat', oldblob, newblob)
        (raw_add,raw_del,raw_extra) = raw_diffstat.split('\t', 2)
        if raw_add == '-' and raw_del == '-':
            # numstat returns '-' for binary files, skip
            continue
        raw_add = int(raw_add)
        raw_del = int(raw_del)

        # Diff the old and new blobs ignoring EOL whitespace
        noeol_diffstat = call_git('diff', '--numstat', '--ignore-space-at-eol', 
                                  oldblob, newblob)
        (noeol_add,noeol_del,noeol_extra) = noeol_diffstat.split('\t', 2)
        noeol_add = int(noeol_add)
        noeol_del = int(noeol_del)

        # Calculate how different the two diffs are (should ideally be zero)
        diff_add = abs(raw_add - noeol_add)
        diff_del = abs(raw_del - noeol_del)

        if diff_add > MAX_DIFFS or diff_del > MAX_DIFFS:
            # Too much difference, probably screwing up the line endings
            # print 'Change to %s rejected (sha: %s, diff_add: %g, diff_del: %g)'%(refname, newsha, diff_add, diff_del)
            oldsha_short = call_git('rev-parse', '--short', oldsha).rstrip()
            newsha_short = call_git('rev-parse', '--short', newsha).rstrip()
            print 'Too many EOL changes detected (try \'git diff %s %s\')'%(oldsha_short, newsha_short)
            sys.stdout.flush()
            sys.exit(1)
#        else:
#            print 'Change accepted (diff_add: %g, diff_del: %g)'%(diff_add, diff_del)
#            sys.stdout.flush()

# Just to be sure
sys.exit(0)
