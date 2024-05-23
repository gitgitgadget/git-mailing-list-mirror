Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23B21362
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485778; cv=none; b=kzWrOmRXZk1x+hrLeyh8smDHmrvQZwP3WrTM6LU6dvnblYd4AjEhiaVyWSzR6zGE6BQzookThSSWfp0DBROPwmxprKTl+NSTyHPhLn/MSuj6ipFiTbX/ek/LuVaFcFXQ0hpCL8R7U5Ty8RAT5TcMZHLee+Lzyo00KUxFqJKy198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485778; c=relaxed/simple;
	bh=hc2if7hpx5mdjMIJNwgPhH0DnUanHnc16KJb3mdfu8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YeWlEWoZhJXnfXfHS6h0mCAk8VTS393qAjGxxckTmo6HWeglD+UC2wIqlYHFO8hDzluwjga9LsJ6tN1IHj+nZ8vZBmXWb8pVmkv+RBXlp+4/McjCnNI1Tl2edOSsEtDPud72epFthOLG2i+WrFr/cGHR6yW5M7qwnR+3upiGhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Aayy/2HU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aayy/2HU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38A5C3245D;
	Thu, 23 May 2024 13:36:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hc2if7hpx5mdjMIJNwgPhH0DnUanHnc16KJb3m
	dfu8c=; b=Aayy/2HUGxCTsxi5IHdSqlZ0FWyvibBX8B3tFxWfKXJMrxqJCjf2rW
	OOuFFSmOq42zKTg5SJUwYhWD+pt4Lxcf1PlWDsXaACJ6n1dm6BdDDz+o4c9+QaQj
	mIoR3DLIVMWxKiLdIVB+243laO8kmftswplQGaH0PNszx7+5ITw7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30A653245C;
	Thu, 23 May 2024 13:36:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E0D33245B;
	Thu, 23 May 2024 13:36:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/20] transport-helper: fix leaking helper name
In-Reply-To: <05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 23 May 2024 14:25:20 +0200")
References: <cover.1716465556.git.ps@pks.im>
	<05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im>
Date: Thu, 23 May 2024 10:36:13 -0700
Message-ID: <xmqq34q8v3aq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F41324F4-192A-11EF-A3FF-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When initializing the transport helper in `transport_get()`, we
> allocate the name of the helper. We neither end up transferring
> ownership of the name, nor do we free it. The associated memory thus
> leaks.
>
> Fix this memory leak and mark now-passing tests as leak free.

It would be more helpful to the readers if this said "Fix this
memory leak by having the helper own the memory, and mark ...".

Not a huge deal, though.

>  struct helper_data {
> -	const char *name;
> +	char *name;
>  	struct child_process *helper;
>  	FILE *out;
>  	unsigned fetch : 1,
> @@ -111,6 +111,7 @@ static void do_take_over(struct transport *transport)
>  	data = (struct helper_data *)transport->data;
>  	transport_take_over(transport, data->helper);
>  	fclose(data->out);
> +	free(data->name);
>  	free(data);
>  }

The patch is looking good.  Thanks.
