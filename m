From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Pushing a git repository to a new server
Date: Mon, 11 Feb 2013 16:45:18 +0400
Message-ID: <20130211164518.ad0a21aff672ad0e4f03a6bb@domain007.com>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
	<20130211075040.GJ5210@localhost.localdomain>
	<CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	git <git@vger.kernel.org>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 13:45:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4slY-00031P-09
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 13:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915Ab3BKMpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 07:45:24 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:44711 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab3BKMpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 07:45:23 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r1BCjJjN000869;
	Mon, 11 Feb 2013 16:45:20 +0400
In-Reply-To: <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216030>

On Mon, 11 Feb 2013 02:57:51 -0500
Ethan Reesor <firelizzard@gmail.com> wrote:

[...]
> I want to create a git-command that 1) creates a bare version of the
> current repo, 2) and uploads it to the specified path on my server
> (using tar, but that's not the point).

Thanks, it's now a bit more clear.

> My problem is that I have no idea how things like git-push works via a
> user with git-shell. Can you only run certain git commands, like
> git-upload-pack?
[...]

Precisely so.  With additional twist that you can create (or link)
other commands under ~/git-shell-commands, and these will be available
as well.

OK, here's the sketch.
On the server, in the home directory of your "git" user, you create a
wrapper around git-receive-pack, like this:

# mkdir ~git/git-shell-commands
# cat >~git/git-shell-commands/git-receive-new-repo
#!/bin/sh

set -e -u

if [ $# -ne 1 ]; then
        echo 'Missing required argument: <directory>' >&2
        exit 1
fi

mkdir "$1" && git init --quiet --bare "$1" && git-receive-pack "$1"
^D
# chmod +x $_

Then, on the client side, to push a new repo, you just do

$ git push --receive-pack=git-receive-new-repo --all git@server:repo.git

This will make `git push` to spawn not just `git receive-pack <dir>` as
it usually does but your wrapper, which would first create and
initialize a bare repository and then spawn `git receive-pack` on it
which would then communicate with the client side and receive
everything from it.

You could then create a client-side wrapper script or a Git alias for
such "creative pushing", like this:

$ git config --add --global alias.push-new-repo \
  'push --receive-pack=git-receive-new-repo --all'

So the whole client call is now reduced to

$ git push-new-repo git@server:repo.git
