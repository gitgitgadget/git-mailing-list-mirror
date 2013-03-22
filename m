From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Fri, 22 Mar 2013 15:53:38 -0700
Message-ID: <7v8v5f59n1.fsf@alter.siamese.dyndns.org>
References: <20130322115352.GI2283@serenity.lan>
 <cover.1363980749.git.john@keeping.me.uk>
 <cover.1363980749.git.john@keeping.me.uk>
 <5fc134f6c4a88232c78240539084e9d35db3a6cb.1363980749.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Mar 22 23:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAqg-0004mw-55
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423471Ab3CVWxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 18:53:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423395Ab3CVWxl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:53:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6CC9A608;
	Fri, 22 Mar 2013 18:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OGpExGtMrSJa5Zk5+jc5oXLgafA=; b=GISerS
	nqQ6cMpZjKUhTS4jgx/cd9NOY220DQ+th2Krc//IqPtIgxNe1xPEA8P/e6Jg2GqQ
	Ln8O95MFAB9G1HgLxaNo7CKnKyeR7sTRywQRismzjxxwWIS9Yi2fTTG2+Gf0e30q
	KGFsTEt7COKYzghrvDasLvJb4xy5WgTcS0Ykk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fw+4so7D/zqcUCeFpmLzBe0ZvQnGcVM0
	IUsl/3W+LVJdf/vNTXuOOx3OIdKBoFull56Ixb8bEVNLVEMAs7ixyB2HG43Y+xUP
	m8LGawwTaLFl00/oTVAdl0KC/k+ci6NPvOwMEVVWSQSvN2ogQtHYDv5Du2Og4/Mc
	1g/rQW1Eqi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA93AA607;
	Fri, 22 Mar 2013 18:53:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19417A605; Fri, 22 Mar 2013
 18:53:40 -0400 (EDT)
In-Reply-To: <5fc134f6c4a88232c78240539084e9d35db3a6cb.1363980749.git.john@keeping.me.uk>
 (John Keeping's message of "Fri, 22 Mar 2013 19:36:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56B1F47A-9343-11E2-8ABB-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218863>

John Keeping <john@keeping.me.uk> writes:

> When 'git difftool --dir-diff' is using --no-symlinks (either explicitly
> or implicitly because it's running on Windows), any working tree files
> that have been copied to the temporary directory are copied back after
> the difftool completes.  This includes untracked files in the working
> tree.

Hmph.  Why do we populate the temporary directory with a copy of an
untracked path in the first place?  I thought the point of dir-diff
was to materialize only the relevant paths to two temporaries and
compare these temporaries with a tool that knows how to compare two
directories?

Even if you had path F in HEAD that you are no longer tracking in
the working tree, a normal

	$ git diff HEAD

would report the path F to have been deleted, so I would imagine
that the preimage side of the temporary directory should get a copy
of HEAD:F at path F, while the postimage side of the temporary
directory should not even have anything at path F, when dir-diff
runs, no?

Isn't that the real reason why the test fails?  The path 'output' is
not being tracked at any revision or in the index that is involved
in the test, is it?

> During the tests, this means that the following sequence occurs:
>
> 1) the shell opens "output" to redirect the difftool output
> 2) difftool copies the empty "output" to the temporary directory
> 3) difftool runs "ls" which writes to "output"
> 4) difftool copies the empty "output" file back over the output of the
>    command
> 5) the output files doesn't contain the expected output, causing the
>    test to fail
>
> Avoid this by writing the output into .git/ which will not be copied or
> overwritten.

It is a good idea to move these test output and expect test vectore
files to a different place to make it easier to distinguish them
from test input (e.g. "sub", "file", etc.) in general, but the
description of the original problem sounds like it is just working
around a bug to me.  What am I missing?

> In the longer term, difftool probably needs to learn to warn the user
> instead of overwrite any changes that have been made to the working tree
> file.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  t/t7800-difftool.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index e694972..1eed439 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -319,29 +319,29 @@ test_expect_success PERL 'setup change in subdirectory' '
>  '
>  
>  test_expect_success PERL 'difftool -d' '
> -	git difftool -d --extcmd ls branch >output &&
> -	grep sub output &&
> -	grep file output
> +	git difftool -d --extcmd ls branch >.git/output &&
> +	grep sub .git/output &&
> +	grep file .git/output
>  '
>  
>  test_expect_success PERL 'difftool --dir-diff' '
> -	git difftool --dir-diff --extcmd ls branch >output &&
> -	grep sub output &&
> -	grep file output
> +	git difftool --dir-diff --extcmd ls branch >.git/output &&
> +	grep sub .git/output &&
> +	grep file .git/output
>  '
>  
>  test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
> -	git difftool --dir-diff --prompt --extcmd ls branch >output &&
> -	grep sub output &&
> -	grep file output
> +	git difftool --dir-diff --prompt --extcmd ls branch >.git/output &&
> +	grep sub .git/output &&
> +	grep file .git/output
>  '
>  
>  test_expect_success PERL 'difftool --dir-diff from subdirectory' '
>  	(
>  		cd sub &&
> -		git difftool --dir-diff --extcmd ls branch >output &&
> -		grep sub output &&
> -		grep file output
> +		git difftool --dir-diff --extcmd ls branch >../.git/output &&
> +		grep sub ../.git/output &&
> +		grep file ../.git/output
>  	)
>  '
