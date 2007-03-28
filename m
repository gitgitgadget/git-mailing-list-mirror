From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git-blame.el: pick a set of random colors for each git-blame turn
Date: Wed, 28 Mar 2007 14:02:53 +0200
Message-ID: <871wj94lua.fsf@morpheus.local>
References: <874po54tle.fsf@morpheus.local>
	<200703281031.l2SAVhj7004802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 14:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWWs1-0005H2-Mo
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 14:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbXC1MC6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 08:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbXC1MC6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 08:02:58 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:36807 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbXC1MC5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 08:02:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 8346E200A1E8;
	Wed, 28 Mar 2007 14:02:56 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29294-01-15; Wed, 28 Mar 2007 14:02:55 +0200 (CEST)
Received: from morpheus (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id B241E200A1E2;
	Wed, 28 Mar 2007 14:02:55 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id EFF9DC00A6; Wed, 28 Mar 2007 14:02:53 +0200 (CEST)
In-Reply-To: <200703281031.l2SAVhj7004802@localhost.localdomain> (Xavier Maillard's message of "Wed, 28 Mar 2007 12:31:43 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43370>

Xavier Maillard <zedek@gnu.org> writes:

> I thought it would be cool to have different set of colors for each
> git-blame-mode. Function `git-blame-new-commit' does this for us
> picking when possible, a random colors based on the set we build on
> startup. When it fails, `git-blame-ancient-color' will be used. We
> also take care not to use the same color more than once (thank you
> David K=C3=A5gedal).

Closer, but still no cigar :-)

>  (defun git-blame-new-commit (hash src-line res-line num-lines)
>    (save-excursion
>      (set-buffer git-blame-file)
>      (let ((info (gethash hash git-blame-cache))
>            (inhibit-point-motion-hooks t)
> -          (inhibit-modification-hooks t))
> +          (inhibit-modification-hooks t)
> +	  (colors git-blame-colors))
>        (when (not info)
> -        (let ((color (pop git-blame-colors)))
> -          (unless color
> -            (setq color git-blame-ancient-color))
> -          (setq info (list hash src-line res-line num-lines
> +	;; Assign a random color to each new commit info
> +	;; Take care not to select the same color multiple times
> +	(let ((color (if colors
> +			 (git-blame-random-pop colors)
> +		       git-blame-ancient-color)))
> +	  (setq info (list hash src-line res-line num-lines
>                             (git-describe-commit hash)
>                             (cons 'color color))))
>          (puthash hash info git-blame-cache))

You are still making a copy of the list head pointer (colors ->
git-blame-colors), and then you do (git-blame-random-pop colors).
This will not update git-blame-colors if the first element was popped,
which means that you will keep reusing that color.  Since you really
do want to always update the buffer-local git-blame-colors, I don't
see why you bind a local variable and work with that instead.

And the last diff line is whitespace-only.  You replaced eight spaces
with a TAB.

--=20
David K=C3=A5gedal
