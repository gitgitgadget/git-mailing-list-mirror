From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 05/15] read_tree_recursive: Avoid missing blobs and
 trees in a sparse repository
Date: Sat, 4 Sep 2010 22:31:33 -0600
Message-ID: <AANLkTimH_iMvvOadoCx_DJybDpzS3eNe92-6ywzdgUUk@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-6-git-send-email-newren@gmail.com>
	<AANLkTinkz1YG45t3njtzj--LcPs3MPbGMTj9cWG_Nj6B@mail.gmail.com>
	<AANLkTimsqDbtXArL_EQc+ZCqOd=tYWJ1ZXZpa7T5qUiH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 06:31:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os6tU-0002yH-RD
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 06:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728Ab0IEEbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 00:31:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60508 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0IEEbf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 00:31:35 -0400
Received: by fxm13 with SMTP id 13so2005873fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 21:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TxcFZV6eWEgvRd7nq9beEDJT+n4+tql2BPhgRaBZUlU=;
        b=rphrPaJGiG7cKMhbuVX2WoRF44/vFVORHqAScWjvr2DvmtrhC/O+k15XVXZVULQF7u
         gJJ0UuhRm49PWG/w+TSgvm4oLmTjWJZ2PLf+738faFM0vjsicPFWQJvt2eqFYeO1Iu/u
         FGtR/18zzs1bxUsgNjXp7Rxw+hjTSAWgP95Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U1+A8hkOShqi608iGzV1LQJRyjZdu44ufwj1+qBN7A1jQyHxrFM1p1pR7tjwkEl6cz
         786QsVHtfSknohhjvi3k7XPUOTLWsFa8obiWxg/cVLZKKQYe2cxm/NAOhERDY4BEmazE
         jAtKmeV8q1hxVnASA/HGnV3XXIvEs77zBeaf4=
Received: by 10.223.117.209 with SMTP id s17mr618672faq.93.1283661093956; Sat,
 04 Sep 2010 21:31:33 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sat, 4 Sep 2010 21:31:33 -0700 (PDT)
In-Reply-To: <AANLkTimsqDbtXArL_EQc+ZCqOd=tYWJ1ZXZpa7T5qUiH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155421>

On Sat, Sep 4, 2010 at 9:16 PM, Elijah Newren <newren@gmail.com> wrote:
> On Sat, Sep 4, 2010 at 8:00 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.c=
om> wrote:
>> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wr=
ote:
>>> @@ -119,6 +119,11 @@ int read_tree_recursive(struct tree *tree,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -1;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (git_sparse_p=
athspecs &&
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sh=
a1_object_info(entry.sha1, NULL) <=3D 0)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;
>>> +
>>
>> I suppose this is temporary and the final solution would have strict=
er
>> checks (i.e. only ignore if those entries are outside sparse zone)?
>> This opens a door for broken repo.
>
> Yes, good catch. =C2=A0Looks like I somehow missed that one, but I ag=
ree,
> there should be an "&& !tree_entry_interesting(...)" in there.

Sorry, now I remember why that isn't in there and can't be.  I did
have it there at one point. However, base & baselen in
read_tree_recursive do not necessarily correspond to the relative path
from the toplevel of the repository, though the sparse limit pathspecs
always will.  For example, running
  git ls-tree master:Documentation/technical
or, equivalently (for current git.git)
  git ls-tree da0ae7c59bb0df4c13554fd840e1a563cde659ea
then base will be "" for paths under Documentation/technical rather
than "Documenation/technical/".  And there's really no way of
determining the "real base" either in order to apply matching to the
sparse limit pathspecs (well...I guess you could do an exhaustive walk
of all history each time, so long as the given sha1sum only appears as
one particular directory, but that's unrealistic and slow and leaves
open what to do when multiple directories at different paths happen to
have the same sha1sum at some point(s) in their history).  Note that
this affects cat-file -p as well, since it calls ls-tree and thus this
code.

I really don't see how one can change this.  However, if it's any
consolation, sha1_object_info() will print out a warning message
whenever it's asked for a sha1sum that cannot be found in the object
store.  For example, in a sparse clone:

$ git ls-tree -rt master
040000 tree f98bf35e9a746ebbd5a706591fe1ea4942942bad    sub
040000 tree 436913a91c5648a6ed8fa23719fbd6e3052e2597    sub/a
error: unable to find 436913a91c5648a6ed8fa23719fbd6e3052e2597
040000 tree 07753f428765ac1afe2020b24e40785869bd4a85    sub/b
100644 blob d95f3ad14dee633a758d2e331151e950dd13e4ed    sub/b/file
040000 tree 07753f428765ac1afe2020b24e40785869bd4a85    sub/bcopy
100644 blob d95f3ad14dee633a758d2e331151e950dd13e4ed    sub/bcopy/file
100644 blob 4b7b65e07a8641bcd14375ebddf5c8a7fc002a30    sub/file

It can't traverse into sub/a because it doesn't have the necessary
information.  I figured the warning message was useful to the end user
as a reminder that they are in a sparse clone. (Such warning messages
don't affect cat-file -p, because its callbacks don't return
READ_TREE_RECURSIVE, making sure it doesn't trigger this part of the
code.)
