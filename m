From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] ref_transaction_update(): remove "have_old" parameter
Date: Thu, 12 Feb 2015 09:32:11 -0800
Message-ID: <CAPc5daX80Mk2cRNAijTckHZ-EFJhiF4GHWMxBK4wYJYSwaEe0w@mail.gmail.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu> <1423739543-1025-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 18:32:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLxcy-0006nv-GI
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 18:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbbBLRcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 12:32:33 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:55987 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbBLRcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 12:32:32 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so11447888obc.6
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GB1sRGmVymrqothcN/i36ghk0zsSefjLKIMWK/x5d4Y=;
        b=gSyZYOtZv7Lo+rSSVbVOhNePzsTp0MWIkXVjq7dnVmu67LKJUe7eimJvpyW6qAIFWz
         FhSCkdVcVBJbFYgv7T4F64rio5rg3sW32/4/v4n41T3j9Tumj8nngr1XqZM1lcEb4pOh
         YM9Fy45rQ4WD3UBV6OWfcX75qSuWhs9CjqoEnCaYxcLMv+irl5NGoT6e/cCXa6ogFdG5
         ioNZAFeeNwQfrn7ZAk8cRJi3oTxL9GKpX99yjmzs9c/3qx0Mty76WNFGQNcDG0AGorEQ
         Ht3n0JZbXKQTPK1JPorDlw+QxtEtrljaPxLUW/fOJSqB/cYAd2uFZuEQsQib1cY6usdP
         N/Aw==
X-Received: by 10.182.43.129 with SMTP id w1mr3594458obl.86.1423762351924;
 Thu, 12 Feb 2015 09:32:31 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Thu, 12 Feb 2015 09:32:11 -0800 (PST)
In-Reply-To: <1423739543-1025-5-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: V0w8pjw0a8_NlBTXHr5IxRLpZls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263745>

On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Instead, verify the reference's old value if and only if old_sha1 is
> non-NULL.
>
>...
> @@ -3664,9 +3664,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
>         if (transaction->state != REF_TRANSACTION_OPEN)
>                 die("BUG: update called for transaction that is not open");
>
> -       if (have_old && !old_sha1)
> -               die("BUG: have_old is true but old_sha1 is NULL");
> -

In the old world, old_sha1 here used to be one of
 (1) NULL, (2) null_sha1[], or (3) a real object name.
What is the rule in the new world?

Does it still allow NULL, and if so what does NULL mean?
The same thing as null_sha1[] or something else?

Or is it an error to pass NULL to this function after this change
(which I think is a very sensible rule, by the way)?

If the former, perhaps "if (!old_sha1) old_sha1 = null_sha1;"
here might be a prudent measure to simplify the code.

If the latter, "assert(old_sha1);" may be appropriate.

>         if (!is_null_sha1(new_sha1) &&
>             check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>                 strbuf_addf(err, "refusing to update ref with bad name %s",
