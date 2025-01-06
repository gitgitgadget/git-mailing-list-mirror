Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C01C69D
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175956; cv=none; b=Tj5Ixt4Bmvo0FgQTWOzZ3YDTaQzhlR8LS5kNLhyUvduWsDas1xWS6kZD0PeMuKaglAg7NNdDT2F2Vo21OFQ5z9Mg8ARF3OJJnRPeAnUiQ9x0zqH8GqM2fQ6M15eEJ75Hta/7aT71N0uK+a4ZyZ3/wmu7tKT9FPt1b2HXnJYZbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175956; c=relaxed/simple;
	bh=1P8cqNy2tPgaO1Nn819OjAIOUOy5F49yQNgtW5PzHMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXpqnIXvquvfLChDxrRaB6kRpSJL6rTp/Y7yDOpQsSJku81IZTyFFRxtIAZBW9AuUgFkSkIs6U29tZkQvVvzdrMRW8cdeASVO705xQXSnmBneZCuNjg9+TWDR4hK9Hba7NkCyICVtuofi5y76MyLU5T8jireVdwhfyKbzDuTHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cYQWfAca; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cYQWfAca"
Received: from cwcc.thunk.org (pool-173-48-117-149.bstnma.fios.verizon.net [173.48.117.149])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 506F5ngc031232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 10:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736175951; bh=jCoMljZnikaosDuR/oGDaoDl2LT8YKbvsb9g92fJRWw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=cYQWfAca6PADjgOy8QWPdBXkHGIlMLSObQbJYiWNDzL47KcqpYXIuBLxM0J6r+u3i
	 jiVmK110WLtz55QGmS0/CU9djbfTvQ2psPueC7auWuCsaxbwN6nI1nAIGwjIXlF+/v
	 4bua8Ov0iJ7yVTs/QfksfRkmWW5xyAhDHdXNOvOpN9xxOJUADxxttvEPGQQNCDwFsj
	 Y84ZtT0YtOwCd1Fgvs2IRndjF2hMlP1bw6cCr9HplMbiEHgxiUwbsPXLfIMOvORMwe
	 veUyZFh+Sg8ig53W8sg68HyXCENac+fuVHfUpvO0zBW5NGSikTZWMhoQk2O/P6LCDk
	 oGJxA0cK9H/GA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 49A8315C0164; Mon, 06 Jan 2025 10:05:49 -0500 (EST)
Date: Mon, 6 Jan 2025 10:05:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chris Packham <judge.packham@gmail.com>
Cc: GIT <git@vger.kernel.org>
Subject: Re: Testing for existence of a remote branch from a script
Message-ID: <20250106150549.GE1284777@mit.edu>
References: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>

On Mon, Jan 06, 2025 at 05:40:36PM +1300, Chris Packham wrote:
> I look after some scripts we use at $dayjob for pushing changes though
> our review system.
> ..
> Is there a better way of checking for the existence of a remote branch?

In gce-xfstests[1] I do this via "git ls-remote":

validate_branch_name()
{
    if test -z "$GIT_REPO"
    then
        echo "GIT_REPO is neither found in the config file nor provided with --repo"
        exit 1
    fi
    if [[ "$GIT_REPO" != *".git" ]]; then
        GIT_REPO="$GIT_REPO.git"
    fi
    if ! git ls-remote "$GIT_REPO" > /dev/null; then
	echo -e "Repo not found: $GIT_REPO\n"
	exit 1
    elif ! git ls-remote --heads  --exit-code "$GIT_REPO" $1 > /dev/null; then
	echo -e "$1 is not a valid branch of $GIT_REPO"
	exit 1
    fi
}

See run-fstests/util/parse_cli[2] for this function, and a related
function, validate_commit_name if you also want to accept git tags.
(The validate_commit_name function isn't perfect, since I don't want
to fetch the full git repo to validate a SHA hash specifier, but it's
good enough to validate typo'ed tag or branch names.)

[1] https://thunk.org/gce-xfstests
[2] https://github.com/tytso/xfstests-bld/blob/master/run-fstests/util/parse_cli

Cheers,

						- Ted
