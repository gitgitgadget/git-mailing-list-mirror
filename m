Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA3367
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326618; cv=none; b=EyWfTDoCT/ZHRasj6ej7DKghj8U6wviI2KWHXq5pCM1t7XZZ7a5lJz12/07VUxFg7rIcYd/k14wTR2sW5W9Yfhiy0G6Vb5PrIESn/Z0PW78ZKJtreTQh1hdcXG43cW6WkFO5GbGGo9oxElgZ32sOPxbUSrqrmiGEqoS0DOIvmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326618; c=relaxed/simple;
	bh=vJA0Wvdt4WBtij/jt0+AsumQab8HvxJm38zCbbCzRjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Oqf8h4tKqX/q+qc1utR/1lAK3sa/6cSjGKMqxm9BZkaMgNiLroKb0ZXk4H4swbQIB2igaIttqOfjNi5rdFhbFI5LHZ4Myd2U7mKPx6I9MKWkkkNlPrMMtFyqbTQZHFHZp4MOHgkBqClraecGZt9AWtj8KQBzCYfx7Ru3mApd8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ve4lXRq5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ve4lXRq5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754326611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iNbZpL4S0Ib+Eb4TmzGMt6ep5+Eu8/8wYElzAP9JLUQ=;
	b=ve4lXRq5H0ovv8+zecpRIP/6cFoXEuXMH+tpNmy638QFTxIUMiiF3po198fOOOsH2hNLI9
	AMQJKMhm6xyXD8owRAcWz6iaHMN8aTosts0HOwO+++NY/UI7HrQiiGHMg7zlwitgq8Zuzy
	FPLVI30sScxn6N2cBeewQ8Xbk9Wnj/Y=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/4] Fix archiving some corner-case files into zip
Date: Mon, 04 Aug 2025 18:56:31 +0200
Message-Id: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/mkGgC/x2MQQqAIBAAvxJ7bkEtIfpKdFh0y72oaEQU/T3pO
 AMzD1QuwhXm7oHCp1RJsYHuO3CB4s4ovjEYZayalMYjpYhUXJCT8ZaMm1xoPJMbjbdEA7Q0F27
 63y7r+37nloRMZgAAAA==
X-Change-ID: 20250801-toon-archive-zip-fix-2deac42d5aa3
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

At $DAYJOB, we've add a customer report an issue where they failed to
download a zip archive from a repository. The error they saw come from
git-archive(1) is:

        fatal: deflate error (0)

My friendly colleague Justin Tobler was able to reproduce this issue[1].
We've diagnosed this error happens on some files that exceed
core.bigFileThreshold. To reproduce the issue, you can run:

        git clone --depth=1 https://github.com/chromium/chromium.git
        cd chromium
        git -c core.bigFileThreshold=1 archive -o foo.zip --format=zip HEAD -- \
                chrome/test/data/third_party/kraken/tests/kraken-1.1/imaging-darkroom-data.js

(originally he mentioned another file, but that didn't trigger the bug
for me)

And a patch to fix the issue was presented that message.

I have tested the fix, and I can confirm this fixes the issue. But I'm
concerned this doesn't fix all issues.

Another way one could trigger the issue, is by initializing
`unsigned char compressed` with length `STREAM_BUFFER_SIZE / 2` (so half
the length of the input buffer, instead of double).

With Justin's fix, you see the error doesn't happen no more. But it
seems, the resulting zip archive isn't valid. When I try to unzip it, I
see:

    inflating: chrome/test/data/third_party/kraken/tests/kraken-1.1/imaging-darkroom-data.js   bad CRC 3ba68a86  (should be b09a04a2)

And when the length is set to `STREAM_BUFFER_SIZE` (so equal length to
input buffer), the decompress goes well, but the data seems to be
mangled.

This is because only the final call of git_deflate() is being wrapped in
a loop for the current chunk of input data. We can see in various other
callsites in the Git codebase, git_deflate() is usually called in a
`while` loop (even when the `flush` parameter is set to `0` =
Z_NO_FLUSH).

For the record, I want to give all the credit to Justin for diagnosing
this bug and to determine a solution. Where he aims to provide a fix
that is minimal, I wanted to present an alternative solution that
implements zlib usuage according to the official usage example[2], but
the changes are more substantial.

I'm on the fence which of two is the better approach. Because the ZIP
format has a End Of Central Directory record (EOCD) at the end, it's far
more likely *only* the final git_deflate() call suffers from unprocessed
input data, so the final Justin provides probably Just Works. I'm gonna
leave it up to the community to decide what is "better"?

[1]: https://lore.kernel.org/git/20250802220803.95137-1-jltobler@gmail.com/
[2]: https://zlib.net/zlib_how.html
[3]: https://en.wikipedia.org/wiki/ZIP_(file_format)#End_of_central_directory_record_(EOCD)

--
Cheers,
Toon

---
Toon Claes (4):
      archive-zip: deduplicate code setting output buffer in write_zip_entry()
      archive-zip: remove unneccesarry condition in write_zip_entry()
      archive-zip: in write_zip_entry() call git_deflate() in a loop
      archive-zip: move git_deflate() with Z_FINISH into the loop

 archive-zip.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)
---



---

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250801-toon-archive-zip-fix-2deac42d5aa3

Thanks
--
Toon

