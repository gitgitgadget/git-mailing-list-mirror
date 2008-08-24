From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.el: Diff only file at point by default
Date: Sat, 23 Aug 2008 18:02:36 -0700
Message-ID: <7v3akvw7gz.fsf@gitster.siamese.dyndns.org>
References: <87vdxtpjkd.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 03:03:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX41F-0003xX-Jb
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 03:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbYHXBCq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 21:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYHXBCp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 21:02:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYHXBCp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 21:02:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BBD765521;
	Sat, 23 Aug 2008 21:02:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C453C65520; Sat, 23 Aug 2008 21:02:39 -0400 (EDT)
In-Reply-To: <87vdxtpjkd.fsf@lysator.liu.se> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of "Fri, 22 Aug 2008 09:58:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5BB946EA-7178-11DD-AA04-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93508>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Use prefix (C-u) to diff all marked files instead.
>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> ---
>  contrib/emacs/git.el |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
>
> For anyone who has used pcvs (or dsvn) this makes much more sense. Th=
e

Looks sensible to me; Alexandre?

> typical usage scenario is that you want to mark the files that are
> relevant, and you do it incrementally by checking if file A is
> relevant and has no strange changes by pressing =3D and then marking =
it,
> proceeding to check file B by pressing =3D on it and potentially mark=
ing
> it as well and so on.
>
> The current way that =3D works means that you have to check each file
> first and remember which one you want to mark. Or diff everything and
> then read through the whole diff and find match the output against th=
e
> files to mark. It is possible to do it like that as well, but it is
> much more convenient to do it as described above, and there is a
> strong precedent in emacs frontends to make the diff command only dif=
f
> the current file by default.
>
> The old behaviour can be restored by using C-u =3D.
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index c30d20a..a3477a4 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -772,6 +772,11 @@ Return the list of files that haven't been handl=
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
> @@ -1138,10 +1143,10 @@ Return the list of files that haven't been ha=
ndled."
>    (when (eq (window-buffer) (current-buffer))
>      (shrink-window-if-larger-than-buffer)))
> =20
> -(defun git-diff-file ()
> -  "Diff the marked file(s) against HEAD."
> -  (interactive)
> -  (let ((files (git-marked-files)))
> +(defun git-diff-file (arg)
> +  "Diff the marked file(s) against HEAD, or the marked files if a pr=
efix arg is given."
> +  (interactive "P")
> +  (let ((files (if arg (git-marked-files) (list (git-current-file)))=
))
>      (git-setup-diff-buffer
>       (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" =
"-M" "HEAD" "--" (git-get-filenames files)))))
> =20
> --=20
> 1.6.0.rc2.7.gbf8a
>
>
> --=20
> David K=C3=A5gedal
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
