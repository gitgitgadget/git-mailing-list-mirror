From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2 1/2] t5520-pull: Add testcases showing spurious conflicts from git pull --rebase
Date: Sun, 8 Aug 2010 23:36:18 +0200
Message-ID: <201008082336.18270.j6t@kdbg.org>
References: <1281294286-27709-1-git-send-email-newren@gmail.com> <1281294286-27709-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, santi@agolina.net,
	Johannes.Schindelin@gmx.de
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 23:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiDXq-0005Ge-Il
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 23:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab0HHVgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 17:36:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:58596 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672Ab0HHVgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 17:36:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 852E6CDF8B;
	Sun,  8 Aug 2010 23:36:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5ED9C19F5C0;
	Sun,  8 Aug 2010 23:36:18 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1281294286-27709-2-git-send-email-newren@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152932>

On Sonntag, 8. August 2010, Elijah Newren wrote:
> +test_expect_success 'setup for detecting upstreamed changes' '
> +	mkdir src &&
> +	(cd src &&
> +	 git init &&
> +	 for i in $(seq 1 10); do echo $i; done > stuff &&

We don't have seq on Windows. The sequence is short enough to list it 
explicitly.

> +	 git add stuff &&
> +	 git commit -m "Initial revision"
> +	) &&
> +	git clone src dst &&
> +	(cd src &&
> +	 perl -pi -e s/5/43/ stuff &&

perl -pi is no better than sed -i; it does not work on Windows because it 
tries to remove an open file (and that is a no-go on Windows). perl -pi.bak 
does work though.

> +	 git commit -a -m "5->43" &&
> +	 perl -pi -e s/6/42/ stuff &&
> +	 git commit -a -m "Make it bigger" &&
> +	 correct=$(git rev-parse HEAD)
> +	) &&

This assignment at the end of the subshell is pointless.

> +test_expect_success 'setup for avoiding reapplying old patches' '
> +	(cd dst &&
> +	 (git rebase --abort || true) &&

Perhaps:

	test_might_fail git rebase --abort &&

but I'm not sure whether that's the intended use of test_might_fail.

> +	 git reset --hard origin/master
> +	) &&
...
> +test_expect_failure 'git pull --rebase does not reapply old patches' '
> +	(cd dst &&
> +	 (git pull --rebase || true) &&

Ditto.

> +	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
> +	)
> +'
> +
>  test_done

-- Hannes
