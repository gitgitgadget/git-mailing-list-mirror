From: Not Sure <kuerzn@googlemail.com>
Subject: GnuPG commit signature verification ignores GPG's status-fd and status-file
 options
Date: Tue, 09 Apr 2013 13:58:52 +0200
Message-ID: <5164027C.4020007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 13:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPXCb-0002E4-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 13:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828Ab3DIL66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 07:58:58 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:45626 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759136Ab3DIL64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 07:58:56 -0400
Received: by mail-ea0-f171.google.com with SMTP id b15so2853547eae.16
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=cU6LqWybyBEuaN4OUWIXZ/W9vNEkrGgG9F8ovV7TyZM=;
        b=Yhh/jB5gZgNymORGAC+2gaX+UIAabbi1ssZTRFhuZ5K/zmaZhSQDHy0I4Bc27Q/s53
         dCIOF2maruU3lpm8naWZ7/tkJtfc6XEnI4kZ7MSEFzEaMzlb2MRFthcyN77+xrvSzWYl
         3GxXzLtwUqmSBbrjWvOM/Jp7a4rmD7jjsiIvd9m1eWFK+3+HqJiZ6eTGfWCEQCkrABpN
         7GGAlZzsP6K0rL2NmwAko3jztq66pp6AgkJyrSil90zbqI5TSILO6VfMUKQMynuEW2Hu
         4ggMh4c0mkE7Eq7aAebaXOeX32n+mrjfCSoukJctMbN0usfYsPBD8f+odr5vsf11l4lv
         t8IQ==
X-Received: by 10.15.107.205 with SMTP id cb53mr59466546eeb.14.1365508735598;
        Tue, 09 Apr 2013 04:58:55 -0700 (PDT)
Received: from [192.168.178.23] (p5480A7D6.dip0.t-ipconnect.de. [84.128.167.214])
        by mx.google.com with ESMTPS id cb50sm15852665eeb.14.2013.04.09.04.58.53
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 04:58:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220566>

Starting with the newest git version 1.8.2.1, the signature checking
code somehow ignores GPG's status-fd and status-file options, which are
THE way to machine parse GPG's output (seee [1])

How to reproduce:

1. Put the following line in your ~/.gnupg/gpg.conf file:

status-fd 1

2. Produce a singed commit:

git commit -aS -m "signed test commit"

3. Let git check the signature:

git log -n 1 --show-signature | cat

Output:

Commit 104cffdaaaaed653aasdddddddddd
gpg: Signature made Tue 09 Apr 2013 01:09:09 PM CEST using RSA key ID
12345678
gpg: Good signature from "User"
Author: user <usermail>


Missing from output is the machine parsable GPG information:


[GNUPG:] SIG_ID sorvifhoerui/asidunb 2013-04-09 23947273
[GNUPG:] GOODSIG 433811111111111324 User <usermail>
[GNUPG:] VALIDSIG ddddddddddddddddddfsjidjfv 2013-04-09 aoidfjidh0 0 4 0
1 2 00 oshidvoo444444ddddddddd
[GNUPG:] TRUST_ULTIMATE



Note: The git-log format specifiers %GG, %G?, %GK, ... do not provide
enough information, as they, for example, do not provide the
information, that the signature is valid, if the key is untrusted (which
will simply leed to a "bad" signature).



[1]
http://www.gnupg.org/documentation/manuals/gnupg-devel/Unattended-Usage.html#Unattended-Usage
