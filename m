From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Sat, 21 Feb 2015 10:51:31 +0700
Message-ID: <CACsJy8DxTC8xG+emwGUM6qJT-ocv1vWVSLe8S=WdTOe_Kb7+bg@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
 <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com> <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 04:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP16u-0001mo-0q
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 04:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbbBUDwD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 22:52:03 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36678 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbbBUDwB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 22:52:01 -0500
Received: by ierx19 with SMTP id x19so12490914ier.3
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WZ8m9kqKlcooXb7lNDyNyVIQdITVe4dc4yqGvAY1iAY=;
        b=yBBwglNW7AnM+2H6hoPwP4MoBJYAji41nCjWF+0BnyhAOAr6yf0Kzztvo5zE/lw2Au
         3Cemo1wWlanlLfevJdVubvIAb4jmiKryoC3ZW16guAZeYraxUw2Y+m0ECHBkHVKihRrY
         p/cg5sMo/TRHQCpqurvp7XXtAfD2Yp/BWwrZkKFU9hnvt6hm591YQ4FCsXa/8QCK1ns5
         wrjnzek6vAs1s3QP8gqwXUkluCAZnplROz6vP+tOseAyusjNWBV4zdMIzpKzzbABpD6J
         mUnqHGzNxG2yuxCalkxn+8j8WRuK6aSr1kw4Pk3D+TjwNHAOs48hX/mQyegcEWGGIDh6
         24Sw==
X-Received: by 10.107.170.220 with SMTP id g89mr1437759ioj.31.1424490721193;
 Fri, 20 Feb 2015 19:52:01 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 20 Feb 2015 19:51:31 -0800 (PST)
In-Reply-To: <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264202>

On Fri, Feb 20, 2015 at 7:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>>> But actually most of "git fetch" is spent in the reachability check
>>> subsequently done by "git-rev-list" which takes several seconds. I
>>
>> I wonder if reachability bitmap could help here..
>
> I could have sworn I had that enabled already but evidently not. I di=
d
> test it and it cut down on clone times a bit. Now our daily repacking
> is:
>
>         git --git-dir=3D{} gc &&
>         git --git-dir=3D{} pack-refs --all --prune &&
>         git --git-dir=3D{} repack -Ad --window=3D250 --depth=3D100
> --write-bitmap-index --pack-kept-objects &&
>
> It's not clear to me from the documentation whether this should just
> be enabled on the server, or the clients too. In any case I've enable=
d
> it on both.

Pack bitmaps matter most on the server side. What I was not sure was
whether it helped the client side as well because you do rev-list on
the client side for reachability test. But thinking again, I don't
think enabling pack bitmaps on the client side helps much. The "--not
--all" part in rev-list basically just traverses commits, not trees
and objects (where pack bitmaps shine). The big problem here is
"--all" which will go examine all refs. So big ref number problem
again..

> Even then with it enabled on both a "git pull" that pulls down just
> one commit on one branch is 13s. Trace attached at the end of the
> mail.
>
>>> haven't looked into it but there's got to be room for optimization
>>> there, surely it only has to do reachability checks for new refs, o=
r
>>> could run in some "I trust this remote not to send me corrupt data"
>>> completely mode (which would make sense within a company where you =
can
>>> trust your main Git box).
>>
>> No, it's not just about trusting the server side, it's about catchin=
g
>> data corruption on the wire as well. We have a trick to avoid
>> reachability check in clone case, which is much more expensive than =
a
>> fetch. Maybe we could do something further to help the fetch case _i=
f_
>> reachability bitmaps don't help.
>
> Still, if that's indeed a big bottleneck what's the worst-case
> scenario here? That the local repository gets hosed? The server will
> still recursively validate the objects it gets sent, right?

The server is under pressure to pack and send data fast so it does not
validate as heavily as the client. When deltas are reused, only crc32
is verified. When deltas are generated, the server must unpack some
objects for deltification, but I don't think it rehashes the content
to see if it produces the same SHA-1. Single bit flips could go
unnoticed..

> I wonder if a better trade-off in that case would be to skip this in
> some situations and instead put something like "git fsck" in a
> cronjob.

Either that or be optimistic, accept the pack (i.e. git-fetch returns
quickly) and validate it in the background. If the pack is indeed
good, you don't have to wait until validation is done. If the pack is
bad, you would know after a minute or two, hopefully you can still
recover from that point.
--=20
Duy
