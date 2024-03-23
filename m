Received: from gavdos.tim-landscheidt.de (gavdos.tim-landscheidt.de [116.203.46.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7B514AA3
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.46.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211982; cv=none; b=Xc7cS2l4VE37k7jPvMUoBTvzORzjV7jtmTURhq4F6LLLkWFFt9cbKCE8eL0HFlZov+0FNgjR0On7R9i0uZGA5/rLiMlvvyQ1KhargR1p28P4fRT5Kah66ceLSB640zTzNJ5U+03Zur1rPsZNJLo3qW0KNt37QEAJMT2idIw0uO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211982; c=relaxed/simple;
	bh=hebAYSk3pqac3mNf2QP3uedR45Yx0BQn9hamS0urrrQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJFcXqoI0Jfj2+TuwkyMDImv1iNs5LOyXgNm47OV+fDSi310Tl/FZXIUCSb7d4eiDVwtltwd41IM/UH1kKL01AGCrh+pkHT7LPXHt7kY18sgSU+1iua8r7oJjyZLbcfjy8FAjYVPhvYSCuO2biykD2ql4B9QykLY8iKj/fR3Ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim-landscheidt.de; spf=pass smtp.mailfrom=tim-landscheidt.de; arc=none smtp.client-ip=116.203.46.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim-landscheidt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tim-landscheidt.de
Received: from [85.195.105.213] (port=54504 helo=vagabond)
	by gavdos.tim-landscheidt.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tim@tim-landscheidt.de>)
	id 1ro3uZ-00GM5V-1N
	for git@vger.kernel.org;
	Sat, 23 Mar 2024 16:07:59 +0000
From: Tim Landscheidt <tim@tim-landscheidt.de>
To: git@vger.kernel.org
Subject: Inconsistent/buggy behaviour of "git config --add"
Organization: https://www.tim-landscheidt.de/
Date: Sat, 23 Mar 2024 16:07:58 +0000
Message-ID: <87o7b5dj8h.fsf@vagabond.tim-landscheidt.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

with Git 2.44.0 on Fedora 39, the behaviour of "git config
--add", i. e., adding multiple lines to a configuration key,
is inconsistent and/or buggy:

| # git config section.key value0
| # git config --add section.key value1
| # cat .git/config
| [core]
|         repositoryformatversion = 0
|         filemode = true
|         bare = false
|         logallrefupdates = true
| [section]
|         key = value0
|         key = value1
| # git config section.key --add value2
| # cat .git/config
| [core]
|         repositoryformatversion = 0
|         filemode = true
|         bare = false
|         logallrefupdates = true
| [section]
|         key = value0
|         key = value1
|         key = --add
| # git config section.key --add
| warning: section.key has multiple values
| error: cannot overwrite multiple values with a single value
|        Use a regexp, --add or --replace-all to change section.key.
| #

So on one hand, "--add" must be given before the key to add
a line, but if on the other hand one passes the option after
the key and before the value, it is literally taken as the
value and the value does not seem to be interpreted as a
value-pattern, either.  However, if the value is missing,
Git correctly recognizes that this does not make sense.

My expectation of least surprise is that "git config
section.key --add value" should be equivalent to "git config
--add section.key value".

If that is not possible, I would expect "git config
section.key --add value2" to mean "change the values of
section.key to '--add' where they currently match the
value-pattern of 'value2'".

Tim
