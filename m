From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git as a versioned filesystem
Date: Fri, 2 Oct 2009 14:11:37 -0400
Message-ID: <32541b130910021111p64ddd35aia503a3de7f473b99@mail.gmail.com>
References: <20091002164929.GA12725@perlcode.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Scott Wiersdorf <scott@perlcode.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 20:12:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtmbr-00039f-MQ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 20:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbZJBSLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 14:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZJBSLy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 14:11:54 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:55223 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbZJBSLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 14:11:53 -0400
Received: by yxe37 with SMTP id 37so1391085yxe.33
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=QF9pDu9rdR6BfLuCrFGGkK+aCCK1j4D/iy4d8ZNKYKI=;
        b=etqpxZyZLAwFih07vvCJJvgrCx17/0jPSNXL5rDJyCgO86fY5bT18xdL3dII+HKe1+
         Ymsc2gAuqBFBNColfBY6rVwKFXWauq6Yob6WUNNkLXu88B96iqW4VgNwHG++uHVzT2lK
         MoEnP15QuqkUbhoAk4kgRhE98LMH6pr1/8Mz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=DxglVtlxkKhzNjJMaSUzWTZDx1NSuzhwPRJ6UmvgfT5rA8cRUH6Ywg4cSLJKAR2nF+
         lsUc/WuJxVjK/G6FpQbom7YZ15IorPuVZFrNt9WxmtndPpryjoijmFUl8MGSIpILRrBd
         TOmWPpudHTel14UD/oW0HrYyXXML0dcSZMCts=
Received: by 10.151.5.8 with SMTP id h8mr4897421ybi.10.1254507117142; Fri, 02 
	Oct 2009 11:11:57 -0700 (PDT)
In-Reply-To: <20091002164929.GA12725@perlcode.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129452>

On Fri, Oct 2, 2009 at 12:49 PM, Scott Wiersdorf <scott@perlcode.org> w=
rote:
> Git seems like the perfect tool for this, but I'm still not sure how
> to adapt it to our situation. I'm building a tool that uses git to le=
t
> the developers commit their binary changes to this master image into
> the git repository, which hopefully will allow me to offer the QA tea=
m
> some ability to cherry-pick updates or revert regressions and make a
> clean dist image from week to week.

Beware that git performs rather badly on binary files, especially huge
ones, which it tries to load entirely into RAM.  It also keeps every
revision of every file that was ever committed (and every user who
checks it out needs to download the whole thing), so your giant binary
repository is going to get very big, very fast.

I've looked into using git for this kind of situation myself.  It's
close, but not quite there (for my purposes anyway).  It basically
just needs some optimizations and some improved support for "shallow
clones."

But on to your actual question:

> But now it's a few weeks later and we're ready to do another
> dist. What I *want* to do is create a *copy* of branch B1 to give the
> release manager a reference point for him to bring things up to
> date. What is the best way to do that?
>
> If I branch off of B1, now I have the burden of doing a whole lot of
> cherry-picks and having a challenging time getting things back in syn=
c:
>
> -----a----b--T1-------c--------d-e---f------g [master]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 \ =A0 (a) =A0\ =A0 =A0 =A0 =A0 \ =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0----|----c'--- =A0 =A0 \ =A0 \ =A0 =A0=
 =A0[B1]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \ =A0 =A0=
\ =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-----e=
'--f'---[B2]
>
> Ugh. Now B2 is kind of a mess. If I rebase it on master, I'll get (d)
> and maybe (a) again, which I don't want. [side question: unless
> there's a way to rebase on master but still exclude
> commits... possible?]. B3 and B4 are going to look even worse and the
> risk of drifting so far away from the master is unappealing.

If you rebase your "release" changes onto current master, you'll get
the revert-a patch applied, so (a) will still be gone.  Rebase will
also probably be smart enough to throw away c', since it's identical
to (c).  You will indeed end up with the unwanted (d), but you can
just revert that in B2.

> Ideally I'd want each week's release to come directly from the master=
,
> kind of the flying-fish approach:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ----e'--f=
'--- =A0[B2]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 / =A0 =A0/ =A0=
 /
> -----a----b--T1-------c--------d-e---f------g [master]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 \ =A0 (a) =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0----|----c'--- =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0[B1]
>
> The problem with this is that now B2 contains (a), so I'll have to
> revert that again--which I can do happily--but I just wonder if
> there's a better way. If it's possible to simply *copy* branch B1 to
> B2 without making B2 a branch off of B1.

"revert-a" is a patch on its own.  Git doesn't think of reverting (a)
as anything special; it's just a change that happens to reverse what
(a) does.  So if you rebase B1 onto master, it will get copied.  It
sounds rebase will produce exactly the results you're looking for
here.

Now, that said, this release process seems extremely suspicious to me.

To summarize what I'm hearing: you have a 'master' branch that people
put stuff into, but which doesn't actually work correctly.  At the
last minute before a release, you make a new branch, drop out the
stuff that doesn't work, and put it into production.

This sounds problematic.  If (a) and (d) don't work, why are they in
master at all?  Git makes branching really easy: get people to put
their not-quite-working features into a different branch, and let the
release manager merge those branches into master when they're actually
ready.

If you do that, you'll always be releasing straight out of master, and
your life will be a lot simpler.  And if you "merge --squash" from the
feature branches into master, you can throw away the interim versions
of the feature branches, which should help keep your repository from
growing so quickly with tons of binary file revisions that never even
got released.

> =A0## is there way besides rebase to clean out a revert as if it neve=
r
> =A0## happened? I suppose I could branch again and repeat this as
> =A0## needed.

You probably want "git revert -i".

Have fun,

Avery
