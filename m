Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E38BE8
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476667; cv=none; b=eAOfmE+GCjlOMap4ArI2hYI6ByW37ePbvFyBjDT7kQtiCD9v0jXScAF8I06oui75VDd1FivKtPOr+bjF/54QUnF41a8+QibfX0OBfI+IDKqw1ulVJxRD92tH7+Rn4u7V0zp02KoAOuABlnxCiiT/D/EZTKfWraQSTf1OBgdfbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476667; c=relaxed/simple;
	bh=nsHIFQ6QEbyrwuqjWNlOcnKOymPzE9xM8Ga2SD8EKQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl8ePIf/6KpFLA4ZQRVVnLdFS030VYl9CvtkKArbevyliqU436vJzsHqynJA2fHwxK1zioVAWAx2kA4yMvom0pi8U0iN3esUvcumDSSfRUfNsKTtI1O+YvpujzqFPI7kz76gjPY2fVGVwnlKhJTDeCWTsF/SXyc6JqWieRiW7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGQNXhe3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGQNXhe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A127AC4CEE3;
	Thu, 24 Apr 2025 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745476667;
	bh=nsHIFQ6QEbyrwuqjWNlOcnKOymPzE9xM8Ga2SD8EKQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGQNXhe3K0RR4+B7VGn7wS72o5iEOq9srqLCg8eQunQOWy41Bte7VtkRz5w25qMlE
	 gjFMfcejLcqB5Ml9ePMfco5alhujFiLSCTssmN8F0cvipfvz6X//gMq6OfNbhJ5ZeU
	 bbDJ3xPjJH+uG3+ElPYyHb1O3sa6trMRskcibtSI=
Date: Thu, 24 Apr 2025 08:36:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	M Hickford <mirth.hickford@gmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
	Shengyu Qu <wiagn233@outlook.com>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v4 1/3] send-email: implement SMTP bearer authentication
Message-ID: <2025042437-agreed-resubmit-a63f@gregkh>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597776CB37BE7B05A7ADD80B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqjz7azrdk.fsf@gitster.g>
 <PN3PR01MB95970394B0E4E84DA244BD36B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB95970394B0E4E84DA244BD36B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Apr 23, 2025 at 06:33:52PM +0000, Aditya Garg wrote:
> 
> 
> > On 23 Apr 2025, at 11:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > ﻿Aditya Garg <gargaditya08@live.com> writes:
> > 
> >> From: Julian Swagemakers <julian@swagemakers.org>
> >> 
> >> Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
> >> This is necessary since they are currently not supported by the Perls
> >> Authen::SASL module.
> >> 
> >> The bearer token needs to be passed in as the password. This can be done
> >> with git-credential-oauth[0] after minor modifications[1]. Which will
> >> allow using git send-email with Gmail and oauth2 authentication:
> > 
> > I am not familiar with this area, especially with Authen::SASL, so
> > I'd appreciate a second eye from other reviewers.
> 
> What I've noticed is that other reviewers didn't seem to have reviewed this
> patch for more than a year when the original author proposed this patch.
> Also, oauth2 is something that is significant in today's world and is definitely
> more secure as well.
> 
> Nevertheless, your concern is quite valid, but I would also appreciate atleast
> pinging the other reviewers who might have the knowledge. 
> 
> I'm Ccing Greg, who is credited for this script and the maintainer of the perl module
> as well, with a hope to get a positive response.

Please when you resend the series, feel free to cc: me.  Dragging me in
like this doesn't help much without any context.

thanks,

greg k-h
