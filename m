From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git-blame.el: pick a set of random colors for each git-blame turn
Date: Wed, 28 Mar 2007 11:15:25 +0200
Message-ID: <874po54tle.fsf@morpheus.local>
References: <87bqifrs7r.fsf@morpheus.local>
	<200703272151.l2RLpqD7012317@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUFg-0000nY-Lj
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934023AbXC1JP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 05:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934031AbXC1JP3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:15:29 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:35439 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934023AbXC1JP2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 05:15:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5CF74200A1FA;
	Wed, 28 Mar 2007 11:15:27 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31892-01-81; Wed, 28 Mar 2007 11:15:26 +0200 (CEST)
Received: from morpheus (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4F376200A1E2;
	Wed, 28 Mar 2007 11:15:26 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id D4902BFF27; Wed, 28 Mar 2007 11:15:25 +0200 (CEST)
In-Reply-To: <200703272151.l2RLpqD7012317@localhost.localdomain> (Xavier Maillard's message of "Tue, 27 Mar 2007 23:51:52 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43364>

Xavier Maillard <zedek@gnu.org> writes:

> @@ -294,18 +312,22 @@ See also function `git-blame-mode'."
>          (t
>           nil)))
> =20
> -
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
> +	(let* ((idx (random (length colors)))
> +	       (color (or (elt colors idx)
> +			  git-blame-ancient-color)))
> +	  (and (assoc color colors)
> +	       (setq colors (delete idx colors)))
> +	  (setq info (list hash src-line res-line num-lines
>                             (git-describe-commit hash)
>                             (cons 'color color))))
>          (puthash hash info git-blame-cache))

I have a few questions here.  Why do you make a local reference
(color) to git-blame-colors, but you are still destructively updating
the list (using delete), possibly making git-blame-colors point to a
partial ruin of the original list?  My original version may look
similar, but pop is only destructive on the variable it is popping
from.  Any other references to the original list will be intact.

Remember that git-blame-colors is a buffer-local variable, but if it
points to a global list, any destructive changes will mess up the
global list.

Then it's this part

> +	(let* ((idx (random (length colors)))
> +	       (color (or (elt colors idx)
> +			  git-blame-ancient-color)))

If you have already consumed all colors, (length colors) will be zero
and random will return an arbitrary integer. And then you will do (elt
'() -47100) and check if that was nil.  It should work, but only by
luck.

I'd prefer something like this:

    (let ((color (if colors
                   (elt colors (random (length colors)))
                  git-blame-ancient-color)))

Then you have to remove it, and your (assoc color colors) looks
"weird", since assoc compares the car of each list element in colors,
but colors doesn't contain any pairs, so I don't really see how it
would ever return something.

You could break this out to a function:

(defmacro random-pop (l)
  "Remove a random element from l and update l"
  ;; only works on lists with unique elements
  `(let ((e (elt ,l (random (length ,l)))))
     (setq ,l (remove e ,l))
     e))

and use it like this:

    (let ((color (if colors
                   (random-pop colors)
                  git-blame-ancient-color)))

--=20
David K=C3=A5gedal
