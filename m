From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: git emacs mode patch
Date: Mon, 26 Mar 2007 12:02:29 +0200
Message-ID: <878xdk491m.fsf@wine.dyndns.org>
References: <200703151403.56552.mega@retes.hu>
	<87y7lwxk2e.fsf@wine.dyndns.org> <200703251903.15333.mega@retes.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?G=C3=A1bor?= Melis <mega@retes.hu>
X-From: git-owner@vger.kernel.org Mon Mar 26 12:03:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVm2g-0003ki-An
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbXCZKCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Mar 2007 06:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbXCZKCf
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:02:35 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:47864 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXCZKCe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 06:02:34 -0400
Received: from adsl-84-227-31-197.adslplus.ch ([84.227.31.197] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HVm24-00063J-VB; Mon, 26 Mar 2007 04:02:33 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 0F6D64F61D; Mon, 26 Mar 2007 12:02:30 +0200 (CEST)
In-Reply-To: <200703251903.15333.mega@retes.hu> (=?utf-8?Q?G=C3=A1bor?=
 Melis's message of "Sun\, 25 Mar 2007 19\:03\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43142>

G=C3=A1bor Melis <mega@retes.hu> writes:

> @@ -515,15 +527,21 @@ and returns the process output as a string."
>        (setq node (ewoc-next status node)))
>      node))
> =20
> -(defun git-parse-ls-files (status default-state &optional skip-exist=
ing)
> +(defun git-parse-ls-files (status &optional default-state skip-exist=
ing)
>    "Parse the output of git-ls-files in the current buffer."
>    (goto-char (point-min))
>    (let (infolist)
>      (while (re-search-forward "\\([HMRCK?]\\) \\([^\0]*\\)\0" nil t =
1)
> -      (let ((state (match-string 1))
> -            (name (match-string 2)))
> -        (unless (and skip-existing (git-find-status-file status name=
))
> -          (push (git-create-fileinfo (or (git-state-code state) defa=
ult-state) name) infolist))))
> +      (let* ((state (or default-state
> +                        (git-state-code (match-string 1))))
> +             (name (match-string 2))
> +             (node (git-find-status-file status name)))
> +        (if skip-existing
> +            (unless node
> +              (push (git-create-fileinfo state name) infolist))
> +          (if node
> +              (git-set-files-state (list (ewoc-data node)) state)
> +            (push (git-create-fileinfo state name) infolist)))))

You don't want to do a git-find-status-file in all cases, this is
O(n^2) and becomes much too slow on a large project. That's the reason
there's a skip-existing flag, to avoid that cost in the common case.

--=20
Alexandre Julliard
julliard@winehq.org
