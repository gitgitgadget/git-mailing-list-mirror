Received: from ambassador.madduck.net (ambassador.madduck.net [188.174.253.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500DDDB5
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=madduck.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=madduck.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=madduck.net header.i=@madduck.net header.b="qshmSUfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=madduck.net;
	s=2015-11-14; t=1704961682;
	bh=ZH++WICiDuHr7vWCDaWTRPcAJh+DikD4MG0Y4CXnilQ=;
	h=Date:From:To:Subject:From;
	b=qshmSUfUCMAZhhtpADwqC1u9WGv40rvWN6KqIKMPCud96dqTY0sSg663am8xIR8VP
	 doPxGzbmSTb0iX1/GCfLnOsc9kKr82xjJHc1d4AhiH75V/aTk2iv7esISij998RD6W
	 Gp1kaVcIAcvlIITv6fawlH18rjb9TsZFIX9qcpXY=
X-MadduckNet-Submission: from lotus.rw.madduck.net (ppp-93-104-80-87.dynamic.mnet-online.de [93.104.80.87]); Creds Client CN "lotus.rw.madduck.net", Issuer "R3" (not verified)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.3 at ambassador.madduck.net
Date: Thu, 11 Jan 2024 09:28:02 +0100
From: martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
Subject: gitweb: Exiting subroutine via next at /usr/lib/cgi-bin/gitweb.cgi
 line 3142
Message-ID: <20240111082802.ilmtwupekkbxqznw@lotus.rw.madduck.net>
X-OS: Debian GNU/Linux trixie/sid kernel 6.5.0-3-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; markup=markdown; format=flowed
Content-Description: Plain-text version
Content-Disposition: inline

Hi team,

I get tens of thousands of messages like

```
[Thu Jan 11 09:01:11 2024] gitweb.cgi: Exiting subroutine via next at /usr/lib/cgi-bin/gitweb.cgi line 3142.
```

in my logs, presumably from crawlers hitting the CGI wrongly. This 
is using gitweb 2.39.2.

I know no Perl whatsoever, but it's my impression that the following 
patch would solve this:

```
--- /tmp/gitweb.cgi	2024-01-11 09:07:47.283764508 +0100
+++ /usr/lib/cgi-bin/gitweb.cgi	2024-01-11 09:01:43.459218235 +0100
@@ -3139,7 +3139,7 @@
  				my $path = substr($File::Find::name, $pfxlen + 1);
  				# paranoidly only filter here
  				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
-					next;
+					return;
  				}
  				# we check related file in $projectroot
  				if (check_export_ok("$projectroot/$path")) {
```

This is within the wanted sub for `File::Find::find`, and it returns 
next so as to skip the currently visited file during the tree walk. 
Returning a false value, which `return` without an argument 
presumably does, should have the same effect.

Cheers,

-- 
martin krafft | https://matrix.to/#/#madduck:madduck.net
 
"it usually takes more than three weeks
 to prepare a good impromptu speech.
                                                       -- mark twain
{: .blockquote }
 
spamtraps: madduck.bogus@madduck.net
{: .hidden }

