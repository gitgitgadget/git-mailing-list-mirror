From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/17] revert: Eliminate global "commit" variable
Date: Wed, 13 Jul 2011 02:10:29 -0500
Message-ID: <20110713071029.GA31285@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-7-git-send-email-artagnon@gmail.com>
 <20110712174518.GB14120@elie>
 <CALkWK0k3muAi_h7GRqgJ9vY8SwHK40-AwMdjA=uCDO8Ng4utCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 09:10:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgtap-0007Zf-KM
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758676Ab1GMHKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:10:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37440 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab1GMHKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:10:42 -0400
Received: by iyb12 with SMTP id 12so5335344iyb.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=isPb9nFQNwTjPu+jyVP+TtvaD0rqVaftt+tTCiKBUEs=;
        b=I80DaAwXzz+nPBJECpYzIH6PVQna+vKbicTv/Pe6KdoYlVmC3Y5XjO/RTeTcZZRJF9
         BlTcEOxaUxwCvLw0fw03UFBAXe0UdV5UTYUhgkFQ1w2HAytTlVapVIEDm2AWZ585EABG
         RUWB4eF9QVtRiCW7hf1HAcQL54PuiUVSJVdys=
Received: by 10.231.92.84 with SMTP id q20mr749778ibm.92.1310541042058;
        Wed, 13 Jul 2011 00:10:42 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id my4sm8746424ibb.20.2011.07.13.00.10.39
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 00:10:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k3muAi_h7GRqgJ9vY8SwHK40-AwMdjA=uCDO8Ng4utCA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177005>

Ramkumar Ramachandra wrote:

> Right.  How about this?
>
> revert: Eliminate global "commit" variable
>
> Functions which act on commits currently rely on a file-scope static
> variable to be set before they're called.  Consequently, the API and
> corresponding callsites are ugly and unclear.  Remove this variable
> and change their API to accept the commit to act on as additional
> argument so that the callsites change from looking like
>
> commit = prepare_a_commit();
> act_on_commit();
>
> to looking like
>
> commit = prepare_a_commit();
> act_on_commit(commit);
>
> This change is also in line with our long-term goal of exposing some
> of these functions through a public API.

Sounds fine to me.  I could nitpick by saying that "Functions which
act on commits" is a little vague (I think the actual story is
something like "The global 'commit' variable used to represent one of
the arguments passed to 'git cherry-pick' or 'git revert' and thus was
static along with the options.  When cherry-pick learned to replay
multiple commits in sequence, that wasn't changed, resulting in a
somewhat unnatural calling sequence that uses a global to pass in a
parameters:

	for each commit c {
		commit = c;
		res = do_pick_commit();
		if (res)
			return res;
	}

Teach do_pick_commit and the functions it calls to accept the commit
to act on as an argument, like we always should have.  Part of a
campaign to clean up cherry-pick/revert's internal APIs before
exposing them.")
