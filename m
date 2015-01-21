From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv1 0/6] Fix bug in large transactions
Date: Wed, 21 Jan 2015 15:23:39 -0800
Message-ID: <1421882625-916-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 00:23:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4cr-0000Ix-F9
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbbAUXXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:23:49 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42317 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbAUXXr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:23:47 -0500
Received: by mail-ie0-f182.google.com with SMTP id ar1so13447789iec.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OPDVOZ6m3yNX9WaoCdbYdJ+2Dom4FyXEzOk0+zs4MGc=;
        b=BbzvpcN92BWRBr51h0/aHIw71p0+vtMEkU83/fBcBGsnVixiE2qCWuzb6McGMaICII
         BfRIhv6qV0K7oXIR4v1/gvxzPxzwcYTPvoSH7KsdBVu/Jh9fIl+bNWula+eaajDerBhv
         G4RQEhJJx+/7QRc9SU/HNkm6mSRRWdaXXqJj/iIapors+FElBIFeZEEXA6GkzT9oKAA4
         2JhatMZdeEZumnnJq+jsDIecKQuTMj7SkG8lnXqxG2EGMNlNN1SCMef0OzErdh2Ahems
         tJMdShDKBtVJ6bEC4diOlVwtfM9V7+gVzePU0GPGGn+BNSM+6i2eLdoB8dzj/35VT9MC
         9jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OPDVOZ6m3yNX9WaoCdbYdJ+2Dom4FyXEzOk0+zs4MGc=;
        b=I5gz+1T7RH5eQxasyKcbya/tN3XW0FXtV7qf8MHKd2SvdMEDUdH5+Am3VJy9eLyFmO
         jcaEujwUQlRagRjRHlhE/adty62Ok8phu76AfZGeQpcjuJGS56spu999lfbARCSaTwb7
         TvA98nBpdLsyVyg8xNsOfMmh+AmlLvZjBlaVFB41CuQ2giOYL3QfYgSi81EYiSNjFGig
         SdmfT45mG+EhVrQpB0Yn6x1kez0N8XLLR+EDMCYY3Q3aczNxucODBXhtcvnqdFPrxIDC
         rPcbae+uo/8gWGfKjXW+JUl0v6t1JyfjdHEAptysbh+ov06UWi0JiHuBRcTsH6Ofi601
         ZpvA==
X-Gm-Message-State: ALoCoQmePdrdxBUYVizgqVVlkXyybUrbUznSjqagTm9rPxnsC3hs0nOWKqZU/B/rV/lXogERsOPa
X-Received: by 10.50.171.201 with SMTP id aw9mr38830163igc.2.1421882627296;
        Wed, 21 Jan 2015 15:23:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id b7sm687741igx.15.2015.01.21.15.23.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 15:23:46 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262776>

(reported as: git update-ref --stdin : too many open files, 2014-12-20)

First a test case is introduced to demonstrate the failure,
the patches 2-6 are little refactoring and the last patch 
fixes the bug and also marks the bugs as resolved in the
test suite.

Unfortunately this applies on top of origin/next.

Any feedback would be welcome!

Thanks,
Stefan

Stefan Beller (6):
  update-ref: Test handling large transactions properly
  refs.c: remove lock_fd from struct ref_lock
  refs.c: replace write_str_in_full by write_in_full
  refs.c: Have a write_in_full_to_lock_file wrapping write_in_full
  refs.c: write to a lock file only once
  refs.c: enable large transactions

 refs.c                | 41 +++++++++++++++++++++++++++++------------
 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.2.1.62.g3f15098
