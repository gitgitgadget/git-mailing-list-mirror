Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E6215F4A
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166743; cv=none; b=OmzPh3q2w3RrOlDwmzTfvvgOI/kR3bfPGzUyqZqYrbCRlu8SzgmADo+4h6Oy6qjBkDkKu2jKgURojHSb2LWo9UWH4guE82NH4pw7igtlEMAcf71KPb1IzV52PvbW6en4Hic/UH7zrR4u7oM6NvBSnQbZsk1TKdbLrU8AseswUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166743; c=relaxed/simple;
	bh=lPUxfLAh0EsySXh5cK05isl2TCXIdLtdMWXYj2iZnS0=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MftEVF0fDjuKU2uPbMEJwGtYiKSDz2S9tkdFdVMmqoH97dc2AZS3EQAIUpWGR/T7AacaLDIWx2XveUKGPhHUw/T2rM8oYlQz22EWUgtuMWiyY6hJL7Pz4UguD7WzD4t7I9MMy+mq5sHPqOB5S1h3LHSkITlz7oz07X0rT5q6u3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58THPW7N3703987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 17:25:33 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'George Ogden'" <george.ogden.human@gmail.com>, <git@vger.kernel.org>
References: <CAJ5EAUw_VN4GXiHYJq0et8oZN0L+AHZz+ROLtK3Hxdp3SEL3=g@mail.gmail.com>
In-Reply-To: <CAJ5EAUw_VN4GXiHYJq0et8oZN0L+AHZz+ROLtK3Hxdp3SEL3=g@mail.gmail.com>
Subject: RE: [Feature Request] Support for sharing root-level files across repositories
Date: Mon, 29 Sep 2025 13:25:26 -0400
Organization: Nexbridge Inc.
Message-ID: <03d601dc3166$0f302170$2d906450$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWVqdm4tOgT+Ob2PvvGE5XjQo5A7Q2HLPQ
Content-Language: en-ca
X-Antivirus: Norton (VPS 250929-4, 9/29/2025), Outbound message
X-Antivirus-Status: Clean

On September 26, 2025 4:33 AM, George Ogden wrote:
>Hello Git developers,
>
>Firstly, apologies if this has already been discussed or if there is a =
way to solve this
>problem that I am not aware of.
>
>Motivation
>
>Git submodules are very useful for sharing directories between =
repositories.
>However, in some workflows, there is a need to share a single file that =
must live in
>the repository root.
>
>A concrete example is .pre-commit-config.yaml. I maintain a standard =
template
>across many repositories. When I add a new hook or update a version, I =
have to
>manually update the file in each repository. I could use a submodule =
for this, but
>submodules always appear in a subdirectory =E2=80=94 not at the root =
where tools expect
>this file.
>
>The same issue arises with other configuration files that need to =
reside at the top
>level of a project (linters, CI configs, licenses, etc.).
>
>Proposal
>
>It would be helpful if Git provided a way to share a file across =
repositories so that it
>appears at the root of the working tree, without requiring a separate =
build step,
>symlink, or copy operation.
>
>I understand there are alternative approaches (subtrees, packages, =
external
>tooling), but they all involve extra indirection. Having first-class =
support within Git
>for this use case would make it much simpler and more consistent.
>
>Thanks
>
>Thank you for your work maintaining and evolving Git! I would greatly =
appreciate
>any feedback on whether this idea has been considered before, and if =
there are
>technical reasons it may not fit Git=E2=80=99s model.

I have been thinking about a current use case for this RFE. Consider
GNU/Configure-based projects where we have config.guess and config.sub =
in the
repository root. These two files are independent of the project itself =
and truly
should be shared and managed from a single authoritative source. It can =
be a
real delay/pain to wait for the project to manually update these two =
files
from an upstream to get platform support for their project.=20

In order to support something like this, we might need a submodule =
concept
That supports something like a link upwards. Or this might be something
That could be part of the sparse-checkout infrastructure. I'm not sure, =
but I
Do think there is merit to this. It could also apply to organisations =
that have
cross-application root certificates that need to be in the same =
directory
as the application root.

Just my musings.
--Randall

