From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Access different NAMESPACE of remote repo from client side
Date: Fri, 15 Nov 2013 20:17:44 +0530
Message-ID: <52863410.9090508@gmail.com>
References: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com> <52862EEE.8010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Josh Triplett <josh@joshtriplett.org>,
	Jamey Sharp <jamey@minilop.net>
To: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 15:47:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhKgc-00080g-SP
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 15:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab3KOOrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 09:47:51 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54965 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab3KOOru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 09:47:50 -0500
Received: by mail-pd0-f177.google.com with SMTP id v10so3556966pde.22
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 06:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OnUnDiAoWttRZ4U0ph/DyA5lAirrvC4T/BpR3DMnnk8=;
        b=EICa/weIkMCSBeTlxpAmgv4UVHM5+R5q6ZMUmQIl1hrchijMgJtcQvI5jxK/5ZOO8s
         JIOXqoz6s11p/JflxZn50KBDG98qn8an8cTnYUBoRpqHv33TwgM0Wq2YenTyEKWk53l0
         WVStkvVzcEt9JTNscK6gv1YoUe3X9UHRfcyAup4MxxfU3V8bDeZd5U+Nqd0FOLB6Q12l
         4Q2/lR6pVKZTmWD+7QieGKLvWdyiAcRzHjH92yGPWI30TzFxeE4ltlPgfHZk4aw9Fp9x
         kgL+jcC5Dlxynqeu4dvdglRDSmy6Fm8D/k6RywrCJNIX4DR6N481jG6+V742SNABAv5Z
         Tmqw==
X-Received: by 10.68.49.232 with SMTP id x8mr7121776pbn.167.1384526869932;
        Fri, 15 Nov 2013 06:47:49 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.221.197.107])
        by mx.google.com with ESMTPSA id xs1sm5530790pac.7.2013.11.15.06.47.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 06:47:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52862EEE.8010800@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237908>

On 11/15/2013 07:55 PM, Sitaram Chamarty wrote:
> On 11/15/2013 01:49 PM, Jiang Xin wrote:
>> GIT_NAMESPACE is designed to be used mainly on the server side, that
>> the server can serve multiple git repositories while share one single
>> repository storage using different GIT_NAMESPACE settings.
>>
>> Since we know that one remote repository hosts multiple namespaces,
>> can we handle different namespaces in one local repository? Or can
>> we access the proper namespace of the remote repository without
>> complicated server settings?
>>
>> At least there are three solutions for ssh protocol: pass namespace
>> through environment, pass namespace in URL, or pass namespace from
>> the proper settings of remote.<name>.receivepack and
>> remote.<name>.uploadpack.
>>
>> Solution 1: passing the namespace through environment.
>>
>>  1. Set '/etc/sshd_config' in the server side as the following,
>>     so that the ssh server can accept GIT_NAMESPACE environment.
>>
>>         AcceptEnv LANG LC_* GIT_NAMESPACE
>>
>>  2. In the client side, When connect to ssh server, must send the
>>     GIT_NAMESPACE environment. This can be done with a remote-ext
>>     url:
>>
>>         $ git remote add foo \
>>           'ext::ssh -o SendEnv=GIT_NAMESPACE git@server %S 'path/to/repo.git'
>>
>> Then the remote "foo" is GIT_NAMESPACE aware, but when operate on
>> this remote, must provide proper "--namespace" option.
>>
>>     $ git --namespace=foo push foo master
>>     $ git --namespace=foo fetch foo
>>     $ git --namespace=foo ls-remote foo
>>     $ git --namespace=foo remote prune foo
>>     $ git --namespace=foo archive --remote foo HEAD
>>
>> But provide a "--namespace" option is error-prone, but we may invent
>> "remote.<name>.namespace" or something to set GIT_NAMESPACE
>> automatically when push to or fetch from remote server.
>>
>> Solution 2: passing the namespace in URL.
>>
>> Again use remote-ext style URL to access remote repository:
>>
>>     $ git remote add foo \
>>         'ext::ssh git@server git --namespace foo %s path/to/repo.git'
>>
>>     $ git remote add bar \
>>         'ext::ssh git@server git --namespace bar %s path/to/repo.git'
>>
>> But if the remote server use a limit shell (such as git-shell or
>> gitolite), the above URLs won't work. This is because these git
>> specific shell (git-shell or gitolite) do not like options.
>>
>> Solution 3: use custom receivepack and uploadpack. e.g.
>>
>>     [remote "foo"]
>>         url = ssh://git@server/path/to/repo.git
>>         receivepack = git --namespace foo receive-pack
>>         uploadpack = git --namespace foo upload-pack
>>         fetch = +refs/heads/*:refs/remotes/foo/*
>>
>>     [remote "bar"]
>>         url = ssh://git@server/path/to/repo.git
>>         receivepack = git --namespace bar receive-pack
>>         uploadpack = git --namespace bar upload-pack
>>         fetch = +refs/heads/*:refs/remotes/foo/*
>>
>> Just like solution 2, these settings won't work without a patched
>> git-shell or gitolite.
> 
> Gitolite has a namespaces branch that handles namespaces as described in
> http://gitolite.com/gitolite/namespaces.html
> 
> Briefly, it recognises that you can have a "main" repo off of which
> several developer might want to hang their logical repos.
> 
> It also recognises that the actual names of the logical repos will
> follow some pattern that may include the name of the developer also, and
> provides a way to derive the name of the physical repo from the logical
> one.
> 
> There is an example or two in that link.

I should add that the Gitolite model is: the user doesn't need to know
about namespaces, because namespaces are just things that the server
admin is setting up for his own reasons...

...typically because he anticipates several dozens of people cloning the
same repo into their namespace and so he expects to save a lot of disk
doing this).

So in this model we don't really need anything on the client side.
