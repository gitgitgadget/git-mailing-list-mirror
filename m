From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: Fix ocasional test failures in kill_p4d
Date: Wed, 29 Apr 2015 22:26:08 +0100
Message-ID: <1430342769-20521-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZVM-0004TJ-G6
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbbD2V0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:26:47 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35321 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbD2V0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:26:47 -0400
Received: by pabtp1 with SMTP id tp1so38998778pab.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Pz0XuIUJaB7Ac1EyA7sTGZwJFz4d/RVg9TSESdOc5y0=;
        b=ASQboJwfQbPUT3Htk7UDsVtYIVKD0d8beQ/l1EuaGaVzI/uPas+hiGnvD7PY3NkMtl
         u8LjXTBip5jnGmHVf5tChNj5SQskX02LBb1TSgJQ9p7rWWRCUiPQx2LSZQo2VNZhqVss
         eeoL6N0oxXQkCYUYAaCLzztDs3Whi5Iruwuaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pz0XuIUJaB7Ac1EyA7sTGZwJFz4d/RVg9TSESdOc5y0=;
        b=gmz+IWvkCcnt6JMKnNG4yYegmSDamB9XUR9zHR3qPJGcG4Uv25ZOENsX8z6sbWuv82
         5oIlgrt4j/OQzd/riFao8gOxvS0Bcqbd+oGDf913T1o9DJvXtiNlgS+nc8qpbw5cLZVE
         Mn+y3dRR7Ht/Amv0iptZEN2izAyVe+GwCCu1c+hhJqmY2t3PU5suZEAHEwJAQzGxw6ZT
         zs1n4x/B9d5rtJZ8CM0QWuHnhIq1k7O0palER11sAhVQSYH9F9ijuAdsvB18s1ZMAYjh
         Xz2vXBsW9BrmqCrodlxBO8MtLNhLFwll0RiJitWqI8Ku01uDiwVC8nT+pJFrFl9pg8GG
         QvVQ==
X-Gm-Message-State: ALoCoQmLoLg+qjVYzOm5u2RY7Tzt1bcJO39fX3pFlJEb2S+jnNbiEpKZvIwqA+fnGXlF55OKYoAu
X-Received: by 10.68.198.36 with SMTP id iz4mr1812553pbc.167.1430342806514;
        Wed, 29 Apr 2015 14:26:46 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id h12sm123299pdk.77.2015.04.29.14.26.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Apr 2015 14:26:45 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268008>

Running the git-p4 unit tests, I notice that the 'kill_p4d' test
occasionally fails. This just terminates the p4d server, so in
theory it should always succeed. The problem is especially
noticeable when running multiple tests in parallel:

    $ make -C t T=t98*.sh -j50

That's annoying, as it makes it harder to test changes to git-p4.

It looks like p4d is sensitive to being killed ungracefully.
Experimentally, I find that starting it with journalling disabled,
and using 'p4 admin stop' rather than kill(1) makes the process much
more reliable; I no longer see the intermittent failures.


Luke Diamand (1):
  git-p4: fix occasional test failure in kill_p4d

 t/lib-git-p4.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.3.4.48.g223ab37
