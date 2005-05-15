From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Ignore rules
Date: Sat, 14 May 2005 23:05:35 -0700
Message-ID: <7v4qd5vxao.fsf@assigned-by-dhcp.cox.net>
References: <4283CAF8.3050304@dgreaves.com>
	<20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com>
	<7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
	<20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com>
	<20050514153027.GN3905@pasky.ji.cz>
	<7vsm0py8vz.fsf@assigned-by-dhcp.cox.net>
	<2cfc4032050514181127c02e43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, David Greaves <david@dgreaves.com>,
	torvalds@osdl.org, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 08:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXCGG-0007FY-T2
	for gcvg-git@gmane.org; Sun, 15 May 2005 08:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVEOGFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 02:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVEOGFu
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 02:05:50 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:23550 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261489AbVEOGFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 02:05:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515060537.TFDG1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 02:05:37 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050514181127c02e43@mail.gmail.com> (Jon Seymour's
 message of "Sun, 15 May 2005 11:11:08 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

JS> Is there value in:

JS> a. pushing the ignore logic into the core git tools such as git-ls-files

When there is an agreed upon Porcelain layer ignore logic,
git-ls-files --others --exclude-from=... should be changed so
that it uses the same file format and same semantics, and
probably use the default ignore file without being explicitly
told.  Otherwise things would get quite confusing, so yes, I see
value in there.

I do not however think this should apply to things like
"git-update-cache --add"; because even though user may say
"git-update-cache --add *" and wish it to ignore things on the
ignore list, that is not how shell parameter expansion works.

I would like to see a git-path-helper command that can act as
filter between "find -print0" and "xargs -0" like this:

    find * -print0 |
    git-path-helper -z --ignore-file=.git/info/ignore |
    xargs -r -0 git-update-cache --add --

I envision that we should not even need --ignore-file parameter,
once we have "an agreed upon Porcelain layer ignore logic".  It
should read the "agreed upon" location, somewhere under the
$GIT_DIR and perform the "agreed upon" filtering logic.

I further envision that this would work from anywhere in the
work tree, not only from the directory that corresponds to the
top of the tree structure GIT_INDEX_FILE describes.  For
example, in linux-2.6 git tree, you _ought_ to be able to say
something like this:

    cd fs
    find ext? ../include/linux -type f -print0 |
    git-path-helper -z |
    xargs -r -0 git-update-cache --add --

The git-path-helper command could internally run getpwd() and
find out the top directory (in this case, the parent directory
of our current working directory "fs"), then canonicalize the
incoming filenames (either relative to getpwd() or the full
filesystem path) to paths relative to the top directory, apply
the ignore filter and send the surviving paths downstream.
Anything downstream driven with xargs -0 would get relative
paths suitable for core GIT consumption.

JS> b. including the current ignore .* rule as a default ignore rule that
JS> can be overridden by a .gitignore file

Knowing the number of places that assume .* are irrelevant, I
would not be looking forward to doing that myself, but that
behaviour would be ideal.


