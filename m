From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: leaky cherry-pick
Date: Wed, 11 Jan 2012 09:00:11 +0530
Message-ID: <CALkWK0kDnxjtQ+ihH_dif_7yivHLd=pibao4KPs_PDXfc2UMOA@mail.gmail.com>
References: <20120109223737.GA1589@padd.com> <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
 <20120110195017.GA19961@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 11 04:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkotb-0001QZ-E9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 04:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab2AKDae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 22:30:34 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:55371 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab2AKDad convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 22:30:33 -0500
Received: by werm1 with SMTP id m1so207771wer.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 19:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=h5tH9aI+e6pLQX1v30068egp74i89PeApo01YTmAtrE=;
        b=Fjxvzj2bPAj3crqCT/yA+K/YZ+Y5t8a4troKW7U/qACuWjdNcGpXa/kVhssdN4ZSm/
         slfYau3LgfBrhW1URV/3i9B7E1GrTUooW5y0Dwqs0ANzr/k7Qcnx4rOr1G5vJi0y/mGk
         DJvtw9ZbcZLuSOv1l+HLnhyvWa9ZQba/Wn2TA=
Received: by 10.216.139.153 with SMTP id c25mr1966840wej.25.1326252632391;
 Tue, 10 Jan 2012 19:30:32 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 19:30:11 -0800 (PST)
In-Reply-To: <20120110195017.GA19961@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188321>

Hi Jeff,

Jeff King wrote:
> On Tue, Jan 10, 2012 at 10:58:45AM +0530, Ramkumar Ramachandra wrote:
>> diff --git a/attr.c b/attr.c
>> index 76b079f..12e3824 100644
>> --- a/attr.c
>> +++ b/attr.c
>> @@ -745,6 +745,7 @@ int git_check_attr(const char *path, int num,
>> struct git_attr_check *check)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check[i].value =3D =
value;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 drop_attr_stack();
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>
> I don't think this is right.

Yeah, I figured it wasn't right by running the testsuite.  I was
struggling to figure out why.

> The attr_stack is intentionally kept in
> place after a lookup as a cache, because callers are very likely to
> lookup nearby filenames. The first thing we do is pop unrelated parts=
 of
> the stack, keep the early bits, and then push any new needed
> directories.
>
> So if you do a lookup for "foo/bar/baz/file1", the stack afterwards w=
ould
> be:
>
> =C2=A0$GIT_DIR/info/attributes
> =C2=A0foo/bar/baz/.gitattributes
> =C2=A0foo/bar/.gitattributes
> =C2=A0foo/.gitattributes
> =C2=A0.gitattributes
> =C2=A0[builtins]
>
> If you then do a lookup for "foo/bar/baz/file2", it can use the exact
> same stack without looking for or reparsing the attribute files. If y=
ou
> then do a lookup for "foo/bar/bleep/file", it pops only the entry for
> "foo/bar/baz/.gitattributes", and pushes only the entry for
> "foo/bar/bleep/.gitattributes".

I see.  Thanks for the excellent explanation-  I'll try implementing
this scheme.

-- Ram
