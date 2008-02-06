From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Add tests for .git file
Date: Tue, 05 Feb 2008 19:25:55 -0800
Message-ID: <7vfxw66a0s.fsf@gitster.siamese.dyndns.org>
References: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
	<1202158761-31211-2-git-send-email-hjemli@gmail.com>
	<1202158761-31211-3-git-send-email-hjemli@gmail.com>
	<1202158761-31211-4-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 04:26:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMavp-0005cE-O8
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 04:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458AbYBFD0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 22:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757130AbYBFD0H
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 22:26:07 -0500
Received: from rune.pobox.com ([208.210.124.79]:48085 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756454AbYBFD0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 22:26:06 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 45F7D194090;
	Tue,  5 Feb 2008 22:26:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C99D19408F;
	Tue,  5 Feb 2008 22:26:19 -0500 (EST)
In-Reply-To: <1202158761-31211-4-git-send-email-hjemli@gmail.com> (Lars
	Hjemli's message of "Mon, 4 Feb 2008 21:59:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72750>

Lars Hjemli <hjemli@gmail.com> writes:

> Verify that the basic plumbing works when .git is a file pointing at
> the real git directory.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>  t/t0002-gitfile.sh |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 71 insertions(+), 0 deletions(-)
>  create mode 100755 t/t0002-gitfile.sh
>
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> new file mode 100755
> index 0000000..f8f39e6
> --- /dev/null
> +++ b/t/t0002-gitfile.sh
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +
> +test_description='.git file
> +
> +Verify that plumbing commands work when .git is a file
> +'
> +. ./test-lib.sh
> +
> +chkfile() {
> +	D=$(echo $1 | cut -b 1-2) &&
> +	F=$(echo $1 | cut -b 3-40) &&
> +	if test ! -f $REAL/objects/$D/$F

	P=$(echo $1 | sed -e 's|\(..\)\(.*\)|\1/\2\|') &&
        if test ! -f "$REAL/objects/$P"
		...

Although it probably is more efficient to do this with one
process, s/cut/sed/ is mostly a style issue.

Be careful with quoting.  $REAL might contain a $IFS whitespace
as you grabbed it from $(pwd)...

> +test_expect_success 'setup' '
> +	REAL=$(pwd)/.real &&
> +	mv .git $REAL &&
> +	echo "gitdir: $REAL" >.git
> +'
> ...
> +test_expect_success 'check update-index' '
> +	if test -f $REAL/index
> +	then
> +		echo "Hmm, $REAL/index exists?"
> +		false
> +	fi &&
> +	rm -rf $REAL/objects/* &&

... and it matters especially if you do this ;-)
