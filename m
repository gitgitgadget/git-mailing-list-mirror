Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B751459F6
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071174; cv=none; b=tsabZOJWqjpUmn+qUcQokve6NhLm8DnQI0iaDSRKnumveYgJJ1PSMrM+xXjakAdRHtJpwSHGCXLh6fBbk83DuyTGrykXuxE+Q3b8MuW2hchMZoM3sczQG7FmIfSMeFtPqp6Vhp2B5UvgDTSXzc3Hy4Y9SR4omONd5b6RTMy/FW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071174; c=relaxed/simple;
	bh=AGRN6/wriz7/0fKcsJWO10yT3Iuxy7F/j5OWNy9C0j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P10EYMs7IKQFhiY75MoirXekWXWHxfhLzUH5w/J1Lc300JtGIqWXNJ7aJE4SJEJBAhXCkfUIfXYcgKgVbBvHA1htlMAKIxsgPmCdqAUzynGUButZGMKWrgACOE71yBHEESWgPlU9lB2lmzF7h1E8CbUg5Od55puRS/2YmVSN/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbpWT-009Rnu-1E;
	Wed, 07 Aug 2024 22:52:49 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbpWQ-005QS9-0U;
	Thu, 08 Aug 2024 07:52:46 +0900
Date: Thu, 8 Aug 2024 07:52:46 +0900
From: Mike Hommey <mh@glandium.org>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 2/6] repository: add initialize_repo wrapper without
 pointer
Message-ID: <20240807225246.7jhqioyqh4e2ibza@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover.1723054623.git.steadmon@google.com>
 <5f2e816cf6359725f2a86ce1d08e5e272fba4dac.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2e816cf6359725f2a86ce1d08e5e272fba4dac.1723054623.git.steadmon@google.com>

On Wed, Aug 07, 2024 at 11:21:27AM -0700, Josh Steadmon wrote:
> Non-C external consumers of libgit.a have to redefine the `repository`
> object in their own language if they want to call
> initialize_repository() to ensure memory for the object is allocated
> correctly. This is not ideal for external consumers that have no need
> for the entire `the_repository` object but need to call other functions
> from an initialized repository. Therefore, add a friendly
> initialize_repository() wrapper without a `the_repository` pointer.

Technically speaking, you don't really need this.

You can define `repository` as an opaque type in Rust:
```
#[allow(non_camel_case_types)]
#[repr(C)]
pub struct repository([u8; 0]);
```

And define `the_repository` as an extern symbol:
```
extern "C" {
    pub static mut the_repository: *mut repository;
}
```

Mike
