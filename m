Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D601714CF
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738414; cv=none; b=p7e7VpSGbKMuV0R8GQk9emA3qV1QTQcBa4IAItjZsonffa/ttUF/uTFrWLppS3DkrulFMyzJRom0kfarCo+02b96RhVT94yCDyge+7UTj6jGNzvrix+jd7fGmpUVHddO4Oqx06/pu+jfGbDB1TQP1bDakCMg7bRqorQYn599urk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738414; c=relaxed/simple;
	bh=xcSIcAIFzjnUJ7DHMh9uTbTHVCkH7cvrdA45zLUS7fQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHBz8/2JmBxiKw+fENR/V5bZxQQKxM8FKMXP18TJex6JvTKcXNJ34b6SCF09CIlf3Apzn2wZ7d2HcAZ3eCEYVwShUPTpJSgcyg1VvOJRbokEzmDnic/5h+zuryIV3EvhZ4iPqPH7OFJBOrmCswRhp9SPSmX7tYuME6OOZPBRSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wc0pFwC5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wc0pFwC5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0308F1EB78;
	Thu, 15 Aug 2024 12:13:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xcSIcAIFzjnUJ7DHMh9uTbTHVCkH7cvrdA45zL
	US7fQ=; b=wc0pFwC5+Ep0qTZvKt4NEKhWdIOVAaHG9EGIF2EcwGxl/czGEDbiEC
	W5aeNCzvsAeYI6p3t/ko3uyz6+U86l2/o5y5/bjUD8uSOEPNXiXRU0AQSrmZtNNV
	6E72Fv2a6QYac/qsQIP8Plo2iQxYDoidJdUXWyjqmUVbdu6aSF08U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDEEE1EB77;
	Thu, 15 Aug 2024 12:13:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B36A1EB76;
	Thu, 15 Aug 2024 12:13:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  phillip.wood@dunelm.org.uk,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v2 7/7] run-command: fix detaching when running auto
 maintenance
In-Reply-To: <6bc170ff05d38845a012ce57e580a0ddd18f1143.1723712608.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 15 Aug 2024 11:12:49 +0200")
References: <cover.1723533091.git.ps@pks.im> <cover.1723712608.git.ps@pks.im>
	<6bc170ff05d38845a012ce57e580a0ddd18f1143.1723712608.git.ps@pks.im>
Date: Thu, 15 Aug 2024 09:13:28 -0700
Message-ID: <xmqq4j7lvk5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4FB8072E-5B21-11EF-BE88-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/run-command.c b/run-command.c
> index 45ba544932..94f2f3079f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1808,16 +1808,26 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  
>  int prepare_auto_maintenance(int quiet, struct child_process *maint)
>  {
> -	int enabled;
> +	int enabled, auto_detach;
>  
>  	if (!git_config_get_bool("maintenance.auto", &enabled) &&
>  	    !enabled)
>  		return 0;
>  
> +	/*
> +	 * When `maintenance.autoDetach` isn't set, then we fall back to
> +	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
> +	 * retain behaviour from when we used to run git-gc(1) here.
> +	 */
> +	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
> +	    git_config_get_bool("gc.autodetach", &auto_detach))
> +		auto_detach = 1;

I think this needs somehow documented.  Something like this,
perhaps?

 Documentation/config/gc.txt          | 2 ++
 Documentation/config/maintenance.txt | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git c/Documentation/config/gc.txt w/Documentation/config/gc.txt
index 664a3c2874..6506ccb87f 100644
--- c/Documentation/config/gc.txt
+++ w/Documentation/config/gc.txt
@@ -41,6 +41,8 @@ use, it'll affect how the auto pack limit works.
 gc.autoDetach::
 	Make `git gc --auto` return immediately and run in the background
 	if the system supports it. Default is true.
+	It also acts as a fallback setting for the `maintenance.autoDetach`
+	configuration variable.
 
 gc.bigPackThreshold::
 	If non-zero, all non-cruft packs larger than this limit are kept
diff --git c/Documentation/config/maintenance.txt w/Documentation/config/maintenance.txt
index 69a4f05153..7a481a494a 100644
--- c/Documentation/config/maintenance.txt
+++ w/Documentation/config/maintenance.txt
@@ -3,6 +3,15 @@ maintenance.auto::
 	`git maintenance run --auto` after doing their normal work. Defaults
 	to true.
 
+maintenance.autoDetach::
+	Tasks that are run via `git maintenance run --auto` by
+	default runs in the background, if the system supports it.
+	Setting this configuration variable to `true` explicitly
+	asks them to run in the background, and setting it to
+	`false` forces them to run in the foreground.  If this
+	variable is not set, `gc.autoDetach` works as a fallback
+	variable and behaves the same way.
+
 maintenance.strategy::
 	This string config option provides a way to specify one of a few
 	recommended schedules for background maintenance. This only affects
