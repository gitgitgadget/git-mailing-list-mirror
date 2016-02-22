From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Submodule harden fetches (WAS: submodule: Fetch the direct sha1 first)
Date: Mon, 22 Feb 2016 14:35:46 -0800
Message-ID: <1456180548-20996-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, dborowitz@google.com,
	jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:37:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXz6k-00080A-0v
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbcBVWh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:37:28 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33028 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbcBVWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:37:26 -0500
Received: by mail-pa0-f46.google.com with SMTP id fl4so98242009pad.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EPzw3xTNLl9QH3hJA31ByjpQj0e0lf64D3z9e2oRfHg=;
        b=ROL68cz1pWak316IXxlzV/z7RXm+T4bV7kR/5Zsen8q+DePQRsZ24VcortbCigbUJr
         ddq13P1Rbm+9aI1wcWyCi/ZyUDMWJmIAuIYplwz6gjoiw2eaOPdfx12logd4xHxA+m9S
         3Sck0jkgIeJQetN0B6O30oZlUtVy/SG83jZVE/TXkz2D5sDSmdwXU4WEat4IEBeAjA9K
         xlSzPiARi8TpWoA4RKLhxgSiJNqqHvoOOluaT2wdbpLsJdj+zMpWMZHvz/SgHuxQpvGS
         q2KBT2pXzbWAv9H3hrVvetRQpwvuRKZ9VW5dC08JRvV1aAoNfTqxx3lx1EH2hKCac3LZ
         IpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EPzw3xTNLl9QH3hJA31ByjpQj0e0lf64D3z9e2oRfHg=;
        b=WTYRnENP2FbU+s3B/u33s7c4SsPdmoMSxkixHlJf6gNFI2lUbYyJFHW7TnQSKqC/8s
         dsVUzuavAoepwU9+/ZX36f6BixbdVjLA8WGGJ60kYMtPQlnat0Bk6gP7OCtz3qId17BB
         gy1XUmztx0cCJIW6dd8+W8hgW0+MD72L2V564dKeKGd5cnpAScztPKTmMDi2eT/FNBry
         KJ6GqLr3Z/nKhJ8VuEEjJyef6OaIOCE4HnHjyuJKXOzqQCeF/2KQUbRFu2E8uq7jNwJT
         0964ZsNKJ6crNALWHPyprz3fZ/Nj1apIcT0TO7zBsJZ5hgXWvVU+tMmATgjC+nPG45nH
         EfHg==
X-Gm-Message-State: AG10YOTtfsfpWqwJWt7AVFs8PCwTaihxraG8eCfJAhmrwXMy/qlk73QtyvwSeBkubYsRmhnv
X-Received: by 10.66.145.194 with SMTP id sw2mr41214112pab.69.1456180645867;
        Mon, 22 Feb 2016 14:37:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c420:8149:fd30:c3e3])
        by smtp.gmail.com with ESMTPSA id yh5sm39410790pab.13.2016.02.22.14.37.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 14:37:25 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286967>

A simple patch evolves into a series!

First we'll fix a bug by adding the --objects switch to rev-list to
have a stricter check for the desired commit to be there. IIUC this
is not 100% right yet, but it improves the situation.

The second patch introduces an extra fetch in case the first fetch
did not yield the expected commit, using the pattern

    # first 4 lines unchanged:
    if $sha1's history and objects are incomplete:
        fetch ;# normally just like we have done before
    else 
        die ...
    # new code:     
    if $sha1's history and objects are still incomplete:
        fetch $sha1
    else
        die ... 
        
Thanks,
Stefan

Stefan Beller (2):
  submodule: Include check for objects when fetching
  submodule: Try harder to fetch needed sha1 by direct fetching sha1

 git-submodule.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.7.0.rc0.34.ga06e0b3.dirty
