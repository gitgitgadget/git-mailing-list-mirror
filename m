From: Scott Chacon <schacon@gmail.com>
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 16:18:54 -0700
Message-ID: <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
	 <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:20:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRXF-0002ww-EX
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbZCSXS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 19:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbZCSXS4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:18:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:14343 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874AbZCSXS4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 19:18:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so794125rvb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m5J27rC+oFBNMG4CR0cBOf1bAaHWTwsznQsyXLHBWBI=;
        b=firOgygtG03XZgUYQ9MfsX7TtmrKun/ef3U7PkzsPesg2fQpdyHGUNGJsgTF1IW8t4
         0p42LL535HEvx/yHrp0bZRhIuIlN4TMkOaIK1LfQ2IiXL9Oiy1L6PFMeovMgWkikJ9mn
         +dvCDViPpBVFcFbZaGbjLaanTp6O/FNskH6FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cervfIzCCFvWJ6Gm9usJPTK6reSZxLhmFbIHyur0BmxdzE1hh/HtfZ/DH5AwBr+9H6
         vAYv+DJvAc6btS4V7axbi/M/b7xxwb4EpKWN8yfe7TWLbxzSZO0bo2A8itMFnFa1+hiL
         0BACulauYio0YEEx9P9I2Cdt4SQjgLEjbIRkY=
Received: by 10.141.176.4 with SMTP id d4mr1015197rvp.109.1237504734221; Thu, 
	19 Mar 2009 16:18:54 -0700 (PDT)
In-Reply-To: <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113860>

Hey,

On Thu, Mar 19, 2009 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Scott Chacon <schacon@gmail.com> writes:
>
>> But where Git instead stores a stub object and the large binary obje=
ct
>> is pulled in via a separate mechanism. I was thinking that the clien=
t
>> could set a max file size and when a binary object larger than that =
is
>> staged, Git instead writes a stub blob like:
>>
>> =3D=3D
>> blob [size]\0
>> [sha of large blob]
>> =3D=3D
>
> An immediate pair of questions are, if you can solve the issue by
> delegating large media to somebody else (i.e. "media server"), and th=
at
> somebody else can solve the issues you are having, (1) what happens i=
f you
> lower that "large" threashold to "0 byte"? =C2=A0Does that somebody e=
lse still
> work fine, and does the git that uses indirection also still work fin=
e?
> If so why are you using git instead of that somebody else altogether?=
 =C2=A0and

In theory it would work fine, where all the commits/trees are
transferred over git and all the blobs are basically stored elsewhere,
but I would assume it would be much slower for the end user and so
nobody would do that.  I would imagine users would only use/enable
this at all if they have large media files that they don't want to
have every version of which cloned every time.  I can't imagine that
this would be used at all by more than a small percentage of users,
but when large media does need to be in source code, they will not use
Git (they will use Perforce or SVN), or they will put it in there and
then kill their (or our) servers when upload-pack tries to mmap it
(twice, yes?).  I thought it would be much more efficient for Git to
have the ability to simply mark files that don't make sense to pack up
and be able to keep track of and transfer them via a more appropriate
protocol.

> (2) what prevents us from stealing the trick that somebody else uses =
so
> that git itself can natively handle large blobs without indirection?
>

Actually, I'm fine with that - phase two of this project, if it made
sense at all, would be to have another set of git transfer commands
that allowed large blobs to be uploaded/downloaded separately,
importantly not passing them in the packfile and keeping them loose,
uncompressed and headerless on disk so they can simply be streamed
when requested.  I am thinking entirely about movies and images that
are already compressed and there is simply no need to load them
entirely into memory.  I simply thought that taking advantage of
services that already did this (scp, sftp, s3) would be quicker than
building another set of transfer protocols into Git.

> Without thinking the ramifications through myself, this sounds pretty=
 much
> like a band-aid and will nend up hitting the same "blob is larger tha=
n we
> can handle" issue when you follow the indirection eventually, but tha=
t is
> just my gut feeling.

The point is that we don't keep this data as 'blob's - we don't try to
compress them or add the header to them, they're too big and already
compressed, it's a waste of time and often outside the memory
tolerance of many systems. We keep only the stub in our db and stream
the large media content directly to and from disk.  If we do a
'checkout' or something that would switch it out, we could store the
data in '.git/media' or the equivalent until it's uploaded elsewhere.

>
> This is an off-topic "By the way", but has another topic addressed to=
 you
> on git-scm.com/about resolved in any way yet?
>

Thanks for pointing that out, I missed that thread.  I actually just
pushed out some changes over the last few days - I added the Gnome
project since they just announced they're moving to Git, added a link
to the new OReilly book that just was released and I pulled in some
validation and other misc changes that had been contributed.

Currently I have to re-gen the Authors data manually, so I do it every
once in a while - I just pushed up new data.  Doing it per release is
a good idea, I'll try to get that in the release script.
