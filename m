From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Wed, 27 Jul 2011 00:22:26 +0600
Message-ID: <CA+gfSn-ZhqXfTELg_LfMJhMW7L7GVBoRTwZO_+QYntLrh+rk0Q@mail.gmail.com>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
	<CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
	<CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
	<20110726165858.GA2334@elie.dc0b.debconf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 20:22:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlmH4-0000D7-AU
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 20:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab1GZSWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 14:22:30 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51566 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab1GZSW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 14:22:28 -0400
Received: by qwk3 with SMTP id 3so371521qwk.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=otsqhbp6/DSsv2Ie0kin3y9dMxE4GBeDUMscb2V2DAA=;
        b=V/teP6YRGDtE7NrXNmlmTuy/0OLItYLid6YzEw+OuRcZ9k4w1NPxM6Vduts5RuU+Dx
         jVqkXrc4efolDhlOQpYWU8u+5o1H3Ccaw1g12oVvxZ8xeeUlnh1H45KXFiG4xYODQydK
         X3GltJLoFFijFyodIELW7O3JL1xI7GBvayoUs=
Received: by 10.229.101.143 with SMTP id c15mr4726614qco.36.1311704547388;
 Tue, 26 Jul 2011 11:22:27 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Tue, 26 Jul 2011 11:22:26 -0700 (PDT)
In-Reply-To: <20110726165858.GA2334@elie.dc0b.debconf.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177893>

Hi,

On Tue, Jul 26, 2011 at 10:58 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Hi Dmitry,
>
> Dmitry Ivankov wrote:
>
>> 3) Is this breakage specific to tags/v1.7.3-rc0~75^2 "Teach
>> fast-import to import subtrees named by tree id" 30 Jun 2010 (allowi=
ng
>> M 040000 <tree id> pathname)?
>
> Probably. :)
>
>> The harder fix is to try to keep e->versions[0].sha1 for trees corre=
ct.
>
> Context for those who don't remember all the details:
>
> When first introduced, "struct tree_entry" was very simple: a mode, a
> filename, and:
>
> =A0- for regular objects and symlinks, a blob object name representin=
g
> =A0 its content;
>
> =A0- for subdirectories, a pointer to "struct tree_content" listing i=
ts
> =A0 contents, along with an _optional_ cached tree object name.
>
> When modifying a tree entry, fast-import would walk through the path
> to it and invalidate the cached tree names at each step. =A0Shawn wro=
te:
>
> =A0 =A0 =A0 =A0Currently trees and commits aren't being deltafied whe=
n written to
> =A0 =A0 =A0 =A0the pack and branch reloading from the current pack do=
esn't work,
> =A0 =A0 =A0 =A0so at most 5 branches can be worked with at any one ti=
me.
>
> but the advantage was that it was very simple. =A0Later, delta
> compression arrived:
>
> =A0 =A0 =A0 =A0commit 4cabf858
> =A0 =A0 =A0 =A0Author: Shawn O. Pearce <spearce@spearce.org>
> =A0 =A0 =A0 =A0Date: =A0 Mon Aug 28 12:22:50 2006 -0400
>
> =A0 =A0 =A0 =A0 =A0 =A0Implemented tree delta compression in fast-imp=
ort.
>
> =A0 =A0 =A0 =A0 =A0 =A0We now store for every tree entry two modes an=
d two sha1 values;
> =A0 =A0 =A0 =A0 =A0 =A0the base (aka "version 0") and the current/new=
 (aka "version 1").
> =A0 =A0 =A0 =A0 =A0 =A0When we generate a tree object we also regener=
ate the prior version
> =A0 =A0 =A0 =A0 =A0 =A0object and use that as our base object for a d=
elta. =A0This strategy
> =A0 =A0 =A0 =A0 =A0 =A0saves a significant amount of memory as we can=
 continue to use the
> =A0 =A0 =A0 =A0 =A0 =A0atom pool for file/directory names and only in=
creases each tree
> =A0 =A0 =A0 =A0 =A0 =A0entry by an additional 24 bytes of memory.
>
> In other words, this commit introduced a "prior" mode and tree or blo=
b
> name to give the pack-writing machinery a hint about what to delta
> against.
>
> With that in mind, it seems very weird that the version 0 tree would
> ever be changed and need to have its object name invalidated.

Well, if we'd read the actual prior contents via sha1-lookup, no
invalidation would be needed,
we can create delta with any base after all.
But we use mktree(v=3D0) to collect versions[0].sha1 of entries with
(mode !=3D 0) as a content.
I think I almost got it now. When we tree_content_set by sha1 (we use
subtree =3D NULL) and
that tree had some versions[0].sha1, we reset it's ->tree to NULL
loosing the old sha1's of
the entries. Later we traverse there and load_tree that NULL, setting
the entries with
versions[0].sha1 =3D versions[1].sha1 =3D sha1's of new/current tree en=
tries.

So looks like load_tree should restore versions[0].sha1's IF the prior
object was a tree.
I've tried this approach with merging two trees, but my rough patch is
bloated and crashes.

A bit slower one is to do sha1 lookups for the delta base trees.

> =A0Perhaps
> we are releasing some memory too early and it is getting clobbered?
> Unless I am missing something, the patch
>
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1514,6 +1514,9 @@ static int tree_content_set(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (=
e->tree)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 release_tree_content_recursive(e->tree);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 e->t=
ree =3D subtree;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (S_=
ISDIR(mode)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 hashclr(e->versions[0].sha1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hash=
clr(root->versions[1].sha1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retu=
rn 1;
>
> just disables deltas for trees that have been modified by a "M 040000=
"
> command, so it feels more like a workaround than a fundamental fix.
Right, I can't even say I understand in full what does it change.

> Could you save the svn-fe output (e.g., by introducing "tee" in the
> middle of the "svn-fe | fast-import" pipeline) and put it up
> somewhere online? =A0This would also be a good starting point for com=
ing
> up with a reduced testcase.
It's 1.9G uncompressed, 0.7G lzo-compressed. Will setup a ftp or
torrent seed a bit later.

>
> Hope that helps,
> Jonathan
>
