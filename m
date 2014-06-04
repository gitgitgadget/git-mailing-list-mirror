From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Wed, 04 Jun 2014 17:16:00 -0400
Organization: Twitter
Message-ID: <1401916560.18134.167.camel@stross>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
	 <1401853091-15535-2-git-send-email-dturner@twitter.com>
	 <538ED2F1.9030003@web.de>
	 <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>
	 <538F2C6B.2030004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 23:16:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIXa-0007Hl-BC
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbaFDVQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 17:16:06 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35515 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaFDVQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:16:05 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so153736qgz.16
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 14:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=oTedYxWxUwg1LKS1J3KhB4Lx4DPAmms8tNEdIQapOZI=;
        b=MicpsF+pt3akx29OsTLLKZocJBS1ld+zw8WCM2mZAVQ3NZlKzHCYzCj96FS/DpEyol
         isgWmGe05eHinpDHs7fD88myPJb5WSVLoeH+3QU2EilhpVmNZlRptQx4LSLZlCD18oLS
         GkCieBiuQAndlwFeWPOFxTQIY/UP58C7jnnwupG/vk7dqCxzi/dttU6lZ4UoKu1fTSIl
         x9avAmTBKckWWPdXXoMk7d2sibyzFG2mmmdMUXk2bhTnFRXUyTwV56gQVop4w4Lvifuc
         ZXl3/qjwpaZ3aKa77lNyy4MwR1o9v5Nac/J0GVJnRFSytU+HNJi6aE/x1SF62wNkXYMZ
         8U/g==
X-Gm-Message-State: ALoCoQlWy/r9JomtClbfo2B1K29TG365lnNP19A9r+7KuqvnPmjLZLKqj8xTwYt2u45K1cS1DD7o
X-Received: by 10.140.80.67 with SMTP id b61mr71986428qgd.98.1401916563788;
        Wed, 04 Jun 2014 14:16:03 -0700 (PDT)
Received: from [172.18.24.70] ([8.25.196.25])
        by mx.google.com with ESMTPSA id i16sm2371761qge.9.2014.06.04.14.16.01
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 14:16:02 -0700 (PDT)
In-Reply-To: <538F2C6B.2030004@web.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250794>

On Wed, 2014-06-04 at 16:25 +0200, Torsten B=C3=B6gershausen wrote:
> On the other hand, looking here:=20
> http://sourceware.org/ml/libc-alpha/2009-10/msg00063.html
> and looking into refs.c,
> it seems as if we can try to run=20
> strcspn(refname, bad_characters)
> and=20
> strstr(refname, "@{"
> and=20
> strstr(refname, ".."
> on each refname, instead of checking each char in a loop.
> The library will pick the fastest version for strcspn() automatically=
=2E

Yes, you could try that, but I worry that it would be less efficient,
because it duplicates the looping machinery.

> David, the repo you run the tests on, is it public?

Unfortunately, it is an internal Twitter repo.

> Or is there a public repo with this many refs ?

I do not know of one.

> Or can you make a dummy repo with 60k refs ?

Sure!  I actually went with > 120k to make measurement easier:
https://github.com/dturner-tw/many-refs
