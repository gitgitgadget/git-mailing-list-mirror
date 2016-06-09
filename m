From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Dealing with a lot of submodules
Date: Thu,  9 Jun 2016 12:06:35 -0700
Message-ID: <20160609190637.21177-1-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 09 21:07:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB5II-0000ck-U5
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcFITHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:07:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35953 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbcFITG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:06:59 -0400
Received: by mail-pa0-f53.google.com with SMTP id b5so15756423pas.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xGVHHvBVk1oyLEK/UYeVG2Gjuqz0+iUffFaUljwutq0=;
        b=JsecIFNCwL1iW3cIG6XygbIGmr9YtG3by7Go/e3sxz/Zyknfy3PnRnqPr9Bi98DztQ
         cnG5VwIPnWdNy/RIVvQrzH/wQJ1c1FZrmc0sXV8DaIsxE2Eq8HljVhSxoV/KAcKbBeTr
         o6ifygecRFrjjxqxNv/Mbn2aOagbwkCXs7yidnIuMtMFOYAiq4TZ6yrnRuarX4c5Uj3Q
         kfCOgFkJF48K+sjmANpT4jx4VikTznmeOYXFrW3JqkOx7RYgcMbJ1lxwNYkgD3UtXMVi
         Q0PNK+G9o5NCtvE8rKu7fxGvxtZQ4GCGFfNXuytFLoENH/MX4FPFAhf54wyFeU+9+QtP
         DI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xGVHHvBVk1oyLEK/UYeVG2Gjuqz0+iUffFaUljwutq0=;
        b=coRD0ORAqeDmbRf2MnXaywu+7cvoQDCMjePgCKg4X068bgSvDazlv5g/WTIADQos1m
         QPr81vw5HZaUuDJqJPn0BEKE7CjA6emX0rT4wfiNyQB3j+iOi0dpr1yMGhmDb1n1J4FR
         jaJKMxPHxz3kMOyQcKaBFLQ2jM0E3ruGIwAX1ONags67pH4Uzz9CPU6nk0JEa/IMTHow
         muUiXXuZS+zncQaNZVVGGpnu+YxJtcRw5Rzld1Pst0c9djJHmBAfl/zo10G21Siq92Wh
         7hqYKajGZUosDLu5IjUjXWAH3SuqhPq4sDmL5kAz22ubzldJoDdDB7XWU3gw5Fmip2Fa
         8NxQ==
X-Gm-Message-State: ALyK8tJ8el8byLPn4TvL//KJoWnQ7bS74vdO1zlrSi6EPDyzpt7iN8Nv07Qm5MgErPfJG4sQ
X-Received: by 10.66.73.138 with SMTP id l10mr13988415pav.92.1465499218200;
        Thu, 09 Jun 2016 12:06:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5a6:3f4d:c2c2:71e])
        by smtp.gmail.com with ESMTPSA id f27sm11894060pff.17.2016.06.09.12.06.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Jun 2016 12:06:57 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc2.368.gdadd65c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296914>

We have a test repo with about 500 submodules, and I noticed some problems
when cloning this repo.  This is a series that helps dealing with that repo
in two ways:

* When having 500 submodules, you have to perform 500 clones. This makes an
  ephemeral error 500 times more likely. To cope with such errors, just try
  again after all other clones have finished.

* If a recursive clone fails for another reason (in our case a missing
  .gitmodules file), we want to keep going to finish the clone, instead of
  failing.
  
Thanks,
Stefan

Stefan Beller (2):
  submodule--helper: initial clone learns retry logic
  submodule update: continue when a clone fails

 builtin/submodule--helper.c | 44 ++++++++++++++++++++++++++++++++++++--------
 git-submodule.sh            |  2 +-
 2 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.9.0.rc2.368.gdadd65c
