From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Access different NAMESPACE of remote repo from client side
Date: Fri, 15 Nov 2013 19:55:50 +0530
Message-ID: <52862EEE.8010800@gmail.com>
References: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Josh Triplett <josh@joshtriplett.org>,
	Jamey Sharp <jamey@minilop.net>
To: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 15:26:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhKLR-0001N9-L6
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 15:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab3KOOZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 09:25:58 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:52142 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab3KOOZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 09:25:56 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so3577172pbc.40
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=T9pN8uyWlromdSyRVz1RBWGZo3iq2/2XA/HYxQmN/H0=;
        b=dpj4HV0aGgMRCmUKdQXwb1wjwsl9JjWUlTdfMQR25RKxh0mVj16vgV/SrfCuykF4H4
         0Z5zPkdmZSWIy5HkCHvk2yDpF745Vy8oB+zrCMudTZdo2c0q8CE68KR+Gx9b/RQajNQ8
         blz1WwfcTJFLIH74d8+DAjgQ68Gr5dXBH8r/ZdPeX3EVeYTTVPiotQ6PejYr4gL9NJRK
         VUYwftm5sA1bDDJISlwM710vH18+++W8aTp2ArNQR27FGe/jWICxmRpE228s27BBuLdu
         X5bAS7kJLQcp0G8zfQ/kN7ZCEzNclMTRN1n4S0g55gqYYF6Pou6bQGjNiJVMu0Bv1O9j
         QZ9w==
X-Received: by 10.66.11.202 with SMTP id s10mr7196022pab.86.1384525556044;
        Fri, 15 Nov 2013 06:25:56 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.221.197.107])
        by mx.google.com with ESMTPSA id uf2sm4848214pbc.28.2013.11.15.06.25.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 06:25:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237907>

On 11/15/2013 01:49 PM, Jiang Xin wrote:
> GIT_NAMESPACE is designed to be used mainly on the server side, that
> the server can serve multiple git repositories while share one single
> repository storage using different GIT_NAMESPACE settings.
> 
> Since we know that one remote repository hosts multiple namespaces,
> can we handle different namespaces in one local repository? Or can
> we access the proper namespace of the remote repository without
> complicated server settings?
> 
> At least there are three solutions for ssh protocol: pass namespace
> through environment, pass namespace in URL, or pass namespace from
> the proper settings of remote.<name>.receivepack and
> remote.<name>.uploadpack.
> 
> Solution 1: passing the namespace through environment.
> 
>  1. Set '/etc/sshd_config' in the server side as the following,
>     so that the ssh server can accept GIT_NAMESPACE environment.
> 
>         AcceptEnv LANG LC_* GIT_NAMESPACE
> 
>  2. In the client side, When connect to ssh server, must send the
>     GIT_NAMESPACE environment. This can be done with a remote-ext
>     url:
> 
>         $ git remote add foo \
>           'ext::ssh -o SendEnv=GIT_NAMESPACE git@server %S 'path/to/repo.git'
> 
> Then the remote "foo" is GIT_NAMESPACE aware, but when operate on
> this remote, must provide proper "--namespace" option.
> 
>     $ git --namespace=foo push foo master
>     $ git --namespace=foo fetch foo
>     $ git --namespace=foo ls-remote foo
>     $ git --namespace=foo remote prune foo
>     $ git --namespace=foo archive --remote foo HEAD
> 
> But provide a "--namespace" option is error-prone, but we may invent
> "remote.<name>.namespace" or something to set GIT_NAMESPACE
> automatically when push to or fetch from remote server.
> 
> Solution 2: passing the namespace in URL.
> 
> Again use remote-ext style URL to access remote repository:
> 
>     $ git remote add foo \
>         'ext::ssh git@server git --namespace foo %s path/to/repo.git'
> 
>     $ git remote add bar \
>         'ext::ssh git@server git --namespace bar %s path/to/repo.git'
> 
> But if the remote server use a limit shell (such as git-shell or
> gitolite), the above URLs won't work. This is because these git
> specific shell (git-shell or gitolite) do not like options.
> 
> Solution 3: use custom receivepack and uploadpack. e.g.
> 
>     [remote "foo"]
>         url = ssh://git@server/path/to/repo.git
>         receivepack = git --namespace foo receive-pack
>         uploadpack = git --namespace foo upload-pack
>         fetch = +refs/heads/*:refs/remotes/foo/*
> 
>     [remote "bar"]
>         url = ssh://git@server/path/to/repo.git
>         receivepack = git --namespace bar receive-pack
>         uploadpack = git --namespace bar upload-pack
>         fetch = +refs/heads/*:refs/remotes/foo/*
> 
> Just like solution 2, these settings won't work without a patched
> git-shell or gitolite.

Gitolite has a namespaces branch that handles namespaces as described in
http://gitolite.com/gitolite/namespaces.html

Briefly, it recognises that you can have a "main" repo off of which
several developer might want to hang their logical repos.

It also recognises that the actual names of the logical repos will
follow some pattern that may include the name of the developer also, and
provides a way to derive the name of the physical repo from the logical
one.

There is an example or two in that link.
