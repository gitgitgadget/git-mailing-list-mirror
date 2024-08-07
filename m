Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604F145B38
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073366; cv=none; b=P+OEquLQFSvy6O6+mxK4dFYihhg3+p+zEJzLyBLoaYxEI/qxsSDANsTYX7CbRmYJdHqUKQE6U8ksVPVxf29uVw/ktrdLCEWL7ujRQ3rLDE5sCVN+FXHAZJYTsX4S+Ub/S1Bu3VCh4aD52JnND0PI/zftQkQmPB08mgjG6XnZ7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073366; c=relaxed/simple;
	bh=CPJOVQbd/991aTJhosuCYKbjC4dUTjYetIuuqufhWyo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSQlHzHk4ET+QDsoNOWCRc/QcUZdrFUjWTg9WtuoZTn9jnc4VvpGlsQy3q2W6TfKxDfXwhtGXeOqqxhWl3rTGN4GmpmMWG7sdWN8GTlVTEAnb4jDDf/6L22Np/yJxuIR7P9g2HOMDEeEr7ifNjFNxW7l8V148D6C8HWFuaWC3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbq5o-00A7I2-2s;
	Wed, 07 Aug 2024 23:29:21 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbq5k-005Uai-0L;
	Thu, 08 Aug 2024 08:29:16 +0900
Date: Thu, 8 Aug 2024 08:29:16 +0900
From: Mike Hommey <mh@glandium.org>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 2/6] repository: add initialize_repo wrapper without
 pointer
Message-ID: <20240807232916.as2jaivlbvk6pa3r@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover.1723054623.git.steadmon@google.com>
 <5f2e816cf6359725f2a86ce1d08e5e272fba4dac.1723054623.git.steadmon@google.com>
 <20240807225246.7jhqioyqh4e2ibza@glandium.org>
 <5miqrfkepbzi4qzu65invte3tk7weshq2fcnkyufnoih3ou6rp@siodpag6csmy>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5miqrfkepbzi4qzu65invte3tk7weshq2fcnkyufnoih3ou6rp@siodpag6csmy>

On Wed, Aug 07, 2024 at 04:23:05PM -0700, Josh Steadmon wrote:
> On 2024.08.08 07:52, Mike Hommey wrote:
> > On Wed, Aug 07, 2024 at 11:21:27AM -0700, Josh Steadmon wrote:
> > > Non-C external consumers of libgit.a have to redefine the `repository`
> > > object in their own language if they want to call
> > > initialize_repository() to ensure memory for the object is allocated
> > > correctly. This is not ideal for external consumers that have no need
> > > for the entire `the_repository` object but need to call other functions
> > > from an initialized repository. Therefore, add a friendly
> > > initialize_repository() wrapper without a `the_repository` pointer.
> > 
> > Technically speaking, you don't really need this.
> > 
> > You can define `repository` as an opaque type in Rust:
> > ```
> > #[allow(non_camel_case_types)]
> > #[repr(C)]
> > pub struct repository([u8; 0]);
> > ```
> > 
> > And define `the_repository` as an extern symbol:
> > ```
> > extern "C" {
> >     pub static mut the_repository: *mut repository;
> > }
> > ```
> > 
> > Mike
> 
> I've actually already done a refactor for V2 that will avoid using this
> patch entirely, but thank you for the pointer. We do something similar
> to opaquely wrap configset pointers in a later patch (we use an empty
> enum there, I'm not sure whether that approach or a zero-size array is
> preferred).

An empty enum is a never type, I wouldn't recommend using it as an opaque
wrapper. It will likely lead to the compiler doing bad things.
https://rust-lang.github.io/never-type-initiative/RFC.html

`#[repr(C)]` and `[u8; 0]` are recommended by the nomicon.
https://doc.rust-lang.org/nomicon/ffi.html#representing-opaque-structs

(the PhantomPinned wasn't there last time I saw that page)

Mike
