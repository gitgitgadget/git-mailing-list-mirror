From: David Aguilar <davvid@gmail.com>
Subject: Re: How to share config and hooks ?
Date: Wed, 27 May 2009 22:54:18 -0700
Message-ID: <20090528055417.GA21329@gmail.com>
References: <4A1D9B4C.7030504@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christian Senkowski <csenkowski@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 28 07:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YZV-00089p-3Q
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 07:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759886AbZE1Fy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 01:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759116AbZE1FyZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 01:54:25 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:62269 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbZE1FyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 01:54:24 -0400
Received: by pxi29 with SMTP id 29so801972pxi.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WLJk/av/5UOJ98OQci2zUaEjyUdELfTx/o+8vjp6oNs=;
        b=PUF9H06DCEyd922jsGOjutlLeWRVvOPhQsPMKEMdpcsErxBWFCrSCNVWeicvEt11tO
         BUU4vMR0a3bciKlLQ9fFBfgL2z/L5KfvJf0SX4XFAqzKJlL6ix7KF0/+6nxJXZgsAuXr
         IoXbOtuEcueO8FnK8UOi4ugvXrMSsZxE68p8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mtZgiCKIw5nsbzPaZNr4NzN0edHCbX9RyfQ61rQ04GVZhNh60yv9AJQCgv8c2yG0ZW
         zD9Gmk9LafPMacWGkQ6wvqUjS5SjK8v6OcCoskN+mQoouTljtQvst1Dq9kN/MUlQZpag
         EjZulcYgceZdjn0yqeFOrseRPHzafom0bMc5k=
Received: by 10.115.75.6 with SMTP id c6mr626422wal.118.1243490066667;
        Wed, 27 May 2009 22:54:26 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l30sm20537286waf.0.2009.05.27.22.54.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 22:54:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A1D9B4C.7030504@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120152>

On Wed, May 27, 2009 at 09:58:04PM +0200, Christian Senkowski wrote:
> I am searching for a way to share 'config' and hooks/* automatically.
> I'd like to change and commit them as normal files and every user
> cloning this repo should get those.

Assuming you control your users' machines (such as in a company)
then you can simply add something like in:
/usr/share/git-core/templates/hooks/pre-commit

#!/bin/sh
for hook in /usr/share/git-hooks/pre-commit.d/*; do
	if ! $hook "$@"; then
		exit $?
	fi
fi

Just create a wrapper for each hook.

When you want to upgrade your hooks you just change the
"included" hooks in /usr/share/git-hooks/<hookname>.d/ and all
of your repos pick up the updated hooks since they reference
them indirectly.

Assuming you're using an apt or rpm infrastructure and you
control your users' machines, then this is easy.


If you're trying to do this generally for anybody who clones
your project (such as in the real world), then there's no way.


> One way might be a little wrapper-script for git-clone which looks if
> repo/.gitconfig or repo/.githooks exist and copies then the files to
> repo/.git/[...]
> But I am searching for a way to do this without any additional scripts.

You're looking for the git templates directory.  That's what
gets copied into each repository at git-init/git-clone time.
Again, only useful in a controlled environment where you
control your user's git install.

I mention the trick above because if you install normal hooks,
upgrading them is a pain because every repo has its own copy.
By adding indirection into the hooks you can upgrade the
hooks globally with little effort.  It's also neat because the
example allows you to install multiple hooks for the same
action.  e.g. the post-commit example above allows you to have
several hooks in the post-commit.d/ directory.


> And what'd you say about implementing this (with a
> yes-please-copy-the-found-files/no-leave-them-alone - question) directly
> into the git-binary ?

Nope, Dscho already mentioned the security implications.


Have fun,

-- 

	David
