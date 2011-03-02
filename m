From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 3/3] merge-recursive: When we detect we can skip an
 update, actually skip it
Date: Wed, 2 Mar 2011 15:22:49 -0700
Message-ID: <AANLkTin1EDUMRY7T+Jx64eG6R4mOZOeOukJWQHpFX+j5@mail.gmail.com>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
	<1298941732-19763-4-git-send-email-newren@gmail.com>
	<7vwrkhb7ig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 23:22:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuuRe-00005R-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 23:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab1CBWWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 17:22:53 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56678 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757404Ab1CBWWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 17:22:52 -0500
Received: by fxm17 with SMTP id 17so516252fxm.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 14:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OCRil2UIixUDTADnpoRJg5ZULqlm1HX1sgWeDNd5Vy8=;
        b=mIjVIFsB8ZLCKCvMQIZ2HtRxDh+ysl7pHAiVpdZW658iytIVGIctvC0jOCfRx0AvM7
         SoqMCvzLBeAs4zU4ldNQIM1Zkh2yRhm4asEAYxokrLrL3yKPECzRNelJas0u4GWEpFmO
         3UcMyOvC3FLbQuCn6B54lOmRbf0FVRCYpLHOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tYh8nIg0AuFauv5uCw7O0dBUCHjpJsRuHFNNXU+6prNs7sxqBQTN0a08HpADdEo+uf
         fxnNhRWW9KFsvIpyfZbpp24QJnS9rDV+LGwaC2p7Ddasia3MbFm10tULbd22i5UIn8GL
         hwBGA0ep834uEcP8a0hrbEnqGHEG3t1Wzy7vM=
Received: by 10.223.70.193 with SMTP id e1mr540947faj.91.1299104569559; Wed,
 02 Mar 2011 14:22:49 -0800 (PST)
Received: by 10.223.111.6 with HTTP; Wed, 2 Mar 2011 14:22:49 -0800 (PST)
In-Reply-To: <7vwrkhb7ig.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168357>

On Wed, Mar 2, 2011 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Elijah Newren <newren@gmail.com> writes:
>
>> @@ -1274,9 +1275,13 @@ static int merge_content(struct merge_options=
 *o,
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 if (mfi.clean && !df_conflict_remains &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha_eq(mfi.sha, a_sha) && mfi.mode =3D=
=3D a.mode)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha_eq(mfi.sha, a_sha) && mfi.mode =3D=
=3D a.mode &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 lstat(path, &st) =3D=3D 0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output(o, 3, "Skipp=
ed %s (merged same as existing)", path);
>> - =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_cacheinfo(mfi.mode, =
mfi.sha, path,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mfi.clean;
>> + =C2=A0 =C2=A0 } else
>
> Hmmmm. =C2=A0During a merge, we allow files missing from the working =
tree as if
> it is not modified from the index. =C2=A0Changing the behaviour based=
 on the
> existence of the path on the filesystem does not feel quite right.

Really?  Ouch.  Then things have been broken ever since
make_room_for_directories_of_df_conflicts() was introduced, as that
function deletes files intentionally and expects them to be reinstated
later when possible.  If a user has a file deleted that happens to be
involved in a D/F conflict before a merge, and the file is unchanged,
the merge will reinstate it.

> Even if we decide that regressing in that use case were acceptable, w=
hat
> guarantees that the path that happens to be in the work tree has the =
same
> contents as what the merge result should be? =C2=A0IOW, shouldn't we =
be looking
> at the original index, making sure that our side (stage #2) at the pa=
th
> had a file there that matches the merge result mfi.{sha,mode}, instea=
d of
> looking at the working tree?

We DID look at the original index, make sure that our side (stage #2)
at the path had a file there that matches the merge result
mfi.{sha,mode}.

But, that's not enough to know that we can skip the update of the
file.  The merged results being different are only one reason to
update the file; the other is that we may have deleted the file
ourselves in make_room_for_directories_of_df_conflicts() and need to
replace it.  This is the location in the code where such deleted files
are reinstated.


Suggestions?
