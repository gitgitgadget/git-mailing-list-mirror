From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 18:22:15 +0200
Message-ID: <33f4f4d70904060922t5c868ec0x89ed5891cf4b19c2@mail.gmail.com>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
	 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
	 <20090406144047.GE23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Users List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 18:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqrc2-0002dA-A5
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbZDFQWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 12:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbZDFQWT
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:22:19 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37599 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbZDFQWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 12:22:18 -0400
Received: by fxm2 with SMTP id 2so1963377fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dTYM+BgYeKbPz3ap5ByTMgAzMWxYj42HeFGIN3EsFvg=;
        b=I0IZmq4rGMM/fASHxKxE5BctezQ5lcm5ecO9AGd7eHR0gZVTbmaVEyQOQCjTUbOGT1
         QwO5SuiDKYn3naTNmYUMBaFc6SrduvbA+z+2kxhczgouJR31oKmVlyJSs/J9k4UE5gSG
         QWiGyvJeTpB9eVai8lQ0Vq02SicJTyLqD+tIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YzCJb5tOFoR7d1MnPjseetuZcbecZC+Y/oqfSc+JVycNYl//57I36BAgDiAvjkA4SW
         1f5gtgUMDF8GZHgRESo4+hd78ysgCOSS9rZuweE3P5fsz0QGDW+B77DyL3MBryb/r3Pn
         /Gc1v8BWECBcB/8p1NFLCw31r+5JxJJ3KBHkY=
Received: by 10.223.122.15 with SMTP id j15mr3865227far.74.1239034935750; Mon, 
	06 Apr 2009 09:22:15 -0700 (PDT)
In-Reply-To: <20090406144047.GE23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115850>

On Mon, Apr 6, 2009 at 4:40 PM, Shawn O. Pearce <spearce@spearce.org> wrote:

> The problem is, upload-pack won't perform a reachability analysis
> to determine if a wanted SHA1 is reachable from a current ref.
> Instead it requires that the wanted SHA1 is *exactly* referenced
> by at least one ref.

I probably just don't understand this properly, so please correct me
as needed. My understanding is that

 * git-fetch-pack looks at the local named reference to figure out the
SHA id "X" for the last locally available commit.
 * git-upload-pack is given "X" as a delimiter for what to include in
the pack to send back to git-fetch-pack.

So if I have "X" and I know which remote "Y" I want (because someone
told me, or it's in a manifest), why shouldn't I be able to let
git-upload-pack search for "X" from "Y" if that is exactly what it
does anyway for named references? I accept that it may fail because
"X" is not reachable from "Y" (just give me a sensible error message).

> There's no reason to perform the reachability test on the server
> when you can move it onto the client, and that's exactly what
> git-submodule is doing.  It fetches everything, and then assumes
> its reachable post fetch.  Since the client has fetched everything,
> the client has the object if its reachable by the server.

Except it will not always be available even when it was reachable at
the source. Here's the real world example that forced me to reject the
use of the submodule command for distributed setups:

 * Bob is located at site S where he sets up tree A with a submodule
B. He uses "submodule init" to initialize B, which will cause it to be
listed relative to S in A.
 * Lisa, at site T, clones A and updates the submodule B. No problem
so far. Her list of submodules is inherited from S and works for
updating B.
 * Lisa commits a new version of B and then a new version of A. Then
she asks Kent to merge her changes.
 * Kent's clone will also have a submodules list that refers to site S
(and not T). Running "submodule update" after fetching from T fails
even though all the material is available at T, because Git is then
trying to fetch the new revision of B from S.

If you try to work around this by not using "submodule init", then you
get a saner tree that can be worked on in a truly serverless fashion,
like with plain git trees, but you have to implement a CM tool on top.

> If the object is no longer reachable by the server's refs (think
> branch rebased) then the object is actually in danger of being GC'd
> off of the server's object store.

This is alright and I would make sure all the refs I want to keep are
reachable from named references to keep git-gc from chomping stuff in
my local tree.

In the remote tree, the unnamed reference is either available or it
isn't. If someone made an unnamed reference unreachable and then
garbage-collected it, well so be it. Just tell the user that the
reference can't be found and may in fact not exist at all and you're
done. No exhaustive search necessary.

> One way we get away with this sort of thing in repo is, we only
> put SHA1s in our manifest that are published in branches that
> won't ever rewind or delete.  Hence, its a moot point.

What is the syntax for that?

Anyway it's not a moot point. I may later want to use that revision of
the manifest to perform a checkout on every component listed by the
manifest. At that point I expect all the work trees to have exactly
the contents they "should" have for that old version of the manifest.
It's all about affordable reproducibility.

/Klas
