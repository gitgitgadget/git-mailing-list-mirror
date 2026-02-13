Received: from naumann.dschung.com (naumann.dschung.com [5.9.77.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017127EFE3
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.9.77.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017440; cv=none; b=Wj6fiDOaDifNExEUJ8OJW4Ju0pfyvueZ6dnsVcOl+3aFHzKH44aRJ+VjqRYm+6nj0eqAY3f9j8rtqMtiOwn0MXqesh5w1oYqwMO9nDJpKaNnmAp3dVS3WTF4LCmc6NU8F9iGcMrdJDpJBU4GK2+Npb2CmPRHLFAPONYfDD/nzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017440; c=relaxed/simple;
	bh=BSLI3FvAy0dQDfElOr/3HAxxAlczUiPJ1u8JeYcGd9E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WtVNvXEatHWVGk2u9q0Ya0Wf0wSowYgfHHCGM5PgQTcWRyfRoscZk/KpJFSOaNu7GM9Kt4fI9ESq/SJ5hzrKBbhUz6uAuHKQjryz9WmjjIG8b2DBieXKCo+3rOtpEKmMt9lPtX7kQ5OTq6GuJhO4lgR+reuZ029gymEWTWcqGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chkpnt.de; spf=pass smtp.mailfrom=chkpnt.de; arc=none smtp.client-ip=5.9.77.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chkpnt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chkpnt.de
Received: by naumann.dschung.com (Postfix) with ESMTPSA id 844EF5F7B30E
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:09:30 +0100 (CET)
Message-ID: <e5904a7b-c146-4c36-8b87-c5c508e14cca@chkpnt.de>
Date: Fri, 13 Feb 2026 22:09:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
To: git@vger.kernel.org
From: gregor@chkpnt.de
Subject: Question: --since date parsing uses current time instead of midnight
 - by design?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've just noticed how git log --since=<date> interprets dates without 
explicit times, and I found the behavior seems potentially unintended. 
I'd like to understand if this is by design or a bug.

When using --since="2026-02-09" (date without time), Git uses the 
current local time at command execution, not midnight (00:00:00) as 
users might expect.

For example:

     Running git log --since="2026-02-09" at 21:20:00 interprets it as 
"2026-02-09 21:20:00"

     Running the same command at 09:00:00 interprets it as "2026-02-09 
09:00:00"

This means the same command returns different results depending on when 
it's executed.

Root Cause (in date.c)

The issue stems from the two-stage parsing in approxidate_careful():
1) parse_date_basic() parses the date fields (year, month, day) but 
fails because time fields remain at -1, causing tm_to_time_t() to return -1
2) Falls back to approxidate_str(), which:
   - Calls localtime_r() to initialize tm with current time
   - Resets only date fields to -1 (year, mon, mday)
   - Re-parses the string, overwriting date fields
   - Time fields retain values from current local time
   - update_tm() calls mktime() with this mixed result

Is this behavior intentional? The approxidate mechanism is designed to 
be "human-friendly," but this seems like an edge case where users likely 
expect --since="2026-02-09" to mean midnight.

Explicitly specifying the time works correctly as a workaround:

--since="2026-02-09 00:00:00"
--since="2026-02-09T00:00:00"

Should this behavior be documented, or would a patch to default to 
midnight be appropriate?

Regards,
Gregor
