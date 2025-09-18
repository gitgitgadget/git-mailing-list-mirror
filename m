Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAD246795
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234094; cv=none; b=lp9GC0kUaQumgvuCkTPVx6fmOE9qcp4RkmszgELhM6Ryh66yzIdryDWg4BomakHaXZMGh547qtSrjrNJst9g+XFWYBNXgs9q1LSzdKP+Q7KCDfWaMJpx0RTkp0bNbWnVNHI6McohwOaXA3UvSgZEFsdZVaWqmsgNtwffoKWuvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234094; c=relaxed/simple;
	bh=RI8Mu8U2pUudjkX4w3f4H2QXNR0wZHaMgm0+zHeSUD8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nk1SwLe+69/FZ/+6nFem6DSSTdpmzwBb04ABwFE07mxM0QdW/zXbhGGNDd+ROUGQrZT7rim4E3AI+CNdTDoJMzEuBczdbB8R5cDNTxjic5wsUoRpiQvExDSZ/N7QVNo27qCX2OsvSvaVKIfKVe2R9uA9zlgGdB/b6RmqlTeYZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58IMLDPn1151963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 22:21:14 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kevin Puetz'" <PuetzKevinA@johndeere.com>, "'Jeff King'" <peff@peff.net>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>
References: <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com> <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net> <DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com> <20250918192045.GA1187769@coredump.intra.peff.net> <DS0PR05MB10013AC6090CEE7A562B56CBCB516A@DS0PR05MB10013.namprd05.prod.outlook.com>
In-Reply-To: <DS0PR05MB10013AC6090CEE7A562B56CBCB516A@DS0PR05MB10013.namprd05.prod.outlook.com>
Subject: RE: [Bug] git fetch --dry-run --filter makes changes to .git/config
Date: Thu, 18 Sep 2025 18:21:08 -0400
Organization: Nexbridge Inc.
Message-ID: <022401dc28ea$8be87d40$a3b977c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKjY+M+qfh1AtDXw1w9C+I4KJIs/QJw85heAXoFi6UBaDV8sQLxks67ssjmxNA=
X-Antivirus: Norton (VPS 250918-8, 9/18/2025), Outbound message
X-Antivirus-Status: Clean

On September 18, 2025 5:55 PM, Kevin Puetz wrote:
>> > I did find one odd quirk. When the remote and the requested commit
>> > are unrelated e.g. I'm taking to the wrong remote, or have done =
`git
>> > checkout --orphan`), I get
>> >
>> > $ git fetch https://github.com/git/git
>
> --negotiate-only --negotiation-tip=3D$COMMIT
>> > fatal: expected 'acknowledgments', received 'packfile'
>> >
>> > This still works for conan's purpose (exiting with an error means =
it
>> > didn't print a matching commit hash), but I expected something more =
like the
>"fatal: remote error: upload-pack: not our ref: ..."
>> > error that you get from git fetch {remote} --refetch $COMMIT. Of
>> > course, unexpectly sending a packfile could be a problem with =
github's server
>implementation, rather than the git client.
>>
>> I had never used --negotiate-only before, and did a simple test which
>> ended up with the exact same problem. I agree it's probably a bug, =
but
>> it's present in git.git itself (my fetch was to a local test repo).
>>
>> I'm not sure if the bug is in the server or client, though. If I
>> understand correctly, the server does not know anything about this
>> "negotiate-only" mode, but is just responding to the client. The
>> client is supposed to say "done" to tell the server that it is not
>> sending any more "have" negotiation, at which point the server sends =
the
>packfile.
>> But in this case the packfile comes anyway. Running with
>> GIT_TRACE_PACKET in the environment shows the client making an extra
>> request with no "have" lines at all, which the server then takes as =
an
>> indication it can send the packfile.
>
>Yep. In the cases where things work as expected, the client sends =
various `have`
>lines for ancestors of the negotiation-tips, and then the server sends =
"ACK ..." with
>the one it knows.
>
>When they are unrelated (none of the have lines are comits known to the =
remote),
>it replies with NAK (which is sensible enough). But then the client =
doesn't just error
>out after the NAK it keeps going. I guess because if this really was a =
fetch, rather
>than negotiate-only, and we have nothing in common with the server, =
we'd still
>need to fetch the wanted ref (and receive everything).
>But it *is* --negotiate-only, so we don't actually want anything =
either.
>Which leads to this weird empty request-for-nothing. Seems like the =
client Really
>should have just exited early after the NAK, given that it doesn't want =
anything.
>
>> So I think there is at least one client bug, which is making that
>> extra request. There might _also_ be a server bug, because it is
>> sending the packfile without a "done" line, even though it was told
>> the client wants the wait-for-done option (and the client does not =
even send a
>"want"
>> line at all, so what does it think it is sending?).
>
>Looking closer, I think the server bug is at
>
>https://github.com/git/git/blob/ca2559c1d630eb4f04cdee2328aaf1c768907a9e=
/
>upload-pack.c#L1805-L1813
>
>There's an early exit to UPLOAD_DONE (without sending any packfile) if =
you didn't
>want anything, But it's skipped over if you use wait-for-done, because =
that's the
>negotiate-only case, which still wants the acknowledgements.
>But then (during the weird empty client request) seen_haves isn't true =
either, So it
>skips the UPLOAD_SEND_ACKS case too. And it ends up just falling =
through into the
>final else { state =3D UPLOAD_SEND_PACK; }
>
>I think here the client was expecting the server to go into =
UPLOAD_SEND_ACKS, and
>just send an empty set of acknowledgements, which seems legal.
>https://git-scm.com/docs/gitprotocol-v2 says
>
>- If the server has found a suitable cut point and has decided to send =
a "ready" line,
>  then the server can decide to (as an optimization) omit any "ACK" =
lines it would
>have sent
>
>So I think the server could/should just reply with no "ACK" lines and =
"ready"
>(i.e. you don't want anything, but sure, I can send you an empty pack =
file).
>But it's definitely a corner case. And right now it wouldn't work, =
because
>https://github.com/git/git/blob/master/upload-pack.c#L1712-L1713
>
>would send NAK instead (which also seems legal, depending on how one =
interprets
>
>- The server will respond with "NAK" if none of the object ids sent as =
have lines
>were common.
>
>I think the client could deal with either "ready" or "NAK", it's just =
the empty pack it's
>not expecting.

If I might ask, and I realize this is an edge-condition, but what is the =
intent when
the clone has been done with a --depth=3D1 or similar? The single commit =
may not
be known locally but may be in the history as far as the remote is =
concerned. I am
just curious.

--Randall

