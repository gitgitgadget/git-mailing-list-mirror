From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Is anyone working on a next-gen Git protocol?
Date: Sun, 7 Oct 2012 21:57:56 +0200
Message-ID: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 21:58:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKwzc-0006IN-AT
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 21:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab2JGT6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2012 15:58:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42188 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab2JGT6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2012 15:58:17 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3147998obb.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2nvzRjLiqKu6aCNtZw5ilWEWyVEQ+To8FddjYKCaK/Q=;
        b=NvKqRnTVesXv1rNydoXk9p+i9y93z35kqGM5RBfQqhSxQQBgBvhLv3Hs726OJMB7zh
         cruYCnUDHXmh4/MQlo3Ms2mGv5wzAvrXhCChMZ7b+fq8oSkdjep7IXmSwDz8rp+kWWeD
         QoQ1/92pVoyG42ZyegpDjyTBObg9s1p8zA4rzokYgjYAwI/A+0IS+XfRdo7BN4s0L27t
         yCfMmDFB+vXog549rCO9UCVMZTfCKQX/EF5d7jokdddxCFUkkDA7tNP+nkdJvgz+MA5H
         Zt3BdyTXZgH6gWo6ORN7VHKc+53ZrT1//WWkAKVlD351Qi0c7+KBOKGqaE42iDJLpBUi
         +JYA==
Received: by 10.182.49.104 with SMTP id t8mr11659530obn.0.1349639897179; Sun,
 07 Oct 2012 12:58:17 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Sun, 7 Oct 2012 12:57:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207190>

On Wed, Oct 3, 2012 at 9:13 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I'm creating a system where a lot of remotes constantly fetch from a
>> central repository for deployment purposes, but I've noticed that ev=
en
>> with a remote.$name.fetch configuration to only get certain refs a
>> "git fetch" will still call git-upload pack which will provide a lis=
t
>> of all references.
>
> It has been observed that the sender has to advertise megabytes of
> refs because it has to speak first before knowing what the receiver
> wants, even when the receiver is interested in getting updates from
> only one of them, or worse yet, when the receiver is only trying to
> peek the ref it is interested has been updated.

Has anyone started working on a next-gen Git protocol as a result of
this discussion? If not I thought I'd give it a shot if/when I have
time.

The current protocol is basically (S =3D Server, C =3D Client)

 S: Spew out first ref
 S: Advertisement of capabilities
 S: Dump of all our refs
 C/S: Declare wanted refs, negotiate with server
 S: Send pack to client, if needed

And I thought I'd basically turn it into:

 C: Connect to server, declare what protocol we understand
 C: Advertisement of capabilities
 S: Advertisement of capabilities
 C/S: Negotiate what we want
 C/S: Same as v1, without the advertisement of capabilities, and maybe
don't dump refs at all

Basically future-proofing it by having the client say what it supports
to begin with along with what it can handle (like in HTTP).

Then in the negotiation phase the client & server would go back &
forth about what they want & how they want it. I'd planned to
implement something like:

    C: want_refs refs/heads/*
    S: OK to that
    C: want_refs refs/tags/*
    S: OK to that

Or:

    C: want_refs refs/heads/master
    S: OK to that
    C: want_refs refs/tags/v*
    S: OK to that

As a proof of concept (and also something that'll solve the issue I
had), but by adding an initial negotiation phase the protocol should
be open to any future extensions without making assumptions about the
client wanting to know about all of the server's refs, unlike the
current protocol.
