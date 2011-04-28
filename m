From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 20:36:27 +0400
Message-ID: <BANLkTinfc9J4vhWd9V+ZpXb5tumtZM1jZA@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu>
	<7voc3r5kzn.fsf@alter.siamese.dyndns.org>
	<20110428062717.GA952@elte.hu>
	<BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
	<20110428093703.GB15349@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:36:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFUCh-0004ff-AQ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760702Ab1D1Qga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 12:36:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36514 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760690Ab1D1Qg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:36:29 -0400
Received: by qyk7 with SMTP id 7so2419182qyk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=O17IxsQZMDXiDCKZJKJIJ1OaIJWPsBi/OwvOYLBFV3c=;
        b=Pn1V+QaD+JIgHMgss1esXBCwqrXulzxRplgZHSDfFKF5zDzmgb7PmJ7sSXj+KqmvPp
         +nST/6bmBy0iP5dX+1tc54xv/FnpqCWmvfOFimN3ge1CjTdb6fVTDgixEUpGqJq6xb6d
         Grl/vos+RxLkucZnmxi0LY4zQ/kTAukugFLog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nmbUNaoyqEod1T7u4lE9C2/YECdnD3vpe8yGVV9IJahq2J03rHnIt/hIjexjt6/u24
         c738BweIgQWDo334ieDMCO5ze+gG34wrfy+tVqikLRc2b77WMQrKo/jg9yK5EnDxOg1z
         azBkpELwVpDS/bS/k2RjIR9zBHK+oqNzmBP5Q=
Received: by 10.229.65.73 with SMTP id h9mr2911185qci.269.1304008587782; Thu,
 28 Apr 2011 09:36:27 -0700 (PDT)
Received: by 10.229.251.85 with HTTP; Thu, 28 Apr 2011 09:36:27 -0700 (PDT)
In-Reply-To: <20110428093703.GB15349@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172375>

2011/4/28 Ingo Molnar <mingo@elte.hu>:
>
> If unsigned char arrays are allocated unaligned then that's another bug i
> suspect that should be fixed. Unaligned access on x86 is not free either -
> there's cycle penalties.

Unsigned char arrays can be stored unaligned. Basically, it depends on
the context in what they were declared. If a preceding field in some
structure ended unaligned then the byte array will start unaligned.
For example:

struct foo
{
   char ch;
   unsigned char sha1[20];
};

The same on the stack, except the compiler may pack them as it wishes.
So, you have no guarantee here. If you want to make sure all SHA-1 are
aligned properly, sha1 should be declared as ui32: 'uint32_t sha1[5]'.


Dmitry
