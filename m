From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.el: Diff only file at point by default
Date: Wed, 27 Aug 2008 12:36:50 -0700
Message-ID: <7v63pmp7vx.fsf@gitster.siamese.dyndns.org>
References: <87vdxtpjkd.fsf@lysator.liu.se>
 <7v3akvw7gz.fsf@gitster.siamese.dyndns.org> <87bpzh8msk.fsf@wine.dyndns.org>
 <873aktnsbf.fsf@lysator.liu.se> <871w0bmn6w.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>,
	Git Mailing List <git@vger.kernel.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQqD-0008N8-UB
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbYH0Tg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 15:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYH0Tg7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:36:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbYH0Tg6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 15:36:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C7AA363637;
	Wed, 27 Aug 2008 15:36:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8F10163636; Wed, 27 Aug 2008 15:36:53 -0400 (EDT)
In-Reply-To: <871w0bmn6w.fsf@lysator.liu.se> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of "Wed, 27 Aug 2008 00:22:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82F16612-746F-11DD-8D81-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93930>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Use prefix (C-u) to diff all marked files.
>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> ---
>  contrib/emacs/git.el |   62 +++++++++++++++++++++++++++++-----------=
----------
>  1 files changed, 36 insertions(+), 26 deletions(-)
>
> Here is an updated patch that udpate the stage diff commands as
> well. It doesn't touch git-diff-file-merge-head since that already
> uses prefix arguments. Don't know if there is a solution to that.

Yeah, me neither.  But otherwise looks quite straightforward conversion=
 to
me.  Alexandre?

> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index c1cf1cb..de9d0f4 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -771,6 +771,11 @@ Return the list of files that haven't been handl=
ed."
>                (setq file (pop files))
>              (setq node (ewoc-next status node))))))))
> =20
> +(defun git-current-file ()
> +  "Return the file at point."
> +  (unless git-status (error "Not in git-status buffer."))
> +  (ewoc-data (ewoc-locate git-status)))
> +
>  (defun git-marked-files ()
>    "Return a list of all marked files, or if none a list containing j=
ust the file at cursor position."
>    (unless git-status (error "Not in git-status buffer."))
> @@ -1137,10 +1142,11 @@ Return the list of files that haven't been ha=
ndled."
>    (when (eq (window-buffer) (current-buffer))
>      (shrink-window-if-larger-than-buffer)))
> =20
> -(defun git-diff-file ()
> -  "Diff the marked file(s) against HEAD."
> -  (interactive)
> -  (let ((files (git-marked-files)))
> +(defun git-diff-file (arg)
> +  "Diff the current file against HEAD.
> +With a prefix arg, diff the marked files instead."
> +  (interactive "P")
> +  (let ((files (if arg (git-marked-files) (list (git-current-file)))=
))
>      (git-setup-diff-buffer
>       (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" =
"-M" "HEAD" "--" (git-get-filenames files)))))
> =20
> @@ -1154,31 +1160,35 @@ Return the list of files that haven't been ha=
ndled."
>       (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" =
"-M"
>              (or (nth (1- arg) merge-heads) "HEAD") "--" (git-get-fil=
enames files)))))
> =20
> -(defun git-diff-unmerged-file (stage)
> -  "Diff the marked unmerged file(s) against the specified stage."
> -  (let ((files (git-marked-files)))
> +(defun git-diff-unmerged-file (stage arg)
> +  "Diff the files against the specified stage."
> +  (let ((files (if arg (git-marked-files) (list (git-current-file)))=
))
>      (git-setup-diff-buffer
>       (apply #'git-run-command-buffer "*git-diff*" "diff-files" "-p" =
stage "--" (git-get-filenames files)))))
> =20
> -(defun git-diff-file-base ()
> -  "Diff the marked unmerged file(s) against the common base file."
> -  (interactive)
> -  (git-diff-unmerged-file "-1"))
> -
> -(defun git-diff-file-mine ()
> -  "Diff the marked unmerged file(s) against my pre-merge version."
> -  (interactive)
> -  (git-diff-unmerged-file "-2"))
> -
> -(defun git-diff-file-other ()
> -  "Diff the marked unmerged file(s) against the other's pre-merge ve=
rsion."
> -  (interactive)
> -  (git-diff-unmerged-file "-3"))
> -
> -(defun git-diff-file-combined ()
> -  "Do a combined diff of the marked unmerged file(s)."
> -  (interactive)
> -  (git-diff-unmerged-file "-c"))
> +(defun git-diff-file-base (arg)
> +  "Diff the current file against the common base file.
> +With a prefix arg, diff the marked files instead."
> +  (interactive "P")
> +  (git-diff-unmerged-file "-1" arg))
> +
> +(defun git-diff-file-mine (arg)
> +  "Diff the current file against my pre-merge version.
> +With a prefix arg, diff the marked files instead."
> +  (interactive "P")
> +  (git-diff-unmerged-file "-2" arg))
> +
> +(defun git-diff-file-other (arg)
> +  "Diff the current file against the other's pre-merge version.
> +With a prefix arg, diff the marked files instead."
> +  (interactive "P")
> +  (git-diff-unmerged-file "-3" arg))
> +
> +(defun git-diff-file-combined (arg)
> +  "Do a combined diff of the marked unmerged file(s).
> +With a prefix arg, diff the marked files instead."
> +  (interactive "P")
> +  (git-diff-unmerged-file "-c" arg))
> =20
>  (defun git-diff-file-idiff ()
>    "Perform an interactive diff on the current file."
> --=20
> 1.6.0.rc2.7.gbf8a
>
>
> --=20
> David K=C3=A5gedal
