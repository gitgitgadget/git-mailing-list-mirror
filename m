From: lennart spitzner <len48@web.de>
Subject: bug report: `git stash save -u` deletes directory whose contents are
 .gitignored
Date: Wed, 14 Oct 2015 00:48:03 +0200
Message-ID: <561D8A23.2090601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 00:48:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8NA-0001m9-P8
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 00:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbJMWsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 18:48:40 -0400
Received: from mout.web.de ([212.227.15.3]:65175 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbbJMWsj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 18:48:39 -0400
Received: from [192.168.178.21] ([77.6.117.61]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MMnD5-1Zeimx26L1-008aET for <git@vger.kernel.org>; Wed,
 14 Oct 2015 00:48:36 +0200
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
X-Provags-ID: V03:K0:AwX1CggMGFNrm87khMZM62uM/raej2fToPFMd2tU4vkVVLQXhxs
 uUjUqMGO9gzCyJTZWZhSSCnV4dNlUsmMuwuSfwyreohBmoVpPXNbTBkBavqIpYTl7e/9hNR
 Fz6hfLV9KA/W3gTREK+02PTF/xD5P6xNZdgxGJcN3nl7uJwfktgk6wdaWj+6C2DKHmEsk9P
 ttj/cGgsUxfWs7/yJ/N/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FVsaWRfUBZ4=:ayE7WarYvg6YDutqFBLyfH
 vZNIRj1dSoK5LwcBA8xgifvz4T6c9k1/rgVsPM2Ma9kwiY2k8TQ6lS8adI6zULXfg9JiJKgBd
 vPcW98AupA4W6hgAOPN0qQdoVfQMutrSJ7Ic5gS34y4N48zTN3wlWeiRhU0NGuE9flMllfEHJ
 hWm38FGLHJ7B/Tc9MJg/AuPK/T1hN8DSyC0kixN2ED66Uhjdwxh1cdB6QTcTzUvnTs3v01bu9
 11I3L3Zr10R7T/r1vguDhkt/3CZrRdcafVM1sRTTt6ATt0gzF9KtsTIQE2H6hitrHJjD6qzTr
 z5QUFs/fLlvP7PSkXHk/c5m7iT/i/zr70YtUw8EeOFC36lSe9MK2qp9bLl9qIubiaolYpT0XO
 j5pr7/0zRTr3gs51I4a6dXgGGC3xRunwdWhanPQCMui2LbjfLZH1gYzOZCbZpIJ+++xiFQzqk
 EDJ1mHZObzQPt7H78WxHgqwVTiCwfdnQEbHBbzEGnANbd+IYEuB7V+FW/LctOYxq79UXgIkSm
 GXnOFhy/9WhUVOas8EkH8EKXxRqyfX8BIZCFLBrRe+MB6x3+ja1lVTa9HjMXryel6aLYQnsyj
 nbnvshM+LdW7wNMev3VD/3K+oiwEpPPe2ljhY54y/DXh+1whfGq0x+XrcVf7f/hMH+Aj0+0lw
 rUlMXUKHcjjEb8IGEFVk0J96I+KNVEhKvdsefU8f81YhlsjApBcW5myli1eFpZDsOZVKUCR0v
 tSKxN2nz9kQq/ilHlSwqlwBFSUee5QicD0tMCZQcLJoXU9FYRbmNU/M7AvO72OLjyDciE2l4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279527>

hi,

- `git stash save -u` deletes a directory, even though the _contents_
of that directory are .gitignored (e.g. "foo/*" in .gitignore).
Detailed reproduction below.
- The behaviour is not present when instead .gitignoring the directory
itself (e.g. "foo"). This does imo not excuse the behaviour of the
described case.
- The behaviour is not present with just `git stash save`.
- The expected behaviour is: Only files listed in `git status` are
stashed away; other things are left untouched. Potential exception:
empty directories.
- I am aware that `git stash save -u` is supposed to have semantics
involving the equivalent of `reset --hard` and `clean -f`. Neither of
those expose the directory-deletion behaviour.

additional comments, not directly relevant to this bug:
- both `git stash save; git stash pop` and `git stash save -u; git
stash pop` should ideally behave as an "identity effect". The latter
might affect the index (i.e. have an effect equivalent to `git reset`
or something in that direction). Any other effect / special cases are
bad interface design imo. If a differing design was chosen on purpose,
i am thankful for pointers on the reasoning.
- no, i luckily did not truely lose files due to the current behaviour.

lennart

----

reproduction:

> git init
Initialized empty Git repository in $SOMEDIR/.git/
> mkdir ignore-contents
> echo "ignore-contents/*" > .gitignore
> git add .gitignore
> git commit -m "initial" > /dev/null
> touch ignore-contents/blah.txt
> touch abc.txt
> git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

  abc.txt

nothing added to commit but untracked files present (use "git add" to
track)
> ls -1a
.
..
abc.txt
.git
.gitignore
ignore-contents
> git stash save -u
Saved working directory and index state WIP on master: adc468b initial
HEAD is now at adc468b initial
> ls -1a
.
..
.git
.gitignore
> git stash pop &> /dev/null
> ls -1a
.
..
abc.txt
.git
.gitignore
> git --version
git version 2.6.1
