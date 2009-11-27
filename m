From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/2] http: allow multi-pass authentication
Date: Fri, 27 Nov 2009 23:41:10 +0800
Message-ID: <20091127234110.7b7e9993.rctay89@gmail.com>
References: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>,
 <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>,
 <1254510286-23155-1-git-send-email-nmiell@gmail.com>,
 <25718488.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Martin =?ISO-8859-1?Q?Storsj=F6?= <martin@martin.st>,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 16:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE2wu-0000Nn-9j
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbZK0PlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZK0PlV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:41:21 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:34333 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbZK0PlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 10:41:20 -0500
Received: by gxk4 with SMTP id 4so3754gxk.8
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NNXJTw3zQhtPcSWY9MjKmCVAAiVEhGyQgW1n6hIQiDw=;
        b=n2HqvXMbP3Ai3YgUBQz4cxp3yyj/pDNmgGB6UZkzGmPuuLwovIwQTOGMU1/fxYoJ9h
         1N7URpK6OC9fyozLIrEmWMoI2HvIEWypZCxuv3oh54x4RqVATx6Rd1SA42qRdglcU7qr
         EHwMM1WkP6K9WCDOAjm6TkGJVr9ghnnzI/jkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=IBsr8N3mIAPWym2bZWdWvB/nWNLVOzSr7QPo0JGEw1+efzBaUjbZUxMmmxtieJbwX2
         3aJ0euUiaUw8aRfCslj4BLSqEOaCMMghnNg98l+AXlZ+kYAKZ/0iqQyt646ohoUkwjii
         AhhZD33JJZ5cwO4ldKBNe/p4xixfQrCE8T5y0=
Received: by 10.150.56.1 with SMTP id e1mr1903991yba.225.1259336482345;
        Fri, 27 Nov 2009 07:41:22 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 4sm641391ywg.28.2009.11.27.07.41.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 07:41:21 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133903>

This patch series applies on top of master. It enables fetching and
pushing over http with the most suitable authentication scheme chosen
by curl when the http.authAny or GIT_HTTP_AUTH_ANY is set.

Authorization headers can also be preserved across requests, with at
least 1 curl session being preserved by default. This is especially
useful for the smart http protocol, where it is hard to rewind and re-
send a request.

Nicholas, Martin's patch should lead to similar functionality as your
patch (dated Oct 3rd) would. However, unlike your patch,
CURLOPT_HTTPAUTH is set even if the user name is not specified
explicitly in the remote url, since it's conditional on
http.c::user_name being set.

I've tested this with Digest, and I believe this should work with NTLM
too.

gsky, could you try this out with NTLM?

=?ISO-8859-15?Q?Martin_Storsj=F6?= (1):
  Add an option for using any HTTP authentication scheme, not only
    basic

Tay Ray Chuan (1):
  http: maintain curl sessions

 Documentation/config.txt |   13 +++++++++++++
 http.c                   |   41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

--
Cheers,
Ray Chuan
