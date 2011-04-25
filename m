From: Junio C Hamano <gitster@pobox.com>
Subject: Re: symlinked working tree gotcha
Date: Mon, 25 Apr 2011 11:15:15 -0700
Message-ID: <7vpqoajiz0.fsf@alter.siamese.dyndns.org>
References: <20110424165825.GA21062@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:15:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEQJo-000257-Cm
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 20:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706Ab1DYSP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 14:15:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab1DYSP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 14:15:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5231531E;
	Mon, 25 Apr 2011 14:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aB5g1ob5LrwUupzK76qbXMqW1dQ=; b=DxcoWd
	BESgbUqfNwCDQlkplDkySRWWWFEfkAGhtjmgKfwqlQ67zVRv9wIODfSYJSXDJMQN
	o7pufvmyeD13Ji0kAsGR7PJJuAP6g9Aze+tF65uhhtynSlI3I7hCDtNCguFN5JD9
	KZCk51KUu3z4OpBcawESXNd1kBDdtQ3f6LIEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C7q8qzEagQwkB06Qcr7q58MSMYOBAXgc
	73cG2aRrbFXMG/0YT4Ne62JNhgjB23NBYMXZEEy4oU5ZjJZEz2OlDPv1LRwDjm+f
	Xu8rI5D5ETSiXWHjNQje1Eu4s6BK+jlgSaFBJkIe83/3K4lt7z3NL0OSUMmczZ31
	baBH8GCnWrE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A313A5312;
	Mon, 25 Apr 2011 14:17:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7234C530B; Mon, 25 Apr 2011
 14:17:20 -0400 (EDT)
In-Reply-To: <20110424165825.GA21062@gnu.kitenet.net> (Joey Hess's message of
 "Sun, 24 Apr 2011 12:58:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44FDB0D0-6F68-11E0-A7D7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172035>

Joey Hess <joey@kitenet.net> writes:

> joey@gnu:/tmp>mkdir foo
> joey@gnu:/tmp>cd foo
> joey@gnu:/tmp/foo>git init
> Initialized empty Git repository in /tmp/foo/.git/
> joey@gnu:/tmp/foo>touch foo
> joey@gnu:/tmp/foo>git add /tmp/foo/foo
> joey@gnu:/tmp/foo>cd ..
> joey@gnu:/tmp>ln -s foo bar
> joey@gnu:/tmp>cd bar
> joey@gnu:/tmp/bar>touch bar
> joey@gnu:/tmp/bar>git add /tmp/bar/bar
> fatal: '/tmp/bar/bar' is outside repository
>
> Is this a bug or a feature of git?

Two 'foo's makes it confusing to read so let's rephrase.

Given this structure:

    /tmp/foo/
    /tmp/foo/.git/
    /tmp/foo/hello
    /tmp/sym@ -> foo

when you refer to /tmp/sym/hello where $(/bin/pwd) is /tmp/foo, should it
be considered to be within the bounds of the working tree that is governed
by your current $GIT_DIR (which is ".git")?

The answer is "perhaps yes, ideally speaking, but does it really matter in
practice, or is it just nice to have?".

I think we do not run realpath to a pathspec given by the end user to
canonicalize it.  And we cannot blindly run realpath.

Think of this structure (the above with some additions):

    /tmp/foo/
    /tmp/foo/.git/
    /tmp/foo/hello
    /tmp/foo/dir/bye
    /tmp/foo/link@ -> dir
    /tmp/sym@ -> foo

and you refer to /tmp/sym/link/bye from /tmp/foo directory.  If we run
realpath to the whole thing, we would get /tmp/foo/dir/bye but as far as
the repository data is concerned, link/bye is beyond a tracked symbolic
link and we should error it out ("git add link/bye" should fail).

If we choose to make your example work, we would need to resolve symbolic
links stepwise until we get into the working tree, and then use the
remainder without resolving symbolic links, e.g.

 0. We get /tmp/sym/hello  and /tmp/sym/link/bye from the user;

 1. Notice /tmp is a directory and outside the working tree;

 2. Notice /tmp/sym is a symlink; resolve it to get /tmp/foo, notice
    that directory is now within the working tree, and stop resolving
    symbolic links for the remainder;

 3. Append the remainder to come up with /tmp/foo/hello and
   /tmp/foo/link/bye;

 4. Strip /tmp/foo/, to get hello and link/bye as pathspec relative to the
    root of the working tree;

 5. Use them as the pathspec. hello is a valid pathspec within the working
    tree. link/bye is beyond symlink and an error should be reported.

Or something like that.  We would also have to deal with "../" in the
pathspec, so we cannot just "stop resolving and tack the remainder", but
would probably need to check if the directory is within bounds of the
working tree in each step.

At least I would say it would be a sensible thing to aim for.
