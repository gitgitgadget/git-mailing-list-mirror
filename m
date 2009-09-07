From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Mon, 7 Sep 2009 13:53:04 +0800
Message-ID: <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
	 <0016e6470f36315b8a0472bc75a8@google.com>
	 <20090904212956.f02b0c60.rctay89@gmail.com>
	 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 07:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkXAS-0001qJ-Pl
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 07:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbZIGFxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 01:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758992AbZIGFxF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 01:53:05 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:39832 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758991AbZIGFxD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 01:53:03 -0400
Received: by iwn5 with SMTP id 5so758038iwn.4
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 22:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Do+w8YUgwOSV7FLfSn5YJhSr5slFDiGvei2eWhhS4iA=;
        b=Zkr2aSs3usMVMIxSzyiVn357wE5sZ9JDz7iEPPLPV+QdYsTARcP01YcoKjXFxFvrIR
         Ol1YUDrmfFecWAWa5iJurGwhJDfPuf5YOcD9TTiNJxhjnceJ4RVI1B7f3f3/CLKOk0mb
         JLB/anNKlbxv9tOn1z/Crvfwt4xInC2esnzts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ln8Y++9l2jDCUpLbgA2nRCgHZ4t1WFeKsxs5vn7xE688FGDoblqDy8SnkqXzxyxQBr
         59Ckeegq30JR8A0+Zp6YrFkYWc/4JzcQlvL5wzZzj5fTUtCZ60iYVnU6N6vunSan2iuc
         GvUtIUWZqQVeBjXjFn9u3r4qVt12kDW3/oDtA=
Received: by 10.231.5.200 with SMTP id 8mr3187362ibw.46.1252302784962; Sun, 06 
	Sep 2009 22:53:04 -0700 (PDT)
In-Reply-To: <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127887>

Hi,

On Mon, Sep 7, 2009 at 12:59 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Before 39dc52c (http: use new http API in fetch_index(), 2009-06-06),=
 we
> used to run the slot by hand and checked results.curl_request against
> CURLE_OK. =A0Everything else was an error.
>
> With the updated code, that all went to http_get_strbuf() which in tu=
rn
> calls http_request() that does the same thing, and the function retur=
ns
> HTTP_OK only when it gets CURLE_OK, but now it says MISSING_TARGET wh=
en we
> ask for an idx file we think exists in the repository but the server =
says
> it doesn't, and all other errors will be ignored with this patch.

We should only be interested in the MISSING_TARGET error, because it
tells us that the pack file is indeed not available. We aren't
interested in other errors, like being unable to perform the request
(HTTP_START_FAILED), or, say, a 401 (Unauthorized) error, or even a
500; we simply move along and we tell the user we couldn't perform the
check.

> If this codepath is what was broken by github returning 500 [*1*], th=
e
> client before 39dc52c would have failed the same way. =A0I do not thi=
nk
> loosening error checking like this is a real solution, but I may be
> reading the patch incorrectly.

You're right to say that git before 39dc52c would have failed. It did,
but no one had the chance to break anything, because 39dc52c was part
of my http patch series that only went wild in v1.6.4.

We can trace this back to 48188c2 ("http-walker: verify remote
packs"), which copied the "feature" from http-push.c to http-walker.c.

Before that, if you tried fetching a pack with http-push.c from a
500-prone server, you would also experience this.

--=20
Cheers,
Ray Chuan
