From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Mon, 27 Jul 2015 14:47:20 +0200
Message-ID: <vpqa8uhaht3.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:47:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJhoZ-00043N-KN
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbbG0Mr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:47:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37133 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbbG0Mr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 08:47:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6RClIDX020588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 14:47:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RClKBu011725;
	Mon, 27 Jul 2015 14:47:20 +0200
In-Reply-To: <1437982035-6658-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Mon, 27 Jul 2015 12:57:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Jul 2015 14:47:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RClIDX020588
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438606041.4499@kR3XTKoNS1F/FQJXK70tSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274673>

Karthik Nayak <karthik.188@gmail.com> writes:

> Make the `color` atom a pseudo atom and ensure that it uses
> `ref_formatting_state`.

Actually, I think this is an incorrect change.

Previously, %(color:...) was taking effect immediately, and after this
patch, it takes effect starting from the next atom.

Try this:

git for-each-ref --format '%(color:red)red %(color:reset)normal'

Before your patch, I get 'red' as red, and 'normal' as normal. After
your patch, I get no color at all, since %(color:...) just stores
information that is never used because I have no real atom.

> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -19,11 +19,13 @@
>  struct atom_value {
>  	const char *s;
>  	unsigned long ul; /* used for sorting when not FIELD_STR */
> -	unsigned int pseudo_atom : 1; /*  atoms which aren't placeholders for ref attributes */
> +	unsigned int pseudo_atom : 1, /*  atoms which aren't placeholders for ref attributes */
> +		color : 1;
>  };

As a consequence of the remark above, I think the name and comment of
the field are misleading. There are 3 kinds of atoms:

* Placeholders for ref attributes

* Atoms that take action immediately, but that are not ref attributes
  like %(color)

* Atoms that only act as modifiers for the next atom. Perhaps they could
  be called "prefix atoms" or "modifier atoms".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
