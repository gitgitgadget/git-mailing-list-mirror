From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Fixing Commit And Author
Date: Fri, 04 Nov 2005 16:35:21 -0500
Message-ID: <1131140121.24792.9.camel@localhost.localdomain>
References: <1131122325.5446.14.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511040924400.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 22:37:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9DY-0003GV-NJ
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 22:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVKDVfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVKDVfW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 16:35:22 -0500
Received: from zealot.progeny.com ([216.37.46.162]:15846 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1750925AbVKDVfV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 16:35:21 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 22DC2636AE; Fri,  4 Nov 2005 16:35:20 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511040924400.27915@g5.osdl.org>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11161>

On Fri, 2005-11-04 at 09:30 -0800, Linus Torvalds wrote:
> The rules currently do _not_ include changing the author/committer info, 
> but it does know how to parse the really old-style dates, for example, 
> which are on those same lines, so adding some code there to also re-write 
> the author/committer name and email wouldn't be impossible.
> 
> The code isn't necessarily all that easy to understand, 

I can follow it mostly. If the commits were being read and built from
scratch with strbuf's I'd be willing to give it a try. :-)

I was able to hack together a really stupid python script that worked
fine (I think) for my less demanding case.


import sys
import os

name = "Darrin Thompson"
mail = "email@address"
os.environ['GIT_AUTHOR_NAME'] = name
os.environ['GIT_AUTHOR_EMAIL'] = mail
os.environ['GIT_COMMITTER_NAME'] = name
os.environ['GIT_COMMITTER_EMAIL'] = mail

commits = os.popen('git-rev-list HEAD | tac')

def parse_commit(commit):
    tree = '///'
    parents = []
    lines = os.popen('git-cat-file commit %s' % commit)
    for line in lines:
        if not line.strip():
            break
        key, value = line.strip().split(None, 1)
        if key == 'tree':
            tree = value
        elif key == 'parent':
            parents.append(value)
        elif key == 'author' or key == 'committer':
            parts = value.split()
            seconds, tz = parts[-2:]
            date = ' '.join([seconds, tz])

    message = ''.join(lines)
    return tree, parents, message, date


tag_map = {}
tags = os.popen('git-rev-parse --symbolic --all | grep ^refs/tags/')
for line in tags:
    filename = line.strip()
    tag_name = filename.split('/')[-1]
    tag_commit = os.popen('git-rev-parse %s' % tag_name).read().strip()
    tag_list = tag_map.setdefault(tag_commit, [])
    tag_list.append(tag_name)

commit_map = {}
for line in commits:
    commit = line.strip()
    tree, bio_parents, message, date = parse_commit(commit)
    real_parents = [ commit_map[p] for p in bio_parents ]
    parents_args = ' '.join([ '-p %s' % p for p in real_parents ])
    os.environ['GIT_COMMITTER_DATE'] = date
    os.environ['GIT_AUTHOR_DATE'] = date
    write_handle, read_handle \
        = os.popen2('git-commit-tree %s %s' % (tree, parents_args), 'w')
    write_handle.write(message)
    write_handle.close()
    new_commit = read_handle.read().strip()
    commit_map[commit] = new_commit
    for tag_name in tag_map.get(commit, []):
        os.system('git-tag -f %s %s' % (tag_name, new_commit))
    read_handle.close()

print new_commit


--
Darrin
