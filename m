From: Stephen Bash <bash@genarts.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 09:42:36 -0500 (EST)
Message-ID: <2137000803.2895009.1384440156683.JavaMail.root@genarts.com>
References: <20131114081456.GC16327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 14 15:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgy88-0004xL-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 15:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab3KNOmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 09:42:45 -0500
Received: from hq.genarts.com ([173.9.65.1]:30832 "EHLO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3KNOmn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 09:42:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6A280BE52A6;
	Thu, 14 Nov 2013 09:42:42 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5reMM3JK2jlT; Thu, 14 Nov 2013 09:42:36 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B521BBE528E;
	Thu, 14 Nov 2013 09:42:36 -0500 (EST)
In-Reply-To: <20131114081456.GC16327@sigill.intra.peff.net>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC30 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237850>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> Sent: Thursday, November 14, 2013 3:14:56 AM
> Subject: Re: can we prevent reflog deletion when branch is deleted?
> 
> On Thu, Nov 14, 2013 at 05:48:50AM +0530, Sitaram Chamarty wrote:
> 
> > Is there *any* way we can preserve a reflog for a deleted branch,
> > perhaps under logs/refs/deleted/<timestamp>/full/ref/name ?
> 
> At GitHub, we log each change to an "audit log" in addition to the
> regular reflog (we also stuff extra data from the environment into the
> reflog message). So even after a branch is deleted, its audit log
> entries remain, though you have to pull out the data by hand (git
> doesn't know about it at all, except as an append-only sink for
> writing). 

We recently ran into a similar situation at my $dayjob, so I made our
server side update hook log all pushes (including deletes) and added the
new log file to logrotate(8) -- note: make sure if logrotate recreates
the file that it allows everyone to write to it.  I'm sure it's not as
comprehensive as Peff's solution, but it's pretty simple for smaller
shops that want a little more protection.  Here are the relevant
excerpts from the script:

#!/usr/bin/env python

import os, sys, pwd, stat
from datetime import datetime

def log_push(too_many_changes):
    log_file = 'push-log.txt'
    try:
        f = open(log_file, 'a')

        try:
            # In case we just created the file, attempt to chmod it
            os.chmod(log_file, 0666)
        except OSError:
            # chmod will fail if the current user isn't the owner, but
            # if we've gotten this far we already have write permissions,
            # so just continue quietly
            pass

        # Linux/Mac okay, bad for Windows
        username = pwd.getpwuid(os.getuid())[0]
        f.write('%s: %s push by %s of %s from %s to %s\n'% \
                (datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                'Failed' if too_many_changes else 'Successful', username,
                refname, oldsha, newsha))
        f.close()
    except IOError:
        try:
            log_stats = os.stat(log_file)
            # Figure out owner and permissions
            log_owner = pwd.getpwuid(log_stats.st_uid).pw_name
            log_perm = oct(stat.S_IMODE(log_stats.st_mode))
            print_flush('Unable to open %s for appending. Current owner ' + \
                        'is %s and permissions are %s.'%(log_file,
                        log_owner, log_perm))
        except:
            exception,desc,stack = sys.exc_info()
            print_flush('Unable to open log file.  While generating error' + \
                        ' message encountered error: %s'%(desc))

if len(sys.argv) != 4:
    print_flush('Usage: %s refname oldsha newsha'%sys.argv[0])
    sys.exit(1)

refname = sys.argv[1]
oldsha = sys.argv[2]
newsha = sys.argv[3]

if newsha == '0'*40:
    # Deleted ref, nothing to do
    log_push(False)
    sys.exit(0)

# ... checking for various rule/style violations ...

log_push(too_many_changes)
if too_many_changes:
    sys.exit(1)
else:
    sys.exit(0)
