From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Another squash on run-command: add an asynchronous parallel child processor
Date: Thu, 24 Sep 2015 14:13:05 -0700
Message-ID: <1443129187-18572-1-git-send-email-sbeller@google.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 23:13:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDpc-00083d-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbbIXVNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:13:21 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34069 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbbIXVNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:13:17 -0400
Received: by padhy16 with SMTP id hy16so83534849pad.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RoTp34OH0HoI/cG9rWZYob2ZFMJ1/r8GzUkb82abgg0=;
        b=f9bbY+ZgzDjWR7gp7zL2KXwCHK0b8Rq597eyA4TJ9hLOaXFxVUylIB0rW4vEc3iqbf
         PJ+8dbth2cOXtY8iBAPTd9c7Tvm6o8bNl0V7W1sA4QcbKLs0x6zwjF0QMI78MFh0g9Xm
         GmjJYr8iChlrgAFEtqFKHm+8mQQTLe6JagHzOLhmK/bEDgwTPk+EvhsDkkIZCEB7KUAl
         C1A8w5irl5wfc3T6DIdltSHSd64LfsRMsg2gRdO/efbduNK9S8byIVKN3oKc/9YqJxnl
         MHIMuDcmNq08dPpWFQNm3t3nSc06BkzpA7QbhECn8cyHoDzWB7uUu6SIIceUh7HdLl+g
         ZS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RoTp34OH0HoI/cG9rWZYob2ZFMJ1/r8GzUkb82abgg0=;
        b=BqBsFRU5HaGhIGtBe8G/sLAeRlXQxxAh3b70c2G4QxnbPrb0viZB80IUUj6sjm9kOD
         bOav6rL8vaxnY9WcwVWrPiT9CLXtfIcbM8F9/HV6ZeSkfJ39Qc9Rp6CEAQaKyuPxxRcZ
         rPpy7hEjZso6eRsvIfrb3v25g7RAmr86hpUHFei/mQ6AqF19qfCViVBvjaxVVkfL6kQi
         EDotAMeuHK/w3ufOdKGm9fHjgNP+HI5gh9oEcf1JRk5872LWypsp6yAOYKCOqxolWFwp
         wiOYPfJX3W1CE7vtspTVbuP5qpHtoRT6Zei7/IKYYvNxvkQ+k+Z6XzXV91I7SLH61ixP
         YrQA==
X-Gm-Message-State: ALoCoQlxkzSLwz6bv1oLdBx3nTBveEiq3T76zHHKkxKp5DAHpIum9UBCaBzTSgWz5OVcbUhPQ2hp
X-Received: by 10.68.109.2 with SMTP id ho2mr2248914pbb.158.1443129196108;
        Thu, 24 Sep 2015 14:13:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:85b5:1b05:2b7d:c74a])
        by smtp.gmail.com with ESMTPSA id bc1sm135818pbb.66.2015.09.24.14.13.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Sep 2015 14:13:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278631>

Here is another proposal for squashing.
It's basically both squash proposals by Junio, plus another issues I think
should be done right from the beginning.

 [added by sb:]
 * If you do not die() in start_failure_fn or return_value_fn, you
   don't want to write to stderr directly as you would destroy the fine
   ordering of the processes output. So make the err strbuf available in
   both these functions, and make sure the strbuf is appended to the
   buffered output in both cases.

Stefan Beller (2):
  SQUASH???
  SQUASH for "fetch_populated_submodules: use new parallel job
    processing"

-- 
2.5.0.273.g6fa2560.dirty
