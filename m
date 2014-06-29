From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/4] fsck: do not die when not enough memory to examine
 a pack entry
Date: Sun, 29 Jun 2014 07:40:19 +0700
Message-ID: <CACsJy8C8TkQLNXdz=D8YC8TjSEP1nth8LmvftJYSG0bTRvqU7A@mail.gmail.com>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
 <1403610336-27761-1-git-send-email-pclouds@gmail.com> <1403610336-27761-2-git-send-email-pclouds@gmail.com>
 <xmqqa98z5yrg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 02:40:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X13As-0001YA-OD
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 02:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaF2Akv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2014 20:40:51 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:45300 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbaF2Aku convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2014 20:40:50 -0400
Received: by mail-qg0-f47.google.com with SMTP id q108so791145qgd.34
        for <git@vger.kernel.org>; Sat, 28 Jun 2014 17:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mIwVxPDkqhMqdOrLZMwfN16RJsNxxqBFqFpPz1PkB1Q=;
        b=0lCOO6fC83VMdOIg3pII3kDeIJ+1dsiji9fSEaEk9H0H8x8h8NBtk+EYZCEK0MA/Cr
         o/DdEPmigPC2PAEGS2aP5Z6DJ0f9fbFdBybComg9voaK59JNRQEqdNdaEAczqQZSta2g
         SnWRGrZ7ZlHdTLzc4eaPAyl4uIRAlDOnhtm7mMVIlNV69rzyPbTusLPfDwC/dC7C1TYv
         h4Sr7wYhYtikfbnS/zteUahBLBSl4bE3+VdtjpB3B45CVbHSgQQmaBZHyjLQEhIes5k8
         DGRRuzexrZCuaVR0evZl/Q0xLi/yde/WjYOIdm/zj6tCJozCOYTesCwfbgHPwE21eiiT
         7Mkw==
X-Received: by 10.140.24.76 with SMTP id 70mr1048624qgq.30.1404002449839; Sat,
 28 Jun 2014 17:40:49 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 28 Jun 2014 17:40:19 -0700 (PDT)
In-Reply-To: <xmqqa98z5yrg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252624>

On Fri, Jun 27, 2014 at 1:09 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> fsck is a tool that error() is more preferred than die(), but many
>
> "more preferred" without justifying why it is "more preferred" is
> not quite a justification, is it?  Also, an object failing to load
> in-core is not a missing object, so if your aim is to let "fsck"
> diagnose a too-large-to-load object as missing and let it continue,
> I do not know if it is "more preferred" in the first place.  Adding
> a "too large--cannot check" bin of objects may be needed for it to
> be useful.  Also, we might need to give at the end "oh by the way,
> because we couldn't read some objects to even determine its type,
> the unreachable report from this fsck run is totally useless."

=46air enough. I think avoiding dying in xmalloc() in this code path is
still a good thing. At least "failed to read object %s" is more
informative than simply "Out of memory". The error cascading effect in
fsck is something I think we already have. I'll try to rephrase the
commit message. But if you think this is not a good direction,
dropping it is not so bad.

I'm going to look at xmalloc() in unpack-objects. That's where we
really should not abort because of memory shortage as the user may try
to get as many objects as possible out of the pack.

> The log message tries to justify that this may be a good thing for
> "fsck", but the patch actually tries to change the behaviour of all
> code paths that try to load an object in-core without considering
> the ramifications of such a change.  I _think_ all callers should be
> prepared to receive NULL when we encounter a corrupt object (and
> otherwise we should fix them), but it is unclear how much audit of
> the callers (if any) was done to prepare this change.
--=20
Duy
