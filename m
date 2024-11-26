Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35021CDFD5
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634365; cv=none; b=EJ68zxhT3J/8VWsgj5A+4QHrnmCIHVKP/TfRDcYJR8JQ0IUIIXbUIiRKtmTlQVzZamSKrJ5iNKzsuXeGbFQvSSVIujBWyNkQn+UVHSmQtNkuWLksGV3FOqEJVb7gnXGAWD7yTrzJxFT4kH4fIZaTxMnParfhCSDsplcUBYuxvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634365; c=relaxed/simple;
	bh=3CpRFRXp+yyqziybTln9feF4LAdbrhsFalm9HHnrTZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI+JsCUgPwO1Phm1zTFeZ59FWYZSCUWI14//LZXiZqPueNVbGk5qGhZXa5ZDzssZWEZnvjKGxvdqvr1wQUa/D9a7XEoilpNaIbGCCDUBYsfznWiz9Wrr+C0sIjYqeproShzmk4ypDooiAPcwzmBIx20N84g3YnBbswsJ9NIxCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t5rqg0ql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t5rqg0ql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4E0C4CED9;
	Tue, 26 Nov 2024 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732634364;
	bh=3CpRFRXp+yyqziybTln9feF4LAdbrhsFalm9HHnrTZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5rqg0qlPw89w9DWGwt3oihKCzrcgVvdjfulm6t4dGY4yJOLFSJef4mBZrNhNuHpl
	 mx4jGj00v4o0blXVJnt7FtrIMEKkJANl5mqytlosNIstnYQ3u7bBO+Wgvcfwic6T7/
	 jY8FrMekGTDKI566PlEr/IpemMJkBaDuijTghunU=
Date: Tue, 26 Nov 2024 10:19:21 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [question] When an identical file is added
Message-ID: <ortjg2pjq6eb6ruz72mcalemqgjr7lqoleqxpiqlghzu3ibwzj@rhvqxlpnkcl2>
References: <lSW86a4L1xWHfSTWIq732o26YCBCIN_B0rd6B1bCP8VIAY8d1V9pD1WEcCyW7Wyw2T14VVYka5XMTwJGFZEKcovBYIgOBUO5lbPWQ44cIfM=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lSW86a4L1xWHfSTWIq732o26YCBCIN_B0rd6B1bCP8VIAY8d1V9pD1WEcCyW7Wyw2T14VVYka5XMTwJGFZEKcovBYIgOBUO5lbPWQ44cIfM=@proton.me>

On Sun, Nov 24, 2024 at 02:24:19AM +0000, A bughunter wrote:
> Q. May this overwrite the same object file because it is the same file? or because it is immutable will it reuse the old object file?
> A. When an identical file is added the old object shall be _ANSWER_HERE_

The file contents are represented as a "blob" inside the git repository, so
when you add a file with identical contents, the existing blob will be reused.
The file metadata (permissions, name, timestamp, etc) will be recorded as part
of the tree information. If the tree information is exactly identical to an
existing tree in the repository, then that tree object will also be reused.

Basically, for any object that it operates on, git will calculate the
checksum. If it then finds an identical checksum already present in the tree,
git will just use that existing object instead.

Reusing objects happens all the time in git. For example, imagine the scenario:

0. you have an existing repo
1. you add a file foo.c, and git commit
2. you change your mind and delete foo.c, and git commit
3. you decide you want foo.c after all, re-add it, and git commit

All tree and blob objects are identical in steps 0,2, and 1,3. However, commit
objects will be different in all 4 states.

-K
