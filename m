From: =?ISO-8859-1?Q?Jens_Lindstr=F6m?= <jl@opera.com>
Subject: [PATCH v2 0/3] remote: optimize rm/prune ref deletion
Date: Fri, 23 May 2014 12:26:26 +0200
Message-ID: <537F2252.3010101@opera.com>
References: <537B2FA4.7020001@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 12:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnmgj-0006qo-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbaEWK0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 06:26:54 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36412 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbaEWK0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:26:53 -0400
Received: by mail-la0-f49.google.com with SMTP id pv20so3878571lab.22
        for <git@vger.kernel.org>; Fri, 23 May 2014 03:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=b/04ppHzvQFyDdbAdxWX15RImsFE12PS/GyItCBDM1k=;
        b=KWR5yb/4CKAPB65Lg+xm9v1JFBnquikeBBe9hueOfxPGiJimUTMJt2m07VM6Sp82MM
         OFM4jdaTS42HSHKnJ+D1k1SoR3F2qUQR6VrzISMwLF/TiloYb8QKiJ0nOIZ5pBfkY522
         t4S07UdJbHKIJO9Pk5fe54cteSez4+EVwYPuVfEE5NZJOjTN5tatGZBzqKrXg9tz5aKe
         nwucd32Sc//RtNsp502LUrQQtToX/IIxqTvvpzVqFKq4yD2AVeyB+X2LeT54CQ/4lXVp
         EXTk/5uS9s56qZqcUwq6UqrVnSyfy10xlYrnOdX3G4m4ni8DG/O2FodMECeV9g8gldOc
         6GHw==
X-Gm-Message-State: ALoCoQlbI8/Uu5tKf/xXkS3cBMVPG78weqL3LT7n1bIqElXodWO7L2vGkzsJRJUa8KtF/2Jkt2+V
X-Received: by 10.113.4.70 with SMTP id cc6mr2605063lbd.21.1400840811557;
        Fri, 23 May 2014 03:26:51 -0700 (PDT)
Received: from [10.34.0.102] (77.72.99.119.c.fiberdirekt.net. [77.72.99.119])
        by mx.google.com with ESMTPSA id bj7sm2528116lbc.22.2014.05.23.03.26.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 03:26:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <537B2FA4.7020001@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249981>

Changes since previous version:

 * Additionally change the order that 'remote rm' does things so that it
   removes the remote configuration as the last step and only if the
   other steps succeeded.

 * Change the packed-refs repacking patch to repack before deleting refs
   instead of after.  This makes the patch simpler, since delete_ref()
   no longer needs to be told not to repack.

Jens Lindstrom (3):
  remote rm: delete remote configuration as the last step
  remote: repack packed-refs once when deleting multiple refs
  remote prune: optimize "dangling symref" check/warning

 builtin/remote.c | 37 ++++++++++++++++++++++++++++++-------
 refs.c           | 21 +++++++++++++++++++--
 refs.h           |  3 +++
 3 files changed, 52 insertions(+), 9 deletions(-)

--
1.9.1
