From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Another approach to large transactions
Date: Thu, 16 Apr 2015 16:17:36 -0700
Message-ID: <1429226259-21622-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Apr 17 01:18:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yit2n-00010f-MB
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 01:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbbDPXR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 19:17:57 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35849 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbbDPXR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 19:17:56 -0400
Received: by iebrs15 with SMTP id rs15so63503478ieb.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BifWRRoWI7eHKCUKe/lb+7TdhNIG0LbvapoJAtnAj1g=;
        b=Eaay2Ir+J3xcG5mplWtkCecVNRkO1FOoPxdm+0oyPbH32L9Mn3+1JUTWNbXc87+99v
         KtZJSVYBDZ850kmLLk5geUVa5rNVVwU7lVRJXQWaFWvpp7DyFX1IbzU1RCesrx6AtHaJ
         IuFZmkzQm/xq0V4Y4xYrdQDKybmYrGgM8uBMc3gnx5edbz5tOsKwT5hGl7Ipfzx0Tidv
         GTXKGF6yntJb4wYatfLGfPKFfA/xIo4Y41xT3eW2hxNog5qRwprfRDTiSa5TSLj3BVfr
         IuuX1rVpDftTXql5lMwOFhAI/JonpXCUBsCKqoWuAd116stsrSHst/HKCfRKEPvRsX11
         FDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BifWRRoWI7eHKCUKe/lb+7TdhNIG0LbvapoJAtnAj1g=;
        b=SUNewLoKCak4Yfh/3Z/PrKk5Klqb2AJnsi5qPMD7QhVDU/kWVEX2lJbq8gfz9F5S6M
         2vCx7MUJ9H9RXdX0jQ5J9+/NpSEQbe3bHgOFrcCwgLd2wH4yIExsQNg1i9p/3HC+s9Dw
         IcO/fdonc+enHLKgTOW33d0sh34xMkP+NdCQYftBx981RUnIARWxTmKOPvU//3CFZvfo
         FFIcoBdz8p0jl5yaObLPGRfIPrN9OhOUFlpxcILxuGYfAs29Ydz0YS6nINOKum+1E1S+
         yjelNxWaxgmQsGGanp/Eorn+qysmrPSwHsroBi17BHehxuY4nkIzpIIaOwPqVH0QopT2
         fTjA==
X-Gm-Message-State: ALoCoQleA2VjkaJ97SWUNPWt0SvJxFT613QAGkMNUUMoCp0onvtYMy7O1F1g9/nVRaNEVL7m0iwd
X-Received: by 10.50.6.4 with SMTP id w4mr779169igw.36.1429226275368;
        Thu, 16 Apr 2015 16:17:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:fdc7:e96c:1b25:2317])
        by mx.google.com with ESMTPSA id kc1sm150960igb.0.2015.04.16.16.17.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Apr 2015 16:17:54 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267342>

* We keep the speed on small transactions 
  (no close and reopen of fds in small transactions)

* No refactoring for refs included, only minimally invasive to the refs.c code

* applies on top of origin/sb/remove-fd-from-ref-lock replacing the last
  commit there (I reworded the commit message of the last patch of that tip,
  being the first patch in this series)
  
* another approach would be to move the fd counting into the lock file api,
  I think that's not worth it for now.


Stefan Beller (3):
  refs.c: remove lock_fd from struct ref_lock
  Move unsigned int get_max_fd_limit(void) to git_compat_util.h
  refs.c: enable large transactions

 git-compat-util.h     |  1 +
 refs.c                | 28 ++++++++++++++++++----------
 sha1_file.c           | 41 -----------------------------------------
 t/t1400-update-ref.sh |  4 ++--
 wrapper.c             | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 53 deletions(-)

-- 
2.3.0.81.gc37f363
