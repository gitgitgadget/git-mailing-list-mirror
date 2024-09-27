Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13570EEAA
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727479927; cv=none; b=L3pbThAQH5jO9uf2ZwMNVfxRbLdrDwyOtgW8fU/yQIS5rd1kqUewGSxjcDA39XshLzv4LzCu3rVZCVND/471wFCpoJdd+z26vObNloMgxtm6Or0O2TDX1G11gK62g/sYkkvfiQB1aaQ50DllTUG4Q1s/1dtfBaj9GBX32iJbeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727479927; c=relaxed/simple;
	bh=0mZ06s0AEttuKh7EJb7a82SQnYCiKr+su6/3GmeHvlE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VE2s4zLQECDMfeMgZ65H87T069YgPvYb72of6U9kxKtpVDcSkyISqjS/mjepcXaOrYHo8FH7NRV54TLeD8X9V871BhUiQV17II6bs9dIw36mDm1fJxtoVNS19aVIBiElrM+yaopoyLrLntFiCdZ2PHt3Woeojgt/psZEQe94ZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48RNVrsR2010796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 23:31:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc: <git@vger.kernel.org>, "'John Cai'" <johncai86@gmail.com>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Michael Haggerty'" <mhagger@alum.mit.edu>
References: <20240731134014.2299361-1-christian.couder@gmail.com>	<20240910163000.1985723-1-christian.couder@gmail.com>	<xmqqikuijni0.fsf@gitster.g>	<CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com> <xmqq34lkg1ck.fsf@gitster.g>
In-Reply-To: <xmqq34lkg1ck.fsf@gitster.g>
Subject: RE: [PATCH v2 0/4] Introduce a "promisor-remote" capability
Date: Fri, 27 Sep 2024 19:31:48 -0400
Organization: Nexbridge Inc.
Message-ID: <036901db1135$7024a430$506dec90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG1JrIma4QpnZcfMioqA84wQO6p5gGxR1wJAlFUMykCh5BamQHL0RT1snVtEUA=

On September 27, 2024 6:48 PM, Junio C Hamano wrote:
>Christian Couder <christian.couder@gmail.com> writes:
>
>> By the way there was an unconference breakout session on day 2 of the
>> Git Merge called "Git LFS Can we do better?" where this was discussed
>> with a number of people. Scott Chacon took some notes:
>>
>> https://github.com/git/git-merge/blob/main/breakouts/git-lfs.md
>
>Thanks for a link.
>
>> It was in parallel with the Contributor Summit, so few contributors
>> participated in this session (maybe only Michael Haggerty, John Cai
>> and me). But the impression of GitLab people there, including me, was
>> that folks in general would be happy to have an alternative to Git =
LFS
>> based on this.
>
>I am not sure what "based on this" is really about, though.
>
>This series adds a feature to redirect requests to one server to =
another, but does it
>really have much to solve the problem LFS wants to solve?  I would =
imagine that
>you would want to be able to manage larger objects separately to avoid =
affecting
>the performance and convenience when handling smaller objects, and to =
serve
>these larger objects from a dedicated server.  You certainly can filter =
the larger blobs
>away with blob size filter, but when you really need these larger =
blobs, it is unclear
>how the new capability helps, as you cannot really tell what the =
criteria the serving
>side that gave you the "promisor-remote" capability wants you to use to =
sift your
>requests between the original server and the new promisor.  Wouldn't =
your
>requests _all_ be redirected to a single place, the promisor remote you =
learned via
>the capability?
>
>Coming up with a better alternative to LFS is certainly good, and it is =
worthwhile
>addtion to the system.  I just do not see how the topic of this series =
helps further
>that goal.

I am one of those who really would like to see an improvement in this =
area. My
community needs large binaries, and the GitHub LFS support limits sizes =
to the
point of being pretty much not enough. I would be happy to participate =
in
requirements gathering for this effort (even if it goes to Rust =
=F0=9F=98=89 )
--Randall

