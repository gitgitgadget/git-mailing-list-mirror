From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] blame: fix email output with mailmap
Date: Sat, 4 Feb 2012 18:39:09 -0500
Message-ID: <20120204233909.GA1366@sigill.intra.peff.net>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brian Gianforcaro <b.gianfo@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <junkio@cox.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 00:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtpCP-0006Bo-P1
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 00:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab2BDXjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 18:39:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57871
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab2BDXjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 18:39:12 -0500
Received: (qmail 13379 invoked by uid 107); 4 Feb 2012 23:46:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 18:46:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 18:39:09 -0500
Content-Disposition: inline
In-Reply-To: <1328385024-6955-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189922>

On Sat, Feb 04, 2012 at 09:50:22PM +0200, Felipe Contreras wrote:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 5a67c20..dd69e51 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1403,10 +1403,13 @@ static void get_ac_line(const char *inbuf, const char *what,
>  	 * Now, convert both name and e-mail using mailmap
>  	 */
>  	if (map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
> -		/* Add a trailing '>' to email, since map_user returns plain emails
> -		   Note: It already has '<', since we replace from mail+1 */
> +		/*
> +		 * Add a trailing '>' to email, since map_user returns plain
> +		 * emails when it finds a matching mail.
> +		 * Note: It already has '<', since we replace from mail + 1
> +		 */
>  		mailpos = memchr(mail, '\0', mail_len);
> -		if (mailpos && mailpos-mail < mail_len - 1) {
> +		if (mailpos && mailpos-mail < mail_len - 1 && *(mailpos - 1) != '>') {
>  			*mailpos = '>';
>  			*(mailpos+1) = '\0';

I'm not sure if it's possible, but do you need to be checking that
"mailpos > mail" to avoid reading off the beginning of the buffer?
It would mean the email field is empty, which may or may not be
possible.

-Peff
