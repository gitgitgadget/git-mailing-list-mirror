From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Location-agnostic submodules
Date: Tue, 1 May 2012 11:16:35 -0400
Message-ID: <CABURp0rUKubfWXxX2ABG2E4dRTEQh4zA0bZFOeXGwv2m4b0YaA@mail.gmail.com>
References: <20120427143710.GA13953@pape.arcanes.fr.eu.org>
 <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com> <20120430220244.GL22827@pape.arcanes.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Pierre Thierry <pierre@nothos.net>
X-From: git-owner@vger.kernel.org Tue May 01 17:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPEp3-0001Bi-FE
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 17:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab2EAPQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 11:16:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46697 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab2EAPQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 11:16:56 -0400
Received: by yhmm54 with SMTP id m54so2017789yhm.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Mv50D2hdyvoAFZq486tQjwJnKqNu4I3kJMkVq4Pei9E=;
        b=J84EPJb9JLz7CRvrT2f0k2ESej/pLH8H0WrSKaTSNEKjKPKDYuosvAow3AR/IVnRdS
         AWKxfcvtZEcaOG/UWVznwPyu+A0gGdFtJu7O0rDBf+G9XVSxRTLiXPNI/RjyzCRoeJnq
         U6ht/yG1ZOndpDPkjwW2rpiG631DpcU/ExNWBfrgHp1QTNoE9PMo8wCPK97gRal7F9Rb
         CdQznyIraNcZCRCq7vhtVuTB0caJFQldxMfscOgWok+QaJ4otDG4d/pkEWreDQUAtbCe
         WTNrHSoO4ug5olc9tzqggFDmaXJ8Pnui5bjTOjmTAaPdLFu2FBUMkSGTZ7alyii4C7T5
         zxfA==
Received: by 10.236.170.71 with SMTP id o47mr23422908yhl.104.1335885415538;
 Tue, 01 May 2012 08:16:55 -0700 (PDT)
Received: by 10.146.122.15 with HTTP; Tue, 1 May 2012 08:16:35 -0700 (PDT)
In-Reply-To: <20120430220244.GL22827@pape.arcanes.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196685>

Adding Jens Lehmann, in case he hasn't noticed this thread yet.

On Mon, Apr 30, 2012 at 6:02 PM, Pierre Thierry <pierre@nothos.net> wro=
te:
> Scribit Phil Hord dies 30/04/2012 hora 16:39:
>> Maybe something like this:
>> =A0 =A0 [submodule "foo"]
>> =A0 =A0 =A0 =A0 path =3D foo-mod
>> =A0 =A0 =A0 =A0 url =3D ../foo ../foo-alternate
>> https://someplace.com/git/foo.git =A0https://kernel.org/git/foo
>
> <rant>That is typically the kind of occasion when I wish every config
> file were sexprs...</rant>

Interesting.  But at least it's not yaml.  :-)

>> But if one of them lags behind the others by a day or even an hour,
>> then you may have gitlinks in your superproject which have not made
>> it into the lagging mirror yet. =A0And this will cause problems.
>
> I see your point, but what if your only repository is lagging behind?
> I.e. in what way is it worse than now?

I actually do not think it is very much worse than now.  But the
specific way it fails in this case is as follows:

Suppose I have mirrors A and B, each containing a superproject and its
submodule.

  A:super:master =3D> A:sub:master
  B:super:master =3D> B:sub:master

A and B are coherent, meaning their superproject gitlinks point to
commits which do exist in the submodule repositories.

Now, I push new commits to A:super and A:sub, giving this:
  A:super:new' =3D> A:sub:new
  B:super:master =3D> B:sub:master

Now, A and B are both internally coherent, but I have a problem if I
try to do this:
  A:super:master' =3D> B:sub:new

This is because the sub:new commit has not made it to B yet, perhaps
intentionally or perhaps because of latency.

This problem still can occur without your change, so I do not think it
is a fatal flaw.  It is just a scenario to consider.

>> Moreover, each time you clone the repository you may get different
>> results. =A0This would be confusing.
>
> Again, I fail to see the difference with the current state. If the
> commit is specified, you will always get the same results, now or wit=
h
> my suggested addition.

The existing implementation has some flaws, and think the multiple
URLs option may expose the flaws further.  Again, not a fatal flaw to
your idea; just something to keep in mind.

Something else to keep in mind:  What you are proposing amounts to a
feature which identifies mirror repositories to use for submodules
when the primary remote repo cannot be reached.  Superprojects have no
such feature.  Why not?

Meanwhile, I really like the other feature you started off with, where
the "embedded" submodule repos could be used as the primary origin.

>> I don't think there is any need for a new 'clone' command since the
>> clone porcelain already understands submodules.
>
> What do you mean? When I clone a repo with submodules, they are not
> cloned as well.

Since git v1.6.5 or so, clone has known the --recursive option.

  git clone --recursive superproject

Since about v1.7.3, fetch and pull also know how to recurse and can do
so by default.

Phil
