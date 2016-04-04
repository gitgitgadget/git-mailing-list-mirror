From: Alexander Rinass <alex@fournova.com>
Subject: [PATCH] diff: run arguments through precompose_argv
Date: Mon,  4 Apr 2016 22:38:44 +0200
Message-ID: <1459802325-22056-1-git-send-email-alex@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Rinass <alex@fournova.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 22:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anBHV-0006OO-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbcDDUjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 16:39:24 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35488 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbcDDUjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 16:39:23 -0400
Received: by mail-lb0-f178.google.com with SMTP id bc4so177443251lbc.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGTStndW9VpL/+2Hn8XR07wCiAAz3dVrln2LgU7r5DE=;
        b=z8rVqUKjr7Wj44Aw0wl2sN3zC06OvBOk8qY2Pgp9NEkYLHwtGi+aTFkBqSTA1WHjlS
         TJPeqlcYv4njfw5QO5uxTWIJAJe75/i6xQmBvyJaVq59y3KWRMLiC1ifJ1ylQsr51Apo
         ++AubPJAL2NE+oCRY979LoUuJyxRfPZSHNrAycU4bsAzHhP+S3mzlHGt/Wdxfhj+Uf1Z
         phZUJuOO95RLLkHVKbEeccIwrTQ0MsvxzTqUtEnj90KnDiuN/2+h2u3K+tytCNcj3DRC
         FUncBWjQBUBd/XVHFMo7Xa8S/1qQAZKYtz8pmZDS7r6Uty33Kw0QsKzZXw83wxngv/H1
         NlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGTStndW9VpL/+2Hn8XR07wCiAAz3dVrln2LgU7r5DE=;
        b=Prw9D4WQdsm9nT5Bs2+zoS4GJrXzOvkX14MeDO1z75wVmuC1BtJPdaL7WvorKpq8fT
         ZpdbD6zN249Rpeg+lKgjSoomh0Dh3g+U4+NA5mSw6YPZ3BIJ9TPkCfbU3Nis54p6KJwf
         rWUyY6skwp7pFFi2jjNTi6rFh597jeOlzxdW8/YXKK/801KNBz4gUw+bgQi0U/KauYiZ
         HjqVLc4i05dGKfORH+s2VJNAenpEb1tpBdwyD6KjWSlWMiaR21BjVdWU5J4Nrf4aWWjB
         ufHGS3F7h4ZDFjWefkVmHI3oph5N3SHwIUGglprmxJ1a8ZRaYVanRDVcbE2UdJzhryS5
         Fu6w==
X-Gm-Message-State: AD7BkJKeYywhw0wdiw2GtUrIXznvbdwXXKRZBf9Ian3m8mC5Ce03iT7/M5rOk0wcizIfmA==
X-Received: by 10.28.132.17 with SMTP id g17mr13977543wmd.63.1459802361541;
        Mon, 04 Apr 2016 13:39:21 -0700 (PDT)
Received: from Alexanders-MacBook-Pro.fritz.box (aftr-95-222-24-110.unity-media.net. [95.222.24.110])
        by smtp.gmail.com with ESMTPSA id c144sm15724635wmd.0.2016.04.04.13.39.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 13:39:21 -0700 (PDT)
X-Mailer: git-send-email 2.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290723>

I found an issue where file paths containing decomposed unicode chars
are not converted to precomposed unicode form when passed to the diff
command family.

As a result, no diff is displayed.

With the help of Torsten B=C3=B6gershausen and Junio C Hamano I came up=
=20
with the following patch to fix the issue.

Alexander Rinass (1):
  diff: run arguments through precompose_argv

 builtin/diff-files.c         |  1 +
 builtin/diff-index.c         |  1 +
 builtin/diff-tree.c          |  2 ++
 builtin/diff.c               |  1 +
 t/t3910-mac-os-precompose.sh | 42 ++++++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 47 insertions(+)

--=20
2.7.2
