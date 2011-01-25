From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git repo on a machine with zero commits is ahead of remote by 103
 commits.. !
Date: Tue, 25 Jan 2011 02:23:05 -0500
Message-ID: <AANLkTinC7yvHJj_onRRWBYaZ23Pvs0JB2DJT44Jy-JLG@mail.gmail.com>
References: <AANLkTikj06sjTbNd8afk9cY2=_Hy+kT+J1NCjR-fKP5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Srirang Doddihal <om.brahmana@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 25 08:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhdNO-0004P9-CV
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 08:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab1AYHbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 02:31:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57624 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab1AYHbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 02:31:36 -0500
Received: by iyj18 with SMTP id 18so4797414iyj.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=mNP5HcwOi13aZPcRsNoVsFRKYUPee9TvpZ26WYZICzM=;
        b=bMPoz8RmRnoOF1Nhbc1uze3QOAMAeW1yjYmf8n6tMFFVPqrhgR3DbAR4ifGpJw5ocu
         /lDv19JqbunxLT6o+VxxKQ+UaqAZdLPfI+FnP7lAuSjN7eRFTg9p+0Ot1gn0JBSZa+Ni
         +Ep/5UV/0oC32myISN2fXM9S2Z8ov+8RbglqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qBQtVSPkwMYjZtbc8VS9aJ/cjE6PMto9xJGneYCqdn8hNHHbm/0qcpwHhHdTOMVhcI
         tCoVPVHi5D7fwg1kLprpi90cCj2WLmmmONb86KZong8cbzHt0V5Ka5zakenU8G57hIMi
         L/XLU4YNc1ztAmSuOl+0MPX+ep11qTI/cVe7o=
Received: by 10.231.34.205 with SMTP id m13mr5998921ibd.184.1295940215172;
 Mon, 24 Jan 2011 23:23:35 -0800 (PST)
Received: by 10.231.167.78 with HTTP; Mon, 24 Jan 2011 23:23:05 -0800 (PST)
In-Reply-To: <AANLkTikj06sjTbNd8afk9cY2=_Hy+kT+J1NCjR-fKP5J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165470>

On Tue, Jan 25, 2011 at 12:48 AM, Srirang Doddihal
<om.brahmana@gmail.com> wrote:

> 1) Why does "git status" =C2=A0say that the local repo on the deploye=
d
> machine (where no commits are made) is ahead of the remote by 103
> commits? (This number, 103, increases with every "git pull origin
> master" and very likely the change is equal to the number of commits
> pulled)

git status is comparing refs/heads/master, aka master, to its
remote-tracking branch, refs/remotes/origin/master, aka origin/master.

master is ahead of origin/master because you've been updating the
former but not the later, with your pull invocation.

> 2) Why is "git log orign/master" stuck at a Jan 8th commit?

Because you've been saying "git pull origin master", git has been
doing the following:

- contacting origin and fetching all commits in its master not in your
local repo
- locally updating FETCH_HEAD with the results of that fetch
- performing a merge operation of FETCH_HEAD into your local master
- because you haven't made any local commits, that is a fast-forward op=
eration
- updating your work tree

However, git is not updating your remote-tracking branch (origin/master=
).

> * How can I set these right?

Just do a "git pull" or "git pull origin". By not explicitly giving
pull a branch, it consults two configuration variables in your
=2Egit/config for the currently checked out branch to figure out what
you want it to do, namely:

  branch.master.remote
  branch.master.merge

Also in this case, it updates the origin/master remote-tracking branch.

(I think there has been previous discussion about this behavior - it
seems broken to me that "git pull <remote> <branch>" doesn't update
the corresponding remote-tracking branch <remote>/<branch> in the case
where "git pull [<remote>]" would normally do so according to that
repo's .git/config.)

j.
