Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872EB46BA0
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949576; cv=none; b=rSzaJ6cVbikgZC/lSvhq8Aw5SKuwZH1XTLiY73xjNM7nGfmcheLubLMlFWx0GVS7Q7sX4VQtM6UR7pugWqsYRClQGotZjGWyWudDQkbjNmAnsxYNH9ADyHIVwGbk4sWTvUVXP+CjKPa7wu55arfYDPIuQlydNJ8j/PU9UYks13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949576; c=relaxed/simple;
	bh=N2YIM4Byoq//BI65u3lMApchgp9QxtLn9E1iqO1XXyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CwaV7vg4xDy2QIY23pGnMkDB6YzVtPxLxYNJU4t0bGOFefl5H8iiRgcWMsRVD7dS+kcxlHxvSwkz27kMsB2SlM5n5dOeoAjLxu9+n50SmE108wnm6eEcGyxljhMrcyhirx6zDIZDXbF+VxoP7h/IppdOAjiOZPjZj7xOgByfWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EEGa5tOK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EEGa5tOK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B9CE42A2A0;
	Mon, 22 Jan 2024 13:52:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N2YIM4Byoq//BI65u3lMApchgp9QxtLn9E1iqO
	1XXyI=; b=EEGa5tOKsCGxXvd1ciett1XeMGWzWXIY2p63glpMPmHJAO4RX6lvF3
	h1IJwUQIoVOuXuyJvoH56Bj5rEog8xBW3dFcBFRL8IEBgW0dnsYgB0IeKIDTRkN2
	tW9tq3rT8iKSGjGpbs/RxRfIRrtf2FkpYpurOugrBIzYUPXtVVRdk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B37C22A29F;
	Mon, 22 Jan 2024 13:52:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C3382A29E;
	Mon, 22 Jan 2024 13:52:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Zsolt Imre <imrexzsolt@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git Push Always uses Protocol Version 0
In-Reply-To: <FD545E92-18EF-44B5-A7D5-61ECADD880E6@gmail.com> (Zsolt Imre's
	message of "Mon, 22 Jan 2024 08:59:35 +0000")
References: <FD545E92-18EF-44B5-A7D5-61ECADD880E6@gmail.com>
Date: Mon, 22 Jan 2024 10:52:48 -0800
Message-ID: <xmqqa5oxurnj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 70F244E8-B957-11EE-8639-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Zsolt Imre <imrexzsolt@gmail.com> writes:

> I'm not entirely sure if this is a bug or I am missing something,
> but I thought I would share in the hope someone can help out. I'm
> playing around with Git and trying to implement a git server that
> communicates over HTTP and supports Git protocol version 2 *only*.
>
> When I `clone` a repository, the Git client (version 2.43.0),
> after fetching the capabilities using protocol version 2, it
> proceeds to fetch the refs, again, via protocol version 2 using
> the `ls-refs` command.  However, when I try to `push` my changes
> to the repo, the Git client refuses to use protocol version 2 and
> tries to obtain the ref list using protocol version 0, even if I
> pass in the `-c protocol.version=2` command line argument.

Given that v0 and v1 in the push direction behave exactly the same,
and there has been no need to add features that were not supportable
in v1 in the push direction, it is not surprising to see this code

        int cmd_send_pack(int argc, const char **argv, const char *prefix)
        {
		...
                switch (discover_version(&reader)) {
                case protocol_v2:
                        die("support for protocol v2 not implemented yet");
                        break;

in https://github.com/git/git/blob/master/builtin/send-pack.c#L282
and also

        int cmd_receive_pack(int argc, const char **argv, const char *prefix)
        {
		...
                switch (determine_protocol_version_server()) {
                case protocol_v2:
                        /*
                         * push support for protocol v2 has not been implemented yet,
                         * so ignore the request to use v2 and fallback to using v0.
                         */
                        break;

in https://github.com/git/git/blob/master/builtin/receive-pack.c#L2538

that tells the receiving end to demote "v2" request down to "v0",
and have the pushing end honor that choice.

What specifically did you want to gain by using protocol version 2
in the "push" direction that you cannot do with the current
versions?


