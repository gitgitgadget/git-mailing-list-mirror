From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 17:53:48 +0000
Message-ID: <AANLkTimiF0UOpvzng95rJcv=+atQ9uh1aHh4YhVjR=gM@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
	<1286099806-25774-7-git-send-email-avarab@gmail.com>
	<201010041802.57398.robin.rosenberg@dewire.com>
	<4CAA0598.9080409@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 19:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pEa-0001BQ-TV
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab0JDRxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 13:53:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52871 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab0JDRxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 13:53:49 -0400
Received: by iwn5 with SMTP id 5so7185362iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TaQqmvw5XjZYIJx6rhn9fq7vf4oZErjWUG1S/Aq2PJ0=;
        b=a9+AWX0u0tuaSsZKSm9t+rO9WCHpq2TXmTWNN3KWompO7hEGE/RgVZMdabY2KBh7Jc
         arvJgXrvD3SfIXbuG/O2RCqJ54nF80J8m+pd1Q8O42phzXOWE/CvACisTHaoJER+tTLj
         fTfBUsm/d26+c5Y48FVeo094DEQyX9Wmb12wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ubIUxLWneVGjzbv+L457thrERH4ZK15Cc5Os/AMXVJ+0W0WSpFVP9LSfh5SGX3je4N
         K+8FW2s0Yixlh3M3vLEypl4au2IK4m0XFCMMMuYJnBnxrlSr+eYDq8MYM065d5dN13AN
         XLKEPyInbMMK90psbVAFwkST7NmX7wvpDQpXU=
Received: by 10.231.11.9 with SMTP id r9mr10594409ibr.47.1286214828920; Mon,
 04 Oct 2010 10:53:48 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 10:53:48 -0700 (PDT)
In-Reply-To: <4CAA0598.9080409@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158074>

On Mon, Oct 4, 2010 at 16:49, Joshua Jensen <jjensen@workspacewhiz.com>=
 wrote:
>> Is anyone thinking "unicode" around here?
>
> On Windows, Unicode filenames are 16-bit wide characters. =C2=A0The c=
urrent code
> doesn't handle them at all.
>
> I do not know about other file systems and what Git actually handles.=
 =C2=A0I was
> under the impression it didn't handle Unicode filenames well in gener=
al... ?

The only sane way of doing this sort of thing is to have a defined
*internal* encoding that gets converted to whatever the native
encoding is at the input/output points.

So Git could use Unicode represented by UTF-8, UTF-16 (whatever's
convenient) internally, but when you check out files those checked out
files can be in whatever encoding you choose.

So you could have a UTF-8 repository but check out UTF-8 filenames on
Windows. I.e. internally we'd have the file:

    =C3=A6ab

Represented by UTF-8:

    c3 a6 61 62 \0

But would check out UTF-16:

    ff fe e6 00 61 00 62 00

Then when you add a new file it'll know it's in UTF-16 and convert it
to UTF-8 before writing to the repository. All invisible to the user.

Perl handles encoding issues like this, and it's awesome. The only
thing you have to do is make sure that the system knows the encoding
of data going into it, and what encoding you want out of it.

But any implementation of this is far off, and just storing raw byte
streams is Good Enough now that almost everyone uses UTF-8 anyway, so
nobody's seriously worked on this.
