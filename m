From: Alain Kalker <a.c.kalker@gmail.com>
Subject: [BUG] Git clone of a bundle fails, but works (somewhat) when run
 with strace
Date: Fri, 15 Feb 2013 20:33:24 +0100
Message-ID: <511E8D84.6060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 20:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6R2h-0004yz-Ji
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 20:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab3BOTdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 14:33:31 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:64747 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3BOTd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 14:33:29 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so1575524wib.6
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 11:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=W09RRpLDlpjxGtlLQGLWmptiQHQSsNsWBCC0fEh5e30=;
        b=SWowFHbaRn4lAtGcw57WUSGqF047Zg2JX2plxxJQg8wlzyeeCgTf8rxnp1m/QcfmfV
         pjhA8TGwtnFwXrTPuaoq/MEDmK2WiaV0QE3ZG02kwHbFYBrada3UjM547ixCBbatSkWl
         P91CwTqlgBFCo8v66ZPGVqo0bmyceWZ7m6ZSYZ2SgfbErdE66tFqQpxPGXGruPYt7PVY
         HVd2kmkEdUe4A8Jjo+kEE5b19647X2DsypxBK7S/Ep3apwmxYXKnLNJWX96sJcnZ6Woy
         x+M+71bcsnbeSmhrkUdIhaZXlXmefDfOrqb1J/RInhw+76FugmmR2iJYroiNsW9+3FHU
         LMEw==
X-Received: by 10.180.84.199 with SMTP id b7mr6343660wiz.22.1360956807517;
        Fri, 15 Feb 2013 11:33:27 -0800 (PST)
Received: from [192.168.1.157] (524A7994.cm-4-3b.dynamic.ziggo.nl. [82.74.121.148])
        by mx.google.com with ESMTPS id ex1sm7186057wib.7.2013.02.15.11.33.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 11:33:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130109 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216352>

tl;dr:

- `git bundle create` without <git-rev-list-args> gives git rev-list 
help, then dies.
   Should point out missing <git-rev-list-args> instead.
- `git clone <bundle> <dir> gives "ERROR: Repository not found."
- `strace ... git clone <bundle> <dir>` (magically) appears to work but
   cannot checkout files b/c of nonexistent ref.
- Heisenbug? Race condition?
- Zaphod Beeblebrox has left the building, sulking.

Full description:

When I try to clone from a bundle created from a local repository, `git 
clone <bundle> <dir>` fails with: "ERROR: Repository not found. fatal: 
Could not read from remote repository." unless I run it with strace.

OS: Arch Linux (rolling release)
Git versions: 1.8.1.3 and git://github.com/git.git master@02339dd

Steps to reproduce:

$ # Clone the Linux kernel repository
$ git clone git://github.com/torvalds/linux.git
Cloning into 'linux'...
remote: Counting objects: 2841147, done.
remote: Compressing objects: 100% (670736/670736), done.
remote: Total 2841147 (delta 2308339), reused 2657487 (delta 2143012)
Receiving objects: 100% (2841147/2841147), 797.62 MiB | 2.59 MiB/s, done.
Resolving deltas: 100% (2308339/2308339), done.
Checking out files: 100% (41521/41521), done.
$ cd linux
$ git branch -av
* master                323a72d Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
   remotes/origin/HEAD   -> origin/master
   remotes/origin/master 323a72d Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net

$ # Try to create a bundle
$ git bundle create ../linux.bundle
usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
   limiting output:
     --max-count=<n>
     --max-age=<epoch>
     --min-age=<epoch>
     --sparse
     --no-merges
     --min-parents=<n>
     --no-min-parents
     --max-parents=<n>
     --no-max-parents
     --remove-empty
     --all
     --branches
     --tags
     --remotes
     --stdin
     --quiet
   ordering output:
     --topo-order
     --date-order
     --reverse
   formatting output:
     --parents
     --children
     --objects | --objects-edge
     --unpacked
     --header | --pretty
     --abbrev=<n> | --no-abbrev
     --abbrev-commit
     --left-right
   special purpose:
     --bisect
     --bisect-vars
     --bisect-all
error: rev-list died
$ # IMHO the error should refer to the usage of `git bundle` with a 
proper basis, not `git rev-list`.
$ # Also nothing should die loudly because of a missing parameter.
$ git bundle create ../linux.bundle master
Counting objects: 2836191, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (505627/505627), done.
Writing objects: 100% (2836191/2836191), 796.59 MiB | 16.23 MiB/s, done.
Total 2836191 (delta 2304454), reused 2834391 (delta 2303193)

$ # Try to clone a new repository from the bundle
$ cd ..
$ git clone linux.bundle linuxfrombundle
Cloning into 'linuxfrombundle'...
ERROR: Repository not found.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
$ git clone linux.bundle -b master linuxfrombundle
Cloning into 'linuxfrombundle'...
ERROR: Repository not found.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

# Try again using strace
$ # (Replace /dev/null with a filename if you really want to try and 
debug this, or if you just want to torture your hard drive ;) )
$ strace -o /dev/null git clone linux.bundle linuxfrombundle
Cloning into 'linuxfrombundle'...
Receiving objects: 100% (2836191/2836191), 796.59 MiB | 24.64 MiB/s, done.
Resolving deltas: 100% (2304454/2304454), done.
warning: remote HEAD refers to nonexistent ref, unable to checkout.

$ # Let's have a look at what we cloned
$ cd linuxfrombundle
$ ls
$ git branch -av
   remotes/origin/master 323a72d Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
$ git checkout master
Checking out files: 100% (41521/41521), done.
Branch master set up to track remote branch master from origin.
Already on 'master'
$ git branch -av
* master                323a72d Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
   remotes/origin/master 323a72d Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
$ # Where's my HEAD?

Kind regards,

Alain Kalker
