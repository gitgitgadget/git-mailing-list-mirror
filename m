Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD431BC22
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930981; cv=none; b=No3GgbCJZTk/bxMn32KIZYyerK1qA5lMiNGvyDjosO/j6/w8RdfCGA2P41qLne43GCesr5UFbduR4z3WURASWMJEGcJkwAE/ZKZUonXdGz1exdPb0eHDl6gjyC5a2RJYfIIa+v6ORh5WiWeZgdTpwnFLLGAsCiUzaurVu+z74W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930981; c=relaxed/simple;
	bh=kTdi25PvIdHR1YbeeCEbTTqhbOdWx8lHtFMb5Qs+CUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTjU+lgQGrGl2imom7z4B8uCDhyLOIQ7KF9EyAZJH5GDF7Pw+8XzgJVR7nXth1MyNxDnu4dbjMCnri5sWUDFojFQXkrGvU4vXL3IcVhJZS3ynMjJTLCCtS5xP4/ypQnXyrJJPYqJN1G0sDVqN0AAsgvUZCLwZZiyWXhHEpam4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19222 invoked by uid 109); 26 Feb 2024 07:02:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 07:02:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32706 invoked by uid 111); 26 Feb 2024 07:03:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 02:03:00 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 02:02:55 -0500
From: Jeff King <peff@peff.net>
To: "Chen, Boyang" <Boyang.Chen@amd.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: CR position changed in exported patch file subject section
Message-ID: <20240226070255.GA780982@coredump.intra.peff.net>
References: <IA0PR12MB822711B89738EDA0E2F25150EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
 <IA0PR12MB822712F1B3E5205711493D55EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA0PR12MB822712F1B3E5205711493D55EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>

On Mon, Feb 26, 2024 at 05:53:19AM +0000, Chen, Boyang wrote:

> D:\Source\CustomerRepoTest\Platform1>git log -3 commit 0c9f8555c55c73fd4e5392c8f8516c389f362d17 (HEAD -> test)
> Author: Boyang Chen
> Date:   Mon Feb 26 11:16:00 2024 +0800
> 
>     Add a file to test, make make sure that the message is a bit long but in a single line
> 
> We can confirm that the commit message is in a single line in the output of git log command(pls refer to above output).
> 
> And use below command to generate a patch file.
> git format-patch -3 --stdout  >  exported_3.patch
> 
> We can observe that the commit message's CR position is changed in the
> exported patch, the subject section is split to two lines(pls refer to
> below output).

This is expected. The format-patch command is generating an email, and
rfc2822 says:

   Each line of characters MUST be no more than 998 characters, and
   SHOULD be no more than 78 characters, excluding the CRLF.

But we can make the subject arbitrarily long by using header
continuation; the line after the "Subject:" should start with
whitespace, which indicates to a parser that it is a continuation of the
previous header.

You don't show that here:

> From 0c9f8555c55c73fd4e5392c8f8516c389f362d17 Mon Sep 17 00:00:00 2001
> From: Boyang Chen
> Date: Mon, 26 Feb 2024 11:16:00 +0800
> Subject: [PATCH 3/3] Add a file to test, make make sure that the message is a
> bit long but in a single line

but I'm not sure if it's really missing, or if the whitespace got munged
as you sent it. Assuming it is, then everything is working as designed.

That said, I have sometimes been annoyed at this myself, because I want
to process the mails with tools that are quite capable of handling long
lines (e.g., mutt). And doing hacky processing with perl, etc, becomes
harder because you have to actually parse the mail correctly rather than
just grepping for "^Subject:". ;)

So I have wondered if it would be useful to have a --no-wrap-email
option. Or perhaps the existing --no-encode-email-headers should be used
as a hint that the user prefers easy-to-parse output over strict rfc
compliance.

-Peff
