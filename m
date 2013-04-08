From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Mon, 8 Apr 2013 17:30:06 -0400
Message-ID: <20130408213006.GD9649@sigill.intra.peff.net>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:30:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJdt-0008AO-89
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936324Ab3DHVaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:30:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34310 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936283Ab3DHVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:30:10 -0400
Received: (qmail 16333 invoked by uid 107); 8 Apr 2013 21:32:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:32:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:30:06 -0400
Content-Disposition: inline
In-Reply-To: <1365416809-4396-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220522>

On Mon, Apr 08, 2013 at 03:56:49PM +0530, Ramkumar Ramachandra wrote:

> git add currently goes past submodule boundaries.  Document this bug.

It's not just submodules, but we should not recurse into any
sub-repository. If I have an unrelated Meta/ repository, I should not be
able to "git add Meta/foo", whether I have used "git submodule" or not.

This topic came about 2 years ago, and I had a quick-and-dirty patch:

  http://thread.gmane.org/gmane.comp.version-control.git/170937/focus=171040

I do not recall anything about the patch at this point (i.e., whether it
was the right thing), but maybe it is a good starting point for somebody
to look into it.

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 874b3a6..a1ea050 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -310,4 +310,18 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>  	test_i18ncmp expect.err actual.err
>  '
>  
> +test_expect_failure 'git add should not go past submodule boundaries' '
> +	mkdir submodule_dir &&
> +	(
> +		cd submodule_dir &&
> +		git init &&
> +		cat >foo <<-\EOF &&
> +		Some content
> +		EOF
> +		git add foo &&
> +		git commit -a -m "Add foo"
> +	) &&
> +	git add submodule_dir/foo
> +'

That is not actually a submodule, but rather just a repo that happens to
be inside our working tree. I know the distinction is subtle, but
according to the thread I linked to above, we may actually treat paths
with gitlinked index entries separately already (I did not try it,
though).

-Peff
