Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9D132C36
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743180; cv=none; b=Q3wWj1VLqxAHknRp4cuTnA5+zvCdl9jhyENXIRB4h/N00iz/vfaobM1d+B8vG0oDLOLbYs0h+oTMK+qgmx0V1HoS3ZOH3E3Ag+B3ncJlx8s+2OnSzQ/Ic3lCIrSHrJSr1nLEKL8zdSBcVJt/T13Daw3/OM4xKQosByhLbQaQrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743180; c=relaxed/simple;
	bh=F23ML3JPQI4aL0SXD2MBw6fZImR02xrTXRT+/HVPKpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ooWpMbe36gCP4xaAaqLsh5YdmNMk0CeHqyIRBfxLtqq4r5RfqYPN9d/63bXeyhltpzQNdpzNhBydaYOFO/SP5rdmqQYasrd5+PKZ6CI++N3GB9EoAFnnv4zyu+g6JhYaAcEBcaQE0FKWc8KHXV02qCN+4EfNdKZzaf4KSWoJANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UZHjVu8C; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UZHjVu8C"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AA131D897D;
	Wed,  6 Mar 2024 11:39:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F23ML3JPQI4aL0SXD2MBw6fZImR02xrTXRT+/H
	VPKpg=; b=UZHjVu8C3f1QzPG1gkLDndyuj75dgQmA7jkxwYPvh052W7JEmxf9en
	fJzXU8W+cOafHOQueC/Eq8h4zSZEP25fXFDDUK5o/zjsXPkxMSZ+2/H6mjKFM/Xs
	Z32fYRME3d8UKACv/RbPH8kNn5Kl6xyJu3iWKykJ1tiRJZ0hGijaQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 932531D897C;
	Wed,  6 Mar 2024 11:39:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02E511D897B;
	Wed,  6 Mar 2024 11:39:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] reftable/stack: register lockfiles during compaction
In-Reply-To: <ZehauDgP4L40QKcH@tanuki> (Patrick Steinhardt's message of "Wed,
	6 Mar 2024 12:59:52 +0100")
References: <cover.1709549619.git.ps@pks.im>
	<45b5c3167fbfd64d8d1e14ed55bae94cb9cba28b.1709549619.git.ps@pks.im>
	<mwhby7dxpiyrvknqe2uoli4ulygjy6hbxcxpqt3alw3dthwntr@4o24tp5jp6h7>
	<ZehauDgP4L40QKcH@tanuki>
Date: Wed, 06 Mar 2024 08:39:35 -0800
Message-ID: <xmqq7ciftiuw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1EBE6438-DBD8-11EE-AF55-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Naive question, why do we include the headers in `system.h`? I assume
>> this is because they are common? Are there other benefits to this
>> indirection?
>
> Well, "system.h" is supposedly the glue between the common Git codebase
> and the reftable library, so all Git-specific headers should be added
> here instead of being added individually to the respective files in the
> library. Whether that is ultimately a sensible thing and whether it
> really helps us all that much is a different question though.

That matches my understanding of what have been done in reftable/
directory.  If a project other than Git wants to use the reftable
code, they only need to prepare a shim and write their own
"system.h" to provide services equivalent to what Git supplies.

Thanks.
