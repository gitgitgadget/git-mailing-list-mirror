From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/2] git-blame.el: separate git-blame-mode to ease maintenance
Date: Tue, 27 Mar 2007 10:38:13 +0200
Message-ID: <87fy7rrsi2.fsf@morpheus.local>
References: <200703262100.l2QL0svB012536@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 10:38:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW7CJ-0003ED-NA
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 10:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbXC0Ii2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 04:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbXC0Ii2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 04:38:28 -0400
Received: from main.gmane.org ([80.91.229.2]:33176 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbXC0Ii1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 04:38:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HW7CA-00009S-Qb
	for git@vger.kernel.org; Tue, 27 Mar 2007 10:38:22 +0200
Received: from oden.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 10:38:22 +0200
Received: from davidk by oden.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 10:38:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oden.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:gmPKZnpRvQkftB4Vd2TSukJgNZA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43240>

Xavier Maillard <zedek@gnu.org> writes:

> git-blame-mode has been splitted into git-blame-mode-on and
> git-blame-mode-off; it now conditionnaly calls one of them depending
> of how we call it. Code is now easier to maintain and to understand.
>
> Fixed `git-reblame' function: interactive form was at the wrong
> place.
>
> String displayed on the mode line is now configurable through
> `git-blame-mode-line-string` (default to " blame").

Why do you feel the need for this?  I don't remember seeing any other
minor mode that does this.

Other than that, I think it is an improvement.

> Signed-off-by: Xavier Maillard <zedek@gnu.org>
> ---
>  contrib/emacs/git-blame.el |   55 +++++++++++++++++++++++++++++-----=
---------
>  1 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
> index 64ad50b..bd87a86 100644
> --- a/contrib/emacs/git-blame.el
> +++ b/contrib/emacs/git-blame.el
> @@ -127,39 +127,58 @@
> =20
>  (defvar git-blame-mode nil)
>  (make-variable-buffer-local 'git-blame-mode)
> -(unless (assq 'git-blame-mode minor-mode-alist)
> -  (setq minor-mode-alist
> -	(cons (list 'git-blame-mode " blame")
> -	      minor-mode-alist)))
> +
> +(defvar git-blame-mode-line-string " blame"
> +  "String to display on the mode line when git-blame is active.")
> +
> +(or (assq 'git-blame-mode minor-mode-alist)
> +    (setq minor-mode-alist
> +	  (cons '(git-blame-mode git-blame-mode-line-string) minor-mode-ali=
st)))
> =20
>  ;;;###autoload
>  (defun git-blame-mode (&optional arg)
> -  "Minor mode for displaying Git blame"
> +  "Toggle minor mode for displaying Git blame
> +
> +With prefix ARG, turn the mode on if ARG is positive."
>    (interactive "P")
> -  (if arg
> -      (setq git-blame-mode (eq arg 1))
> -    (setq git-blame-mode (not git-blame-mode)))
> +  (cond
> +   ((null arg)
> +    (if git-blame-mode (git-blame-mode-off) (git-blame-mode-on)))
> +   ((> (prefix-numeric-value arg) 0) (git-blame-mode-on))
> +   (t (git-blame-mode-off))))
> +
> +(defun git-blame-mode-on ()
> +  "Turn on git-blame mode.
> +
> +See also function `git-blame-mode'."
>    (make-local-variable 'git-blame-colors)
>    (if git-blame-autoupdate
>        (add-hook 'after-change-functions 'git-blame-after-change nil =
t)
>      (remove-hook 'after-change-functions 'git-blame-after-change t))
>    (git-blame-cleanup)
> -  (if git-blame-mode
> -      (progn
> -        (let ((bgmode (cdr (assoc 'background-mode (frame-parameters=
)))))
> -          (if (eq bgmode 'dark)
> -              (setq git-blame-colors git-blame-dark-colors)
> -            (setq git-blame-colors git-blame-light-colors)))
> -        (setq git-blame-cache (make-hash-table :test 'equal))
> -        (git-blame-run))
> -    (cancel-timer git-blame-idle-timer)))
> +  (let ((bgmode (cdr (assoc 'background-mode (frame-parameters)))))
> +    (if (eq bgmode 'dark)
> +	(setq git-blame-colors git-blame-dark-colors)
> +      (setq git-blame-colors git-blame-light-colors)))
> +  (setq git-blame-cache (make-hash-table :test 'equal))
> +  (setq git-blame-mode t)
> +  (git-blame-run))
> +
> +(defun git-blame-mode-off ()
> +  "Turn off git-blame mode.
> +
> +See also function `git-blame-mode'."
> +  (git-blame-cleanup)
> +  (if git-blame-idle-timer (cancel-timer git-blame-idle-timer))
> +  (setq git-blame-mode nil))
> =20
>  ;;;###autoload
>  (defun git-reblame ()
>    "Recalculate all blame information in the current buffer"
> +  (interactive)
>    (unless git-blame-mode
>      (error "git-blame is not active"))
> -  (interactive)
> + =20
>    (git-blame-cleanup)
>    (git-blame-run))

--=20
David K=C3=A5gedal
