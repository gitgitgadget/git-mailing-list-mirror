From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 18:06:23 -0700
Organization: Twitter
Message-ID: <1430355983.14907.55.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	 <1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	 <1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	 <20150430003750.GA4258@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yncvv-0002wq-PP
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbbD3BG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:06:27 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33310 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbD3BG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:06:26 -0400
Received: by pacwv17 with SMTP id wv17so43565957pac.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 18:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=jbtYtjo9FdV2bK3xF+nTcpXZq0acthbGIM6qbbd4490=;
        b=KJd9NuKRKVlHO25OWa1hfyU3FJQdgAAxlgWQmKECwhZHWjKIagRCdQmJ8h0ufkVGt1
         fqA2pOr/YL9zZZLxztf63IdQVJg7kF+UU87lDWOirtnfJ/Mww3jdPtwZ6/6RfJyFsh5c
         XTY8iZxqYZENYok6CVUjvIaHZuArFTPO7BdrLFkJMlJkbnmh95ntrB2TMIo+T3wj/zLz
         WDcvonenL++V6wjZq2kQRTgwY1b9tqLM8HYxdsEVFM/sopvE24AmrwzrXdyh1suE3DZe
         PQxwrLa9TqHmn/DAbwbXObUGI4zFWfYMqczhPLD6JDrr1cDe5gesWqItxb1TjDcevPJ8
         lbEg==
X-Gm-Message-State: ALoCoQmx5DxX/Pkgipx3dRSy1ui1ZAxouNzruOlOKEe0AZqBRuQNeMrJcxPXgpcr49Vg1me4p6qf
X-Received: by 10.66.172.4 with SMTP id ay4mr3178606pac.157.1430355986450;
        Wed, 29 Apr 2015 18:06:26 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id w6sm377701pbt.60.2015.04.29.18.06.24
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 18:06:25 -0700 (PDT)
In-Reply-To: <20150430003750.GA4258@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268041>

On Wed, 2015-04-29 at 20:37 -0400, Jeff King wrote:
> On Wed, Apr 29, 2015 at 07:11:50PM -0400, Jeff King wrote:
> 
> > Yeah, I agree if you let git punt on leaving the filesystem, most of the
> > complicated problems go away. It still feels a bit more magical than I
> > expect out of cat-file, and there are still corner cases (e.g., do we do
> > cycle detection? Or just have a limit to the recursion depth?)
> 
> I was pondering the "magical" above. I think what bugs me is that it
> seems like a feature that is implemented as part of one random bit of
> plumbing, but not available elsewhere.
> 
> Conceptually, this is like peeling object names. You may give a tag
> name, but if you ask for a tree commit we will peel the tag to a commit,
> and the commit to a tree. This is sort of the same thing; you give a
> path within a tree, and we will peel until we hit a "real" non-symlink
> object.
> 
> I don't know what the syntax would look like. To match "foo^{tree}" it
> would be something like:
> 
>   HEAD:foo/bar^{resolve}
> 
> or something like that. Except that it is a bad idea to allow "^{}"
> syntax on the right-hand side of a colon, as it is ambiguous with
> filenames that contain "^{resolve}". So it would have to look something
> like:
> 
>   HEAD^{resolve}:foo/bar
> 
> which is a _little_ weird, but actually kind of makes sense. The
> "resolve" operation inherently is not just about the filename, but about
> uses HEAD^{tree} as the root context.
> 
> So I dunno. This pushes the resolving logic even _lower_ in the stack
> than it would be in cat-file. So why do I like it more? Cognitive
> dissonance? I guess I the appeal to me is that it:
> 
>   1. Makes the concept available more generally (you can "rev-parse" it,
>      you can "git show" it, etc). It also lets you _name_ the object in
>      question, so you can ask for other things besides it contents (like
>      its name, its type, etc).
> 
>   2. Positions it alongside other peeling name-resolution functions.

Just to clarify: if you do git rev-parse, and the result is an
out-of-tree symlink, you see /foo or ../foo instead of a sha?  And if
you "git show" it it says "symlink HEAD:../foo"?

This seems totally reasonable to me, and solves my problem.
