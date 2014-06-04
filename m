From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 2/2] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Tue, 03 Jun 2014 23:35:11 -0400
Organization: Twitter
Message-ID: <1401852911.18134.134.camel@stross>
References: <1401690015-19191-1-git-send-email-dturner@twitter.com>
	 <1401690015-19191-2-git-send-email-dturner@twitter.com>
	 <xmqqd2epwsw0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 05:35:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws1z0-0006o1-75
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 05:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbaFDDfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 23:35:16 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:56643 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbaFDDfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 23:35:15 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so14909802qgf.35
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 20:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=uFTCzeCsP1aVpnkjET3B39R2wMTrgLySPNenMOXnPjo=;
        b=mu+WSsuHUl879HCVIFMc8KklMjWHMwQpakn9zAlAm1Rgrc1m0TeMvpq6oGE3ctkjvg
         0rSOsEFx2AqDT6PQwuL9CHTSmK/J7ud9IYDQZx54LPFbDNDb81rt/QAsiWiE3l827AAr
         zTy+a3UCHN3u4o+95c/WFyHgl1CFeT2d1CA4SQm+D0VtSvpPIjyBcNjYSmslEsWqlypC
         95lF8IyOxiC9GJbEzAoI6p2CwF+1lZaMIevnF5d4BSrweerIDyjNCI33kqROhCT2V1El
         Eu6T+JCzPBFuq3rE/EMOcT0lPfq2Ay9GZvcOyzp9pkB8JJ4c0awceP3wqQV190fsqmfX
         J//A==
X-Gm-Message-State: ALoCoQkCwhIfB4QfLsxYNxcHmZ01kF66kNIPHa8BhevTP1Aq44q0BYY7ABX4Sa7nEiJ7EZn4Bdl4
X-Received: by 10.140.25.166 with SMTP id 35mr64459261qgt.103.1401852914261;
        Tue, 03 Jun 2014 20:35:14 -0700 (PDT)
Received: from [172.18.24.142] ([8.25.196.25])
        by mx.google.com with ESMTPSA id c2sm2131929qan.0.2014.06.03.20.35.12
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 20:35:13 -0700 (PDT)
In-Reply-To: <xmqqd2epwsw0.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250712>

On Tue, 2014-06-03 at 15:05 -0700, Junio C Hamano wrote:
> > +		if (((uintptr_t) vp & (PAGE_SIZE - 1)) > PAGE_SIZE - BLOCK_SIZE)
> > +			/* End-of-page; fall back to slow method for
> > +			 * this entire component. */
> > +			return check_refname_component_1(refname, flags);
> 
> It is somewhat sad that we have to redo the whole thing, but nobody
> higher in the callchain knows how long the refname will be before
> calling us, so this cannot be avoided.

It actually could be avoided; we could pass in some extra args that let
check_refname_component_1 start checking after the part that we have
already checked.  I decided not to do this because I believe that
the average refname component is short, which means that the cost is not
too high and that it won't happen very often.  But I would be willing to
change this if you would like.
