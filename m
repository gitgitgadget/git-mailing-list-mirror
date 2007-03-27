From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 2/2] git-blame.el: pick a set of random colors when blaming
Date: Tue, 27 Mar 2007 10:44:24 +0200
Message-ID: <87bqifrs7r.fsf@morpheus.local>
References: <200703262101.l2QL1sGL012549@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 10:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW7IH-0006IJ-Rj
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 10:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbXC0Ioj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 04:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbXC0Ioj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 04:44:39 -0400
Received: from main.gmane.org ([80.91.229.2]:55168 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbXC0Ioh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 04:44:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HW7I8-0000qT-DA
	for git@vger.kernel.org; Tue, 27 Mar 2007 10:44:32 +0200
Received: from oden.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 10:44:32 +0200
Received: from davidk by oden.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 10:44:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oden.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:dBjrUEfAJj14XeK35EsAviUjl1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43241>

Xavier Maillard <zedek@gnu.org> writes:

> I thought it would be cooler to have different set of colors each tim=
e
> I blame.

But the code for it looks weird:

> @@ -302,9 +320,8 @@ See also function `git-blame-mode'."
>            (inhibit-point-motion-hooks t)
>            (inhibit-modification-hooks t))
>        (when (not info)
> -        (let ((color (pop git-blame-colors)))
> -          (unless color
> -            (setq color git-blame-ancient-color))
> +        (let ((color (or (elt git-blame-colors (random (length git-b=
lame-colors)))
> +			 git-blame-ancient-color)))
>            (setq info (list hash src-line res-line num-lines
>                             (git-describe-commit hash)
>                             (cons 'color color))))

Instead of using the colors one at a time, you randomly select one of
them. This means that you might select the same color twice or more,
and even twice in a row.  And you will never run out of colors, so
git-blame-ancient-color will never be used.

This change should probably not go in, but your patch has other stuff
that's good.

> * Prevent (future possible) namespace clash by renaming `color-scale'
> into `git-blame-color-scale'. Definition has been changed to be more
> in the "lisp" way (thanks for help goes to #emacs). Also added a smal=
l
> description of what it does.

Ok, but the heavier cl dependency is noted below.

> * Added docstrings at some point and instructed defvar when a variabl=
e
> was candidate to customisation by users.

Good.

> * Added fix to silent byte-compilers (git-blame-file,
> git-blame-current)

Good.

> * Do not require 'cl at startup.

You removed the pop calls, but added a couple of dolist calls.  So you
still need to require cl.

> * Added more informations on compatibility

Good.

> Signed-off-by: Xavier Maillard <zedek@gnu.org>
> ---
>  contrib/emacs/git-blame.el |   71 +++++++++++++++++++++++++++-------=
---------
>  1 files changed, 44 insertions(+), 27 deletions(-)
>
> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
> index bd87a86..6d0c1b0 100644
> --- a/contrib/emacs/git-blame.el
> +++ b/contrib/emacs/git-blame.el
> @@ -8,8 +8,8 @@
>  ;; License:    GPL
>  ;; Keywords:   git, version control, release management
>  ;;
> -;; Compatibility: Emacs21
> -
> +;; Compatibility: Emacs21, Emacs22 and EmacsCVS
> +;;                Git 1.5 and up
> =20
>  ;; This file is *NOT* part of GNU Emacs.
>  ;; This file is distributed under the same terms as GNU Emacs.
> @@ -61,8 +61,9 @@
> =20
>  ;;; Compatibility:
>  ;;
> -;; It requires GNU Emacs 21.  If you'are using Emacs 20, try
> -;; changing this:
> +;; It requires GNU Emacs 21 or later and Git 1.5.0 and up
> +;;=20
> +;; If you'are using Emacs 20, try changing this:
>  ;;
>  ;;            (overlay-put ovl 'face (list :background
>  ;;                                         (cdr (assq 'color (cddddr=
 info)))))
> @@ -77,30 +78,43 @@
>  ;;
>  ;;; Code:
> =20
> -(require 'cl)			      ; to use `push', `pop'
> -
> -(defun color-scale (l)
> -  (let* ((colors ())
> -         r g b)
> -    (setq r l)
> -    (while r
> -      (setq g l)
> -      (while g
> -        (setq b l)
> -        (while b
> -          (push (concat "#" (car r) (car g) (car b)) colors)
> -          (pop b))
> -        (pop g))
> -      (pop r))
> -    colors))
> +(eval-when-compile (require 'cl))			      ; to use `push', `pop'
> +
> +
> +(defun git-blame-color-scale (&rest elements)
> +  "Given a list, returns a list of triples formed with each
> +elements of the list.
> +
> +a b =3D> bbb bba bab baa abb aba aaa aab"
> +  (let (result)
> +    (dolist (a elements)
> +      (dolist (b elements)
> +        (dolist (c elements)
> +          (setq result (cons (format "#%s%s%s" a b c) result)))))
> +    result))
> +
> +;; (git-blame-color-scale "0c" "04" "24" "1c" "2c" "34" "14" "3c") =3D=
>
> +;; ("#3c3c3c" "#3c3c14" "#3c3c34" "#3c3c2c" "#3c3c1c" "#3c3c24"
> +;; "#3c3c04" "#3c3c0c" "#3c143c" "#3c1414" "#3c1434" "#3c142c" ...)
> =20
>  (defvar git-blame-dark-colors
> -  (color-scale '("0c" "04" "24" "1c" "2c" "34" "14" "3c")))
> +  (git-blame-color-scale "0c" "04" "24" "1c" "2c" "34" "14" "3c")
> +  "*List of colors (format #RGB) to use in a dark environment.
> +
> +To check out the list, evaluate (list-colors-display git-blame-dark-=
colors).")
> =20
>  (defvar git-blame-light-colors
> -  (color-scale '("c4" "d4" "cc" "dc" "f4" "e4" "fc" "ec")))
> +  (git-blame-color-scale "c4" "d4" "cc" "dc" "f4" "e4" "fc" "ec")
> +  "*List of colors (format #RGB) to use in a light environment.
> +
> +To check out the list, evaluate (list-colors-display git-blame-light=
-colors).")
> =20
> -(defvar git-blame-ancient-color "dark green")
> +(defvar git-blame-colors '()
> +  "Colors used by git-blame. The list is built once when activating =
git-blame
> +minor mode.")
> + =20
> +(defvar git-blame-ancient-color "dark green"
> +  "*Color to be used for ancient commit.")
> =20
>  (defvar git-blame-autoupdate t
>    "*Automatically update the blame display while editing")
> @@ -125,6 +139,10 @@
>    "A queue of update requests")
>  (make-variable-buffer-local 'git-blame-update-queue)
> =20
> +;; FIXME: docstrings
> +(defvar git-blame-file nil)
> +(defvar git-blame-current nil)
> +
>  (defvar git-blame-mode nil)
>  (make-variable-buffer-local 'git-blame-mode)
> =20
> @@ -177,7 +195,7 @@ See also function `git-blame-mode'."
>    "Recalculate all blame information in the current buffer"
>    (interactive)
>    (unless git-blame-mode
> -    (error "git-blame is not active"))
> +    (error "Git-blame is not active"))
>   =20
>    (git-blame-cleanup)
>    (git-blame-run))

--=20
David K=C3=A5gedal
