From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: branch.<branch>.merge and --format='%(upstream)'
Date: Tue, 16 Jun 2009 16:07:50 +0200
Message-ID: <adf1fd3d0906160707m713d9fe0l966d14c0e0af9127@mail.gmail.com>
References: <adf1fd3d0906160408s668f7a3fj5725cc4e98b317fc@mail.gmail.com>
	 <20090616122312.GB5227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 16:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGZKS-0002C9-FD
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 16:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbZFPOHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 10:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbZFPOHt
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 10:07:49 -0400
Received: from mail-fx0-f211.google.com ([209.85.220.211]:49764 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbZFPOHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 10:07:48 -0400
Received: by fxm7 with SMTP id 7so669908fxm.37
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 07:07:50 -0700 (PDT)
Received: by 10.204.67.66 with SMTP id q2mr8320218bki.161.1245161270105; Tue, 
	16 Jun 2009 07:07:50 -0700 (PDT)
In-Reply-To: <20090616122312.GB5227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121681>

2009/6/16 Jeff King <peff@peff.net>:
> On Tue, Jun 16, 2009 at 01:08:02PM +0200, Santi B=E9jar wrote:
>
>> =A0 I've noticed that having branch.<branch>.merge set with the bran=
ch
>> name, and not with the full ref, cause problems with
>> --format=3D'%(upstream)' =A0and also with the "branch -av" and "git
>> status" upstream branch outputs. But git-fetch and git-pull works ok=
,
>> so it is a valid setting.
>
> Actually, it is broken in a lot of places. for-each-ref relies on the
> same code as "git status", "git checkout", etc, which will all fail t=
o
> display tracking info. I believe the same code is also used for updat=
ing
> tracking branches on push. So I'm not sure if it was ever intended to=
 be
> a valid setting.
>
> Fixing it would involve tweaks to remote_find_tracking, I think, but =
I
> haven't looked into it too closely.

It should be interpreted as "git pull branchname" does, or at least as
close as possible.

Another non-working example is with:

remote.origin.fetch=3D+master:refs/remotes/origin/master
branch.master.merge=3Drefs/heads/master

so it looks like that both have to match for remote_find_tracking to
work (and in this case "git fetch" also works ok).

I suppose that remote_find_tracking should DWIM: build the full ref
prepending refs/ and heads/, as necessary.

>
> I'm not sure of the impliciations of allowing non-qualified refs in t=
hat
> config.

They are currently allowed (fetch/pull) since a long time, and it is
not only this config, but also remote.<remote>.fetch (see above).

In b888d61 (Make fetch a builtin, 2007-09-10):

commit b888d61c8308027433df9c243fa551f42db1c76a
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Tue Sep 11 05:03:25 2007

[...]

    This changes a few small bits of behavior:

    branch.<name>.merge is parsed as if it were the lhs of a fetch
    refspec, and does not have to exactly match the actual lhs of a
    refspec, so long as it is a valid abbreviation for the same ref.

[...]


> Will we detect and warn about ambiguities? Does it actually work
> with non-branches?

With tags yes, but full qualified.

Santi
