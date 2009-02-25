From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: git push
Date: Wed, 25 Feb 2009 23:58:26 +0100
Message-ID: <20090225225826.GA13510@pvv.org>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com> <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 00:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcSjs-0006G3-OB
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 00:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905AbZBYW6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 17:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbZBYW6f
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 17:58:35 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:47674 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbZBYW6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 17:58:34 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LcShu-0000zb-AH; Wed, 25 Feb 2009 23:58:26 +0100
Content-Disposition: inline
In-Reply-To: <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111509>

Sorry to people receiving this mail twice, the list ate my first reply
since it managed to hit the spam-filter (maybe I should take a hint... :)

On Tue, Feb 24, 2009 at 11:01:38PM -0800, Junio C Hamano wrote:
> [...]
>
> But if you are talking about changing the default when "git push" is run
> without any parameter, I have to say it is a terrible idea, for two
> reasons, and one is too obvious to state so I wouldn't repeat it and talk
> only about the other one.

The current default behaviour of git push is very annoying for us at
least. The current behaviour is _dangerous_ and leads to serious
problems. It is too easy for someone to write "git push". They hit
enter too soon, or they write it expecting to get usage
information. They do not necessarily expect to overwrite random
branches in a remote repository.

Most git commands are not destructive with no arguments at all, and
push is the _only_ command that really can screw things up for others,
so this command in particular should refrain from destructive default
behaviour.

An example of random branch overwriting:
$ mkdir a
$ cd a
$ git init
$ echo contents > file
$ git add file
$ git commit -m message
$ cd ..
$ git clone a b
$ cd b
$ git checkout -b gif-support
$ echo foo > somefile
$ git add somefile
$ git commit -m message
$ ( cd ../a && git branch gif-support) # Assume done by someone else
$ git checkout master
$ # <hack away, maybe commit a bit>
$ git push  # <-- OOOPS! pushes gif-support!

Notice that what branches git push ends up pushing is out of your
control, since new branches can appear in the remote repository at any
time. This is very unfriendly in our setup with a shared incoming repo.

If developer A creates "gif-support", shares it with developer B, who
does an additional commit on it to make it print more debug info (but
has no intent of pushing it anywhere), and A pushes it to the "incoming"
repo, developer B risks overwriting that with his debug version.

It is not realistic to believe that in a big project with many
developers, no one will ever do the mistake of typing "git push".  It
is also not realistic to believe that everyone will know how to (or
remember to) configure this away.

> If you shoot for the least damage for such people, the sanest default for
> "git push" would be to do nothing.  You *always* say what to push where,
> then there is no risk of pushing something you did not intend to.  Perhaps
> "push.default = never" configuration may not be such a bad idea?

If "git push" could do nothing at all without configuring anything, that
would be a big improvement to us.

- Finn Arne
