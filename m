From: Patrick Donnelly <batrick@batbytes.com>
Subject: reject "backwards" merges
Date: Fri, 12 Dec 2014 13:40:29 -0500
Message-ID: <CACh33FqHindeksHv7wcgu983oBSbm5G0ZswrQdTAz5tqgZdgjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzV8m-0002lc-82
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 19:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933814AbaLLSkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 13:40:32 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:40711 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbaLLSkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 13:40:31 -0500
Received: by mail-la0-f53.google.com with SMTP id gm9so6505723lab.26
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 10:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=hMxZ3KjdrpfZCy/vLaoP8Zz2Jekvl1YnFxxG6w13n6U=;
        b=fX8zO/POJU+1zI6m6fEjgyc04/rNrcOEE2W4g2EUrF+xB0ltqFXj3T+KeAr0Z1is0g
         RX6P26m0habnV98w2i5jhPub2uFsn2siXRMiQd+i7gpVhx5U1sGKId5a/m0vG2y2L47r
         5Q+zgKmfr+g4V1JGlpAw+/d73ujZ1/0L1LSIMFIdXwn0siEQsPkuByRMrJB9Q3pKHNy+
         Q1noAZL6qNLVPvbYGcnw2Y0q2qGlk7/L86mV0+NO+J2G3RfGU3xvxAa3Baje+ycAknRq
         cOh4abTWUCy+4ftYqCaAKul/R8F9HHxpRdSPXk1BROz4Pr5UesyedQQDHtT3kl2M6RUf
         Q9Kw==
X-Gm-Message-State: ALoCoQn6KjBqra7Yj+hkW7oWyc1uD2M4qD6j5kEPTJjTGQeSSRjacoz4hlO3oMITgW2sG8T/gFqC
X-Received: by 10.112.198.1 with SMTP id iy1mr16809360lbc.13.1418409629961;
 Fri, 12 Dec 2014 10:40:29 -0800 (PST)
Received: by 10.112.49.15 with HTTP; Fri, 12 Dec 2014 10:40:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261356>

Is there a way to reject pushes that change the history of
first-parents, caused by a "backwards" merge? To clarify by example
(using branches instead of separate repositories):

$ git init
Initialized empty Git repository in /tmp/tmp.O0efpRrV4p/.git/
$ touch foo
$ git add foo
$ git commit -m initial
[master (root-commit) c4890b9] initial
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ git branch b1
$ touch bar
$ git add bar
$ git commit -m bar
[master 9cb303e] bar
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bar
$ git checkout b1
Switched to branch 'b1'
$ touch baz
$ git add baz
$ git commit -m baz
[b1 4c618bc] baz
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 baz
$ git merge master
Merge made by the 'recursive' strategy.
 bar | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bar
$ git checkout master
Switched to branch 'master'
$ git merge b1
Updating 9cb303e..1b0a9d4
Fast-forward
 baz | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 baz
$ git log --graph
*   commit 1b0a9d4a011cd7e36c8c58b190aed0b450f06ca1
|\  Merge: 4c618bc 9cb303e
| | Author: Patrick Donnelly <>
| | Date:   Fri Dec 12 13:32:51 2014 -0500
| |
| |     Merge branch 'master' into b1
| |
| * commit 9cb303e2578af305d688abf62570ef31f3f113da
| | Author: Patrick Donnelly <>
| | Date:   Fri Dec 12 13:32:23 2014 -0500
| |
| |     bar
| |
* | commit 4c618bc094e82d9a5126a1c3fbc59921e41bd7b5
|/  Author: Patrick Donnelly <>
|   Date:   Fri Dec 12 13:32:46 2014 -0500
|
|       baz
|
* commit c4890b9bd590b34a9eb955d50e6e736729509a7c
  Author: Patrick Donnelly <>
  Date:   Fri Dec 12 13:31:46 2014 -0500

      initial

Here the desired first parent (HEAD^) would be commit
9cb303e2578af305d688abf62570ef31f3f113da. Unfortunately, the incorrect
merge reversed the line of parents. Is there a way to prevent this
from happening (via git-config) other than fixing the human?

-- 
Patrick Donnelly
