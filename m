From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] bisect--helper: `bisect_voc` shell function in C
Date: Mon, 16 May 2016 09:49:33 +0200
Message-ID: <vpqlh3a1lyq.fsf@anie.imag.fr>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
	<1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 09:49:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2DHe-0003VG-Je
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 09:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbcEPHtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 03:49:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35845 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbcEPHtm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 03:49:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4G7nWRj025240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 16 May 2016 09:49:32 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4G7nXiu005492;
	Mon, 16 May 2016 09:49:33 +0200
In-Reply-To: <1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
	(Pranit Bauva's message of "Sat, 14 May 2016 01:32:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 16 May 2016 09:49:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4G7nWRj025240
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1463989776.66121@2os2hBocJQrDxV0+sHUG4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294730>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +int bisect_voc(const char *term)
> +{
> +	if (!strcmp(term, "bad"))
> +		printf("bad|new\n");
> +	if (!strcmp(term, "good"))
> +		printf("good|old\n");

If you meant to use this as a helper command, then the implementation is
right, but you're not doing that.

If you write the function because one day you'll be calling it from C,
then:

1) First, I'd wait for this "one day" to happen. In general, write code
   when you need it, don't write it ahead of time. Currently, you have
   dead and untested code (I know, *you* have tested it, but it's still
   "untested" as far as git.git is concerned). Dead code may bother
   people reading the code (one would not understand why it's there),
   and untested code means it may break later without anyone noticing.

2) Second, you'd need to return the string, not print it. You'll
   typically use it like this:

     printf(_("You need to give me at least one %s and one %s"),
            bisect_voc(BISECT_BAD), bisect_voc(BISECT_GOOD));

   which gives one more argument for 1): once you have a use-case, you
   can design the API properly, and not blindly guess that you're going
   to need printf. Actually, writting these 2 example lines, I also
   noticed that the parameters could/should be an enum type rather than
   a string, it makes the code both more efficient and clearer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
