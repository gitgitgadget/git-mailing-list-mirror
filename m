Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DB1EA91
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878521; cv=none; b=DVG7BuIbkVq2rTPJJ9hOnJ7vRDWb0CdfCYRdY0NhD45Om5t+IWCdaV+y1dRBBnpjsGXtCwWPGicgBCjqNzw5i63/ZvQUMdWyszYDmS2ePPIY+h06rWIscLvP3x+Gt0m5rgqY+kvBFhnlZC03hAIrsjnQJnpoEH+8Pu/5alnxa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878521; c=relaxed/simple;
	bh=P6bUYBlHXE6RLDWiPbQyJCwXopgLT482yHiFn8iA1zQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=R7+cTNMEINvPWQVQlCculSK6IW8z93Byqx51aWk0vEsRQEESe4VA4gieoYhIBZpxXFK5xse3mJ7mdU8RF2HTrQyx4T3mxEoXYi/xiXPkAep85YD2fyFywy/+7yFqyrI7Qgvo+6ajBjUCp8W59OcXWHOcxbhtmzqxo5Fr+OLxAmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Pnnw7Mpv; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Pnnw7Mpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1718877946;
	bh=0k6I1UyPeJ+ClPq0Ux/I3sxyygp9HJkcXc86OKbkq4A=;
	h=Date:To:From:Subject:From;
	b=Pnnw7MpvGPn+/263sbPLEkDMVj0XagWM1bqC1rH5pZvL6oT9L+abFqRQqOtid677C
	 RY+8XLidlL9W4Gr0vwPpqPTh8vqbueFIkaQiCIv+7Bi8YkwfJljD1Ubr2yNeXOqz3Q
	 doS/YRxzIAp2Jn2ftwdynBp1Oew/h3EtmRXFC2iKY0itEu4a7V9x6vjscV6Rb+ZUda
	 2C/d4o0S/qpAQb7tBeaw0jKeX/jn8UVvqAsdt2MkN/szA9kchmg50O2qCRr0FzgIBQ
	 ozAgfIZ+dt6ECKStPjNBEbSUq4BRBF5y8S3z+0GnXfxYjTsFIyOeNH3chES5L6qbkc
	 yV2HakhgOVcYA==
Received: from [192.168.42.22] (69-99-142-46.pool.kielnet.net [46.142.99.69])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 5F1453C053B
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 12:05:46 +0200 (CEST)
Message-ID: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
Date: Thu, 20 Jun 2024 12:05:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
To: Git <git@vger.kernel.org>
From: Stefan Haller <lists@haller-berlin.de>
Subject: Thoughts about the -m option of cherry-pick and revert
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

There are plenty of StackOverflow questions and blog posts about the
error message that you get when you use git cherry-pick or git revert on
a merge commit without specifying the -m option. Many people don't seem
to understand what the error message means, or why they even get an
error in the first place.

The answers to these questions patiently explain what the error means
and why the -m option is necessary. Many of them contain example
scenarios; but I haven't seen a single one that doesn't use -m1 to
illustrate the usage.

I have two questions:

- What are real-world scenarios where you would use a mainline number
  other than 1? I could only come up with a single example myself, which
  is that you have a topic branch, and right before merging it back to
  main, you merge main into the topic branch; and then you merge it to
  main with a fast-forward merge. If you then want to cherry-pick or
  revert that topic, you'd have to use -m2 on that last merge from main.
  Any other examples?
- Wouldn't it make sense to default to -m1 when no -m option is given?
  It seems that this would do the expected thing in the vast majority of
  cases.

For the GUI client that I'm co-maintaining (lazygit), I'm actually
considering going so far as to not providing a choice at all, and always
using -m1. I'm not fully decided yet if that's a good idea, but it seems
that most people expect this, most of the time.

I'm probably missing something though, but what?

-Stefan
