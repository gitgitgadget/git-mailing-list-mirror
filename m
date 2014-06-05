From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Thu, 05 Jun 2014 18:02:45 -0400
Organization: Twitter
Message-ID: <1402005765.18134.181.camel@stross>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
			 <1401853091-15535-2-git-send-email-dturner@twitter.com>
			 <538ED2F1.9030003@web.de>
			 <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>
			 <538F2C6B.2030004@web.de> <1401916560.18134.167.camel@stross>
		 <539062D9.60000@web.de> <1401996362.18134.179.camel@stross>
	 <5390E43B.3070501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:02:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsfkK-0000hw-L5
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 00:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaFEWCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2014 18:02:49 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:52860 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaFEWCs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 18:02:48 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so2797151qga.28
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 15:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=fLqNfzsAc57my16Nc0cpB2SB7J8Jv2P/AT+H9ye4kO8=;
        b=cmXhnHhZ8XuLw/2cCJI5bEH4bKAGC1yMJ87K+WMboBgr2q23z+7RCrQhB/VppMduAw
         N6e7YguPZ5FY0xsv7PpyMxc5yFgZ/YE0prQPTojdOj+xxCkTX9hcsaLtO6eVeeZBLh61
         4D2CoLGNcDUlIHHb3anqWWSZhb+KqxyGXjT7+blFzFjIfMiB1YQuV2zX/0UndPbnwULR
         i4pbyXSHrFbW0q0dNMUP2ynb7WXMrpHbwpN3a5LrHT/oMT2ZdHRy0nJQLmsGwJoXOwxp
         BFZE7xDFC6MmTEDPglvdjxRXtFzbG1eAvQyfpY08KQAmxoHnCE5L2WRnL/GGXxQl5zOu
         CEAg==
X-Gm-Message-State: ALoCoQl0n/4ukD4s9zG4ryaGhaKpihNcPavOhnIJFcN/eOMRWFkHx9FXjTz+JF98F+Q7VEQdW14o
X-Received: by 10.224.161.83 with SMTP id q19mr1026552qax.56.1402005767491;
        Thu, 05 Jun 2014 15:02:47 -0700 (PDT)
Received: from [172.17.3.196] ([38.104.173.198])
        by mx.google.com with ESMTPSA id l9sm11437214qag.40.2014.06.05.15.02.45
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 15:02:46 -0700 (PDT)
In-Reply-To: <5390E43B.3070501@web.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250870>

On Thu, 2014-06-05 at 23:42 +0200, Torsten B=C3=B6gershausen wrote:
> On 2014-06-05 21.26, David Turner wrote:
> > On Thu, 2014-06-05 at 14:30 +0200, Torsten B=C3=B6gershausen wrote:
> >> On 2014-06-04 23.16, David Turner wrote:
> >>>
> >>> Sure!  I actually went with > 120k to make measurement easier:
> >>> https://github.com/dturner-tw/many-refs
> >> Hm, I didn't get so man
> >>
> >> git remote -v
> >> origin  https://github.com/dturner-tw/many-refs=20
> >>
> >>  wc .git/packed-refs=20
> >>      750    1130   38868 .git/packed-refs
> >>
> >=20
> > Oops.  It looks like I forgot to push all of the refs.  And when I =
try,
> > it fails with "fatal: cannot exec 'send-pack': Argument list too lo=
ng"
>=20
> I just noticed that I may be able to re-use code from t5551 to create=
 a repo
> with 50000 tags.

That's good, because github really didn't like me having a repo with
thousands of refs.  Try 100k, tho, because the difference is easier to
see.
