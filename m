From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Thu, 05 Jun 2014 15:27:20 -0400
Organization: Twitter
Message-ID: <1401996440.18134.180.camel@stross>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
	 <1401853091-15535-2-git-send-email-dturner@twitter.com>
	 <538ED2F1.9030003@web.de> <1401916476.18134.165.camel@stross>
	 <xmqqsinktkjv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsdJw-0006fv-Om
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 21:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbaFET1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2014 15:27:24 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:61938 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbaFET1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 15:27:23 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so2366675qge.26
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 12:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=zhxVbA7ttu8098socY2Cz5Q4MUahHYb+oarX+mnNNrs=;
        b=U0JvhtEKuWUBohwMvuPSKVjDmNu7iJHHCqP8Ng17cK6EbN1rNMaPX3UKjV9JTXWZgP
         Idf0sHgJgGZv4k6+mkOO6504FcdIMbtIrs7qUA1AFf6F0y5jFMq3LuAk3fwTNrnaxl7R
         ZJL6ypXZ67fa3v1G1z17ULOf/guW4GSpiiP0ylSljCTPu8OOFFGH8aSMyqeXAAQCY5qf
         Ekb0WMeW6ezRv7Qjx25b/e/uv9RG9nBqPk4WH0O+DzJfzL1zxmw+CEEGEtX73aYrHJFK
         V7sZD3h0k4CE5ndxCtt49CqeyGG+WQ+Cnmwcbn4iHM2+fhEsyY34ZCNEEFa1Bxxw/awD
         EVXg==
X-Gm-Message-State: ALoCoQl9gSJks+Zu2yG80AVB5nKnk/aXnhmZV73yaxkVAXqG7+c1cawC86EwmnT5Or6WmCDwftxv
X-Received: by 10.229.53.65 with SMTP id l1mr85210905qcg.19.1401996442141;
        Thu, 05 Jun 2014 12:27:22 -0700 (PDT)
Received: from [172.17.3.196] ([38.104.173.198])
        by mx.google.com with ESMTPSA id h90sm4303729qge.0.2014.06.05.12.27.20
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 12:27:21 -0700 (PDT)
In-Reply-To: <xmqqsinktkjv.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250859>

On Wed, 2014-06-04 at 14:46 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> > On Wed, 2014-06-04 at 10:04 +0200, Torsten B=C3=B6gershausen wrote:
> > [snip discussion of compiler flags; I'll look into a cpuid approach=
]
>=20
> Hmmmm, I am not sure if the complexity is really worth it.
>=20
> In any case, [PATCH 1/2] is fairly uncontroversial, so I am inclined
> to queue it by itself early without waiting for the discussion on
> 2/2 to settle.
>=20
> >> The name check_refname_component_1() doesn't tell too much,
> >> (check_refname_component_sse42()  or check_refname_component_nonss=
e42() say more)
> >
> > I'll go with "_bytewise", since that's how it works.
>=20
> That naming assumes that there will never be any alternative
> implementation of the bytewise checker other than the one that uses
> sse42, no?

check_refname_component_1 is the non-sse (LUT) one; I assume that there
will only be one implementation of that (and if there's later another
one we can rename it).  I guess this is strong evidence for _1 being a
bad name.
