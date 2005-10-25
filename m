From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] GIT paths
Date: Tue, 25 Oct 2005 14:31:25 +0200
Message-ID: <435E259D.3040701@op5.se>
References: <7vhdb7qown.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 14:33:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUNy3-0005lb-U3
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 14:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVJYMb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 08:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVJYMb1
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 08:31:27 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:20198 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932135AbVJYMb1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 08:31:27 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 0556B6BD00
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 14:31:26 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vhdb7qown.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10583>

Junio C Hamano wrote:
> Our networking commands can take either URL or non URL to
> specify remote repository.  This note first attempts to clarify
> what <path> means in the current implementation, and then
> discusses two possible enhancements.
> 
> For connections over plain TCP talking with git-daemon, or over
> SSH in this form, path is always relative to the root directory
> on the remote site, because '/' that terminate either <host> or
> <port> starts the <path> = '/' + <rest-of-path>.
> 
> There are two things I would like to discuss here.
> 
>  - It might make sense to have SERVER_ROOT (similar to
>    DOCUMENT_ROOT in Apache) for git-daemon, so <path> does not
>    have to be relative to the true filesystem root.  Note that
>    this is not a security measure, but meant for administration
>    convenience [*1*].
> 
>  - Over a git-daemon connection, supporting ~user expansion
>    makes sense.  E.g git://host.xz/~junio/ refers to my home
>    directory on that machine.  It would make it impossible to
>    have a directory literally named '~junio' directly underneath
>    the root directory, but that is a good limitation anyway.
> 

I like this idea, although I'd extend it with a Userdir-like config 
option in git-daemon (like ~/public_html for apache). This makes it a 
bit easier to see what's published and what isn't.

About the literally named /~junio directory, it would be possible with 
this syntax;

	git fetch host.xz:/~junio

The userdir is (with my previous patch) only expanded if the path starts 
with a tilde.

> The above enhancements, especially SERVER_ROOT, however make
> paths inconsistent between non URL form and URL form.  This
> probably is OK -- people are used to using different paths when
> uploading to HTTP server and testing a download from it.  That
> leaves one issue.  Do we want to support ~user expansion, and if
> so how, on non git-daemon connections?
> 
> I would propose that
> 
> 	git fetch host.xz:~junio/repo
> 	git fetch ssh://host.xz/~junio/repo
> 
> mean the same thing (i.e. both understand ~user expansion).
> Also these are equivalent (i.e. no ~user expansion; both mean
> absolute filesystem path without SERVER_ROOT prefixing):
> 
> 	git fetch host.xz:/frotz/repo
> 	git fetch ssh://host.xz/frotz/repo
> 
> While these two might not mean the same thing (the former is
> prefixed with SERVER_ROOT, but not the latter):
> 
> 	git fetch git://host.xz/frotz/repo
> 	git fetch ssh://host.xz/frotz/repo
> 
> There are small technical issues.
> 
>  - connect.c should not be affected at all, since it does not
>    know how the remote site arranges SERVER_ROOT (if we support
>    it) or user home directories.
> 

It must remove the leading slash for this syntax:

	ssh://host.xz/~junio/repo

Otherwise it would be passed as /~junio/repo to the remote end and no 
~user interpolation would be done.

> 
>  - git-daemon needs to validate the incoming requested path and
>    in order to avoid aliasing issues, we should resolve ~user
>    expansion and SERVER_ROOT prefixing first, then validate the
>    resulting path against white/black list, before calling
>    upload-pack or receive-pack.  However, after git-daemon
>    decides to run these programs, they could find out some
>    problems with the specified repository and may need to report
>    them.  Arguably, this reporting should not reveal the real
>    path used to address the repository [*2*].
> 

This could be done by writing the relative path in the error message;

	.git/foo/bar: failed to do something nifty

The user or the admin should know where that path is and will know what 
to do. Messages logged on the server-side should ofcourse hold the full 
path.

> Although we _could_ forget about the "error reporting exposing
> real path" issue for now, I think we should at least have a plan
> to make things consistent and well defined.  Here is a strawman:
> 
>  - Have a common library code that takes user supplied path and
>    does SERVER_ROOT prefixing and ~user expansion.
> 
>  - Have git-daemon use it to canonicalize the requested path
>    before validating.  Make it invoke the programs with the path
>    received from the other end (before SERVER_ROOT prefixing, or
>    ~user expansion).
> 

I'd say make it invoke the programs with the canonicalized path. As you 
say, git-daemon has to verify that it's a proper git repo and in the 
whitelist anyway so I think it would be silly to add extra complexity to 
upload-pack and receive-pack.

git-daemon could ofcourse present some uniform error message if 
git-upload-pack or git-receive-pack fails but this wouldn't really be 
necessary if they use relative paths as mentioned above (someone who 
makes one of those two fail while working will already know the path).

>  - Give --server-root=/path/to/root flag to programs that can be
>    called by git-daemon, and have git-daemon run them with this
>    flag.  Have them use the same library to canonicalize the
>    requested path to the real path.  When these programs are run
>    via direct SSH connection (i.e. ssh://host/path and
>    host:path), this flag is not given so they see filesystem
>    path as-is, but make the ~user expansion still available.
> 

If we stick with canonicalized paths I suppose this can be dropped.

> 
> [Footnote]
> 
> *2* This is theoretical right now, since packed transfer
> protocols cannot report errors back, but Andreas' patch
> addresses this issue by dying carefully in srvside_chdir().  It
> falls into security-by-obscurity category, so we may choose not
> to worry about it, though.
> 

Keeping valid usernames hidden is normally considered best practice.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
