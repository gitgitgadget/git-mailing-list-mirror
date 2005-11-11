From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Fri, 11 Nov 2005 10:37:03 -0800
Message-ID: <7v64qzni9c.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<43730E39.6030601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 19:38:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eadlu-0005Xz-9z
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 19:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVKKShG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 13:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVKKShG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 13:37:06 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48285 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750998AbVKKShF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 13:37:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111183635.FACI9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 13:36:35 -0500
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <43730E39.6030601@pobox.com> (Jeff Garzik's message of "Thu, 10
	Nov 2005 04:09:13 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11625>

Jeff Garzik <jgarzik@pobox.com> writes:

> Junio C Hamano wrote:
>>  - One important newcomer is git-pack-redundant...
>
> IMHO git-prune-packed should prune redundant pack files...

Maybe not in git-prune-packed, but you are right.  We should at
least do that in git-prune.  Maybe with something like the patch
at the end?

>> Oh, and we will not be moving things out of /usr/bin/ during 1.0
>> timeframe.
>
> :(  bummer.  I do like the elegance of having /usr/bin/git executing 
> stuff out of /usr/libexec/git.

Bummer here as well.  This is not my first preference, but more
or less "all things considered...".  I can go over cogito and
stgit with Pasky and Catalin and coordinate the transition, but
at the same time, everybody's existing scripts need to be
adjusted.  As Linus said, we broke kernel.org snapshot scripts
number of times.

Also places we execute git-upload-pack and git-receive-pack over
an SSH connection need to be updated to execute 'git' with the
first parameter 'upload-pack' and 'receive-pack' to make sure it
would keep working with older or newer git on the other end.

After all that happens, we can start installing things in
/usr/lib/git/.  During the transition, the C rewrite of git
wrapper posted by Andreas Ericsson might help, so I am planning
to merge it before 1.0, after deciding what the right word for
the "path to the rest of git executables" should be.

So let's say 1.0 will ship with all things in /usr/bin/, with
updated docs that explain the situation: (1) the dash form
'git-frotz' is being deprecated, and you are encouraged to spell
it as 'git frotz'; (2) if you want to use the dash form in your
scripts for performance reasons, you need to have something like
PATH="$(git --exec-path):$PATH" at the beginning of your script.

And after some time (say 2 months) we can switch.

I just do not want to wait that long before 1.0.

-- >8 -- cut here -- >8 --
[PATCH] git-prune: prune redundant packs.

---
diff --git a/git-prune.sh b/git-prune.sh
index ef31bd2..aa79807 100755
--- a/git-prune.sh
+++ b/git-prune.sh
@@ -27,3 +27,14 @@ sed -ne '/unreachable /{
 }
 
 git-prune-packed $dryrun
+
+redundant=$(git-pack-redundant --all)
+if test "" != "$redundant"
+then
+	if test "" = $dryrun
+	then
+		echo "$redundant" | xargs rm -f
+	else
+		echo rm -f "$redundant"
+	fi
+fi
