From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] sha1_name: don't trigger detailed diagnosis for file arguments
Date: Mon, 18 Jun 2012 19:56:56 +0200
Message-ID: <vpqipeopkpj.fsf@bauges.imag.fr>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
	<1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vehpc4jpw.fsf@alter.siamese.dyndns.org>
	<vpqpq8wpled.fsf@bauges.imag.fr>
	<7v62ao4ihf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 19:57:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SggCK-0001zk-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab2FRR5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 13:57:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36742 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468Ab2FRR5C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 13:57:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5IHugoi030228
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 18 Jun 2012 19:56:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SggC9-0003dZ-Fs; Mon, 18 Jun 2012 19:56:57 +0200
In-Reply-To: <7v62ao4ihf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 18 Jun 2012 10:50:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 18 Jun 2012 19:56:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5IHugoi030228
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340647004.64986@dYqGyCJ373Hd5HdPnT5qgA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200153>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> My version reads as
>>
>>   try something;
>>   if (it failed && I'm only here to report an error)
>>           report_error();
>>
>> which I find easier to understand.
>
> I agree that _this_ part is easy to understand when written that
> way.  But then shouldn't there be a blanket "The caller is here only
> to report an error, but all the previous code didn't find any error,
> so there is something wrong" check much later in the code before it
> returns a success?  Or am I being too paranoid?

Currently, there's no problem if get_sha1_with_context_1 returns without
dying, because the caller does:

	if (!(arg[0] == ':' && !isalnum(arg[1])))
		/* try a detailed diagnostic ... */
		get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);

	/* ... or fall back the most general message. */
	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
	    "Use '--' to separate paths from revisions", arg);

If we failed to give a nice diagnosis, we give the generic error
message.

We could add this check within get_sha1_with_context_1 to simplify the
task of the caller, but that would require adding it before each
"return" statement, which I think is overkill.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
