From: Csaba Henk <csaba@lowlife.hu>
Subject: commit message parsing error in rebase
Date: Sat, 5 May 2012 00:05:35 +0530
Message-ID: <CAA-jfp=F7ije9nFJio5gnmNGptDR1ZTBbCi-aOv7JokqrXBgYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 20:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQNMI-00048n-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 20:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2EDSf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 14:35:57 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36929 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab2EDSf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 14:35:57 -0400
Received: by eaaq12 with SMTP id q12so918765eaa.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=+Pi28V2omYIiIr948MQf6RkmlwQjk/Mj9ypYihkVmwo=;
        b=zvZuqCZ+c4o1fCpJ/keZDhY1lxiKJ1chDcFzxRJrgrPpKCHzuy8aZ+xZpFw/dFNQSj
         me3Vq59RQsjUWeFeWUiOBRRZ1y4hHzjJQGz+YVYWvFOei5HzmVABr11dyMC9KuzUM+Hi
         lPVg13EatUbOuILW/5iR/+JNmKqk5URDsYhXRnoMNFopTNJ3KbrzvuN5+/vuQwjOJt86
         Kk+yzsG41s3MmmETVYrvNwIRHggV41qLi5hLYsR+tfMXhWONnNyROHrEuQjRihzOAxfG
         sdc0/ZbSiazQ5/pdHcMXJ8HqMhewFp7zA+C12XBEXqhRXem3A7wUyqkBqGDue+dgpLJq
         gy+g==
Received: by 10.213.121.67 with SMTP id g3mr1350203ebr.134.1336156555913; Fri,
 04 May 2012 11:35:55 -0700 (PDT)
Received: by 10.14.194.198 with HTTP; Fri, 4 May 2012 11:35:35 -0700 (PDT)
X-Google-Sender-Auth: H_BXnu_EmIti-CgVXRFhN3YcoXM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197047>

Hi,

The bug I'm to report is objectively a bug; nevertheless, let
me use a fictive scenario to illustrate it.

Say we have a project where we fix a vulnerability in the
server component. In the commit message of the fix, we
give a PoC malicious client that can be used to test if
server is vulnerable. The PoC is specified by embedding
a diff against normal client in the commit message.

(Let's not discuss how good or bad it is to give PoCs in
commit messages.)

Now if you rebase this commit, git-rebase will think the
PoC diff in the commit message is part of the commit diff,
and will apply it. So the client will became malicious
upon the rebase.

Nb. cherry-pick does not make this mistake (what took
me by surprise as I thought rebase and cherry-pick have a
common backend).

The following script creates such a scenario:

####################################################
echo 'def client(conn):
  print >> conn, "hello"' > client.py
echo 'def server(conn):
  print conn.read()[4]' > server.py
git add .
git commit -m first
echo 'def server(conn):
  msg = conn.read()
  if len(msg) >= 5:
    print msg[4]' > server.py
git commit -am 'server: check msg size

Make sure client cannot crash server.

Q/A: check with PoC malicious client
by applying patch:

diff --git a/client.py b/client.py
--- a/client.py
+++ b/client.py
@@ -1,2 +1,2 @@
 def client(conn):
-  print >> conn, "hello"
+  print >> conn, "hell"'
git checkout --detach HEAD^
echo 'def load_balancer():
  balance_load()' > load_balancer.py
git add load_balancer.py
git commit -m 'added load balancer prototype'
git tag LOAD_BALANCER_PROTO
git branch bleeding-edge master
git rebase LOAD_BALANCER_PROTO bleeding-edge
git checkout LOAD_BALANCER_PROTO
git cherry-pick master
echo
echo '###### RESULT #######'
echo '### '`git --version`
echo
echo '## topolgy'
git log --graph --pretty=oneline --all --decorate
echo
echo '## original commit'
git show --stat --decorate master
echo
echo '## rebased commit'
git show --stat --decorate bleeding-edge
echo
echo '## cherry-picked commit'
git show --stat --decorate HEAD
####################################################

and it has an output like this:

###### RESULT #######
### git version 1.7.10.1

## topolgy
* f5100d373242554f71db47592d8214c9e89d854a (bleeding-edge) server:
check msg size
| * c8fa20bd901d3bc0e745d976151d3b34d91f077d (HEAD) server: check msg size
|/
* 0cb17691eb9a9774af0fc991bf34da89fd413325 (tag: LOAD_BALANCER_PROTO)
added load balancer prototype
| * 3628281d81d275f431bdc0da36fe7c7d66240175 (master) server: check msg size
|/
* 80d8113aa7f6fa46245408ddbc846d9c1e796373 first

## original commit
commit 3628281d81d275f431bdc0da36fe7c7d66240175 (master)
Author: Csaba Henk <>
Date:   Fri May 4 23:56:51 2012 +0530

    server: check msg size

    Make sure client cannot crash server.

    Q/A: check with PoC malicious client
    by applying patch:

    diff --git a/client.py b/client.py
    --- a/client.py
    +++ b/client.py
    @@ -1,2 +1,2 @@
     def client(conn):
    -  print >> conn, "hello"
    +  print >> conn, "hell"

 server.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

## rebased commit
commit f5100d373242554f71db47592d8214c9e89d854a (bleeding-edge)
Author: Csaba Henk <>
Date:   Fri May 4 23:56:51 2012 +0530

    server: check msg size

    Make sure client cannot crash server.

    Q/A: check with PoC malicious client
    by applying patch:

    diff --git a/client.py b/client.py
    --- a/client.py
    +++ b/client.py
    @@ -1,2 +1,2 @@
     def client(conn):
    -  print >> conn, "hello"
    +  print >> conn, "hell"

 client.py |    2 +-
 server.py |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

## cherry-picked commit
commit c8fa20bd901d3bc0e745d976151d3b34d91f077d (HEAD)
Author: Csaba Henk <>
Date:   Fri May 4 23:56:51 2012 +0530

    server: check msg size

    Make sure client cannot crash server.

    Q/A: check with PoC malicious client
    by applying patch:

    diff --git a/client.py b/client.py
    --- a/client.py
    +++ b/client.py
    @@ -1,2 +1,2 @@
     def client(conn):
    -  print >> conn, "hello"
    +  print >> conn, "hell"

 server.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


Csaba
