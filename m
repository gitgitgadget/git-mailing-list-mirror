From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 16:28:26 +0100
Message-ID: <EA6D22B6-CB49-439C-B31B-AE145B22BB35@wincent.com>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218105941.GA17251@albany.tokkee.org> <Pine.LNX.4.64.0712181231420.23902@racer.site> <4767D7A2.30703@op5.se>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Harl <sh@tokkee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4eVr-0006Kt-69
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758574AbXLRPgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 10:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757747AbXLRPgw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:36:52 -0500
Received: from wincent.com ([72.3.236.74]:33370 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757715AbXLRPgv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 10:36:51 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBIFSSQN025802;
	Tue, 18 Dec 2007 09:28:28 -0600
In-Reply-To: <4767D7A2.30703@op5.se>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68762>

El 18/12/2007, a las 15:22, Andreas Ericsson escribi=F3:

> Johannes Schindelin wrote:
>> Hi,
>> On Tue, 18 Dec 2007, Sebastian Harl wrote:
>>> On Mon, Dec 17, 2007 at 04:31:12PM -0800, Junio C Hamano wrote:
>>>> But the original point by Sebastian hasn't been answered.  He =20
>>>> wanted to make the command list the stash without arguments.
>>>>
>>>> This was discussed already in the early days of stash and there =20
>>>> indeed was a suggestion to do so (I think I sided with that), but =
=20
>>>> the users did not want it.  IIRC, the argument went like: "when I =
=20
>>>> say 'stash', that is because I want a quick and immediate way to =20
>>>> stash, and I do not want a list.  If I do not have to have a =20
>>>> quick way, I would create a temporary commit on the current =20
>>>> branch, or switch to a temporary branch and commit there."
>>> Well, "git stash save" is just five characters more - I really =20
>>> don't see why this would be less comfortable (and for the really =20
>>> lazy people there are still aliases...). On the other hand (if =20
>>> "list" is the default), we'd get a more consistent interface which =
=20
>>> imho is imho more important than typing five characters less.
>> It's more about what you're used to.  I had an alias named 'stash' =20
>> long before it became a git command.  And now guess how _annoying_ =20
>> it would be to type "git stash<Return><Curse out loud at my =20
>> mouse>git stash save<Return>".
>
> Not nearly as annoying as losing work because of it, and you obviousl=
y
> *know* what to do when you're done cursing, while clueless-newbie-X =20
> just
> hops away and uses subversion.

There's not really any peril of losing work here, seeing as this =20
should be a lossless round trip:

git stash
# oops! didn't mean to save
git stash apply

We could help clueless-newbie-X here by augmenting the save output:

   Saved "WIP on master: 8ed8a26... s"
   HEAD is now at 8ed8a26... s

As follows (or similar):

   Saved working directory and index state "WIP on master: 8ed8a26... s=
"
   (To restore them type "git stash apply")
   HEAD is now at 8ed8a26... s

ie. we explicitly tell them what was saved (their working directory =20
and index state), and also how to get it back immediately if that's =20
not what they meant to do. Something like this (no doubt will be =20
whitespace-mangled because I'm pasting this into my email client, but =20
it's just to demo the idea):

diff --git a/git-stash.sh b/git-stash.sh
index f16fd9c..a2f3723 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -99,7 +99,8 @@ save_stash () {

         git update-ref -m "$stash_msg" $ref_stash $w_commit ||
                 die "Cannot save the current status"
-       printf >&2 'Saved "%s"\n' "$stash_msg"
+       printf >&2 'Saved working directory and index state "%s"\n' =20
"$stash_msg"
+       echo >&2 '(To restore them type "git stash apply")'
  }

  have_stash () {

Cheers,
Wincent
