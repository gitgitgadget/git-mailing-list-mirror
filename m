From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix support for repository directories with
 spaces
Date: Mon, 16 Jun 2008 18:14:27 -0700
Message-ID: <7vd4mg9824.fsf@gitster.siamese.dyndns.org>
References: <1213664977-23964-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 03:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8PnT-00032Z-2j
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 03:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYFQBOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 21:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbYFQBOs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 21:14:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbYFQBOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 21:14:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BFE27C501;
	Mon, 16 Jun 2008 21:14:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 91731C4FF; Mon, 16 Jun 2008 21:14:41 -0400 (EDT)
In-Reply-To: <1213664977-23964-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Tue, 17 Jun 2008 03:09:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C672CFFE-3C0A-11DD-9C3A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85255>

Lea Wiemann <lewiemann@gmail.com> writes:

> git_cmd_str does not quote the directory names without this patch.
>
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
> git_cmd_str is really really bad from a security POV: Where it is
> used, command lines are passed to the shell, which (I believe) just
> *happen* to open no security holes.  Hence the function should
> ultimately go away.  However, let's make the tests work for the
> meantime while it's still there.
>
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 07e64da..0bddc31 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1502,7 +1502,7 @@ sub git_cmd {
>  
>  # returns path to the core git executable and the --git-dir parameter as string
>  sub git_cmd_str {
> -	return join(' ', git_cmd());
> +	return join ' ', map("'$_'", git_cmd());
>  }

What happens to a path or parameter that has a sq in it?

You are returing this from git_cmd():

	return $GIT, '--git-dir='.$git_dir;

How is this cmd_str() gets used?  If you absolutely have to have a single
string that can be safely passed to the shell, the easiest would be to
quote mechanically in sq following the pattern illustrated at the
beginning of quote.c
