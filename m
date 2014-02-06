From: Lee Carver <leeca@pnambic.com>
Subject: Rebase fail with new file
Date: Thu, 6 Feb 2014 12:11:34 -0800
Message-ID: <CABpzZJRzku4xJyg1t1E4sJJee9_qwq0+jYpo34Hdxi2fXOLKdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0153673ee9826404f1c27ab8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 21:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVIn-0003wW-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaBFUL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:11:57 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49529 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbaBFUL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:11:56 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so3613036qab.40
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 12:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=MzyaCVW+3d3dUzZQLgV+4TgjBQe5ykmclbjBreswj0U=;
        b=SxVl9ZhlFW2NcGwWppSkgYa4BIC312lCVs+U3MYspdlbCx/L5dVIzBAtJGhT+pnHQE
         Vr035EhONpQxuASFAjec5G9kZhriKdRInIXJxeArq/22DaTYj6AviLOgsTUTb9s8heRt
         M6csQttNhvFK9jxqnYqcd9SF04q1Y6qRGEKQgNvOiBcQGDRLEgfET8bP32cX2QcjKajd
         0cAuzOBXXmKou/xVr6tyjdHcPz3QrgVaSSwJew4Cl5CoFRJkN+fqRLP0LqNCN5MOBnle
         CZYHdQQw7gF7O2thbbw8EAqUoDF11M1L0EjhlJR9xGDkN7eDNjOwsfqUWq605ve8asLX
         H6XA==
X-Gm-Message-State: ALoCoQkdyKuYy+YX4oT1bX/sHaj9MPo6M9FRZYPY9R4V4HCZ6sfsii4seE/ogTVTAiJljjTGRmij
X-Received: by 10.224.151.147 with SMTP id c19mr15353109qaw.86.1391717494897;
 Thu, 06 Feb 2014 12:11:34 -0800 (PST)
Received: by 10.224.217.194 with HTTP; Thu, 6 Feb 2014 12:11:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241722>

--089e0153673ee9826404f1c27ab8
Content-Type: text/plain; charset=ISO-8859-1

GitDev -


During a rebase of a feature branch to the master branch, I lost a new
file in a new directory.  I was able to recover by replaying the
rebase and taking exceptional actions.  However, I'm left with the
impression the git does not handle new files properly under some
rebase situations and gives the wrong advice to users.


I was able to recover by reseting the branch to the pre-rebase commit,
repeating the rebase, and manually applying the
.git/rebase-apply/patch at the critical point.  I do not understand
why the patch did not work through the rebase command.


Additionally, the git recommendation that after the failed patch, with
no local changes, a [git rebase --skip] is a likely resolution is just
wrong.  Skipping after a complete patch failure lead me to very broken
working directory.


Details follow, and the contents of the problematic commit are
attached (from [git show 2e9b460]).


Thanks

   Lee


This occurs with git version 1.8.3.2


[1024] $ git --version

git version 1.8.3.2


*** Details ***


Initial setup:  After working in branch feature/build-projects for
several days (with ~21 commits+pushes from branch point), I needed to
integrate new changes from the master branch.  Here are the steps from
my bash history:


  879  git checkout master

  880  git pull

  881  git checkout feature/build-projects

  882  git rebase master


There were a couple of conflicts, which I resolved and moved on with
[git rebase --continue].


At approximately the 14th commit, the rebase stopped with this message:


<bash>


Applying: STRY0057770: Add -Z parent for late build modules.

Using index info to reconstruct a base tree...

Falling back to patching base and 3-way merge...

error: Your local changes to the following files would be overwritten by merge:

glide-app-itbm/pom.xml

Please, commit your changes or stash them before you can merge.

Aborting

Failed to merge in the changes.

Patch failed at 0014 STRY0057770: Add -Z parent for late build modules.

The copy of the patch that failed is found in:

   /Users/lee.carver/Service-now/dev/glide04/git/glide/.git/rebase-apply/patch


When you have resolved this problem, run "git rebase --continue".

If you prefer to skip this patch, run "git rebase --skip" instead.

To check out the original branch and stop rebasing, run "git rebase --abort".

</bash>



Git status indicated no change, and inspection of the
glide-app-itbm/pom.xml showed no conflicts or unexpected content:


<bash>

[888] $ git status

# HEAD detached from ee6d51c

# You are currently rebasing branch 'feature/build-projects' on 'ee6d51c'.

#   (all conflicts fixed: run "git rebase --continue")

#


When I tried to  [git rebase --continue], the error message provided a
little more information.  Specifically, it mentions the added (new)
file glide-module-parent-z/pom.xml.


[904] $ git rebase --continue

Applying: STRY0057770: Add -Z parent for late build modules.

Applying: STRY0057770: Provide version properties for diagrammer and
email-notification.

Using index info to reconstruct a base tree...

M glide-app-itbm/pom.xml

A glide-module-parent-z/pom.xml

Falling back to patching base and 3-way merge...

Auto-merging glide-module-parent/pom.xml

Auto-merging glide-app-itbm/pom.xml

CONFLICT (content): Merge conflict in glide-app-itbm/pom.xml

Failed to merge in the changes.

Patch failed at 0015 STRY0057770: Provide version properties for
diagrammer and email-notification.

The copy of the patch that failed is found in:

   /Users/lee.carver/Service-now/dev/glide04/git/glide/.git/rebase-apply/patch


When you have resolved this problem, run "git rebase --continue".

If you prefer to skip this patch, run "git rebase --skip" instead.

To check out the original branch and stop rebasing, run "git rebase --abort".

</bash>



I made a minor edit to the glide-app-itbm/pom.xml (adding a "-z" to
the parent name), [git add -u], and then [git rebase --continue].


There were a couple of addition conflicts, some resolved with
--continue, some with --skip.


In the end, I was left with a working direction that did not contain
the new file glide-module-parent-z/pom.xml or other changes from the
problematic commit/rebase step (STRY0057770: Add -Z parent for late
build modules.).


*** Recovery ***


I was able to recover the branch, and complete the rebase with the
expected results only by manually applying the patch file at the
critical rebase step:


Starting in the feature branch, these actions were performed:


  928  git reset --hard 6793d9f

  930  git checkout master

  931  git pull

  932  git checkout feature/build-projects

  934  git rebase master


When the rebase of (STRY0057770: Add -Z parent for late build
modules.) stopped, I manually applied the patch


  959  git apply .git/rebase-apply/patch


With the appropriate adds, etc. I was able to [git rebase --continue]
to a successful conclusion.

--089e0153673ee9826404f1c27ab8
Content-Type: application/octet-stream; name="2e9b460.out"
Content-Disposition: attachment; filename="2e9b460.out"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hrcgnijw0

Y29tbWl0IDJlOWI0NjBjNTAzNTg2MTZkYTJkNGVjNjJiYzMwMzhkYTZjZjVkYWQKQXV0aG9yOiBM
ZWUgQ2FydmVyIDxsZWUuY2FydmVyQHNlcnZpY2Vub3cuY29tPgpEYXRlOiAgIFR1ZSBGZWIgNCAx
Mzo1MToxNCAyMDE0IC0wODAwCgogICAgU1RSWTAwNTc3NzA6IEFkZCAtWiBwYXJlbnQgZm9yIGxh
dGUgYnVpbGQgbW9kdWxlcy4KICAgIAogICAgTWF2ZW4ncyByZWxlYXNlIHRvb2wgdGhpbmtzIHRo
ZSBzaGFyZWQgcGFyZW50IGhhcyB0aGUgd3JvbmcgdmVyc2lvbgogICAgd2hlbiB3ZSBidWlsZCB0
aGUgY29tcG9uZW50cyBpbiBtdWx0aXBsZSBzdGFnZXMuCgpkaWZmIC0tZ2l0IGEvZ2xpZGUtYXBw
LWl0Ym0vcG9tLnhtbCBiL2dsaWRlLWFwcC1pdGJtL3BvbS54bWwKaW5kZXggNGY0MWZiYi4uNmVh
NjFhMiAxMDA2NDQKLS0tIGEvZ2xpZGUtYXBwLWl0Ym0vcG9tLnhtbAorKysgYi9nbGlkZS1hcHAt
aXRibS9wb20ueG1sCkBAIC0zLDEwICszLDExIEBACiAJPG1vZGVsVmVyc2lvbj40LjAuMDwvbW9k
ZWxWZXJzaW9uPgogCTxwYXJlbnQ+CiAJCTxncm91cElkPmNvbS5zbmM8L2dyb3VwSWQ+Ci0JCTxh
cnRpZmFjdElkPmdsaWRlLW1vZHVsZS1wYXJlbnQ8L2FydGlmYWN0SWQ+CisJCTxhcnRpZmFjdElk
PmdsaWRlLW1vZHVsZS1wYXJlbnQtejwvYXJ0aWZhY3RJZD4KIAkJPHZlcnNpb24+NS4wLjAuMC1T
TkFQU0hPVDwvdmVyc2lvbj4KLQkJPHJlbGF0aXZlUGF0aD4uLi9nbGlkZS1tb2R1bGUtcGFyZW50
L3BvbS54bWw8L3JlbGF0aXZlUGF0aD4KKwkJPHJlbGF0aXZlUGF0aD4uLi9nbGlkZS1tb2R1bGUt
cGFyZW50LXovcG9tLnhtbDwvcmVsYXRpdmVQYXRoPgogCTwvcGFyZW50PgorCiAJPGFydGlmYWN0
SWQ+Z2xpZGUtYXBwLWl0Ym08L2FydGlmYWN0SWQ+CiAJPG5hbWU+SVQgQnVzaW5lc3MgTWFuYWdl
bWVudCBhcHBsaWNhdGlvbnM8L25hbWU+CiAJCmRpZmYgLS1naXQgYS9nbGlkZS1hdXRvdGVzdGVy
L3BvbS54bWwgYi9nbGlkZS1hdXRvdGVzdGVyL3BvbS54bWwKaW5kZXggYWQ3ZTE3ZS4uYTYzYmY4
MiAxMDA2NDQKLS0tIGEvZ2xpZGUtYXV0b3Rlc3Rlci9wb20ueG1sCisrKyBiL2dsaWRlLWF1dG90
ZXN0ZXIvcG9tLnhtbApAQCAtMywxMCArMywxMSBAQAogCTxtb2RlbFZlcnNpb24+NC4wLjA8L21v
ZGVsVmVyc2lvbj4KIAk8cGFyZW50PgogCQk8Z3JvdXBJZD5jb20uc25jPC9ncm91cElkPgotCQk8
YXJ0aWZhY3RJZD5nbGlkZS1tb2R1bGUtcGFyZW50PC9hcnRpZmFjdElkPgorCQk8YXJ0aWZhY3RJ
ZD5nbGlkZS1tb2R1bGUtcGFyZW50LXo8L2FydGlmYWN0SWQ+CiAJCTx2ZXJzaW9uPjUuMC4wLjAt
U05BUFNIT1Q8L3ZlcnNpb24+Ci0JCTxyZWxhdGl2ZVBhdGg+Li4vZ2xpZGUtbW9kdWxlLXBhcmVu
dC9wb20ueG1sPC9yZWxhdGl2ZVBhdGg+CisJCTxyZWxhdGl2ZVBhdGg+Li4vZ2xpZGUtbW9kdWxl
LXBhcmVudC16L3BvbS54bWw8L3JlbGF0aXZlUGF0aD4KIAk8L3BhcmVudD4KKwogCTxhcnRpZmFj
dElkPmdsaWRlLWF1dG90ZXN0ZXI8L2FydGlmYWN0SWQ+CiAJPG5hbWU+R2xpZGUgQXV0b3Rlc3Rl
cjwvbmFtZT4KIApkaWZmIC0tZ2l0IGEvZ2xpZGUtY21zL3BvbS54bWwgYi9nbGlkZS1jbXMvcG9t
LnhtbAppbmRleCA3ZTQ0MDIwLi5mZGViZDM1IDEwMDY0NAotLS0gYS9nbGlkZS1jbXMvcG9tLnht
bAorKysgYi9nbGlkZS1jbXMvcG9tLnhtbApAQCAtMywxMCArMywxMSBAQAogCTxtb2RlbFZlcnNp
b24+NC4wLjA8L21vZGVsVmVyc2lvbj4KIAk8cGFyZW50PgogCQk8Z3JvdXBJZD5jb20uc25jPC9n
cm91cElkPgotCQk8YXJ0aWZhY3RJZD5nbGlkZS1tb2R1bGUtcGFyZW50PC9hcnRpZmFjdElkPgor
CQk8YXJ0aWZhY3RJZD5nbGlkZS1tb2R1bGUtcGFyZW50LXo8L2FydGlmYWN0SWQ+CiAJCTx2ZXJz
aW9uPjUuMC4wLjAtU05BUFNIT1Q8L3ZlcnNpb24+Ci0JCTxyZWxhdGl2ZVBhdGg+Li4vZ2xpZGUt
bW9kdWxlLXBhcmVudC9wb20ueG1sPC9yZWxhdGl2ZVBhdGg+CisJCTxyZWxhdGl2ZVBhdGg+Li4v
Z2xpZGUtbW9kdWxlLXBhcmVudC16L3BvbS54bWw8L3JlbGF0aXZlUGF0aD4KIAk8L3BhcmVudD4K
KwogCTxhcnRpZmFjdElkPmdsaWRlLWNtczwvYXJ0aWZhY3RJZD4KIAk8bmFtZT5HbGlkZSBDb250
ZW50IE1hbmFnZW1lbnQgU3lzdGVtIGFuZCBIb21lUGFnZTwvbmFtZT4KIAkKZGlmZiAtLWdpdCBh
L2dsaWRlLWludGVncmF0aW9ucy9wb20ueG1sIGIvZ2xpZGUtaW50ZWdyYXRpb25zL3BvbS54bWwK
aW5kZXggODk4NDIzYy4uY2NmYjhjOCAxMDA2NDQKLS0tIGEvZ2xpZGUtaW50ZWdyYXRpb25zL3Bv
bS54bWwKKysrIGIvZ2xpZGUtaW50ZWdyYXRpb25zL3BvbS54bWwKQEAgLTMsMTAgKzMsMTEgQEAK
IAk8bW9kZWxWZXJzaW9uPjQuMC4wPC9tb2RlbFZlcnNpb24+CiAJPHBhcmVudD4KIAkJPGdyb3Vw
SWQ+Y29tLnNuYzwvZ3JvdXBJZD4KLQkJPGFydGlmYWN0SWQ+Z2xpZGUtbW9kdWxlLXBhcmVudDwv
YXJ0aWZhY3RJZD4KKwkJPGFydGlmYWN0SWQ+Z2xpZGUtbW9kdWxlLXBhcmVudC16PC9hcnRpZmFj
dElkPgogCQk8dmVyc2lvbj41LjAuMC4wLVNOQVBTSE9UPC92ZXJzaW9uPgotCQk8cmVsYXRpdmVQ
YXRoPi4uL2dsaWRlLW1vZHVsZS1wYXJlbnQvcG9tLnhtbDwvcmVsYXRpdmVQYXRoPgorCQk8cmVs
YXRpdmVQYXRoPi4uL2dsaWRlLW1vZHVsZS1wYXJlbnQtei9wb20ueG1sPC9yZWxhdGl2ZVBhdGg+
CiAJPC9wYXJlbnQ+CisKIAk8YXJ0aWZhY3RJZD5nbGlkZS1pbnRlZ3JhdGlvbnM8L2FydGlmYWN0
SWQ+CiAJPG5hbWU+R2xpZGUgSW50ZWdyYXRpb25zPC9uYW1lPgogCmRpZmYgLS1naXQgYS9nbGlk
ZS1tb2R1bGUtbWFzdGVyLXovcG9tLnhtbCBiL2dsaWRlLW1vZHVsZS1tYXN0ZXItei9wb20ueG1s
CmluZGV4IGQyYmE3OWYuLjM1OWQ0N2IgMTAwNjQ0Ci0tLSBhL2dsaWRlLW1vZHVsZS1tYXN0ZXIt
ei9wb20ueG1sCisrKyBiL2dsaWRlLW1vZHVsZS1tYXN0ZXItei9wb20ueG1sCkBAIC05LDEyICs5
LDEyIEBACiAJPC9wYXJlbnQ+CiAKIAk8YXJ0aWZhY3RJZD5nbGlkZS1tb2R1bGUtbWFzdGVyLXo8
L2FydGlmYWN0SWQ+Ci0JPG5hbWU+TWFzdGVyIHByb2plY3QgZm9yIGdsaWRlIG1vZHVsZXMgYW5k
IHNlcnZpY2VzPC9uYW1lPgorCTxuYW1lPk1hc3RlciBaIHByb2plY3QgZm9yIGdsaWRlIG1vZHVs
ZXMgYW5kIHNlcnZpY2VzPC9uYW1lPgogCTx2ZXJzaW9uPjUuMC4wLjAtU05BUFNIT1Q8L3ZlcnNp
b24+CiAJPHBhY2thZ2luZz5wb208L3BhY2thZ2luZz4KIAogCTxtb2R1bGVzPgotCQk8bW9kdWxl
Pi4uL2dsaWRlLW1vZHVsZS1wYXJlbnQ8L21vZHVsZT4KKwkJPG1vZHVsZT4uLi9nbGlkZS1tb2R1
bGUtcGFyZW50LXo8L21vZHVsZT4KIAogCQk8IS0tIG5lZWRzIENNREIgLS0+CiAJCTxtb2R1bGU+
Li4vZ2xpZGUtYXBwLWl0Ym08L21vZHVsZT4KZGlmZiAtLWdpdCBhL2dsaWRlLW1vZHVsZS1wYXJl
bnQtei9wb20ueG1sIGIvZ2xpZGUtbW9kdWxlLXBhcmVudC16L3BvbS54bWwKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMDFiNGYxYgotLS0gL2Rldi9udWxsCisrKyBiL2dsaWRl
LW1vZHVsZS1wYXJlbnQtei9wb20ueG1sCkBAIC0wLDAgKzEsMjE0IEBACis8P3htbCB2ZXJzaW9u
PSIxLjAiIGVuY29kaW5nPSJVVEYtOCI/PgorPHByb2plY3QgeG1sbnM9Imh0dHA6Ly9tYXZlbi5h
cGFjaGUub3JnL1BPTS80LjAuMCIgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hN
TFNjaGVtYS1pbnN0YW5jZSIgeHNpOnNjaGVtYUxvY2F0aW9uPSJodHRwOi8vbWF2ZW4uYXBhY2hl
Lm9yZy9QT00vNC4wLjAgaHR0cDovL21hdmVuLmFwYWNoZS5vcmcveHNkL21hdmVuLTQuMC4wLnhz
ZCI+CisJPG1vZGVsVmVyc2lvbj40LjAuMDwvbW9kZWxWZXJzaW9uPgorCTxwYXJlbnQ+CisJCTxn
cm91cElkPmNvbS5zbmM8L2dyb3VwSWQ+CisJCTxhcnRpZmFjdElkPmdsaWRlLWJ1aWxkLWJvb3Rz
dHJhcDwvYXJ0aWZhY3RJZD4KKwkJPHZlcnNpb24+NS4wLjAuMDwvdmVyc2lvbj4KKwkJPHJlbGF0
aXZlUGF0aD4uLi9nbGlkZS1idWlsZC1ib290c3RyYXAvcG9tLnhtbDwvcmVsYXRpdmVQYXRoPgor
CTwvcGFyZW50PgorCisJPGFydGlmYWN0SWQ+Z2xpZGUtbW9kdWxlLXBhcmVudC16PC9hcnRpZmFj
dElkPgorCTxuYW1lPlBhcmVudCBaIHByb2plY3QgZm9yIGdsaWRlIG1vZHVsZXM8L25hbWU+CisJ
PHZlcnNpb24+NS4wLjAuMC1TTkFQU0hPVDwvdmVyc2lvbj4KKwk8cGFja2FnaW5nPnBvbTwvcGFj
a2FnaW5nPgorCisJPHByb3BlcnRpZXM+CisJCTxnbGlkZS52ZXJzaW9uPjUuMC4wLjAtU05BUFNI
T1Q8L2dsaWRlLnZlcnNpb24+CisJCTxhcHAuY21kYi52ZXJzaW9uPjUuMC4wLjAtU05BUFNIT1Q8
L2FwcC5jbWRiLnZlcnNpb24+CisJCTxhcHAucmVwb3J0aW5nLnZlcnNpb24+NS4wLjAuMC1TTkFQ
U0hPVDwvYXBwLnJlcG9ydGluZy52ZXJzaW9uPgorCisJCTwhLS0gVGVzdC1yZWxhdGVkIGRlcGVu
ZGVuY2llcyAtLT4KKwkJPHBvd2VybW9jay52ZXJzaW9uPjEuNTwvcG93ZXJtb2NrLnZlcnNpb24+
CisJPC9wcm9wZXJ0aWVzPgorCisJPGRlcGVuZGVuY2llcz4KKwkJPCEtLSBBbGwgR2xpZGUgc2Vy
dmljZXMgZGVwZW5kIG9uIEdsaWRlIC0tPgorCQk8ZGVwZW5kZW5jeT4KKwkJCTxncm91cElkPmNv
bS5zbmM8L2dyb3VwSWQ+CisJCQk8YXJ0aWZhY3RJZD5nbGlkZTwvYXJ0aWZhY3RJZD4KKwkJCTx2
ZXJzaW9uPiR7Z2xpZGUudmVyc2lvbn08L3ZlcnNpb24+CisJCTwvZGVwZW5kZW5jeT4KKwkJPGRl
cGVuZGVuY3k+CisJCQk8Z3JvdXBJZD5qdW5pdDwvZ3JvdXBJZD4KKwkJCTxhcnRpZmFjdElkPmp1
bml0PC9hcnRpZmFjdElkPgorCQkJPHZlcnNpb24+NC4xMDwvdmVyc2lvbj4KKwkJCTxzY29wZT50
ZXN0PC9zY29wZT4KKwkJPC9kZXBlbmRlbmN5PgorCTwvZGVwZW5kZW5jaWVzPgorCisJPGRlcGVu
ZGVuY3lNYW5hZ2VtZW50PgorCQk8ZGVwZW5kZW5jaWVzPgorCQkJPGRlcGVuZGVuY3k+CisJCQkJ
PGdyb3VwSWQ+amF2YXguc2VydmxldDwvZ3JvdXBJZD4KKwkJCQk8YXJ0aWZhY3RJZD5qYXZheC5z
ZXJ2bGV0LWFwaTwvYXJ0aWZhY3RJZD4KKwkJCQk8dmVyc2lvbj4zLjAuMTwvdmVyc2lvbj4KKwkJ
CQk8c2NvcGU+cHJvdmlkZWQ8L3Njb3BlPgorCQkJPC9kZXBlbmRlbmN5PgorCQkJPGRlcGVuZGVu
Y3k+CisJCQkJPCEtLSBmb3IgZ2xpZGUtb2F1dGggLS0+CisJCQkJPGdyb3VwSWQ+b3JnLmJvdW5j
eWNhc3RsZTwvZ3JvdXBJZD4KKwkJCQk8YXJ0aWZhY3RJZD5iY21haWwtamRrMTVvbjwvYXJ0aWZh
Y3RJZD4KKwkJCQk8dmVyc2lvbj4xLjUwPC92ZXJzaW9uPgorCQkJPC9kZXBlbmRlbmN5PgorCQkJ
PGRlcGVuZGVuY3k+CisJCQkJPCEtLSBmb3IgZ2xpZGUtb2F1dGggLS0+CisJCQkJPGdyb3VwSWQ+
b3JnLmJvdW5jeWNhc3RsZTwvZ3JvdXBJZD4KKwkJCQk8YXJ0aWZhY3RJZD5iY3Byb3YtamRrMTVv
bjwvYXJ0aWZhY3RJZD4KKwkJCQk8dmVyc2lvbj4xLjUwPC92ZXJzaW9uPgorCQkJPC9kZXBlbmRl
bmN5PgorCQkJPGRlcGVuZGVuY3k+CisJCQkJPCEtLSBmb3IgZ2xpZGUtb2F1dGggLS0+CisJCQkJ
PGdyb3VwSWQ+b3JnLmJvdW5jeWNhc3RsZTwvZ3JvdXBJZD4KKwkJCQk8YXJ0aWZhY3RJZD5iY3Br
aXgtamRrMTVvbjwvYXJ0aWZhY3RJZD4KKwkJCQk8dmVyc2lvbj4xLjUwPC92ZXJzaW9uPgorCQkJ
PC9kZXBlbmRlbmN5PgorCisJCQk8IS0tIEZJWE1FOiAiSW50ZXJuYWwiIGRlcGVuZGVuY2llcyAt
LT4KKwkJCTxkZXBlbmRlbmN5PgorCQkJCTxncm91cElkPmNvbS5zbmM8L2dyb3VwSWQ+CisJCQkJ
PGFydGlmYWN0SWQ+Z2xpZGUtb2F1dGg8L2FydGlmYWN0SWQ+CisJCQkJPHZlcnNpb24+JHtwcm9q
ZWN0LnZlcnNpb259PC92ZXJzaW9uPgorCQkJPC9kZXBlbmRlbmN5PgorCQkJPGRlcGVuZGVuY3k+
CisJCQkJPGdyb3VwSWQ+Y29tLnNuYzwvZ3JvdXBJZD4KKwkJCQk8YXJ0aWZhY3RJZD5nbGlkZS1w
YWFzPC9hcnRpZmFjdElkPgorCQkJCTx2ZXJzaW9uPiR7cHJvamVjdC52ZXJzaW9ufTwvdmVyc2lv
bj4KKwkJCTwvZGVwZW5kZW5jeT4KKwkJCTxkZXBlbmRlbmN5PgorCQkJCTxncm91cElkPmNvbS5z
bmM8L2dyb3VwSWQ+CisJCQkJPGFydGlmYWN0SWQ+Z2xpZGUtcmVzdDwvYXJ0aWZhY3RJZD4KKwkJ
CQk8dmVyc2lvbj4ke3Byb2plY3QudmVyc2lvbn08L3ZlcnNpb24+CisJCQk8L2RlcGVuZGVuY3k+
CisKKwkJCTwhLS0gVGVzdC1yZWxhdGVkIGRlcGVuZGVuY2llcyAtLT4KKwkJCTxkZXBlbmRlbmN5
PgorCQkJCTxncm91cElkPm9yZy5oYW1jcmVzdDwvZ3JvdXBJZD4KKwkJCQk8YXJ0aWZhY3RJZD5o
YW1jcmVzdC1jb3JlPC9hcnRpZmFjdElkPgorCQkJCTx2ZXJzaW9uPjEuMzwvdmVyc2lvbj4KKwkJ
CTwvZGVwZW5kZW5jeT4KKwkJCTxkZXBlbmRlbmN5PgorCQkJCTxncm91cElkPm9yZy5oYW1jcmVz
dDwvZ3JvdXBJZD4KKwkJCQk8YXJ0aWZhY3RJZD5oYW1jcmVzdC1pbnRlZ3JhdGlvbjwvYXJ0aWZh
Y3RJZD4KKwkJCQk8dmVyc2lvbj4xLjM8L3ZlcnNpb24+CisJCQk8L2RlcGVuZGVuY3k+CisJCQk8
ZGVwZW5kZW5jeT4KKwkJCQk8Z3JvdXBJZD5vcmcubW9ja2l0bzwvZ3JvdXBJZD4KKwkJCQk8YXJ0
aWZhY3RJZD5tb2NraXRvLWNvcmU8L2FydGlmYWN0SWQ+CisJCQkJPHZlcnNpb24+MS45LjU8L3Zl
cnNpb24+CisJCQk8L2RlcGVuZGVuY3k+CisJCQk8ZGVwZW5kZW5jeT4KKwkJCQk8Z3JvdXBJZD5v
cmcucG93ZXJtb2NrPC9ncm91cElkPgorCQkJCTxhcnRpZmFjdElkPnBvd2VybW9jay1tb2R1bGUt
anVuaXQ0PC9hcnRpZmFjdElkPgorCQkJCTx2ZXJzaW9uPiR7cG93ZXJtb2NrLnZlcnNpb259PC92
ZXJzaW9uPgorCQkJCTxleGNsdXNpb25zPgorCQkJCQk8ZXhjbHVzaW9uPgorCQkJCQkJPCEtLSBF
eGNsdWRlZCBhcyB3ZSBicmluZyBpbiBqdW5pdC1kZXAgLS0+CisJCQkJCQk8Z3JvdXBJZD5qdW5p
dDwvZ3JvdXBJZD4KKwkJCQkJCTxhcnRpZmFjdElkPmp1bml0PC9hcnRpZmFjdElkPgorCQkJCQk8
L2V4Y2x1c2lvbj4KKwkJCQk8L2V4Y2x1c2lvbnM+CisJCQk8L2RlcGVuZGVuY3k+CisJCQk8ZGVw
ZW5kZW5jeT4KKwkJCQk8Z3JvdXBJZD5vcmcucG93ZXJtb2NrPC9ncm91cElkPgorCQkJCTxhcnRp
ZmFjdElkPnBvd2VybW9jay1hcGktbW9ja2l0bzwvYXJ0aWZhY3RJZD4KKwkJCQk8dmVyc2lvbj4k
e3Bvd2VybW9jay52ZXJzaW9ufTwvdmVyc2lvbj4KKwkJCTwvZGVwZW5kZW5jeT4KKwkJPC9kZXBl
bmRlbmNpZXM+CisJPC9kZXBlbmRlbmN5TWFuYWdlbWVudD4KKworCTxidWlsZD4KKwkJPHJlc291
cmNlcz4KKwkJCTxyZXNvdXJjZT4KKwkJCQk8ZGlyZWN0b3J5PnNyYy9tYWluL3BsdWdpbnM8L2Rp
cmVjdG9yeT4KKwkJCQk8dGFyZ2V0UGF0aD5HTElERS1JTkYvcGx1Z2luczwvdGFyZ2V0UGF0aD4K
KwkJCTwvcmVzb3VyY2U+CisJCTwvcmVzb3VyY2VzPgorCQk8cGx1Z2luTWFuYWdlbWVudD4KKwkJ
CTxwbHVnaW5zPgorCQkJCTxwbHVnaW4+CisJCQkJCTxncm91cElkPm9yZy5lY2xpcHNlLm0yZTwv
Z3JvdXBJZD4KKwkJCQkJPGFydGlmYWN0SWQ+bGlmZWN5Y2xlLW1hcHBpbmc8L2FydGlmYWN0SWQ+
CisJCQkJCTx2ZXJzaW9uPjEuMC4wPC92ZXJzaW9uPgorCQkJCQk8Y29uZmlndXJhdGlvbj4KKwkJ
CQkJCTxsaWZlY3ljbGVNYXBwaW5nTWV0YWRhdGE+CisJCQkJCQkJPHBsdWdpbkV4ZWN1dGlvbnM+
CisJCQkJCQkJCTxwbHVnaW5FeGVjdXRpb24+CisJCQkJCQkJCQk8cGx1Z2luRXhlY3V0aW9uRmls
dGVyPgorCQkJCQkJCQkJCTxncm91cElkPm9yZy5yZWZsZWN0aW9uczwvZ3JvdXBJZD4KKwkJCQkJ
CQkJCQk8YXJ0aWZhY3RJZD5yZWZsZWN0aW9ucy1tYXZlbjwvYXJ0aWZhY3RJZD4KKwkJCQkJCQkJ
CQk8dmVyc2lvblJhbmdlPlswLjkuOCwpPC92ZXJzaW9uUmFuZ2U+CisJCQkJCQkJCQkJPGdvYWxz
PgorCQkJCQkJCQkJCQk8Z29hbD5yZWZsZWN0aW9uczwvZ29hbD4KKwkJCQkJCQkJCQk8L2dvYWxz
PgorCQkJCQkJCQkJPC9wbHVnaW5FeGVjdXRpb25GaWx0ZXI+CisJCQkJCQkJCQk8YWN0aW9uPgor
CQkJCQkJCQkJCTxleGVjdXRlPgorCQkJCQkJCQkJCQk8cnVuT25JbmNyZW1lbnRhbD50cnVlPC9y
dW5PbkluY3JlbWVudGFsPgorCQkJCQkJCQkJCTwvZXhlY3V0ZT4KKwkJCQkJCQkJCQk8aWdub3Jl
IC8+CisJCQkJCQkJCQk8L2FjdGlvbj4KKwkJCQkJCQkJPC9wbHVnaW5FeGVjdXRpb24+CisJCQkJ
CQkJPC9wbHVnaW5FeGVjdXRpb25zPgorCQkJCQkJPC9saWZlY3ljbGVNYXBwaW5nTWV0YWRhdGE+
CisJCQkJCTwvY29uZmlndXJhdGlvbj4KKwkJCQk8L3BsdWdpbj4KKwkJCTwvcGx1Z2lucz4KKwkJ
PC9wbHVnaW5NYW5hZ2VtZW50PgorCisJCTxwbHVnaW5zPgorCQkJPHBsdWdpbj4KKwkJCQk8Z3Jv
dXBJZD5vcmcucmVmbGVjdGlvbnM8L2dyb3VwSWQ+CisJCQkJPGFydGlmYWN0SWQ+cmVmbGVjdGlv
bnMtbWF2ZW48L2FydGlmYWN0SWQ+CisJCQkJPHZlcnNpb24+MC45Ljg8L3ZlcnNpb24+CisJCQkJ
PGV4ZWN1dGlvbnM+CisJCQkJCTxleGVjdXRpb24+CisJCQkJCQk8aWQ+cmVmbGVjdGlvbnMtcHJv
Y2Vzcy1jbGFzc2VzPC9pZD4KKwkJCQkJCTxnb2Fscz4KKwkJCQkJCQk8Z29hbD5yZWZsZWN0aW9u
czwvZ29hbD4KKwkJCQkJCTwvZ29hbHM+CisJCQkJCQk8cGhhc2U+cHJvY2Vzcy1jbGFzc2VzPC9w
aGFzZT4KKwkJCQkJCTxjb25maWd1cmF0aW9uPgorCQkJCQkJCTxzY2FubmVycz5UeXBlQW5ub3Rh
dGlvbnNTY2FubmVyLCBTdWJUeXBlc1NjYW5uZXIsIE1ldGhvZEFubm90YXRpb25zU2Nhbm5lciwg
RmllbGRBbm5vdGF0aW9uc1NjYW5uZXI8L3NjYW5uZXJzPgorCQkJCQkJCTx0ZXN0cz5mYWxzZTwv
dGVzdHM+CisJCQkJCQk8L2NvbmZpZ3VyYXRpb24+CisJCQkJCTwvZXhlY3V0aW9uPgorCQkJCQk8
ZXhlY3V0aW9uPgorCQkJCQkJPGlkPnJlZmxlY3Rpb25zLXByb2Nlc3MtdGVzdC1jbGFzc2VzPC9p
ZD4KKwkJCQkJCTxnb2Fscz4KKwkJCQkJCQk8Z29hbD5yZWZsZWN0aW9uczwvZ29hbD4KKwkJCQkJ
CTwvZ29hbHM+CisJCQkJCQk8cGhhc2U+cHJvY2Vzcy10ZXN0LWNsYXNzZXM8L3BoYXNlPgorCQkJ
CQkJPGNvbmZpZ3VyYXRpb24+CisJCQkJCQkJPHNjYW5uZXJzPlR5cGVBbm5vdGF0aW9uc1NjYW5u
ZXIsIFN1YlR5cGVzU2Nhbm5lciwgTWV0aG9kQW5ub3RhdGlvbnNTY2FubmVyLCBGaWVsZEFubm90
YXRpb25zU2Nhbm5lcjwvc2Nhbm5lcnM+CisJCQkJCQkJPHRlc3RzPnRydWU8L3Rlc3RzPgorCQkJ
CQkJPC9jb25maWd1cmF0aW9uPgorCQkJCQk8L2V4ZWN1dGlvbj4KKwkJCQk8L2V4ZWN1dGlvbnM+
CisJCQkJPGRlcGVuZGVuY2llcz4KKwkJCQkJPGRlcGVuZGVuY3k+CisJCQkJCQk8Z3JvdXBJZD5v
cmcucmVmbGVjdGlvbnM8L2dyb3VwSWQ+CisJCQkJCQk8YXJ0aWZhY3RJZD5yZWZsZWN0aW9uczwv
YXJ0aWZhY3RJZD4KKwkJCQkJCTx2ZXJzaW9uPjAuOS44LXNuYzk8L3ZlcnNpb24+CisJCQkJCTwv
ZGVwZW5kZW5jeT4KKwkJCQk8L2RlcGVuZGVuY2llcz4KKwkJCTwvcGx1Z2luPgorCQk8L3BsdWdp
bnM+CisJPC9idWlsZD4KKworCTwhLS0gVGhpcyBpcyBkdXBsaWNhdGVkIGZyb20gc25jLXBhcmVu
dCwgYnV0IGlzIG5lZWRlZCB0byBib290c3RyYXAgZGV2ZWxvcG1lbnQgLS0+CisJPHJlcG9zaXRv
cmllcz4KKwkJPHJlcG9zaXRvcnk+CisJCQk8aWQ+c3RhYmxlPC9pZD4KKwkJCTxuYW1lPlNOQyBT
dGFibGU8L25hbWU+CisJCQk8dXJsPmh0dHBzOi8vcmVsZWFzZS5kZXZzbmMuY29tL2NvbnRlbnQv
Z3JvdXBzL3N0YWJsZTwvdXJsPgorCQkJPHJlbGVhc2VzPgorCQkJCTxlbmFibGVkPnRydWU8L2Vu
YWJsZWQ+CisJCQk8L3JlbGVhc2VzPgorCQkJPHNuYXBzaG90cz4KKwkJCQk8ZW5hYmxlZD5mYWxz
ZTwvZW5hYmxlZD4KKwkJCTwvc25hcHNob3RzPgorCQk8L3JlcG9zaXRvcnk+CisJPC9yZXBvc2l0
b3JpZXM+CisKKzwvcHJvamVjdD4K
--089e0153673ee9826404f1c27ab8--
