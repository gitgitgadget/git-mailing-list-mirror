From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] pathspec: cache string length when initialize pathspec
Date: Tue, 28 Sep 2010 11:08:09 +1000
Message-ID: <AANLkTinu5msupME4efxLLRcDPvM3gFd2q+k3RLw6tYuV@mail.gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
	<1284938514-16663-4-git-send-email-pclouds@gmail.com>
	<7v62xqx20o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 03:08:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Og5-0003Pq-5z
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 03:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab0I1BIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 21:08:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48125 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab0I1BIL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 21:08:11 -0400
Received: by wyb28 with SMTP id 28so4487223wyb.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 18:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TyNTxOO8d0/so7FLJvNYLA4tnlvHOuswBBULyEBp4vw=;
        b=xZOOw2PXi5Umngn6IbWtzJnza+IklrqzJnCgQKXBwVBIRXoFGfv3x2kZhhivYE3JMC
         C3juNnUazo3Nw0KcDii5KndKb6lxoF7p8Onmp29ErQ96ORZH/59Pexo49AkU2AlhFTfj
         e+l1ZoU1SPm2h5M+q/BsAFlq28Pd+iFiDYXwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pk0VIiNUYbrfHVBfutD50i0GtflOLa3QiWdqVz2y/pIKnmCDtAZ8t3uKnQixVnn7Lf
         vTW/dwHzmWoUEehIIxUtwmsgxcy5CMeRldoekK6GkyvB8/6FdSmVv46kkFVnZ0eOHcvP
         z5a62E9fwRrUx3x26bYPHixXfukiORl80f1Rs=
Received: by 10.216.159.143 with SMTP id s15mr338503wek.69.1285636089633; Mon,
 27 Sep 2010 18:08:09 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Mon, 27 Sep 2010 18:08:09 -0700 (PDT)
In-Reply-To: <7v62xqx20o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157383>

2010/9/28 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Subject: Re: [PATCH 3/6] pathspec: cache string length when initiali=
ze pathspec
>
> s/initialize/initializing/;
>
>> This field will be used when tree_entry_interesting() is converted t=
o
>> use struct pathspec. Currently it uses pathlens[] in struct
>> diff_options to avoid calculating string over and over again.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0cache.h | =C2=A0 =C2=A03 +++
>> =C2=A0dir.c =C2=A0 | =C2=A0 11 ++++++++++-
>> =C2=A02 files changed, 13 insertions(+), 1 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 6227ddb..045c9fc 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -495,6 +495,9 @@ extern int ie_modified(const struct index_state =
*, struct cache_entry *, struct
>> =C2=A0struct pathspec {
>> =C2=A0 =C2=A0 =C2=A0 const char **raw;
>> =C2=A0 =C2=A0 =C2=A0 int nr;
>> + =C2=A0 =C2=A0 struct pathspec_item {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len;
>> + =C2=A0 =C2=A0 } *items;
>
> Hmm... I would have expected to see
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pathspec_item {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *pa=
ttern;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int len;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pathspec {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pathspe=
c_item *items;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>
> as you would be allocating a structure anyway, but persumably many pl=
aces
> take their input as a NULL terminated "char **" array, and keeping su=
ch an
> array around as the "raw" field may be easier in refactoring.

pathspec_item.pattern is added later on when I implement negative
pathspec so it's not too different from your expectation. "raw"
however is kept. The reason (again in my WIP negative pathspec) is
that I use "!" alone to denote a negative pathspec. So if user gives {
"foo", "!", "foo/bar", NULL }, "raw" will contain exactly that, but
there are only two pathspec_item for "foo" and "foo/bar" (with
negative flag set).
--=20
Duy
