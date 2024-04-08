Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FB1442F2
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597202; cv=none; b=SuQeHBVMk9HkJGpLnDImuqNYqq7SArK+JUXGMeWUxYD/aXl8vBznbu5mZvKOdLg1MqH3Bdibwpg1ea63NyI8+ZScLhvThDZmn8vLW+I+rqNK8P70p5CqTvtJV77HQA3aeizethAMma2sZwFSaZSih2DeAHPciA5qc4/+M7yy+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597202; c=relaxed/simple;
	bh=C6OvtjYTlA047KXbfQkJF9Vg3JAa1Isi7bsu/lr/NdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODy/E+jHTlfytQYrQEWX8KbfePRcgSEvJm+8335Gcw4h/aMSiPeOHvTCcasJ/ZP+S6xA6zYGJgxnT8VksFUJV4s6eJ+bx7qPhMXqot6tuscEXfVDiIygxGfobtYraMPgelGt5j3qeFszgR0UqMgnhkn5SQxVUWbp72px6B6XWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30931 invoked by uid 109); 8 Apr 2024 17:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Apr 2024 17:26:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27358 invoked by uid 111); 8 Apr 2024 17:26:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Apr 2024 13:26:39 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Apr 2024 13:26:38 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <20240408172638.GB1629595@coredump.intra.peff.net>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
 <CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
 <xmqqpluzet2z.fsf@gitster.g>
 <ZhQZsq5_NyXmWM-b@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhQZsq5_NyXmWM-b@tanuki>

On Mon, Apr 08, 2024 at 06:22:10PM +0200, Patrick Steinhardt wrote:

> On Mon, Apr 08, 2024 at 09:07:32AM -0700, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > 
> > > I was going to suggest that you could accomplish this more easily
> > > directly in shell (without employing `awk`):
> > >
> > >     {
> > >         echo start &&
> > >         printf "create refs/heads/branch-%d HEAD\n" $(test_seq 0 9999) &&
> > >         echo commit
> > >     } >input &&
> > >
> > > but then I realized that that could potentially run afoul of
> > > command-line length limit on some platform due to the 0-9999 sequence.
> > 
> > As xargs is supposed to know the system limit, perhaps
> > 
> > 	test_seq 0 9999 | xargs printf "...%d...\n"
> > 
> > should work?
> 
> Is there a reason why we want to avoid using awk(1) in the first place?
> We use it in several other tests and I don't think that the resulting
> code is all that bad.

Using awk is fine, but I think in general if we can do something just as
easily without an extra process, that is preferable. Using xargs here
does not to me count as "just as easily". However, using a shell loop
might actually be more readable because you'd avoid the extra quoting.
I.e. either:

  for i in $(test_seq 10000)
  do
	echo "create refs/heads/branch-$i HEAD"
  done

or:

  i=0
  while test $i -lt 10000
  do
	echo "create refs/heads/branch-$i HEAD"
	i=$((i+1))
  done

I think the first one actually incurs an extra process anyway because of
the $(). The second one would not. Of course, the second one probably
needs &&-chaining and a "|| return 1" to work in our test snippet.

IMHO the nicest thing would be if our test_seq could take a format
parameter, like:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2eccf100c0..c8f32eb409 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1404,6 +1404,13 @@ test_cmp_fspath () {
 # from 1.
 
 test_seq () {
+	local fmt="%d"
+	case "$1" in
+	-f)
+		fmt="$2"
+		shift 2
+		;;
+	esac
 	case $# in
 	1)	set 1 "$@" ;;
 	2)	;;
@@ -1412,7 +1419,7 @@ test_seq () {
 	test_seq_counter__=$1
 	while test "$test_seq_counter__" -le "$2"
 	do
-		echo "$test_seq_counter__"
+		printf "$fmt\n" "$test_seq_counter__"
 		test_seq_counter__=$(( $test_seq_counter__ + 1 ))
 	done
 }

Then you could just write:

  test_seq -f "create refs/heads/branch-%d HEAD" 0 9999

and I suspect there are several other spots which could be simplified as
well.

Anyway, I don't think it is worth derailing your series for this, but
just general food for thought.

-Peff
