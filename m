From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] index-pack: kill union delta_base to save memory
Date: Sat, 28 Feb 2015 18:44:07 +0700
Message-ID: <CACsJy8A3MxpQRwboVjyv7akvzgf3y23ZsnAaxuHXkm2U=tUk0A@mail.gmail.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
 <1424947928-19396-1-git-send-email-pclouds@gmail.com> <1424947928-19396-3-git-send-email-pclouds@gmail.com>
 <xmqqzj7zhx31.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	matthew sporleder <msporleder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 12:44:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRfp8-0005TD-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 12:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbbB1Loj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2015 06:44:39 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:43259 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbB1Loi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2015 06:44:38 -0500
Received: by iebtr6 with SMTP id tr6so37203547ieb.10
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 03:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rKKa129RrtwRfvjsyyhmu3OhQ4c26QBYmk/AP3EZ00g=;
        b=p0XY8G3WQ7KgmqA79No8Ka+t+Yvwbhzcdz+83G4pPfHN8NaERebRbfFwF3JamAjaid
         QjGSeicCT9Sr5xCEQjxGxVozaWrCUR9SrDRGkWWLrzAQ8OfPQq7yjcb76abf1ke+XpiF
         79TzL++PpYyGWzaZ8bezpNDQa6xZmoeJzI4cLbtzPaLccJSc7FDdyVhuqCULW4E5YjtJ
         KEgbfQJfPwqEMAgmDKZZxnEKLjkejr1iL/gLhXItuHC4aFUOjBDHhbej/19xVDBQ+4LR
         5RlwpmNM/dq+BsM2JrXxVdlXohAzjBgFfyujv1dW42KEcHTrXy5aa5+oQMjriQLleO+W
         hoog==
X-Received: by 10.42.83.147 with SMTP id h19mr20460832icl.95.1425123878025;
 Sat, 28 Feb 2015 03:44:38 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Sat, 28 Feb 2015 03:44:07 -0800 (PST)
In-Reply-To: <xmqqzj7zhx31.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264528>

On Sat, Feb 28, 2015 at 4:18 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Notice that with "recent" Git versions, ofs-delta objects are
>> preferred over ref-delta objects and ref-delta objects have no reaso=
n
>> to be present in a clone pack.
>
> It is true that we try to use ofs-delta as much as possible, but
> where does "have no reason to be present" come from?

Lack of knowledge, or writing without double checking the code.

> When an object cannot be represented as an ofs-delta (which can only
> refer backwards), don't we use ref-delta, instead of storing it as a
> deflated-full object?

Ah I think you're right. The decision to choose ofs-delta in
pack-objects is if ofs-delta is enabled _and_ the offset to base is
available (i.e. base is already written).

> Probably "Not so ancient versions of Git tries to use ofs-delta
> encoding whenever possible, so it is expected that objects encoded
> using ref-delta are minority" may be closer to the truth.  And that
> observation does justify why using two separate pools (one with
> 8-byte entries for ofs-delta, the other with 20-byte entries for
> ref-delta) is a better idean than using one pool with 20-byte
> entries for both kinds.

Yes. Looks good. Should I send a patch, or you fix the commit message l=
ocally?
--=20
Duy
