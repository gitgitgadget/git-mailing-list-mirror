From: greened@obbligato.org
Subject: Re: Subtree in Git
Date: Mon, 11 Jun 2012 20:30:13 -0500
Message-ID: <87bokpxqoq.fsf@smith.obbligato.org>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Herman van Rink <rink@initfour.nl>,
	Junio C Hamano <gitster@pobox.com>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 04:01:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeGQU-0000p5-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 04:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab2FLCBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 22:01:42 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:37526 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751856Ab2FLCBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 22:01:41 -0400
X-Greylist: delayed 1514 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2012 22:01:41 EDT
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SeG2y-00035s-1Z; Mon, 11 Jun 2012 20:37:28 -0500
In-Reply-To: <nngaa0z3p8b.fsf@transit.us.cray.com> (dag@cray.com's message of
	"Wed, 23 May 2012 10:13:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  <dag@cray.com> writes: > <dag@cray.com> writes: > >>> Its
   now available as https://github.com/helmo/git/tree/subtree-updates >>> The
    subtree merge version is still available as >>> https://github.com/helmo/git/tree/subtree-updates-merged
    >> >> Cool. I'll take a look, probably Wednesday at the earliest. > > Ack.
    Sorry, I got sidetracked by home repair issues. This is still on > my radar.
    Just wanted to let you know I haven't forgotten. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name            
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199757>

<dag@cray.com> writes:

> <dag@cray.com> writes:
>
>>> Its now available as https://github.com/helmo/git/tree/subtree-updates
>>> The subtree merge version is still available as
>>> https://github.com/helmo/git/tree/subtree-updates-merged
>>
>> Cool.  I'll take a look, probably Wednesday at the earliest.
>
> Ack.  Sorry, I got sidetracked by home repair issues.  This is still on
> my radar.  Just wanted to let you know I haven't forgotten.

Ok, I FINALLY got a look at this (yay!).  Some comments:

Can you put each of these changes in its own commit?

    Collected subtree updates
    
    These include:
     * a .gittrees file with meta data
     * new sub commands (push-all, pull-all, from-submodule, prune, diff, list)
     * Documentation updates

It's hard to tell what's what with one big diff.  Each command should
get its own commit plus more if infrastructure work has to be done.  I
realize it's a bit of a pain to reformulate this but git rebase -i makes
it easy and the history will be much better long-term.

Each command should be described briefly in the commit log.

Some questions/comments:

- Is .gittrees the right solution?  I like the feature it provides but
  an external file feels a bit hacky.  I wonder if there is a better way
  to track this metadata.  Notes maybe?  Other git experts will have to
  chime in with suggestions.


+               # this is ugly, but I don't know of a better way to do it. My git-fu is weak.
+               # git diff-tree expects a treeish, but I have only a repository and branch name.
+               # I don't know how to turn that into a treeish without creating a remote.
+               # Please change this if you know a better way!

- Anyone know a better way?  :)


+               if [ $# -eq 1 ]; then
+                       repository=$(git config -f .gittrees subtree.$prefix.url)
+                       refspec=$1
+               elif [ $# -eq 2 ]; then
+                       repository=$1
+                       refspec=$2
+               else
+                       repository=$(git config -f .gittrees subtree.$prefix.url)
+                       refspec=$(git config -f .gittrees subtree.$prefix.branch)
+               fi

- This code seems to be repeated a lot.  Maybe it should be a utility
  function.


<more>
+check_not()
+{
+       echo
+       echo "check: NOT " "$@"
+       if "$@"; then
+               echo FAILED
+               exit 1
+       else
+               echo ok
+               return 0
+       fi
+}
+
+check_equal()
+{
+       echo
+       echo "check a:" "{$1}"
+       echo "      b:" "{$2}"
+       if [ "$1" = "$2" ]; then
+               return 0
+       else
+               echo FAILED
+               exit 1
+       fi
+}
<more>

- I removed all this stuff in favor of the test library.  Please don't
  reintroduce it.  These new tests will have to be rewritten in terms of
  the existing test infrastructure.  It's not too hard.

I like the features introduced here.  The code and tests need a bit of
cleanup and they really should be split into multiple commits.

Thanks for working on this!

                                   -Dave
