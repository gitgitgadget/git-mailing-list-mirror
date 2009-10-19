From: John Feuerstein <john@feurix.com>
Subject: Rebase fails because of apply.whitespace setting
Date: Tue, 20 Oct 2009 01:31:53 +0200
Message-ID: <4ADCF6E9.8090704@feurix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 01:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N01rG-0000G9-01
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 01:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbZJSXlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 19:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757925AbZJSXlU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 19:41:20 -0400
Received: from mx2.cluster1.pyrox.eu ([78.46.200.219]:45741 "EHLO
	mx2.cluster1.pyrox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758007AbZJSXlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 19:41:19 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2009 19:41:18 EDT
Received: from [192.168.10.100] (ip-95-223-145-189.unitymediagroup.de [95.223.145.189])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.cluster1.pyrox.eu (PX-MAIL) with ESMTPSA id F16E74E15B
	for <git@vger.kernel.org>; Tue, 20 Oct 2009 01:31:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091008)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130744>

I had to rewrite history recently (ugh -- private repo, not shared with
anybody) and wanted to change the commit message of the root commit.
During this I've encountered a failing git-rebase if apply.whitespace is
set to "error".

Should whitespace-errors really be detected when rebasing?
(or worse: be "fixed" without explicitely asking for it when using a
global apply.whitespace=fix setting)
What about making --ignore-whitespace the default for git-rebase?


Simplified example:

$ mkdir test
$ cd test/
$ git config apply.whitespace
error
$ git init
Initialized empty Git repository in /home/john/test/.git/
$ git commit --allow-empty -m 'root commit'
[master (root-commit) a208f9f] root commit
$ echo ' ' > whitespace
$ git add whitespace
$ git commit -m 'add whitespace file'
[master 12b685b] add whitespace file
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 whitespace
$ git tag root a208f9f
$ git checkout -b new-root root
Switched to a new branch 'new-root'
$ git commit --amend --allow-empty -m 'changed root commit'
[new-root b9adb89] changed root commit
$ git checkout -
Switched to branch 'master'
$ git rebase --onto new-root root
First, rewinding head to replay your work on top of it...
Applying: add whitespace file
Patch failed at 0001 add whitespace file

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

$ git diff
$ git status
$ git apply .git/rebase-apply/0001
.git/rebase-apply/0001:17: trailing whitespace.

fatal: 1 line adds whitespace errors.
