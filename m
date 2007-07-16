From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Add a test script for "git notes"
Date: Sun, 15 Jul 2007 22:11:30 -0700
Message-ID: <7v3azp6igt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160024060.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 07:11:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAIs2-0007cn-W6
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 07:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbXGPFLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 01:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXGPFLd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 01:11:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50313 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbXGPFLc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 01:11:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716051133.CHJV1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 01:11:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q5BW1X00k1kojtg0000000; Mon, 16 Jul 2007 01:11:31 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52638>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> new file mode 100755
> index 0000000..eb50191
> --- /dev/null
> +++ b/t/t3301-notes.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Johannes E. Schindelin
> +#
> +
> +test_description='Test commit notes'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	: > a1 &&
> +	git add a1 &&
> +	test_tick &&
> +	git commit -m 1st &&
> +	: > a2 &&
> +	git add a2 &&
> +	test_tick &&
> +	git commit -m 2nd
> +'

Does not test the failure mode of not having a HEAD yet.

> +cat > fake_editor.sh << EOF
> +echo "\$MSG" > "\$1"
> +echo "\$MSG" >& 2
> +EOF

You can avoid all these backslashes by saying:

	cat >fake_editor.sh <<\EOF
        echo "$MSG" >"$1"
        echo "$MSG" >&2
	EOF

> +chmod a+x fake_editor.sh
> +VISUAL="$(pwd)"/fake_editor.sh
> +export VISUAL

Not that it hurts anybody, but do you really need that $(pwd),
instead of "./fake_editor.sh"?

> +
> +test_expect_success 'need notes ref' '
> +	! MSG=1 git notes edit &&
> +	! MSG=2 git notes show
> +'
> +
> +test_expect_success 'create notes' '
> +	git config core.notesRef refs/notes/commits &&
> +	MSG=b1 git notes edit &&
> +cat .git/new-notes &&
> +test b1 = "$(cat .git/new-notes)" &&
> +	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
> +	test b1 = $(git notes show) &&
> +	git show HEAD^ &&
> +	! git notes show HEAD^
> +'

Is there particular reason for that (lack of) indentation for
the two lines among them?

I think it is a bug to leave ".git/new-notes" and friends
behind.

> +
> +cat > expect << EOF
> +commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:14:13 2005 -0700
> +
> +    2nd
> +
> +Notes:
> +    b1
> +EOF
> +
> +test_expect_success 'show notes' '
> +	! (git cat-file commit HEAD | grep b1) &&
> +	git log -1 > output &&
> +	git diff expect output
> +'
> +
> +test_done

Hmph.  This makes the reader wonder why this is not optional,
perhaps linked to --decorate option somehow.
