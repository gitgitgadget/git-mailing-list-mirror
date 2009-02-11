From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add automatic git-mergetool invocation to the new infrastructure
Date: Wed, 11 Feb 2009 10:20:28 +0100
Message-ID: <20090211092028.GC26136@diana.vm.bytemark.co.uk>
References: <20090210141157.28782.10027.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:22:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBI9-0000Hv-NC
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbZBKJUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 04:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbZBKJUd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:20:33 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:57927 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbZBKJUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:20:32 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LXBGe-000737-00; Wed, 11 Feb 2009 09:20:28 +0000
Content-Disposition: inline
In-Reply-To: <20090210141157.28782.10027.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109388>

On 2009-02-10 14:14:07 +0000, Catalin Marinas wrote:

> with the classic implementation is that mergetool is no invoked from =
the

now?

> I'm still not entirely sure where the check for stgit.autoimerge
> should be done. In the classic infrastructure, it is done in the
> merge function. With this patch, it is done in Transaction.push().
> Should we push this even further to stgit.commands.push? My opinion
> is not since by having it in Transaction we get the advantage not
> listing the conflicts if the mergetool succeeds and we don't need to
> abort the transaction.

Yes, one advantage of having it here is that if the user resolves the
conflict, we can just continue. I'm not sure I personally like that
mode of operation -- you might have guessed by now that I like
noninteractive mechanisms -- but I can see how it's useful to someone
who does.

Another advantage of having it here is that it automatically just
works for all commands, not just "stg push".

The disadvantage that I see is that we ask the user to put work into
resolving conflicts before we've made sure that we won't roll back the
whole transaction. If this is to become a dependable feature, we need
a way to make sure we'll never throw away the user's work.

> --- a/stgit/lib/git.py
> +++ b/stgit/lib/git.py
> @@ -842,6 +842,12 @@ class IndexAndWorktree(RunWithEnvCwd):
>                  raise MergeConflictException(conflicts)
>          except run.RunException, e:
>              raise MergeException('Index/worktree dirty')
> +    def mergetool(self, files =3D []):
> +        """Invoke 'git mergetool' on the current IndexAndWorktree to=
 resolve
> +        any outstanding conflicts."""
> +        err =3D os.system('git mergetool %s' % ' '.join(files))
> +        if err:
> +            raise MergeException('"git mergetool" failed, exit code:=
 %d' % err)
>      def changed_files(self, tree, pathlimits =3D []):
>          """Return the set of files in the worktree that have changed=
 with
>          respect to C{tree}. The listing is optionally restricted to

This is the right place for this method. But what happens if "files"
isn't specified -- do we operate on all files then? The method
documentation should probably say this.

(Small style tip: In Python, you're free to mutate the default values
of your arguments, and those changes will be visible the next time you
call the funtction. You don't change "files" in this function, but
it's probably still a good idea to make the default value an immutable
type, such as tuple.)

The rest of the patch looks good to me (with the roll-back caveat I
mentioned above).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
