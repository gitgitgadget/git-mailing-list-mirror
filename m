From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] msvc: Select the "fast" definition of the
 {get,put}_be32() macros
Date: Sat, 26 Jun 2010 13:31:12 -0500
Message-ID: <20100626183111.GB13070@burratino>
References: <4C2264B6.5010906@ramsay1.demon.co.uk>
 <20100624112148.GA12485@burratino>
 <4C250DD2.2030801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSaAB-0001Fd-Kh
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab0FZSb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 14:31:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61047 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0FZSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 14:31:27 -0400
Received: by iwn41 with SMTP id 41so3082044iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=t3zf/k4x32uhU4rY40EMvJGeCB1XJdrvrO+NTKmMAWw=;
        b=CI5UkVVYXuCpxLHzmemEstA2CwQ8kbMJW/H6Qj7bHFeYQzDGbEUkix4Xgr69Yzs5cD
         4YJt/S601YBJOFA7k6hf9v6RyGdutYh8em7nO0NvcRqSmCr7FwH2p4/KWTTGfnB2mQ4q
         f4yeP5ivpFYEsQtbFheuiU2zA801/vvwO8Lbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qaRANcnyVxU5sF6UTp3PLEDuRP8rD1ahoF0dTFleUvWhM7jck2FvO8TQ17X0mEzoCs
         U2iF98dT2eD+8wUiakuDfRv0+6wubQ0VNgG/QMKgxRq35/KR5Q7kEhkSEXkltgaRA2NG
         UQsfi6dASamlPImwnQUxxGjKH+lfK9tQ8B420=
Received: by 10.231.196.221 with SMTP id eh29mr2671367ibb.180.1277577085794;
        Sat, 26 Jun 2010 11:31:25 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v23sm6909672ibp.15.2010.06.26.11.31.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 11:31:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C250DD2.2030801@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149769>

Ramsay Jones wrote:
> Jonathan Nieder wrote:

>> -#if defined(__i386__) || defined(__x86_64__)
>> +#if defined(__i386__) || defined(__x86_64__) || \
>> +	defined(_M_IX86) || defined(_M_X64)
>>    #define setW(x, val) (*(volatile unsigned int *)&W(x) =3D (val))
>
> I looked at this, but decided not to make this change (while adding
> an item to my TODO list to investigate further).

Mmm, my only complaint is that leaving out this change makes the
code appear to do something other than it does.  Maybe a comment
would help.

> After reading the large comment before line 57, and with a vague
> recollection of the mailing list discussion, I was left with the
> impression that this was aimed specifically at a quirk of the gcc
> code generator.

Sort of, but sort of not.  Using volatile here is saying =E2=80=9CI rea=
lly
want to do these stores in this order=E2=80=9D.  And that is probably t=
he
right thing to do for _any_ code generator on x86, unless it is very
smart.

> In other words, maybe line 57 should read:
>
> #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))

That would exclude icc etc so I=E2=80=99d prefer to avoid it without
empirical evidence.

> It should probably be investigated at some point, but I don't think
> it's an urgent issue (and the msvc build will be no worse off ;-).

Right, I agree with this. :)  So for what it=E2=80=99s worth:

  Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I am referring to your original patch $gmane/149542 here.

Thanks.
