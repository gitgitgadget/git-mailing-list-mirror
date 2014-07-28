From: Bryan Turner <bturner@atlassian.com>
Subject: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 19:42:16 +1000
Message-ID: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 11:50:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBhZo-0007j8-LE
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 11:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbaG1Jug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 05:50:36 -0400
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50973 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752256AbaG1Jue (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 05:50:34 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jul 2014 05:50:34 EDT
Received: from mail-oi0-f51.google.com ([209.85.218.51]) (using TLSv1) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKU9Yc6e/qIqJubnHM963667QhLKXHyFgD@postini.com; Mon, 28 Jul 2014 02:50:34 PDT
Received: by mail-oi0-f51.google.com with SMTP id g201so5819906oib.24
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 02:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=QBtuypRc2NS9NMOJAODAUNkFB2O+/UsKKtiAITIJkwE=;
        b=GUvbVcNm39m8reohc9z3vrkiemDqTYXYh3GElrO7FimhgZ0HI5RZa9I+vlnVh6Kbdr
         XWTnIUtWQXuJDse+BR11PKDIy1KcQfIoCYFLNiaUcGxPwV8uh2g/vXZEPm8H/R6RcV6h
         IhiRC+kKykNt/nc9DcgudhkZVBwmX1qUxk/lcprX6R8DvXhHje3BA7M7Rw5TMnssfSW9
         IdfyAyxobNs9i08FTVR+PTk1+vKAb+xDbKlVwpyvizvjJpvUI+pkSUV4cDPyxrhHD4vU
         8VtP5UlRTDbg049UhtrF/5QqC7pWzy4Gmaz4V1OwF3yipeKnTNBUVOowblM2oXTu6Z7C
         StAA==
X-Received: by 10.60.158.8 with SMTP id wq8mr19926245oeb.40.1406540536515;
        Mon, 28 Jul 2014 02:42:16 -0700 (PDT)
X-Gm-Message-State: ALoCoQkaiy8iDWaajCMlkePFi8wo71SI9p47YzW2754ogxruOmBEmL+Lsc3qmGKeZv1Ggs5TulI5O8xlq+BpdgPe1cUC1dRt0Jn9s2Col1tsc++RDP3mF2XHu9Ys5XZIB/Ee5bNAgcND
X-Received: by 10.60.158.8 with SMTP id wq8mr19926208oeb.40.1406540536247;
 Mon, 28 Jul 2014 02:42:16 -0700 (PDT)
Received: by 10.182.51.130 with HTTP; Mon, 28 Jul 2014 02:42:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254285>

Using git diff-tree --stdin on 2.0.2 and 2.0.3 produces incorrect
commit messages.

Here's an example to reproduce the issue:

bturner@ubuntu:/tmp$ git init --bare test.git
Initialized empty Git repository in /tmp/test.git/
bturner@ubuntu:/tmp$ git clone test.git
Cloning into 'test'...
warning: You appear to have cloned an empty repository.
done.
bturner@ubuntu:/tmp$ cd test
bturner@ubuntu:/tmp/test$ echo "Hello" > file.txt
bturner@ubuntu:/tmp/test$ git add file.txt
bturner@ubuntu:/tmp/test$ git commit -m "Initial commit"
[master (root-commit) c5e16f3] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
bturner@ubuntu:/tmp/test$ echo "World" >> file.txt
bturner@ubuntu:/tmp/test$ git commit -am "Second commit"
[master 9214ac7] Second commit
 1 file changed, 1 insertion(+)
bturner@ubuntu:/tmp/test$ git push origin HEAD
Counting objects: 6, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (6/6), 446 bytes | 0 bytes/s, done.
Total 6 (delta 0), reused 0 (delta 0)
To /tmp/test.git
 * [new branch]      HEAD -> master
bturner@ubuntu:/tmp/test$ cd ../test.git/
bturner@ubuntu:/tmp/test.git$ git rev-list -1
--format="%H|%h|%P|%p|%aN|%aE|%at%n%B%n" 9214ac7
commit 9214ac79728424a971244c34432c6d948754198d
9214ac79728424a971244c34432c6d948754198d|9214ac7|c5e16f37164f1b7411685def64d7390775437f07|c5e16f3|Bryan
Turner|bturner@atlassian.com|1406539558
Second commit


bturner@ubuntu:/tmp/test.git$ /opt/git/2.0.3/bin/git diff-tree
--no-renames --always --format="commit
%H%n%H|%h|%P|%p|%aN|%aE|%at|%B%n" --root
9214ac79728424a971244c34432c6d948754198d
commit 9214ac79728424a971244c34432c6d948754198d
9214ac79728424a971244c34432c6d948754198d|9214ac79728424a971244c34432c6d948754198d|c5e16f37164f1b7411685def64d7390775437f07|c5e16f37164f1b7411685def64d7390775437f07|Bryan
Turner|bturner@atlassian.com|1406539558|Second commit



:100644 100644 e965047ad7c57865823c7d992b1d046ea66edf78
f9264f7fbd31ae7a18b7931ed8946fb0aebb0af3 M    file.txt
bturner@ubuntu:/tmp/test.git$ /opt/git/2.0.3/bin/git diff-tree
--no-renames --always --format="commit
%H%n%H|%h|%P|%p|%aN|%aE|%at|%B%n" --root --stdin
--9214ac79728424a971244c34432c6d948754198d
commit 9214ac79728424a971244c34432c6d948754198d
9214ac79728424a971244c34432c6d948754198d|9214ac79728424a971244c34432c6d948754198d|c5e16f37164f1b7411685def64d7390775437f07|c5e16f37164f1b7411685def64d7390775437f07|Bryan
Turner|bturner@atlassian.com|1406539543|Initial commit



:100644 100644 e965047ad7c57865823c7d992b1d046ea66edf78
f9264f7fbd31ae7a18b7931ed8946fb0aebb0af3 M    file.txt
bturner@ubuntu:/tmp/test.git$

Running a git bisect between v2.0.1, which does not manifest this
issue, and v2.0.2 fingers the following commit:
bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0 is the first bad commit
commit c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0
Author: Jeff King <peff@peff.net>
Date:   Tue Jun 10 17:43:02 2014 -0400

    commit: convert commit->buffer to a slab

Bryan Turner
