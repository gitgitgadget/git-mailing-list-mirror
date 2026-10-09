Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23216360EE1
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537112; cv=none; b=VxsIJlGR+4EV23fi7ECREMK7PJfKcsc6nbDi44ES0eBvHwXOvkU/2yYx2+UM6SHTfXrCMTjdJHZUk9Im7JMhoB+p95h+cofJXevmajuUFM5MH4zssoZNHuU1IfjInK2VrM/C7GUZI7yDxCf69/S6kwnIc7wS5TMzMxZvgi53Dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537112; c=relaxed/simple;
	bh=5XGoifBmHKPAHjZqvugFC4LFacGcU1a3p66xFA1PRyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfTQwKJ1blytZKsmg0RqV/HWVTLC+kt4cWwaV7MUv8889fxHlHdWZqrCKqpWFpcfJMLevj1IExTL82jKlf0kF4HxMO0OaM4aJm5UBfUDeKXl0Xk8+SSewKKRH+uKlGb6Cwx6HNeMPUWEvPLSPk8/O1RJgloxhlS5zKop0uQRNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RzLL6kPr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RzLL6kPr"
Received: from MacBookPro (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8BD420B716A;
	Fri,  9 Oct 2026 02:11:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8BD420B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791537109;
	bh=6llUFdUU0+v+2SO9s+Mpq1l70K3GPoGiHKqtocx/fbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzLL6kPrFAsareQ34cy2HSBITpjQT5YSFyPv3Ir6aGhwdUwyIXtRC1pVXragyba5Q
	 gkaiKPNN7gVQN3rvH05L4dc4Eh0B1WSlg7xrfgZfMNoDMN4+fglHJLZ32ecHvtq8Nr
	 YuUiPPVSYuqtcH02VnHgCEJoKycJKvOa5emM+o1w=
Date: Fri, 9 Oct 2026 20:11:41 +1100
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Nils Fahldieck <nils@fahldieck.de>, 
	Patrick Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Delilah Ashley Wu <delilahwu@microsoft.com>, Derrick Stolee <stolee@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] config: let sequence require a successful file
Message-ID: <asivbJyLJ3QbehBf-delilahwu@linux.microsoft.com>
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
 <20260823-fix-config-list-global-home-and-xdg-v2-2-b29cc63f017b@microsoft.com>
 <xmqqy0dsg2vt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0dsg2vt.fsf@gitster.g>

On Wed, Aug 26, 2026 at 11:20:22AM +1000, Junio C Hamano wrote:
> Delilah Ashley Wu <delilahwu@linux.microsoft.com> writes:
>> From: Delilah Ashley Wu <delilahwu@microsoft.com>
>> +static void attempt_git_config_from_file_with_options(config_fn_t fn,
>> [...]
>>  static int do_git_config_sequence(const struct config_options *opts,
>> +				  const struct repository *repo, config_fn_t fn,
>> +				  void *data, int require_successful_config)
>>  {
>>  	int ret = 0;
>> +	int success_count = 0;
>
> I am not convinced 100% that we need "success_count", either, until
> we see how it is used in the later steps.

Good point!! I realised that v2 overcomplicated the error handling. We
want to let `do_git_config_sequence()` optionally bail when both global
configuration files could not be read. We can simply set a boolean flag
when a global configuration file is successfully read, rather than
adding a helper function that tracks the number of successful reads.
I've corrected this in v3.
