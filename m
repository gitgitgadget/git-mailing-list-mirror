From: John Clemens <clemej@gmail.com>
Subject: mirroring and development with three levels of repositories?
Date: Tue, 28 Sep 2010 13:25:40 -0400
Message-ID: <AANLkTinFiOA6Grzk16W2D=k8Xt+EgTanrS7iryW2evop@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 19:25:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0dw5-0005qW-AE
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 19:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab0I1RZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 13:25:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61445 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab0I1RZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 13:25:41 -0400
Received: by bwz11 with SMTP id 11so4328327bwz.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=8KvoQqbbTI+nZzTbHCiCyRC3ZcNa2LTJooN95D5sBNU=;
        b=nU7KvKBwspr4dweNdr6fnV+36EzsEd11LeVZULsCUyJ7WjlI//Nf1BaOus3ULlvGG/
         4fqRtHeXHCOkVLq9x8YdkcH7+zTpSaISXnDysR191BA3O5ugO+3A8pvZ7YOIADRiDOat
         CI2UvPjtCMxK06MkFcoYT3rs5YcrzAvMYMn+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WK4Z90uZCKb5zd6IZOlM+vd9TTccUhO/6xFu953xns3Hdm0nbpa82Ec9SITGb3dKID
         lFk/Kckbb366AhOhpouuEU03YKyyJo1RPQlJSLLGUpnOWE5S5NrWUuOQOv60RDs8SmSW
         2w8wC7TOZ/XIgo2vrKeSUGzbGZnZjtUr+VjAQ=
Received: by 10.204.82.167 with SMTP id b39mr235575bkl.164.1285694740274; Tue,
 28 Sep 2010 10:25:40 -0700 (PDT)
Received: by 10.204.153.10 with HTTP; Tue, 28 Sep 2010 10:25:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157446>

Apologies in advance for the long question.  I'm obviously doing something
wrong, but I'm not sure what and searching hasn't provided me with anything.
If there is a git-users mailing list this would be more appropriate for,
please tell me.

Short question:
It it possible for a bare repository to have both local (company-wide) and
remote (mirroring upstream) branches, as well as serving those branches to our
devs? If so, how?

Long question:

We're working on a project that's a collaboration between several companies.
The full tree for everyone is stored on a central server that, for firewall
reasons, only one person can access in the company.  So, that person creates
and updates nightly a local mirror of the central server.  We then have a few
branches of our own that we do development on inside the company, and
periodically merge those branches into the main ones and push them upstream.

In mercurial, we do the branching by cloning the local mirror on our internal
server, having the devs push and pull from that repo, and then pushing those
changes to our local mirror, which gets pushed to the central server.

Now the central server has some things using git, and the git repo has
6 branches within it, as opposed to individual repos.  The setup looks
like this:

+----------+
| upstream |  <--- contains tree with 6 branches
+----------+
    |
------------- <---- firewall
    |
+--------------+
| Local Mirror | <--- "git clone --mirror" from upstream.
+--------------+
    |
    |---------|
  +-----+     +-----+
  | dev |     | dev |
  +-----+     +-----+

I would like to create two company-wide branches here that remain local,
one that branches from upstream's HEAD, and one that branches from one
of the existing branches on upstream (call it branch-a). I then want the devs
to be able to git clone our mirror, and then switch to our company-local branch
and hack away, putting thier changes on the company-wide server.

I thought I'd do this in git by the following:

(on client/dev machine):
$ git clone http://local-server/local-mirror.git

For later reference:
$ git remote show origin
* remote origin
  Fetch URL: http://local-server/local-mirror.git
  Push  URL: http://local-server/local-mirror.git
  HEAD branch: xxx/stable
  Remote branches:
    feature             tracked
    branch-a            tracked
    xxx/master          tracked
    xxx/feature1        tracked
    xxx/feature2        tracked
    xxx/stable          tracked
  Local branch configured for 'git pull':
    xxx/stable merges with remote xxx/stable
  Local ref configured for 'git push':
    xxx/stable pushes to xxx/stable (up to date)

Then, we create a new branch and push it to the server:

$ git branch company-name/test1
$ git push origin company-name/test1

So far, so good, gitweb shows the new beanch in the mirror, pointing to
HEAD.  Now lets create and push the other new company-wide branch:

$ git checkout -b company-name/branch-a origin/branch-a
$ git push origin company-name/branch-a

Again, all seems well.  gitweb shows the new company-name/* branches on the
local server.

However, when you do a new clone of the local mirror, it now fails:

$ git clone http://local-server/local-mirror.git
Initialized empty Git repository in /home/clemej/git/local-mirror/.git/
warning: remote HEAD refers to nonexistent ref, unable to checkout.

$ git branch -a
remotes/origin/company-name/test1
remotes/origin/company-name/branch-a

Note the distinct absense of all the other branches in the repository.

$ git remote show origin
* remote origin
  Fetch URL: http://local-server/local-mirror.git
  Push  URL: http://lodql-server/local-mirror.git
  HEAD branch: (unknown)
  Remote branches:
    company-name/test1       tracked
    company-name/branch-a    tracked

Jumping over to the server, we see:

$ cd local-mirror.git/
$ git remote show origin
* remote origin
  Fetch URL: http://upstream/tree.git
  Push  URL: http://upstream/tree.git
  HEAD branch: xxx/stable
  Remote branches:
    company-name/test1       stale (use 'git remote prune' to remove)
    company-name/branch-a    stale (use 'git remote prune' to remove)
    feature             tracked
    branch-a            tracked
    xxx/master          tracked
    xxx/feature1        tracked
    xxx/feature2        tracked
    xxx/stable          tracked
  Local refs will be mirrored by 'git push'

So, I'm obviously not thinking about this the right way.  It it possible
for a bare repository to have both local (company-wide) and remote (mirroring
upstream) branches, as well as serving those branches to our devs?  If so, how?

Thanks for your time,
john.c

-- 
John Clemens <clemej@gmail.com>
