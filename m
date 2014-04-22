From: Dan Porter <dpreid@gmail.com>
Subject: git p4: bug - branch detection broken on empty branches
Date: Tue, 22 Apr 2014 10:20:07 +0100
Message-ID: <CADtnS+zAnnpaU59-rAwMHF7Z4SNjcYWASqpKdEq+GVs8mVSb3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 11:26:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcWs9-00077t-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 11:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbaDVJUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 05:20:09 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:65278 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbaDVJUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 05:20:08 -0400
Received: by mail-ig0-f170.google.com with SMTP id uq10so2645941igb.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Lkq/k+DI6nk8XGbWPhni7sAdH3RljkJmEC4GkrJ6/y8=;
        b=qJOooSKYZBeq2Bx/0N0/SHyYWtK+CXT5OjeuvZlIM2m38VoJkkt2TQmbrD8NBdKB8d
         OeiyLgFynI4wJXmC0YHZNEjNTOGOniNhUWNq8vjRhBRtEAf7J/LWeIGHlXQJQ4Nb8fc3
         i1XKURuY5vyi3n0RDROxOldDXZVGgtTsLSHVRP6qran1Vz1PxFvm1ZD0Q/IoRnjrmJU9
         Q9nfiihrcrhzknZpxowKDu146utKmyIRu+PNLp6b3IhgtI7e6Xmeyabtpxeqbap+R5ni
         ux4Qd5AfxgUOX7taZC/gDNDnNkkxH6KzymsfuVy3mycEbB6Q/zbgfqnqWFapjdkEqgsg
         Aq/g==
X-Received: by 10.50.28.84 with SMTP id z20mr28155429igg.0.1398158407311; Tue,
 22 Apr 2014 02:20:07 -0700 (PDT)
Received: by 10.64.28.233 with HTTP; Tue, 22 Apr 2014 02:20:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246721>

As part of my work to help get git-p4 close to bug-free before Git
2.0, I'm posting all bugs and patches to this mailing list. Please
direct me elsewhere if this is incorrect.

When trying to clone a particular directory from a depot, that
contains one or more branches that contain no commits for that
directory, branch detection is broken and results in a failed clone.

fatal: ambiguous argument
'refs/remotes/p4/silly_project_branch/trunk': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
Traceback (most recent call last):
  File "/home/dreid/bin/git-p4", line 3295, in ?
    main()
  File "/home/dreid/bin/git-p4", line 3289, in main
    if not cmd.run(args):
  File "/home/dreid/bin/git-p4", line 3163, in run
    if not P4Sync.run(self, depotPaths):
  File "/home/dreid/bin/git-p4", line 3016, in run
    self.importChanges(changes)
  File "/home/dreid/bin/git-p4", line 2678, in importChanges
    blob = self.searchParent(parent, branch, tempBranch)
  File "/home/dreid/bin/git-p4", line 2600, in searchParent
    for blob in read_pipe_lines(["git", "rev-list", "--reverse",
  File "/home/dreid/bin/git-p4", line 155, in read_pipe_lines
    die('Command failed: %s' % str(c))
  File "/home/dreid/bin/git-p4", line 106, in die
    raise Exception(msg)
Exception: Command failed: ['git', 'rev-list', '--reverse',
'--no-merges', 'refs/remotes/p4/silly_project_branch/trunk']

Original command:
$ git-p4 clone //insane_depot/projects/Exchange/CompanyName/silly_project_branch@all
silly-project --detect-branches -v
