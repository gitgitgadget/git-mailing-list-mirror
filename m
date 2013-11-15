From: Jiang Xin <worldhello.net@gmail.com>
Subject: Access different NAMESPACE of remote repo from client side
Date: Fri, 15 Nov 2013 16:19:17 +0800
Message-ID: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Triplett <josh@joshtriplett.org>,
	Jamey Sharp <jamey@minilop.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 09:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhEce-0000OF-7x
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 09:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3KOITU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 03:19:20 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57647 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3KOITT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 03:19:19 -0500
Received: by mail-wi0-f182.google.com with SMTP id i19so626614wiw.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 00:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=2TU139RAEgrDxCAyHCIftalHBe47v5bjxDgPmVbO//A=;
        b=xatedgshMjtf8cxqMGo/Pdh8e7Vz7151/Mv9JbWE5QAqP4Q9tCQyk51nafO89Lk0vK
         buc1/HMAoYH9r4/c6X0itBqlQwLyuRYQTBxZKDPdReWv0gTQC/xtjh3FTX3XicfHwTYR
         jn6psjxvfFKD6I7YriUDHdw/M5TVTOgT9InQvYgtaTcEt/2mPITgIe8Hil/kyZ1pQEJO
         mwSuHDYRNdu22twPY3APvwZH3UTblVV7sjPQ2wTW0cjowvvlTf9348on17mC2Heq6n0q
         vNr3eYZWfNi6z9mweZt+2uwC7WSsuN+GbWGvDs3lIO6Z/jd6CSaHYAOVVUrg6PQMXepB
         q7Cg==
X-Received: by 10.194.185.73 with SMTP id fa9mr5645834wjc.29.1384503557477;
 Fri, 15 Nov 2013 00:19:17 -0800 (PST)
Received: by 10.216.122.202 with HTTP; Fri, 15 Nov 2013 00:19:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237891>

GIT_NAMESPACE is designed to be used mainly on the server side, that
the server can serve multiple git repositories while share one single
repository storage using different GIT_NAMESPACE settings.

Since we know that one remote repository hosts multiple namespaces,
can we handle different namespaces in one local repository? Or can
we access the proper namespace of the remote repository without
complicated server settings?

At least there are three solutions for ssh protocol: pass namespace
through environment, pass namespace in URL, or pass namespace from
the proper settings of remote.<name>.receivepack and
remote.<name>.uploadpack.

Solution 1: passing the namespace through environment.

 1. Set '/etc/sshd_config' in the server side as the following,
    so that the ssh server can accept GIT_NAMESPACE environment.

        AcceptEnv LANG LC_* GIT_NAMESPACE

 2. In the client side, When connect to ssh server, must send the
    GIT_NAMESPACE environment. This can be done with a remote-ext
    url:

        $ git remote add foo \
          'ext::ssh -o SendEnv=GIT_NAMESPACE git@server %S 'path/to/repo.git'

Then the remote "foo" is GIT_NAMESPACE aware, but when operate on
this remote, must provide proper "--namespace" option.

    $ git --namespace=foo push foo master
    $ git --namespace=foo fetch foo
    $ git --namespace=foo ls-remote foo
    $ git --namespace=foo remote prune foo
    $ git --namespace=foo archive --remote foo HEAD

But provide a "--namespace" option is error-prone, but we may invent
"remote.<name>.namespace" or something to set GIT_NAMESPACE
automatically when push to or fetch from remote server.

Solution 2: passing the namespace in URL.

Again use remote-ext style URL to access remote repository:

    $ git remote add foo \
        'ext::ssh git@server git --namespace foo %s path/to/repo.git'

    $ git remote add bar \
        'ext::ssh git@server git --namespace bar %s path/to/repo.git'

But if the remote server use a limit shell (such as git-shell or
gitolite), the above URLs won't work. This is because these git
specific shell (git-shell or gitolite) do not like options.

Solution 3: use custom receivepack and uploadpack. e.g.

    [remote "foo"]
        url = ssh://git@server/path/to/repo.git
        receivepack = git --namespace foo receive-pack
        uploadpack = git --namespace foo upload-pack
        fetch = +refs/heads/*:refs/remotes/foo/*

    [remote "bar"]
        url = ssh://git@server/path/to/repo.git
        receivepack = git --namespace bar receive-pack
        uploadpack = git --namespace bar upload-pack
        fetch = +refs/heads/*:refs/remotes/foo/*

Just like solution 2, these settings won't work without a patched
git-shell or gitolite.

I will send a patch in next email to address the latter two cases.


-- 
Jiang Xin
