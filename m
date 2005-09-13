From: Junio C Hamano <junkio@cox.net>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 15:11:42 -0700
Message-ID: <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	<20050913211444.GA27029@mars.ravnborg.org>
	<7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:31:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFJ0F-00035l-Ec
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 00:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVIMWLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 18:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVIMWLp
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 18:11:45 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46236 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932300AbVIMWLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 18:11:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913221142.HDOZ11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 18:11:42 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 13 Sep 2005 14:30:16 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8497>

Junio C Hamano <junkio@cox.net> writes:

> Sam Ravnborg <sam@ravnborg.org> writes:
>
>> Whats wrong using cogito?
>> In other words. Why does you feel like that when we use cogito to do
>> cg-update.
>
> Using cogito is not a problem at all.  The mechanism to prepare
> trees to serve wider audience not being used widely is.

I need to clarify what I meant by 'not welcoming dumb transport'
a bit better.  Namely, those (~80 - 23) = ~57 repositories lack
support for 'git ls-remote' over http, which means you cannot
discover what refs the repository has.

Some people argued that it can be done via recursive wget on
refs/ hierarchy.  Here is what you would get if you do that
against kernel.org:

  $ wget -r -np -nH --cut-dirs=4 http://kernel.org/pub/scm/git/git.git/refs/.
  $ ls -R refs
  refs:
  ./      index.html          index.html?C=N;O=A  index.html?C=S;O=D
  ../     index.html?C=M;O=A  index.html?C=N;O=D  tags/
  heads/  index.html?C=M;O=D  index.html?C=S;O=A

  refs/heads:
  ./          index.html?C=M;O=A  index.html?C=N;O=D  master  todo
  ../         index.html?C=M;O=D  index.html?C=S;O=A  pu
  index.html  index.html?C=N;O=A  index.html?C=S;O=D  rc

  refs/tags:
  ./                  index.html?C=M;O=D  index.html?C=S;O=D  v0.99.2  v0.99.6
  ../                 index.html?C=N;O=A  junio-gpg-pub       v0.99.3
  index.html          index.html?C=N;O=D  v0.99               v0.99.4
  index.html?C=M;O=A  index.html?C=S;O=A  v0.99.1             v0.99.5

Of course, I do not have a branch called index.html there, and
this also means I will not be able to have a branch with that
name even if I wanted to.

Also some webservers are configured not to even allow directory
index, and they may use different formatting for directory index
even when they do support it, so excluding anything that matches
index.html* would work well but that is only heuristics.

The file $GIT_DIR/info/refs was introduced to solve this by
listing the available refs for discovery, and hooks/post-update,
when enabled, runs update-server-info to update the file (among
other things) whenever you push into the repository.  info/refs
is not strictly necessary for repositories at kernel.org because
people tend to know what refs are available for pulling and you
can always visit there via gitweb to find it out.

I just felt that it is a good habit to get into to prepare your
repositories in a shape usable even when served by an HTTP
server that is less forgiving than what kernel.org runs -- that
was what I felt "discouraging" about.

Another thing is that the missing info/refs file means the
repository is not prepared with update-server-info, so it is
likely that it lacks objects/info/packs to describe what packs
are in the object database.  I believe cogito uses git-http-pull
after you tell which ref to pull, and this step would break if
the repository is packed, objects/info/packs is not available,
and if the downloader does not have an object that is already
prune-packed in the repository.  This means either people are
not packing their repository (hence nobody complained), or
public are pulling over rsync transport (which slurps everything
in sight).  Both are good reasons to feel discouraged about.
