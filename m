Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8F1422D0
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720784161; cv=none; b=hUUDrCH93tBEkD9Wrab1Zn+wHA8dA88+5eLfdbB/DkiEMPKiOjuAWlCFacb4z54g3kO6l7ACn+5nX6mC+9qpyXk8r8IHZGoi5NxRgJJj5G8z7nlDKJ6r6p9GeLJJNYzKwNPMI8QzjkurtYh9TZu20N/ZbSxQe8i/XPvyO3ShUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720784161; c=relaxed/simple;
	bh=nIzzrXjmz+OYKfoGzFECQijPAn1YLSoIHAuXDXUsY2A=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EdclKQp4ffZ6dcx/ZJqk+YtjWVtLCle20+tRJzMG6BCLhCnvNdEXUmVQ95yOGwIdMQiqDLafPiCOgRKcjvnembaD15rprK6+5jhbIiF//i1KFZoCsM3/isNBdLXSLV4Ds+GWPAEjCvxo4gPCROZ/iIJtLf/gwpQQl3chAxW5AUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46CBZrGU4046371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 11:35:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Arpit Gupta'" <argupta@axway.com>, <git@vger.kernel.org>
References: <DB9P190MB15008877ED559C3ED70050E3A7A62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DB9P190MB15008877ED559C3ED70050E3A7A62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
Subject: RE: Issue : Writing commits into the git repository takes longer than expected
Date: Fri, 12 Jul 2024 07:35:48 -0400
Organization: Nexbridge Inc.
Message-ID: <011301dad44f$a80fbec0$f82f3c40$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQM+fK5a0Jqf9NU+yeqlas3lg84pvq8rpEgw
Content-Language: en-ca

On Friday, July 12, 2024 12:11 AM, Arpit Gupta wrote:
>We are maintaining the different versions of data in git repository using
jgit maven
>library. So, a commit is done on the repository containing properties such
as author
>name, date and time, action, and the file path.
>The file path refers the xml file which contains the action performed and
is stored
>inside the repository.

Can you confirm you are using JGit rather than Git core commands? If this is
a JGit situation, you may be hitting Java garbage collection or there may be
a git garbage collection happening. If this is JGit, please raise this with
the JGit team rather than here.

>We have a job running every 5 minutes that commits the information onto the
>repository and the XML file content is over-written every time. Usually,
the commits
>and writing of XML file takes around 4-5 seconds but sometimes the time
while
>committing as well as writing the data increases which also increase the
overall CPU
>utilization of the machine. This behavior is inconsistent with respect to
the process
>and occurs randomly but during this behavior, there is a time when the CPU
>utilization becomes high that all other running processes hangs up which
demands
>the restart of the server.
>
>Furthermore,
>>> The XML files that are being written as content are multi-line. There
are 2 tags
>present in the file and each tag are on their own line (one tag being the
child of the
>other). The file size isn't large. It is hardly 2-3kb. Below is the sample
structure of
>the XML file being added as a part of content:
>
><?xml version="1.0" encoding="UTF-8" standalone="yes"?> <ServiceName
>type=ServiceType> <property>PropertyValue</property>
></ServiceName>
>
>>> There are no virus scans running in the repository. Also, the git LFS
isn't involved
>in this scenario.
>>> There might be a case as when the commit time starts increasing
(initially from 4-
>5s to 30s to 1min to 6-7min) and during that time another commit call also
starts as
>there is a scheduler of 5 minutes which triggers this action. But this will
only cause a
>certain amount of delay and it shouldn't be the factor to increase the CPU
>Utilization.

There is a lock file (.git/index.lock) that acts as a semaphore to prevent
two processes from writing to the repo at once. If your scheduler starts a
log-running job that interacts with the repo, this may cause essentially a
lock wait. Check how long it is around during your delay.

>Also, the machine memory size is 32GB and the machine type is /dev/nvme2n1
>
>The commit time starts increasing from 4-5s and goes up to 6-7mins, what
could be
>the trigger for the commit to increase from 4-5s to 1min and so on in this
scenario
>since before that there can't be any parallel commits ongoing onto the
repository?
>Also, as I mentioned before, this issue is totally inconsistent.
>Let me know in case any other information is required.
>
>Could you please suggest which areas should we look for while identifying
the cause
>of this issue? Also, does frequent commit of the content onto repository
can trigger
>this issue?
>In your view, what might be the trigger of this issue and how we can
proceed to
>resolve it?

