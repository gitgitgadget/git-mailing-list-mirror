From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] Add support for -i/--interactive to git-clean
Date: Wed, 01 May 2013 17:12:04 +0200
Message-ID: <vpq38u6n397.fsf@grenoble-inp.fr>
References: <CANYiYbHKWv6R2vtwG=bTNhj8q0iC4EBt8usC3posBCtYBTXOvA@mail.gmail.com>
	<3ecc9ca1b1363b5bd27ae53cbf5899ce6d44cd48.1367349734.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 17:14:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXYjS-0002at-T1
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 17:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab3EAPOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 11:14:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36262 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938Ab3EAPOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 11:14:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r41FC20O009634
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 May 2013 17:12:02 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UXYhQ-0004n9-MP; Wed, 01 May 2013 17:12:04 +0200
In-Reply-To: <3ecc9ca1b1363b5bd27ae53cbf5899ce6d44cd48.1367349734.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 1 May 2013 03:25:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 May 2013 17:12:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r41FC20O009634
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368025924.0882@ZzHZq++aE9oIoY66NSzxoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223093>

Jiang Xin <worldhello.net@gmail.com> writes:

> Show what would be done and the user must confirm before actually
> cleaning. In the confirmation dialog, the user has three choices:
>
>  * Yes: Start to do cleaning.
>  * No:  Nothing will be deleted.
>  * Edit (default): Enter edit mode.

I like this much more than the previous one. I played with it a bit, and
found it much more pleasant than "rm -i": by default, only one querry,
but still an option to select which files to clean.

I'm wondering whether "Enter" in the edit mode should return to the
yes/no/Edit querry instead of applying the clean. It would make it clear
for the user that it's still possible to cancel completely (the
Control-C hint is not visible in the UI otherwise).

> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Please, no. I already mentionned it in my previous patch, but I did not
review the patch. See SubmittingPatches:

  3. "Reviewed-by:", unlike the other tags, can only be offered by the
     reviewer and means that she is completely satisfied that the patch
     is ready for application.  It is usually offered only after a
     detailed review.

Commenting != reviewing.

> +		/* dels list may become empty when we run string_list_remove_empty_items later */
> +		if (!dels->nr)
> +			break;

This happens when the user removed everything from the list in the edit
mode. This could print something before breaking (and then exiting
silently). Maybe "No more files to clean, exiting." or so.

> +			printf(_("Remove (yes/no/Edit) ? "));
> +			strbuf_getline(&confirm, stdin, '\n');
> +			strbuf_trim(&confirm);
> +			if (confirm.len) {
> +				if (!strncasecmp(confirm.buf, "yes", confirm.len)) {
> +					break;
> +				} else if (!strncasecmp(confirm.buf, "no", confirm.len)) {
> +					string_list_clear(dels, 0);
> +					break;
> +				}
> +			}
> +			edit_mode = 1;

It's weird that anything but "yes" and "no" enter the edit mode without
complaining. It's safe, but surprising. If I type "foo", I'd rather get
an error and be asked again.

> +		if (!matches) {
> +			strbuf_addf(&message, _("WARNING: Cannot find items prefixed by: %s"), confirm.buf);

"prefixed" seems a remainder of the previous version of the patch. You
probably mean "matched by: %s".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
