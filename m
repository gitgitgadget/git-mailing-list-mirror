From: Elijah Newren <newren@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Sat, 5 Feb 2011 07:21:23 -0700
Message-ID: <AANLkTi=J+oTE6RoVgziGfwNzkqgRe0yNJB0RVqdWegyc@mail.gmail.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
	<201012170254.13005.trast@student.ethz.ch>
	<9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com>
	<20101217030855.GB7003@burratino>
	<AANLkTi=-0Sj9c5b778jchn+pgw26xCbioQ2K4tNgtm_G@mail.gmail.com>
	<010EA68F-6122-47C7-B761-7D786F37B0C6@irridia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 15:31:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PljAN-0006DO-RX
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 15:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab1BEOav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 09:30:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47998 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1BEOVZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Feb 2011 09:21:25 -0500
Received: by fxm20 with SMTP id 20so3392919fxm.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 06:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j9MM+5mcCVr8oAfoVq660tzBCCBVjjlIF2F9zVw7eeo=;
        b=wVw/A3u0hiBZwYsF/x7HWkSmBp/wevlREUdNv7KFXmyI6I9WBAVmU8AWhk63HPrVU8
         tN/FUPBUtGNFC2+d8gw/wN90vCq8qOIjCOJXc/IpjFputSLC0U04TF7Z/pJvTYFtkDBW
         kBI/A7ioC3CRIPscam+fdbyiNP+suSDlnaTuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DKOx0iYxMrfTBPz8spA3vXrKS5E+qVN0J1ixsDsfO1uMZF3zkY7lGbhNYsDJY4mEbJ
         jKyYTW8XASF6364DQmN0cmqYz67u5nwhxvevlpN+cRA0VH3ZhLPriCnNWaVzytBIcFJx
         CFQzeK4jb3323DBVx9f2CZ6EeFlC3DRNK68W8=
Received: by 10.223.87.78 with SMTP id v14mr6190425fal.80.1296915683670; Sat,
 05 Feb 2011 06:21:23 -0800 (PST)
Received: by 10.223.134.65 with HTTP; Sat, 5 Feb 2011 06:21:23 -0800 (PST)
In-Reply-To: <010EA68F-6122-47C7-B761-7D786F37B0C6@irridia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166096>

Hi,

On Fri, Feb 4, 2011 at 2:17 PM, Ken Brownfield <krb@irridia.com> wrote:
> Thanks for the feedback on git_fast_filter. =C2=A0It takes 11.5 hours=
 on our repository instead of 6.5 days, so that's a significant improve=
ment. :-) =C2=A0I have a couple of observations:
>
> 1) You said that your repo would have taken 2-3 months to filter with=
 git-filter-branch, and the time was reduced to ~1hr. =C2=A0I'm surpris=
ed our reduction was not quite as dramatic, although I presume the vari=
ability of repo contents are the explanation.

Variability of the repo certainly would account for some differences,
though I suspect more of the differences come from what kind of
filtering we were doing.  For example, the advantage of
git_fast_filter over filter-branch's --index-filter will be much less
than its advantage over filter-branch's --tree-filter.  Further, in my
case, I was parsing and potentially editing the contents of all files,
which becomes much more painful with filter-branch as you'll need to
re-edit the exact same contents in as many revisions of history as the
file remains unchanged in (in other words, duplicating the same work
hundreds or thousands of times).  With git_fast_filter, I only needed
to parse/edit a given version of some file exactly once.  That's what
really helped in my case.

> 2) The resulting repository pack files are actually much larger. =C2=A0=
A garbage collection reduces the size below the original, but only slig=
htly. =C2=A0I'm concerned that the recreated repository has redundant o=
r inefficiently stored information, but I'm not sure how to verify what=
 objects are taking up what space.

You may want to use packinfo.pl from under contrib/stats/ in the git
repository to find out what objects take up how much space.  From my
notes on using it for this purpose:

  git verify-pack -v .git/objects/pack/pack-<sha1sum>.idx |
packinfo.pl -tree -filenames > tree-info.txt
  sort -k 4 -n tree-info.txt | grep -v ^$ | less

> 3) git_fast_filter doesn't currently support remote submodules. =C2=A0=
When it tries to parse a submodule line, the regex fails and the code a=
borts:
>
> Expected:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 100644 :433236 foo/bar/bletch
> Received, something like:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 100644 cd821b4c0ea8e9493069ff43712a0b09 =
foo/bar/bletch
>
> To correct the issue, I modified git_fast_filter to simply skip these=
=2E =C2=A0While we no longer utilize remote submodules, I would prefer =
not to have them removed.
>
> Any feedback on what the proper behavior would be in the submodule ca=
se? =C2=A0Perhaps this is covered in your internal version?

git_fast_filter would need to be modified to handle this kind of
input, create an appropriate object type, and that object type would
need to be able to appropriately output itself later.  Since
submodules haven't really been relevant for me, I've never bothered
implementing this[*].  The assumption that git-fast-export will
produce numeric ids (i.e. that submodules are not present) is somewhat
hardwired in, so it'd take a little bit of refactoring, though
probably not to bad.


Elijah

[*] Well, actually we did hit it once somewhat recently when someone
created a commit containing a submodule...and then also immediately
reverted it.  Since we don't want to use submodules, I simply put in a
hack that would recognize them and unconditionally strip them out on
the input parsing end, which sounds like the same thing you did.
That's obviously not what you're asking for.
