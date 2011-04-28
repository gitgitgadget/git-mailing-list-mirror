From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 12:52:16 +0400
Message-ID: <BANLkTim7bbFiSsj3PRr-_yM5gh1txYQR5w@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 10:52:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFMxW-0007hS-5D
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 10:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237Ab1D1IwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 04:52:19 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47715 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab1D1IwR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 04:52:17 -0400
Received: by qyk7 with SMTP id 7so2201595qyk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TxliXbq6TUj/3GNxUBNawmuulRDlF6mYAPuD5JSEiQ4=;
        b=MgTGrZWV0Os3GrPWZJdL0J+cPFDegm85NTTSwb3adQFjaK9b3wNAbjigsFd1fFbFwv
         skZmXp9SV2P4pGT9AIjr8CHjf8BJtaZWXVx3V8hMDNhVNEpdurvPiSdLmeHHOVnf7ugD
         /10h06ESstnF972sAG4XmBRwLcuoxgIn6HdzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZCBn1cS1SR6b8XboGi6TBNQbpL1lrOGR1/z/K/O1OcAAIGxtqTNnTYIPUqxuVda9kV
         GHexzud0LYpnPPAKsavR6uR2t4csdR0I7e3fqfKrizO49pbG288nhKV6tZ8jgyNsPH6m
         PHGoZb4/y9gkOcydO4nQCMiiZOV0uoH6+WkKs=
Received: by 10.229.20.77 with SMTP id e13mr2570920qcb.193.1303980736654; Thu,
 28 Apr 2011 01:52:16 -0700 (PDT)
Received: by 10.229.251.85 with HTTP; Thu, 28 Apr 2011 01:52:16 -0700 (PDT)
In-Reply-To: <20110427225114.GA16765@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172324>

2011/4/28 Ingo Molnar <mingo@elte.hu>:
> +static inline int hashcmp(const unsigned char *sha1, const unsigned =
char *sha2)
> =A0{
> - =A0 =A0 =A0 return !memcmp(sha1, null_sha1, 20);
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 20; i++, sha1++, sha2++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*sha1 !=3D *sha2) {

At the very least, you may want to put 'likely' in this 'if'
condition, otherwise the compiler may optimize this loop in
the same way as with memcmp. So, it may work well now, but
it may not work much slower with future versions or different
level of optimization. (AFAIK, -O3 is far more aggressive in
optimizing of loops).

Another thing is that so far this optimization was only with
GCC, and we do not know whether it helps or harms to compilers.
So, maybe placing this code under 'ifdef __GNUC__' makes more
sense than pushing this change on other compilers too.


Dmitry
