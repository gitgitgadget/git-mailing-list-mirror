From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 14:41:42 -0400
Message-ID: <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
References: <4E7A3BDE.3040301@alum.mit.edu>
	<7vy5xh1whq.fsf@alter.siamese.dyndns.org>
	<4E7AF1AE.5030005@alum.mit.edu>
	<CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
	<20110922171340.GA2934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 22 20:41:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6oDU-0005fO-9e
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1IVSln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 14:41:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65396 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1IVSlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2011 14:41:42 -0400
Received: by ywb5 with SMTP id 5so2185484ywb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nwtv1CYolrGgYEvm/MaIjCfqRMS+spxFfpvzu+C9CsU=;
        b=XMj9gjAozNGYfNvPvNY5rPBMAxE1NmCM8FIX0HEl8Y/zUx82TbR9JNaBTbmdNWwu28
         qCtCxdhAT4LHrWRpB2/rRB49I61S/5NZJK0VuaIaciC6wp8forkJZwf2Z+HUGYe1J52Q
         p9OpmLdQ5giQN38y9vBCcmLIQskpkR8klIlhw=
Received: by 10.236.190.200 with SMTP id e48mr15669149yhn.59.1316716902261;
 Thu, 22 Sep 2011 11:41:42 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 22 Sep 2011 11:41:42 -0700 (PDT)
In-Reply-To: <20110922171340.GA2934@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181910>

On Thu, Sep 22, 2011 at 1:13 PM, Jeff King <peff@peff.net> wrote:
>
> No, we definitely don't use in-tree gitattributes. IIRC, there are so=
me
> precedence and ordering questions. I think the ordering now is:
>
> =C2=A01. Look in $GIT_DIR/info/attributes
>
> =C2=A02. If not found, look in per-directory .gitattributes
>
> =C2=A03. If not found, look in core.gitattributesfile
>
> Where do in-tree attributes fit in? Between 1 and 2? Or 2 and 3? And
> which tree do we look at?

attr.c says:

  a. built-in attributes
  b. $(prefix)/etc/gitattributes unless GIT_ATTR_NOSYSTEM is set
  c. core.attributesfile
  d. per-directory .gitattributes
  e. $GIT_DIR/info/attributes

The mechanics of (d) are established by git_attr_direction:

  GIT_ATTR_CHECKIN: working-copy, then index
  GIT_ATTR_CHECKOUT: index, then working-copy
  GIT_ATTR_INDEX: index-only

Where GIT_ATTR_CHECKIN is the default direction and GIT_ATTR_CHECKOUT
is used while checking-out files from the index. (GIT_ATTR_INDEX is
used only by git-archive.)

Note that (d) only occurs in non-bare repos or if direction is GIT_ATTR=
_INDEX.

> Here are some examples:
>
> =C2=A0a. If I do "git checkout branch-foo", we should look at branch-=
foo's
> =C2=A0 =C2=A0 tree for things like crlf, right? =C2=A0Do we still fal=
l back to
> =C2=A0 =C2=A0 per-directory .gitattributes in the working tree? On th=
e one hand,
> =C2=A0 =C2=A0 they're not really relevant to the commit we're moving =
to. But they
> =C2=A0 =C2=A0 are respected in the current code, and can be useful wh=
en moving to
> =C2=A0 =C2=A0 old commits which lack attributes.
>
> =C2=A0 =C2=A0 I think this is where the index magic comes in in the c=
urrent code
> =C2=A0 =C2=A0 (we do something like "load the index, then respect git=
attributes
> =C2=A0 =C2=A0 from the index").
>
> =C2=A0 =C2=A0 So maybe this is solved already.
>
> =C2=A0b. You're diffing commit $a against commit $b. Whose gitattribu=
tes
> =C2=A0 =C2=A0 have precedence? Is order important? Are gitattributes =
in the
> =C2=A0 =C2=A0 working tree and index relevant?
>
> =C2=A0c. You're diffing commit $a against HEAD. Which gitattributes h=
ave
> =C2=A0 =C2=A0 precedence? Again, is order important (i.e., does "diff=
 -R" look at
> =C2=A0 =C2=A0 different attributes than "diff")?
>
> I'm sure there are others, too. And I don't think any of these is
> insurmountable. But somebody needs to think through a lot of cases an=
d
> come up with consistent, sane behavior that does the right thing in e=
ach
> case (considering both bare repositories and ones with working trees)=
=2E

I think that diff-index --cached or when there is no working tree,
should set the direction to GIT_ATTR_INDEX so that it may be used with
a bare repo. In such case, the .gitattributes would come from the
index.

Consistent with that, when comparing two commits (diff-tree), I think
you look at the .gitattributes in the second commit.

j.
