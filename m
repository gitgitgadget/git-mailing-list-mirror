From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Fri, 19 Jun 2015 13:32:46 -0700
Message-ID: <xmqq1th77829.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:33:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62yU-00052Z-O1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbbFSUc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:32:59 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33859 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbbFSUcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:32:48 -0400
Received: by igboe5 with SMTP id oe5so24702594igb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YIxn3lazLwIdWrZgkkOrK4fZrF2OQ2f+SHQSpyMVxUQ=;
        b=I3UHpAjEKFsWWzAcW67HYTzosmaLO7vDxfR8/5QdEXpaCGXbU6AijbtV15kQWQEtT/
         LdP/x7/P3dpZVm3JbkT7e7QwE6y3H6dsq9fz7mibJEMS8XodYLVWsH33BLlivxv8gArD
         Ihqg9zg3vtQ4whabIXy2hzIaFElAYKCjQi42soak/AcU0ZRPJfpe0Gqo6O2wuZ2C44Pk
         +t98rI0CqeBID5ffYQ+1iZ9Dbs6GnzPSWIMZgCmrO6weoWPuYF0bX/pDDI+LyT7eCafn
         339DUrQCePyng9yqcRPbnFIA0GuId4eHySWukE6Y47gQ79TO465X40xFMKGRQeDMBJSA
         RYrw==
X-Received: by 10.50.7.68 with SMTP id h4mr7132143iga.40.1434745967796;
        Fri, 19 Jun 2015 13:32:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id 77sm7741521ioi.20.2015.06.19.13.32.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:32:47 -0700 (PDT)
In-Reply-To: <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:35:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272198>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This option avoids unpacking each and all objects, and just verifies the
> connectivity.

That sounds like marketing ;-)

"Wow this does not unpack unnecessarily, wait, it needs to unpack
and parse 3 out of 4 kinds of objects?"

Jokes aside, given that you should regularly repack your repository
anyway, I do not think it is such a big downside that this mode
misses a corrupt objects, and the 1 out of 4 kinds of objects,
i.e. blobs, occupy major part of the repository storage, so this new
mode probably makes sense.

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 922c346..2863a8a 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -431,4 +431,26 @@ test_expect_success 'fsck notices ref pointing to missing tag' '
>  	test_must_fail git -C missing fsck
>  '
>  
> +test_expect_success 'fsck --quick' '
> +	rm -rf quick &&
> +	git init quick &&
> +	(
> +		cd quick &&
> +		touch empty &&
> +		git add empty &&
> +		test_commit empty &&
> +		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
> +		rm -f $empty &&
> +		echo invalid >$empty &&
> +		test_must_fail git fsck --strict &&
> +		git fsck --strict --quick &&
> +		tree=$(git rev-parse HEAD:) &&
> +		suffix=${tree#??} &&
> +		tree=.git/objects/${tree%$suffix}/$suffix &&
> +		rm -f $tree &&
> +		echo invalid >$tree &&
> +		test_must_fail git fsck --strict --quick
> +	)
> +'
> +
>  test_done

I see a few impedance mismatch here.  For --quick, I would have
expected that the addition would be in t/perf/, not here.

Also the fact that quickness comes by cheating on blobs is an
implementation detail; in the future, perhaps somebody may come up
with a way to do a quick fsck while making sure blob corruption is
also detected.  The new test that expects "--quick" to ignore a
corrupt blob forbids such a progress.

If the option name was "--ignore-corrupt-blob", then the above
change is 100% justified, though.
