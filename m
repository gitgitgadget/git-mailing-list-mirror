Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6C72610
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.148.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554180; cv=none; b=mLtkNo8WXbzZCf/OJLXZYlcp+v+EjhKNiY6jiq74MDnBWeFBkrToBRd5+Xu+r7NLrEqINgldAzEu1K3xLIJQJHjFUTGW2pSrfNb9Je6TCmCGVbuBi2Ryxlar2OVepj7zmi+HGeT5KcYJAbkWEB+wUwNRmZLGjrdgOkWzBej+FRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554180; c=relaxed/simple;
	bh=Coz4eP/JbtdLFW7cJYyh2EqK0kMtsWctfeKGkABUH04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c2JYTOTcVknSWFViTCK2gQQQ1g4No0fyTotaC3hpkyb6V8a0nZOGYObDscTiY7pi/wgUwqlWqdd2BLyp4P6N4tP9KuONpCsX7tr9h4yWRjO81r6NSRto3m2d7PHDhevaiVO5U2vOHoapE3kOhqA5FwsDBryWP/pYtuixed3g+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesynthesis.com; spf=pass smtp.mailfrom=codesynthesis.com; dkim=pass (2048-bit key) header.d=codesynthesis.com header.i=@codesynthesis.com header.b=kQP6VV4X; arc=none smtp.client-ip=188.40.148.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesynthesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codesynthesis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codesynthesis.com header.i=@codesynthesis.com header.b="kQP6VV4X"
Received: from brak.codesynthesis.com (unknown [105.184.106.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by codesynthesis.com (Postfix) with ESMTPSA id ED7FD5E5A5;
	Thu,  3 Jul 2025 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
	s=mail1; t=1751553608;
	bh=Coz4eP/JbtdLFW7cJYyh2EqK0kMtsWctfeKGkABUH04=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:From;
	b=kQP6VV4X+GbEy0RyA0dSG0JD/cAs1Q8miUQcTfmD11VC/mpAA8cYq71zvsu61MorC
	 OQNTNE7ed6OROBey+denV0cSKWqygiOHxRrIOXNhaBeT7l3F+pGZhWRYLO1BPKoDqV
	 JPe6qrbOGlDa/pT4ISPEb+eqUGXYNHSP+GXe4Sg+0tJ8WTldlVKNN1mjX2G791L/zq
	 vcriMHFHbz9oha9jifFYivf5FKzsgrG1aj4Ep88cx2wrCH4mtRS8UgBpWDz8/HpRSz
	 Ag/KTUAZEXrl5uXPyyTSrjh60xBkJ86/GZsndLAptvohJPA6rJBC9pElEYf2WrxYCc
	 B39P1Euh5SNIg==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
	id 6C6C3141030; Thu,  3 Jul 2025 16:40:02 +0200 (SAST)
Date: Thu, 3 Jul 2025 16:40:02 +0200
From: Boris Kolpackov <boris@codesynthesis.com>
To: git@vger.kernel.org
Cc: karen@codesynthesis.com
Subject: Document ability to disable template directory in git-init
Message-ID: <boris.20250703161436@codesynthesis.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Code Synthesis

Hello,

Looking at the git-init(1) man page, there doesn't appear to be a way
to disable copying the contents of the default template directory, other
than passing a path pointing to an empty directory.

However, if one passes an empty path, for example with the --template
option, then git does not complain and does not copy anything:

git init --template=

Looking at the code, this undocumented (AFAICS) behavior appears to
be there at least from git 2.1:


static void copy_templates(const char *template_dir)
{
	...

	if (!template_dir)
		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
	if (!template_dir)
		template_dir = init_db_template_dir;
	if (!template_dir)
		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
	if (!template_dir[0])
		return;


For reference, the corresponding code in 2.50:


static void copy_templates(const char *option_template)
{
	const char *template_dir = get_template_dir(option_template);
	
	...

	if (!template_dir || !*template_dir)
		return;


I would like to suggest that we document this behavior so that it can
be relied upon. The motivation for omitting the default template are
repositories created by tools, such as package managers, for the sole
purpose of fetching some information from remotes. In this case all
the stuff copied from the template (such as hooks) is an unnecessary
waste of time and space.

Looking at the git-init(1) man page, the TEMPLATE DIRECTORY section
seems like the natural place to document this semantics. For example,
we could add the following sentence after the list of all the places
where the template directory can be specified:

"If the specified template directory is an empty path (for example,
--template=), then no template will be copied."

Let me know what you think.


Thanks,
Boris
