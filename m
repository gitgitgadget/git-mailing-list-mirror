Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665991C232B
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759151; cv=none; b=XXhIpmCvZu6YE1ugoKanyhiJRRSsZFvHOaA5z4tN3AVHLKr88yIXpHfl+ZmX7UUUYh7G2tewbPHz/YI1P+BcCSrvkJ1QfqKrerDl4iHManjpvvHpfyknYP9kX6Oo3X/ml6W0rtsbgGWEUsWhdi/cTYJUyQeX1PTRxFGNPmsyZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759151; c=relaxed/simple;
	bh=fyGAwTFUc5iqz0h7bBJaNM5AknSS2e/+zrpcK+HCftg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaE5EcGzE4KVk+z70nKMXJ6tlXauJ5nfTMhjkK4zUlghl+6VzlSlMgZHTeQ9pYEcdcOfQREl9iQ5qKzlqAAV1E3HepSL8Xwb5TPr4QIt1EJ73jPsR6TUPOBil2Nkwt90d15GbBoNLvmUC5ydWtXHyFTsKpoW99GqKkS2kauWF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saVMIRri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saVMIRri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6C5C4CED6;
	Mon, 13 Jan 2025 09:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736759150;
	bh=fyGAwTFUc5iqz0h7bBJaNM5AknSS2e/+zrpcK+HCftg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saVMIRrimo6A8CM5t4aC4jcWQkC6OXpP9lpI4Y2mK4WM4ScbN8Huee62pKAROWc8+
	 eI9QjpdcGpF+cHaO257yJ0OKDcEvxY45UCzZPztga8MNaAJ09Ln0JH01mY2+zwLjzS
	 mXxx9gyYUx5Ov9ZfAUNi79UNZzd3i5dk0dHYeunChJcJgdxM36UuPF7G8qtWhfdpdW
	 OAkU6F0iU+MGrkII7K9O3IQJbv55+cj7s0mr8NuByhBYIuiYtksGdinJNsZTmAna9K
	 uhY1qZLpAR2GZRRcGk+ybCu8WIXaME8bRQ2CVoCatdDq+3iOsv+sKFS74/NUtDooLE
	 EVWloEYcMXHlw==
Date: Mon, 13 Jan 2025 10:05:46 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [Bug report] signingKey beying bypassed
Message-ID: <47yfez6r4f4jitps3re23q5vp6vzjas5624f2mp3looocc2myg@vineab4jdxdl>
References: <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>
 <20241216113543.GD2201417@coredump.intra.peff.net>
 <cw6ggzhw4o5c5v5juh7sx2ubfaidnzugxx3ydgfvdlywqhndzf@6rfdfajvscif>
 <20250107030025.GA21698@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107030025.GA21698@coredump.intra.peff.net>

Hi Jeff, sorry the delayed reply.

On Mon, Jan 06, 2025 at 10:00:25PM -0500, Jeff King wrote:
> On Mon, Jan 06, 2025 at 03:55:32PM +0100, Carlos Maiolino wrote:
> 
> > >      If git is passing the correct "-u" option to gpg, then the bug (or
> > >      misconfiguration) may be in gpg.
> > 
> > I particularly think git is the 'problem' here. After I tried GIT_TRACE, I decided
> > to run it without specifying the key on the CLI as I'd normally do, and it did
> > work normally, and I think I what happens is git defaults for another key, if
> > the specified key is not available.
> 
> Git doesn't know anything about available keys, though. We just call
> "gpg" with the signing key configured in your .gitconfig and it tells us
> whether it worked or not.
> 
> Are you saying that:
> 
>   GIT_TRACE=1 git tag -sm foo foo
> 
> shows git invoking gpg with the wrong key, but:
> 
>   GIT_TRACE=1 git -c user.signingkey=$RIGHT_KEY -sm foo foo
> 
> uses the right key? That implies something funny with the config
> reading. Or are there cases where GIT_TRACE shows us passing the right
> key to gpg, but the signature is made with the wrong key? Then that is
> not something git can control, and is a problem with gpg.
> 
> Can you show us the exact commands you're running and their output?
> 
> > As I mentioned earlier, the key configured on my .gitconfig, is inside a
> > smartcard.
> > I just tested creating a tag, without the smartcard connected, and git
> > ignored the signing key I passed, using another key.
> > 
> > I am not sure how right I am, so please correct me if I'm not, but I would
> > expect git tag to fail, or at least give me a big warning if for any reason it
> > could not sign the tag with the specified key.
> 
> I'd expect it to produce a warning, too, but we can only do so if gpg
> tells us it failed. From Git's perspective, we are just passing along
> the key string from user.signingkey to gpg. We don't know what it means,
> and don't have any mechanism for using a different key.

First, I'd like to apologize because I'm not exactly sure if what I'm doing is
correct, and exploring it a bit, I do agree with you this smells more a gnupg
problem after the information you provided.

I was just playing around with it a bit. And I can't really understand gpg's
behavior here. As you asked, here is what I'm doing now:

- I commented out the user.signingkey in my .config file, and I'm specifying it
  on the CLI as you suggested.

I have a subkey stored locally (besides the one in my smartcard). So, I tried to
use the locally stored key to create a new signed tag, in a random repo, with
this command:

$GIT_TRACE=1 git -c user.signingkey=A6... tag -s foo -m "bar"

First thing gnupg does is ask me to provide my smartcard passphrase, even tough
my smartcard is not even connected :)

After I cancel the password request (I use pinentry, so it moves to the pwd
prompt), I can see the trace:

09:29:49.780058 git.c:479               trace: built-in: git tag -s foo -m bar
09:29:49.781317 run-command.c:666       trace: run_command: gpg --status-fd=2 -bsau A6...
09:29:49.781361 run-command.c:758       trace: start_command: /usr/bin/gpg --status-fd=2 -bsau A6...
error: gpg failed to sign the data:
[GNUPG:] KEY_CONSIDERED 40... 0
[GNUPG:] BEGIN_SIGNING H9
[GNUPG:] PINENTRY_LAUNCHED 5587 curses 1.3.1-unknown /dev/pts/5 xterm-256color :0 20620/1000/5 1000/1000 0
gpg: signing failed: Operation cancelled
[GNUPG:] FAILURE sign 83886179
gpg: signing failed: Operation cancelled

So, from my POV, git is passing the correct key to the gpg commandline, but for
whatever reason gpg is ignoring it.

The key it defaults to, is the one in my smartcard. I'm not sure why it is using
it as the default, I don't have any default key configured in my gpg.

When I cancel the pwd request for the key, gpg emits the KEY_CONSIDERED message,
with yet a different key, and fails the operation.

Well, anyway, thanks for the help, but I do think now git is only a victim here
of some weird behavior from gpg.
I'll try to find out more information about this.


> -Peff
