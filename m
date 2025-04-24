Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FA27B4FA
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500164; cv=none; b=q8So6AToDF6SrkXCAOANB4hsuZ/SSsdlFwdUjxAh9jZK9q4u15bsDArjN7BsNz6AsPc+rz4yHIOYZmPxZZkQ6Y60u+mRUYOaAkXAf0ApMtfsv53zi0rPTewxqFMQ9J1eVPD3JX/JS4ILkLKjTDtvMjXpyGzAjq8ZwSSQxxYAytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500164; c=relaxed/simple;
	bh=DEHkoaAhYLwpsmEvM/GAGc5MQw4DbFA1XoS1BBOIQXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p71P5cp0U/G6pAYlQGTbt5OKgSM9NS0uvr3YJCfZF8W8fEO6yZ9H99gtSh7W5cMGTB8PBKI1D0nZQtrUavJ1hXNwq6Ouz/sLi2DgaFYfIlOTuz10EFVC5ePwH71/8urr9zhnKT8iPkTJVolvQpYO6YiI3tlY9AtBYrRJBQA4IVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wL/6F328; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wL/6F328"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F35C4CEE3;
	Thu, 24 Apr 2025 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745500163;
	bh=DEHkoaAhYLwpsmEvM/GAGc5MQw4DbFA1XoS1BBOIQXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wL/6F328uYTrsHffs52dUYd2HbUuA3up7QVrlmoF1eDLjWVuD72k8qM64/obrWpZ+
	 ADcgwWXDtFkqvN5hp10K50vERQdkbtPEizHP9LPmjvGiVhPWOb/fNs4eKBqsqWgKuo
	 RRF+LEYvxktxSdaSx7yuEsyqam9o17Mjcr9c8pIM=
Date: Thu, 24 Apr 2025 15:09:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v5 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Message-ID: <2025042437-photo-header-2d0d@gregkh>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588861EB2B9589C8BA6A8EBB8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB9588861EB2B9589C8BA6A8EBB8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>

On Thu, Apr 24, 2025 at 07:53:54AM +0000, Aditya Garg wrote:
> The script generates a Message-ID alongwith the other headers when
> gen_header is called, and is sent alongwith the email. For most email
> providers, including gmail, the Message-ID goes unchanged to the
> recipient.
> 
> But, this does not seem to be a case with Outlook. In Outlook, when we
> send our own Message-ID as a part of the headers, it discards it. Then
> it generates a new random Message-ID and that is what the recipient
> gets.
> 
> This is a problem because the Message-ID is crucial when we are sending
> multiple emails in a thread. The current implementation for threads in
> the script replies to the Message-ID it generated, but due to Outlook's
> behavior, it is not the same as the one that the recipient got, thus
> breaking threads. So a need arises to retrieve the Message-ID from the
> server response and set it in the In-Reply-To and References email
> headers instead of using the self generated one for the purpose of
> replies.
> 
> The $smtp->message variable in this script for outlook is something like
> this:
> 
> 2.0.0 OK <Message-ID> [Hostname=Some-hostname]
> 
> The Message-ID here is the one the recipient gets, rather than the one
> the script generated.
> 
> This patch uses the fact above and retrieves the Message-ID from the
> server response. It then changes the value of the $message_id variable
> to the one received from the server. This value will be used when next
> and subsequent messages are sent as replies to the message, thus
> preserving the threading of the messages.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  git-send-email.perl | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9ba47a6f38..8c8544f120 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1643,6 +1643,11 @@ sub gen_header {
>  	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
>  }
>  
> +sub is_outlook {
> +	my ($host) = @_;
> +	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
> +}

No real objection here, but what about all of the company-hosted outlook
server systems out there?  Do they need this same type of "flag"?  And
if so, why not make it a config variable?

thanks,

greg k-h
