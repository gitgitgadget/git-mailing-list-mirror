From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Combining APPLE_COMMON_CRYPTO=1 and NO_OPENSSL=1 produces
 unexpected result
Date: Wed, 23 Dec 2015 03:51:56 -0500
Message-ID: <CAPig+cS2+NP=-XEYA6e=doQu=+Qn-Lzut-7OCeYJRFZFchNepg@mail.gmail.com>
References: <CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jack Nagel <jacknagel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 09:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBf9O-0001WE-6r
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 09:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933546AbbLWIv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 03:51:58 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35334 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbbLWIv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 03:51:57 -0500
Received: by mail-vk0-f47.google.com with SMTP id k1so3143000vkb.2
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 00:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Shuy29wsOPcayTiv6CKfhFpBGcS0Brmg4nQXvKmW4DI=;
        b=YV32y2gvqTEV3NJU4Q0kNOE+zcvHF6qmXBOMtjKao4FcaVrBmfQRcWZjjuPo9RaMXO
         4OFKP58CWXufKTg4aHUufGeguoJJUnj24qvpUWCOn/VHIS13er3qCbz18aCBlwdH2rWn
         o/aleEkmKPcan9R6tHjilkZPooM49m6TTGkQFVBXzEQSPf5fuDwuKancvGZ7g4jrEc/c
         05Uytu8GRvuSW1RtDjtPmGnDF5Qo+nha7HKaQNODRN9O6zpLOlIPJqL+JSZ97ZEl6W5F
         07lMfs2S1V8S8+PuC6n8DFG/7JkmlO8adM/8qMDuO6LvJTHEBkenSmVWY3k98TEIn+If
         Hczw==
X-Received: by 10.31.58.142 with SMTP id h136mr18716847vka.115.1450860716723;
 Wed, 23 Dec 2015 00:51:56 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 23 Dec 2015 00:51:56 -0800 (PST)
In-Reply-To: <CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com>
X-Google-Sender-Auth: _5-SGqf7WU4r-YvwfCl6koVwVzo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282928>

On Wed, Nov 25, 2015 at 10:10 AM, Jack Nagel <jacknagel@gmail.com> wrote:
> When compiling git on OS X (where APPLE_COMMON_CRYPTO=1 is the
> default) and specifying NO_OPENSSL=1, the resulting git uses the
> BLK_SHA1 implementation rather than the functions available in
> CommonCrypto.
>
> $ make NO_OPENSSL=1
> [...]
> $ nm git | grep _SHA1_
> 0000000100173f00 t _blk_SHA1_Block
> 0000000100174e80 T _blk_SHA1_Final
> 000000010018fbb0 s _blk_SHA1_Final.pad
> 0000000100173de0 T _blk_SHA1_Init
> 0000000100173e10 T _blk_SHA1_Update

NO_OPENSSL disables all SSL-related functionality in Git, not just
SHA1 computation, however, Git still needs to compute SHA1 hashes for
other reasons, so it uses its own BLK_SHA1 versions when OpenSSL is
unavailable.

> However, with OpenSSL available, it does use the CommonCrypto functions:
>
> $ make
> [...]
> $ nm git | grep _SHA1_
>                  U _CC_SHA1_Final
>                  U _CC_SHA1_Init
>                  U _CC_SHA1_Update
>
> I would not expect the presence of NO_OPENSSL=1 to change the behavior
> here, since neither case actually makes use of the OpenSSL SHA1
> functions.

Apple's CommonCrypto headers present OpenSSL-compatible API. When
CommonCrypto is enabled in the Git makefile, aside from pulling in the
CommonCrypto header and linking against the CommonCrypto framework,
from Git's perspective, it still thinks it's using OpenSSL, and all
SSL-related functionality is enabled (including the SHA1 functions).

So, it might be easier to think of NO_OPENSSL as really meaning NO_SSL
(that is, "disable all SSL-related functionality"). Since the only SSL
implementation Git knows how to use is OpenSSL, perhaps one can
consider the name NO_OPENSSL a historic anomaly.
