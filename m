From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 15:18:15 +0200
Message-ID: <50800197.90105@drmicha.warpmail.net>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 15:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOpzb-0005VG-AN
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 15:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2JRNST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 09:18:19 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56617 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753336Ab2JRNSS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 09:18:18 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EF73A2094E;
	Thu, 18 Oct 2012 09:18:17 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 18 Oct 2012 09:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=xTQorqzbTAgCvLN/4XEeHm
	OvQ6E=; b=hwmieiRv3wB93wywzIixbJ6dBiMeyCfZwoXdJkLh4B4v92eJvyZqXl
	05v0AVxZrowWSbMBatyxYHiV2sGo3cHtqhVzb3vcmqsJLGsil2TT/YUcZ+TGyGpd
	qbK/GHZZoB/d6Gt6cyNmcr2z18MsCBZMcBUsFXzAaYjGQKS7P4VkM=
X-Sasl-enc: gqrZVdSBZpKS8t/d93k7JxMrC7d3J9oPsC4VHtviI5gG 1350566297
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A0890482740;
	Thu, 18 Oct 2012 09:18:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208004>

Felipe Contreras venit, vidit, dixit 17.10.2012 14:58:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> 
> I've looked at many hg<->git tools and none satisfy me. Too complicated, or too
> slow, or to difficult to setup, etc.

It's in an unsatisfying state, I agree. We have a great remote helper
infrastructure, but neither git-svn nor git-cvsimport/export use it, and
remote-hg is not in git.git.

git-svn used to be our killer feature! (It's becoming hard to maintain,
though.)

git-hg (in the shape of a remote helper) could be our next killer
feature, finally leading to our world domination ;)

> The only one I've liked so far is hg-fast-export[1], which is indeed fast,
> relatively simple, and relatively easy to use. But it's not properly maintained
> any more.
> 
> So, I decided to write my own from scratch, using hg-fast-export as
> inspiration, and voila.
> 
> This one doesn't have any dependencies, just put it into your $PATH, and you
> can clone and fetch hg repositories. More importantly to me; the code is
> simple, and easy to maintain.

Well, it still has hg as a dependency. All our remote
integration/helpers suffer from that. At least, every hg install comes
with the modules, whereas svn is a beast (apr and such) that often comes
without the language bindings.

> [1] http://repo.or.cz/w/fast-export.git
> 
>  contrib/remote-hd/git-remote-hg | 231 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100755 contrib/remote-hd/git-remote-hg

That diffstat looks great (sans tests, of course; it's contrib), but
there's no push functionality, and that is usually the most difficult
part all helpers have to implement: Not only the push interaction, but
also making sure that commits don't get duped in a roundtrip (git fetch
from vcs, push to vcs, git fetch from vcs).

Just cloning and fetching can be done most easily with a shared worktree
and scripting around "hg up" and "git commit -A" in some flavour.

> diff --git a/contrib/remote-hd/git-remote-hg b/contrib/remote-hd/git-remote-hg
> new file mode 100755
> index 0000000..9157b30
> --- /dev/null
> +++ b/contrib/remote-hd/git-remote-hg
> @@ -0,0 +1,231 @@
> +#!/usr/bin/python2
> +
> +# Inspired by Rocco Rutte's hg-fast-export
> +
> +# Just copy to your ~/bin, or anywhere in your $PATH.
> +# Then you can clone with:
> +# hg::file:///path/to/mercurial/repo/
> +
> +from mercurial import hg, ui
> +
> +import re
> +import sys
> +import os
> +import json
> +
> +def die(msg, *args):
> +    print >> sys.stderr, 'ERROR:', msg % args
> +    sys.exit(1)

While we don't have to code for py3, avoiding '>>' will help us later.
(It got removed in py3.) sys.sdterr.write() should be most portable.

> +def gitmode(flags):
> +    return 'l' in flags and '120000' or 'x' in flags and '100755' or '100644'
> +
> +def export_file(fc):
> +    if fc.path() == '.hgtags':

Is this always relative? Just wondering, dunno.

> +        return
> +    d = fc.data()
> +    print "M %s inline %s" % (gitmode(fc.flags()), fc.path())
> +    print "data %d" % len(d)
> +    print d
> +
> +def get_filechanges(repo, ctx, parents):
> +    l = [repo.status(p, ctx)[:3] for p in parents]
> +    changed, added, removed = [sum(e, []) for e in zip(*l)]
> +    return added + changed, removed
> +
> +author_re = re.compile('^((.+?) )?(<.+?>)$')
> +
> +def fixup_user(user):
> +    user = user.replace('"', '')
> +    m = author_re.match(user)
> +    if m:
> +        name = m.group(1)
> +        mail = m.group(3)
> +    else:
> +        name = user
> +        mail = None
> +
> +    if not name:
> +        name = 'Unknown'
> +    if not mail:
> +        mail = '<unknown>'
> +
> +    return '%s %s' % (name, mail)
> +
> +def get_repo(path, alias):
> +    myui = ui.ui()
> +    myui.setconfig('ui', 'interactive', 'off')
> +    repo = hg.repository(myui, path)
> +    return repo

Is there a reason to spell this out, e.g.: Why not

return hg.repository(myui, path)

> +
> +def hg_branch(b):
> +    if b == 'master':
> +        return 'default'
> +    return b
> +
> +def git_branch(b):
> +    if b == 'default':
> +        return 'master'
> +    return b
> +
> +def export_tag(repo, tag):
> +    global prefix
> +    print "reset %s/tags/%s" % (prefix, tag)
> +    print "from :%s" % (repo[tag].rev() + 1)
> +    print
> +
> +def export_branch(repo, branch):
> +    global prefix, marks, cache, branches
> +
> +    heads = branches[hg_branch(branch)]
> +
> +    # verify there's only one head
> +    if (len(heads) > 1):
> +        die("Branch '%s' has more than one head" % hg_branch(branch))

We have to deal with this at some point... Do you support "hg
bookmarks"? They'd be an option, or we implement better detached head
handling in git...

> +
> +    head = repo[heads[0]]
> +    tip = marks.get(branch, 0)
> +    # mercurial takes too much time checking this
> +    if tip == head.rev():
> +        # nothing to do
> +        return
> +    revs = repo.revs('%u:%u' % (tip, head))
> +    count = 0
> +

> +    revs = [rev for rev in revs if not cache.get(rev, False)]
> +
> +    for rev in revs:

Those lines set up the list just so that you iterate over it later.
Please don't do this (unless you know that revs is very small).

for rev in revs:
  if cache.get(rev, False):
    continue

is more performant. You can reduce this further to

count=0
for rev in repo.revs('%u:%u' % (tip, head)):
  if cache.get(rev, False):
    continue

which is even more performant generally, and especially if repo.revs()
returns an iterator rather than a list.

[Yes, you could use lambda+filter, but let's not get religious. The
above is simple and pythonic.]

> +
> +        c = repo[rev]
> +        (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(c.node())

Same here, you introduce c just for the next line (unless I'm mistaken).

> +        rev_branch = git_branch(extra['branch'])
> +
> +        tz = '%+03d%02d' % (-tz / 3600, -tz % 3600 / 60)
> +
> +        print "commit %s/branches/%s" % (prefix, rev_branch)
> +        print "mark :%d" % (rev + 1)
> +        print "committer %s %d %s" % (fixup_user(user), time, tz)
> +        print "data %d" % (len(desc) + 1)
> +        print desc
> +        print
> +
> +        parents = [p for p in repo.changelog.parentrevs(rev) if p >= 0]
> +
> +        if len(parents) == 0:
> +            modified = c.manifest().keys()
> +            removed = []
> +        else:
> +            added = []
> +            changed = []
> +            print "from :%s" % (parents[0] + 1)

What is this +1 offset that is appearing here and there?

> +            if len(parents) > 1:
> +                print "merge :%s" % (parents[1] + 1)
> +            modified, removed = get_filechanges(repo, c, parents)
> +
> +        for f in removed:
> +            print "D %s" % (f)
> +        for f in modified:
> +            export_file(c.filectx(f))
> +        print
> +
> +        count += 1
> +        if (count % 100 == 0):
> +            print "progress revision %d '%s' (%d/%d)" % (rev, branch, count, len(revs))
> +            print "#############################################################"
> +
> +        cache[rev] = True
> +
> +    # store the latest revision
> +    marks[branch] = rev
> +
> +def do_capabilities(repo, args):
> +    global prefix, dirname
> +
> +    print "import"
> +    print "refspec refs/heads/*:%s/branches/*" % prefix
> +    print "refspec refs/tags/*:%s/tags/*" % prefix
> +
> +    path = os.path.join(dirname, 'marks-git')
> +
> +    print "*export-marks %s" % path
> +    if os.path.exists(path):
> +        print "*import-marks %s" % path
> +
> +    print
> +
> +def do_list(repo, args):
> +    global branches
> +
> +    head = repo.dirstate.branch()
> +    for branch in repo.branchmap():
> +        heads = repo.branchheads(branch)
> +        if len(heads):
> +            branches[branch] = heads

I'm a bit confused here. repo.brancheads() is a list, no? Is this the
single head case only? I'd expect [0] of that, but you seem to be
getting branch names (strings).

Also, if len(heads) == 0 then branches[branch] is undefined or stale. No?

> +
> +    for branch in branches:
> +        print "? refs/heads/%s" % git_branch(branch)
> +    for tag, node in repo.tagslist():
> +        if tag == 'tip':
> +            continue
> +        print "? refs/tags/%s" % tag
> +    print "@refs/heads/%s HEAD" % git_branch(head)
> +    print
> +
> +def do_import(repo, args):
> +    ref = args[1]
> +
> +    if (ref == 'HEAD'):
> +        return
> +
> +    if ref.startswith('refs/heads/'):
> +        branch = ref[len('refs/heads/'):]
> +        export_branch(repo, branch)
> +    elif ref.startswith('refs/tags/'):
> +        tag = ref[len('refs/tags/'):]
> +        export_tag(repo, tag)
> +
> +def main(args):
> +    global prefix, dirname, marks, cache, branches
> +
> +    alias = args[1]
> +    url = args[2]
> +
> +    gitdir = os.environ['GIT_DIR']
> +    dirname = os.path.join(gitdir, 'hg')
> +    cache = {}
> +    branches = {}
> +
> +    repo = get_repo(url, alias)
> +    prefix = 'refs/hg/%s' % alias
> +
> +    if not os.path.exists(dirname):
> +        os.makedirs(dirname)
> +
> +    marks_path = os.path.join(dirname, 'marks-hg')
> +    try:
> +        fp = open(marks_path, 'r')
> +        marks = json.load(fp)
> +        fp.close()
> +    except IOError:
> +        marks = {}
> +
> +    line = True
> +    while (line):
> +        line = sys.stdin.readline().strip()
> +        if line == '':
> +            break
> +        args = line.split()
> +        cmd = args[0]
> +        if cmd == 'capabilities':
> +            do_capabilities(repo, args)
> +        elif cmd == 'list':
> +            do_list(repo, args)
> +        elif cmd == 'import':
> +            do_import(repo, args)
> +        sys.stdout.flush()
> +
> +    fp = open(marks_path, 'w')
> +    json.dump(marks, fp)
> +    fp.close()
> +
> +sys.exit(main(sys.argv))
> 

Overall, this looks like plain scripting in python rather than anything
oo'ish, but that's okay and probably dictated by the remote helper
interface and/or the existing exporter.

I'm all for an improvement in that area, but still feel we'd need a
combined effort rather than yet another start.

Michael
