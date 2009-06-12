From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 19:26:45 -0400
Message-ID: <ca433830906121626q52c15f6cjdb91ffee1f2d8652@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	 <20090612084209.6117@nanako3.lavabit.com>
	 <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>,
	Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFG98-0001XQ-Ql
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbZFLX0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZFLX0p
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:26:45 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36847 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbZFLX0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:26:44 -0400
Received: by bwz9 with SMTP id 9so2369486bwz.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 16:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LHPjD3vXx0/c7YvFDphTQ78n2Urmx2hdeq05JESvgls=;
        b=h4YvwBeZzmOfRBdboVXyuYGn6HjRHQ7PaHttXOikRvS880TjYQ9QvKEi8REQ6ev3Es
         nWmKmu8omRnsJRraG5vH019jC3+TWBg0YSZ/KhNH7PQ/BB6gF7GGLnNax+W1lbDY25/2
         sZgOwAk3xQ41ZImaSDdWVjxYrGKcKr42sEP3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=negirsQ1dGCM+lx8O4N9Ef1Gxro13luJiCiGYlfsa3nE8kd6xLVnoS3ogUqw3QbIsx
         ieyjV0WXyZLilMZk8lnni9R4Tse07UIMiZ2uUc1Z0whk2XyB1r2XlYYzIZBYpZ+ZRX3s
         i0LaCUBnPeNOfEymQwUJkRTLkKstxOZCWcu/Q=
Received: by 10.223.113.199 with SMTP id b7mr3051243faq.82.1244849205633; Fri, 
	12 Jun 2009 16:26:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121470>

On Fri, Jun 12, 2009 at 3:56 AM, Daniel Stenberg<daniel@haxx.se> wrote:
> On Fri, 12 Jun 2009, Nanako Shiraishi wrote:
>
>> It would be ideal if you can inspect the certificate and decide if you
>> need to ask for decrypting password before using it (and otherwise you don't
>> ask). If you can't do that, probably you can introduce a config var that
>> says "this certificate is encrypted", and bypass your new code if that
>> config var isn't set.
>
> Is this really a common setup? Using an unencrypted private key sounds like
> a really bad security situation to me. The certificate is never encrupted,
> the passphrase is for the key.
>
> And for the libcurl not supporting this, I figure it _could_ be done by
> simply letting libcurl prope the remote and see if it can access it without
> a passphrase as that would then imply that isn't necessary.
>
> I'm not familiar enough with the code and architecture to deem how suitable
> such an action would be.

I don't think it is possible to check to see if it is encrypted from
within git (without calling OpenSSL directly.)  To implement this in
libcurl, a possible solution is to always set
SSL_CTX_set_default_passwd_cb(), and have the callback function prompt
the user on the first call if CURLOPT_KEYPASSWD is not set.  If there
is interest, I could try this out and, if it works, submit a patch for
libcurl.

The upside of doing the prompting in git is that it works with old
libcurl versions... but I'm not sure this is a big deal.  Having it in
libcurl is probably better.


On Thu, Jun 11, 2009 at 7:42 PM, Nanako Shiraishi<nanako3@lavabit.com> wrote:
> Somebody mentioned that your patch forces people to type password
> even when the certificate isn't encrypted. How was this issue addressed?
>
> <snip...> If you can't do that, probably you can introduce a config var that says
> "this certificate is encrypted", and bypass your new code if that config var isn't set.

Patch 2/2 gives the user a way to disable this new password prompt.  I
imagine it is a more common for the certificate to be encrypted than
not, so I believe the default should be to prompt.


Mark
