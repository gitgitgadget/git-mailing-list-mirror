From: Pete Wyckoff <pw@padd.com>
Subject: Re: Is there a scriptable way to update the stat-info in the index
 without having git open and read those files?
Date: Sat, 27 Aug 2011 11:18:24 -0400
Message-ID: <20110827151824.GA1903@arf.padd.com>
References: <CABPp-BEiN7ffNmvLCvEfz056M_F36j+gV9t6J9-x_=H9q0rZFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 17:18:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxKeZ-0002EU-0Z
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 17:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab1H0PS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 11:18:29 -0400
Received: from honk.padd.com ([74.3.171.149]:56760 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab1H0PS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 11:18:28 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 81E625B64;
	Sat, 27 Aug 2011 08:18:27 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AF2CF314D1; Sat, 27 Aug 2011 11:18:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABPp-BEiN7ffNmvLCvEfz056M_F36j+gV9t6J9-x_=H9q0rZFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180231>

newren@gmail.com wrote on Mon, 22 Aug 2011 16:28 -0600:
> I want to do something really close to
>   git update-index -q --refresh
> However, I want it to assume the files in the working tree are
> unmodified from the index (i.e. don't waste time opening and reading
> the file) and simply update the stat information in the index to match
> the current files on disk.
> 
> Yes, I know that would be unsafe if the files don't have the
> appropriate contents; I'm promising that they do have the appropriate
> contents and don't want to pay the performance penalty for git to
> verify.  Is that possible?

I have the same issue in my workflow, and agree with Junio that this
is just too bizarre to put in the code.  Here's the script I use,
relying on dulwich, that you might find helpful.

		-- Pete


------8<------------------
#!/usr/bin/env python2.6
# git-index-clone - Update index after a volume clone
# Copyright 2010 Pete Wyckoff <pw@padd.com>

import sys
import os
from dulwich.index import Index

index_name = ".git/index"

#
# Debugging option:  show the index entry for just one file name,
# e.g. git-index-clone file/name/in/tree
#
def show_entry(name):
    idx = Index(index_name)
    if name not in idx:
	print >>sys.stderr, "No index entry", name
	return
    print "index", idx[name]
    t = update_from_stat(idx[name], name)
    print "stat ", t

#
# Stat the file, return the new tuple
#
def update_from_stat(idx, name):
    (ctime, mtime, dev, ino, mode, uid, gid, size, sha, flags) = idx

    sb = os.lstat(name)

    # times are float; dulwich converts to (sec, ns) on write
    ctime = sb.st_ctime
    mtime = sb.st_mtime
    dev = sb.st_dev
    ino = sb.st_ino
    # assume mode unchanged
    uid = sb.st_uid
    gid = sb.st_gid
    # assume size, sha, flags unchanged
    return (ctime, mtime, dev, ino, mode, uid, gid, size, sha, flags)

def convert():
    idx_in = Index(index_name)
    os.unlink(index_name)

    idx_out = Index(index_name)

    for name in idx_in:
	idx_out[name] = update_from_stat(idx_in[name], name)

    idx_out.write()
    os.chmod(index_name, 0644)  # drop exec perms

def usage():
    print >>sys.stderr, "Usage: %s [<index entry name>]\n"
    sys.exit(1)

def main():
    if len(sys.argv) == 1:
	convert()
    elif len(sys.argv) == 2:
	show_entry(sys.argv[1])
    else:
	usage()
    return 0

if __name__ == "__main__":
    sys.exit(main())
