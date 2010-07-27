From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] upload-pack: support subtree packing
Date: Wed, 28 Jul 2010 08:29:10 +1000
Message-ID: <AANLkTin+S9Y2+DtWWETJjFKaVAesL8M6K3D=XrDPqvMY@mail.gmail.com>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
	<1280187370-23675-2-git-send-email-pclouds@gmail.com>
	<20100727144605.GA25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 00:29:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdseC-0002bY-Tq
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 00:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0G0W3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 18:29:12 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51282 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab0G0W3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 18:29:10 -0400
Received: by pxi14 with SMTP id 14so653518pxi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m+iDP/WZvZyo4xuOLIYiK0p01b1t/nuMeOCIZi8D2Bo=;
        b=CFsXMuHFwf/uBami5L22h7WB3ZMb4Z+PTJ2DzKcHMY8WY+hUA7v4E5a8zxasQpTOv6
         zRNXLnoqXgV9mze49HX1IcbfpG/XZGldbSOgqarjFlTyb/xN7tl0iokwD+JwQTHVLQN+
         xtfDfwLISkB3ntaht2thBPF6EgrXRTdypmBLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IEZMxKGyiSSZ5B2rv0k7ccCB4yarwNXHc4FE5B3r49O075mVbLpqm3cJT3th2ZBwi5
         dMCVMcX5TgGlAtuSllAvXdBCi1IpN4oHYwdNVx+6YXEdkPEPM7IlcasYesAPTARtWuht
         hG6TIjt2RluYuAiKLXF7IPLtNdd/x0wRpILv4=
Received: by 10.142.150.29 with SMTP id x29mr10966661wfd.326.1280269750183; 
	Tue, 27 Jul 2010 15:29:10 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Tue, 27 Jul 2010 15:29:10 -0700 (PDT)
In-Reply-To: <20100727144605.GA25268@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152010>

On Wed, Jul 28, 2010 at 12:46 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> wrote:
>> This patch adds a new capability "subtree", which supports two new
>> requests "subtree" and "commit-subtree".
>>
>> "subtree" asks upload-pack to create a pack that contains only blobs
>> from the given tree prefix (and necessary commits/trees to reach
>> those blobs).
>>
>> "commit-tree" asks upload-pack to create a pack that contains trees =
of
>> the given prefix (and necessary commits/trees to reach those trees)
>>
>> With "subtree" request, Git client may then rewrite commits to creat=
e
>> a valid commit tree again, so that users can work on it independentl=
y.
>> When users want to push from such a tree, "commit-tree" may then be
>> used to re-match what users have and what is in upstream, recreate
>> proper push commits.
>
> I disagree with a lot of this... but the idea is quite cool.
>
> I like the "subtree" command, being able to clone down only part of
> the repository is a nice feature, and the implementation of subtree
> seems simple enough for the server. =C2=A0It only has to emit some of
> the paths, but the entire commit DAG. =C2=A0This is pretty simple to
> implement server side and is very lightweight.

Another point is server side can disallow full clone completely and
give permission to clone on directory basis. Enterprise users would
love this.

> But I disagree with the client rewriting the commits in order to
> work with them locally. =C2=A0Doing so means you can't take a commit
> from your team's issue tracker and look it up. =C2=A0And any commit
> you create can't be pushed back to the server without rewriting.
> Its messy for the end-user to work with.

That's what happens with git-subtree in its current form (I don't know
much about git-subtree though). But I guess if they can use
git-subtree as it is now, they can live with subtree clone+git-subtree
just fine.

> I would prefer doing something more like what we do with shallow
> on the client side. =C2=A0Record in a magic file the path(s) that we
> did actually obtain. =C2=A0During fsck, rev-list, or read-tree the
> client skips over any paths that don't match that file's listing.
> Then we can keep the same commit SHA-1s, but we won't complain that
> there are objects missing.

That's another option. With all trees, sparse checkout can be used, as
long as you limit your operations within a subdirectory. Full tree
commands like git-fsck can be taught to realize it's subtree clone and
stop complain of non-existing objects. Download pack would be bigger
(I don't know how much). And it also defeats the enterprise point
above.

> The downside is, a lot of the client code is impacted, and that
> is why nobody has done it yet. =C2=A0Tools like rebase or cherry-pick
> start to behave funny. =C2=A0What does it mean to rebase or cherry-pi=
ck
> a commit that has deltas outside of the area you don't have cloned?
> It probably should abort and refuse to execute. =C2=A0But `git show`
> should still work, which implies you need a way to toggle the
> diff code to either skip or fail on deltas outside of the shallow
> path space.

Where do those deltas come from? I thought, with proper path limiting
in upload-pack, pack-objects would never generate anything that needs
things outside the area?

Sounds like git-subtree for short term, and without git-subtree long
term to me :)
--=20
Duy
