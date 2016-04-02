From: santiago@nyu.edu
Subject: [PATCH v3 0/4] tag: move PGP verification code to tag.c
Date: Sat,  2 Apr 2016 19:16:11 -0400
Message-ID: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:16:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amUmm-0004UZ-CR
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbcDBXQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:16:51 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34323 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbcDBXQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 19:16:50 -0400
Received: by mail-qk0-f194.google.com with SMTP id z64so1088611qkb.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+T6HkZJimmM5d6WNEAR3ESnyE5abvIEQNO6lrA8rXug=;
        b=Acczl2Rhfqs7laJk/ZDhV+TXJjph3yVP+ZyiC1uRivK6+rsPlxfuh2gU+tmlFCCo75
         qw+6G13nW7j6f54W6jpH26yr2gtMZvrq4+WVmflaEcrVxSjPcxe1hsmMgHrq4IGP0Wzi
         Ey4r6lnrwKSixjrG8XZzc3mNPdwDL9R9DdXjkLPAHDwDVXk8yMAeR+QOmbk1h2FQZ/Lt
         f4LoQopN/66EcCKtHC8jWAPLcw2PWvjBNSoFTqD9Zns0TNx2giwxJ3v96o26B/jqLQQd
         h7g4CcFOQ56bYkKnr+zAclvfTCAWIOhvs4jOd75EOOHPAP6uwHOohlmKD/4F2BAPAEzk
         ZJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+T6HkZJimmM5d6WNEAR3ESnyE5abvIEQNO6lrA8rXug=;
        b=YgcUCIqxgRdN9XnqC8Vjc+PJd9KpZdKlpDthDabyMWUcH0Pbsjd4vaZTlZ/SzQfwz7
         ce5OjukJ16pupk4dcQIjctI0Oyq5gBnM/izgc0CEE0VhvQNNpDBgMjczi++qxYEANNQj
         I8S1rm1NwOH313m9L/qLsdACocGoQ1B8BI9d1uQhALlsvPsicH2FhKyDDC7iNpIYmwhR
         eEK0SXpS2XZ+KQGcygQxrEkiun9ZY1NYopBIQsIMz/4r+YHgtbI2FSRHoxAM0TBdW//6
         gn29AC1uRKOYcP4KZRE+mvOAlTEnNXkJ9MG7Yjnmxm/vXDyK6O5q0eNT9wmcDxxSDkmB
         xkVA==
X-Gm-Message-State: AD7BkJK65iGxKKoYbUWXfDqT+EzrrZorDDUhrmoCA4WXFIaT5dXrPTm3qLkdJJToMK3Zv0Ao
X-Received: by 10.55.71.143 with SMTP id u137mr26467449qka.1.1459639009766;
        Sat, 02 Apr 2016 16:16:49 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id l33sm9199788qge.11.2016.04.02.16.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 16:16:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290608>

This is a follow up of [1] and [2]:

v3 (this):
Thanks Eric, Jeff, for the feedback.

 * I separated the patch in multiple sub-patches.
 * I compared the behavior of previous git tag -v and git verify-tag 
   invocations to make sure the behavior is the same
 * I dropped the multi-line comment, as suggested.
 * I fixed the issue with the missing brackets in the while (this is 
   now detected by the test).

v2:

 * I moved the pgp-verification code to tag.c 
 * I added extra arguments so git tag -v and git verify-tag both work
   with the same function
 * Relocated the SIGPIPE handling code in verify-tag to gpg-interface

v1:
 
The verify tag function is just a thin wrapper around the verify-tag
command. We can avoid one fork call by doing the verification inside
the tag builtin instead.


This applies on v2.8.0.

Thanks!
-Santiago

[1]
http://git.661346.n2.nabble.com/PATCH-RFC-builtin-tag-c-move-PGP-verification-inside-builtin-td7651529.html#a7651547
[2] http://git.661346.n2.nabble.com/PATCH-tag-c-move-PGP-verification-code-from-plumbing-td7651562.html 
