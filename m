From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH v4 3/4] t4052: Test diff-stat output with minimum
 columns
Date: Fri, 27 Apr 2012 00:34:22 +0200
Message-ID: <20120426223422.GC22261@camk.edu.pl>
References: <1334716196-9870-3-git-send-email-lucian.poston@gmail.com>
 <1334783377-31229-1-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?iso-8859-2?Q?J=EAdrzejewski-Szmek?= 
	<zbyszek@in.waw.pl>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXGw-000708-Og
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759546Ab2DZWel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:34:41 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:46425 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab2DZWek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:34:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 0A7C95F004A;
	Fri, 27 Apr 2012 00:35:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EomWcvhMsk5P; Fri, 27 Apr 2012 00:35:16 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 554FD5F0049;
	Fri, 27 Apr 2012 00:35:16 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 568894671D; Fri, 27 Apr 2012 00:34:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1334783377-31229-1-git-send-email-lucian.poston@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196442>

On Wed, Apr 18, 2012 at 02:09:33PM -0700, Lucian Poston wrote:
> When COLUMNS or --stat-width restricts the diff-stat width to near the
> minimum, 26 columns, the graph_width value becomes negative. Consequently, the
> graph part of diff-stat is not resized properly.

> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
> ---
>  t/t4052-stat-output.sh |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)

> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index d748e5e..b8eec8f 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -284,6 +284,34 @@ respects expect200 show --stat
>  respects expect200 log -1 --stat
>  EOF

> +cat >expect1 <<'EOF'
> + ...aaaaaaa | 1000 ++++++
> +EOF
> +cat >expect1-graph <<'EOF'
> +|  ...aaaaaaa | 1000 ++++++
> +EOF
> +while read teststate verb expect cmd args
> +do
> +	test_expect_$teststate "$cmd $verb prefix greater than COLUMNS (big change)" '
> +		COLUMNS=1 git $cmd $args >output
> +		grep " | " output >actual &&
> +		test_cmp "$expect" actual
> +	'
> +
> +	test "$cmd" != diff || continue
> +
> +	test_expect_$teststate "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
> +		COLUMNS=1 git $cmd $args --graph >output
> +		grep " | " output >actual &&
> +		test_cmp "$expect-graph" actual
> +	'
> +done <<\EOF
> +success ignores expect80 format-patch -1 --stdout
> +failure respects expect1 diff HEAD^ HEAD --stat
> +failure respects expect1 show --stat
> +failure respects expect1 log -1 --stat
> +EOF
> +
>  cat >expect <<'EOF'
>   abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  EOF

These tests fail when /bin/sh is mksh. The problem is, mksh set COLUMNS
to be at least 12.

-- 
  Kacper Kornet
