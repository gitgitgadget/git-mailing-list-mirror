From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Sun, 18 May 2008 21:51:16 -0700
Message-ID: <7v7idqaocb.fsf@gitster.siamese.dyndns.org>
References: <20080518145727.GA3058@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 06:52:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxxM8-0000rj-2j
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 06:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbYESEvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 00:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYESEvY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 00:51:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYESEvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 00:51:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB4AD3EC5;
	Mon, 19 May 2008 00:51:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1C7BB3EC2; Mon, 19 May 2008 00:51:18 -0400 (EDT)
In-Reply-To: <20080518145727.GA3058@steel.home> (Alex Riesen's message of
 "Sun, 18 May 2008 16:57:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AC13DE0-255F-11DD-BFF1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82412>

Alex Riesen <raa.lkml@gmail.com> writes:

> diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
> index c8310ae..f1c91c8 100755
> --- a/t/t6031-merge-recursive.sh
> +++ b/t/t6031-merge-recursive.sh
> @@ -12,8 +12,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
>  	git add dummy &&
>  	git commit -m a &&
>  	git checkout -b b1 master &&
> -	chmod +x file1 &&
> -	git add file1 &&
> +	git update-index --chmod=+x file1 &&
>  	git commit -m b1 &&
>  	git checkout a1 &&
>  	git merge-recursive master -- a1 b1 &&

I have to wonder if this is enough on a filesystem with usable executable
bit.  Has this been tested on both kinds of filesystems?

You aren't setting +x on work tree file anymore, but only flipping the bit
inside the index before committing.  Because of this change, after "b1"
commit, work tree has a local modification relative to the commit (namely,
reversion of chmod +x is in the work tree), which is different from the
original test sequence.  Doesn't this local modification interact with
switching to a1 branch and what merge-recursive does?
