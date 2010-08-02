From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 05/16] Hook up replace-object to allow bulk commit 
	replacement
Date: Tue, 3 Aug 2010 08:42:06 +1000
Message-ID: <AANLkTimMxtVGYnVhMOdnZ4oWQa1BsmUC2gUpt0ZcDspE@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-6-git-send-email-pclouds@gmail.com>
	<7v8w4olrc0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3iB-0005ao-12
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab0HBWmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:42:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45457 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab0HBWmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:42:09 -0400
Received: by wwj40 with SMTP id 40so4468948wwj.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uzyNvOuntJq1rExrguuAh8abMWV+gc13xfLDaWooxjU=;
        b=utLRR3HIxBf9MYVftsE4xmox+yATf715vbX54eLoXq87ZKjp1zP+eZeP3PdzZWA/OY
         1b8FC5F5G0GqhWnrUG8wx/CXwLeALooqQt69Z5m/M2aDTgL61CAgaz057b0BpVWbbeJn
         c/LZsEyxgIC+qeuOUs+z1ALXIXRsjR1AYkjRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SOVj2fxEmdULMi0sbPtkTZw35wPuykho7CDSXV6te45seDK8f0E3dBwxcSD/f5Mosf
         L3hJAMhFwXCPUOhKNHBw9nGRlo4xkmJEAJjPKvCQJNx/Gwmby12/4CbOVyc+HVISz+di
         NKmTuTaduJXaeDeFH6K1lxJ/3I4nGgHQ27RzA=
Received: by 10.227.135.18 with SMTP id l18mr4411397wbt.120.1280788926342; 
	Mon, 02 Aug 2010 15:42:06 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Mon, 2 Aug 2010 15:42:06 -0700 (PDT)
In-Reply-To: <7v8w4olrc0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152478>

2010/8/3 Junio C Hamano <gitster@pobox.com>:
> I really do not like the use of "replace" for the purpose of narrow
> clones. =C2=A0While "replace" is about fixing a mistake by tweaking t=
rees, a
> desire to have a narrow clone at this moment is _not_ a mistake. =C2=A0=
You may
> want to have wider or full clone of the project tomorrow. =C2=A0You m=
ay want to
> push the result of committing on top of such a narrowed clone back to=
 a
> full repository. =C2=A0My gut feeling is that that use of "replace" t=
o stub out
> the objects that you do not currently have would make it a nightmare =
when
> you would want to widen (especially to widen over the wire while push=
ing
> into a full repository on the other end), although I haven't looked a=
t all
> the patches in the series.

Indeed. My intention was "hey this repo is too big, I only need some
pieces of it. Let me grab something and do my work. (Then throw away
the cloned repo)". It's best used together with shallow clone to give
low download/disk space, and a minimum tree to fix something quick.

I'm not really sure if such repos are sustainable in long run. And no
I did not want to widen/narrow the tree (as it was to be throw away
tree). Now thinking of widening. The way I do narrow clone is quite
similar with shallow clone. I hope the way shallow clone is deepen can
be applied to widening clone.

> Can you back up a bit and give us a high-level overview of how variou=
s
> operations in a narrowed clone should work, and how you achieve that
> design goal?

Operations work as normal (as the incomplete clone is augmented to
become "normal"). In order to make it looks normal, every time a new
commit comes in (either from another repository, or user creates a new
one), the commit needs to be processed/replaced, so that the repo
looks normal from git perspective.

> Let's take an example of starting from git.git and narrow-clone only =
its
> Documentation/ (as you seem to have used as a guinea-pig) subdirector=
y.
> For the sake of simplicity, let's say the upstream project has only o=
ne
> commit.
>
> One plausible approach would be to have the commit, its top level tre=
e
> object, its Documentation/ tree object and all the blobs below that l=
evel,
> while other blobs and trees that are reachable from the top level tre=
e
> object are left missing, but somehow are marked so that fsck would th=
ink
> they are OK to be missing. =C2=A0Your worktree would obviously be nar=
rowed to
> the same Documentation/ area, and unlike the narrow checkout codepath=
, you
> do not widen on demand (unless you automatically fetch missing parts =
of
> the tree, which I do not think you should do by default to help peopl=
e who
> work while at 30,000ft). =C2=A0Instead, any operation that tries to m=
odify
> outside the "subtree" area should fail.

Changes outside the subtree area are dropped on the floor now, not
fail. But yes, it should fail.

> When you build a commit that represents a Documentation patch on top =
of
> such a narrowed clone, because you have a full tree of Documentation/
> area, you can come up with the updated tree object for that part of t=
he
> project. =C2=A0If "subtree" mode (aka narrowed clone) rejects operati=
on outside
> the cloned area, your commit is guaranteed to touch only Documentatio=
n/
> area and nothing outside. =C2=A0You therefore should be able to compu=
te the
> tree object for the whole repository (i.e. all the other entries in t=
he
> top level tree object should be the same as those from HEAD).

Correct. Except..

> Because the index is a flat structure, you would need to fudge the en=
tries
> that are missing-but-OK in there somehow, _and_ you would need to be =
able
> to recompute the tree after updating Documentation/ area. =C2=A0E.g. =
you may
> know ppc/ is tree db31c066 but may not know that it has three blobs
> underneath it nor what their object names are, so your index operatin=
g in
> this mode would need to record (ppc -> db31c066) mapping in order to =
be
> able to recreate the tree object out of it.

This is where git-replace comes in. I do not want to deal with full
flat index. Giving pointers to missing objects may make git commands
nervous. I rewrite the commit so that now it only has Documentation/
and nothing else (which I have all needed objects). The index is
narrowed too. Because the index (even narrowed) is complete (i.e. all
entries reachable), most operations should work.

Then, to hide the helper commit from user, I replace the original
(full) commit with this new commit. So from outside git sees SHA-1 of
the original commit, but its content is from the helper one. These
helper commits guarantee git won't reach out for missing objects.

It's a trade off. Doing full index requires much more effort into git.
Using "git-subtree split", while free git developers to do other
things, might be inconvenient for users (without server support, full
repo must be downloaded, replaced SHA-1 from git-subtree cannot be
used to communicate with coworkers..)

> Using cache-tree data structure might help in doing this. =C2=A0It so=
 far has
> been an optimization (i.e. when it says it has an up-to-date informat=
ion,
> it does, but if it doesn't you can always recompute what is needed fr=
om
> the flat index entries), but I would imagine that you can add an "out=
 of
> cloned area" bit to cache-tree entries, and mark a subtree that repre=
sents
> missing parts (e.g. 'ppc/') as such---anything that tries to invalida=
te
> such a cache-tree entry would be an error anyway, and when you need t=
o
> write the index out as a tree, such cache-tree entries that record th=
e
> trees outside your cloned area can be reused, no?

That's just a part of the story. Repository integrity is a
prerequisite in git from the beginning. git-merge operates directly on
trees so cache-tree won't help much. git-commit does sha1 existence
check on every sha1 before commit, so it needs to be
narrow-clone-aware too. That made me wonder if has_sha1_file was used
elsewhere. Then "git grep has_sha1_file" scared me off and I'm back
away.
--=20
Duy
