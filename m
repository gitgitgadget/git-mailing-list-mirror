From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mailinfo may corrupt patch headers on attached files
Date: Sun, 06 Jul 2008 17:09:47 -0700
Message-ID: <7vej66blmc.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0807061036500.3016@woody.linux-foundation.org>
 <1215379261-10802-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 02:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFeKX-0007O8-4Z
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 02:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757331AbYGGAJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 20:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757273AbYGGAJ7
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 20:09:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198AbYGGAJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 20:09:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C8FF10444;
	Sun,  6 Jul 2008 20:09:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6A3F810442; Sun,  6 Jul 2008 20:09:50 -0400 (EDT)
In-Reply-To: <1215379261-10802-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Sun, 6 Jul 2008 17:21:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07BABC70-4BB9-11DD-8932-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87568>

> I noticed this the other day, just never got a chance to send the fix out.
> This might be the same problem I ran into.
>
> Cheers,
> Don
>
>  builtin-mailinfo.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 2894e34..cedda18 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -795,7 +795,7 @@ static void handle_body(void)
>  	int rc = 0;
>  	static char newline[2000];
>  	static char *np = newline;
> -	int len = strlen(line);
> +	int len;
>  
>  	/* Skip up to the first boundary */
>  	if (content_top->boundary) {
> @@ -814,6 +814,9 @@ static void handle_body(void)
>  				return;
>  		}
>  
> +		/* line may have changed after handling boundary, check len */
> +		len = strlen(line);
> +
>  		/* Unwrap transfer encoding */
>  		len = decode_transfer_encoding(line, sizeof(line), len);
>  		if (len < 0) {

This does fix the "F\n" issue, but seems to break t5100 test ("respect
NULs").  I haven't looked into the details yet...
