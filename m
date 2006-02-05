From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2 questions/nits about commit and config
Date: Sat, 04 Feb 2006 21:43:29 -0800
Message-ID: <7vu0bemkce.fsf@assigned-by-dhcp.cox.net>
References: <20060204212337.GA8612@blinkenlights.visv.net>
	<7voe1mvkls.fsf@assigned-by-dhcp.cox.net>
	<7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
	<1139094055.4200.6.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 06:43:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5cge-0000JH-Dn
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 06:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWBEFnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 5 Feb 2006 00:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWBEFnc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 00:43:32 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23525 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964893AbWBEFnc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 00:43:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205054336.XXRY25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 00:43:36 -0500
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1139094055.4200.6.camel@evo.keithp.com> (Keith Packard's message
	of "Sat, 04 Feb 2006 15:00:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15621>

Keith Packard <keithp@keithp.com> writes:

> making '-a' equivalent to '.' then? Seems like '.' is a whole lot mor=
e
> understandable than '-a', but maybe that's just my na=EFvit=E9 showin=
g
> again. I expected the '-a' flag to commit the whole tree from whereve=
r
> you were inside it...

Good point.

Because I _never_ use 'git commit paths...'  form myself, I
admit that I did not even know that "git commit ."  meant
"commit all the changed files in this directory and under".

But it apparently does ;-).

I would not personally be confused if "cd foo/ && git commit -a"
committed things outside foo/ directory, but I am not sure about
others.

We have had enough discussion on what the "git commit paths.."
semantics should be, and I think we settled most of the issues.
Until this latest "committing from subdirectory" monkey wrench
was thrown into it, that is X-<.

Here is me thinking aloud again.

 - "git commit" without _any_ parameter would keep the current
   behaviour.  It commits the current index.

   We have two choices.  (1) we disallow this form to be run in
   a subdirectory, or (2) we do the whole index even when this
   form was run from a subdirectory.  I am inclined to say the
   latter.

 - "git commit --include paths..." (or "git commit -i paths...")
   is equivalent to:

   	git update-index --remove paths...
        git commit

   So subdirectory semantics depends entirely on what we do for
   the parameterless form.  Also note that we allow --remove but
   never --add; this is what we do for "git commit paths.."
   currently.

 - "git commit paths..." acquires a new semantics.  This is an
   incompatible change that needs user training, which I am
   still a bit reluctant to swallow, but enough people seem to
   have complained.  It

   1. refuses to run if $GIT_DIR/MERGE_HEAD exists (maybe
      remind trained git users that the traditional semantics
      now needs -i flag).
   2. refuses to run if named paths... are different in HEAD and
      the index (ditto about reminding).
   3. reads HEAD commit into a temporary index file.
   4. updates named paths... from the working tree in this
      temporary index (similar to -i form, we never --add).
   5. does the same updates of the paths... from the working
      tree to the real index.
   6. makes a commit using the temporary index that has the
      current HEAD as the parent, and updates the HEAD with this
      new commit.

   The first check is needed because otherwise during a merge
   you would end up inserting an unrelated commit between the
   original HEAD and the eventual merge result.  The second
   check is to prevent "skewed commit" from confusing people.
   If you updated index, modified the file further and then used
   "git commit paths..." to make a commit, next "git commit"
   without paths would record a partial revert otherwise.

   For this one, I think running from subdirectory is a natural
   thing to allow.

 - "git commit --all".  Now what should we do about this?  As
   you reminded me, it is equivalent to "git commit -i ." if run
   from the toplevel (because of the "index must match HEAD on
   named paths" requirements for the partial commits with named
   paths, it is equivalent to "git commit ." only if your index
   is clean).  I am inclined to say that this should commit all
   changes in the whole working tree, regardless of where it is
   run.
