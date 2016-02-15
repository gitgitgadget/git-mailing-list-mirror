From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/4] git remote improvements
Date: Mon, 15 Feb 2016 18:42:26 +0100
Message-ID: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 18:43:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNBa-0001Qe-4u
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbcBORnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:43:41 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34653 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbcBORnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:43:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id b205so9442867wmb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EnOLQYs2477GqXswkUODstv15SBTOFtWRBpZY4Lme1c=;
        b=wYd4U3G6oip7pMSJzNoG9c0+VC9P7gnq88wAWBqSnvoB4FvQvbHd29apUGdBehJVho
         bmlUJq4FItw9j4H2xOg49u0L90VDEF03yvwNKbgiasbBipFADJc4w+uUG4u0R9GfcR/5
         TN96BVrVastP6munIdWeW3JWwJkB3AQrlwn4ykAwU4zqjCkJp5WZZsZLBlmlxrzQRg3L
         ZRuwjxiy/OV7HhCsKmRRi4jWbzzNWfl/mjn91aaC+xPJjMGHVIALOk17UVpsnLIXxg4u
         PVkXkwX7LsHBT1DhUHwRbtjcCkf0Yybly1dByxPaXhn/6+oVzg+oIS87SDCST+5gFVOd
         TR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EnOLQYs2477GqXswkUODstv15SBTOFtWRBpZY4Lme1c=;
        b=Of5Ad2BH4ePl4NZoqu6j2/VYZg6RG8nOVIvH1H6uCJP6sSJZgkg10wW8x3IAZ5yKDB
         PCIOOwJu4n5RzDF0+joqBxYH4eqgxUl98ZOlNSKUEWWZJ+h8TnXHZ6IfQPwNY6n2mW9J
         PjuOp8H15wWUYD86Ku3jU/5X7lvUpt2i2oZfUPmhNH1drADDfSax7so+BJQB9WHRm2w7
         UI17meO9MRUg9VDO5dFzOxlAyOQoAaRoFvwk/8UNz1eOZJPq+lAudF+kWAG6vwqbThyE
         Wqt3qjEWU9Wq4IKIaKjyN6V7mT2LXOvq+FKKCpRSsH4ApoekE0o9i16wyRA2rtWjpVz4
         0Caw==
X-Gm-Message-State: AG10YOS/LHJJhT/be3WszV0OdD9Gc8UBJKgemWdH4gc+TOayaCOnebg45Qn4YHJshUgEeQ==
X-Received: by 10.194.89.70 with SMTP id bm6mr18070909wjb.0.1455558218346;
        Mon, 15 Feb 2016 09:43:38 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id e194sm16812019wma.19.2016.02.15.09.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 09:43:37 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286214>

In builtin/remote.c there are a few cases which check whether a remote
exists or not.  These checks are however done inconsistently, and in a
few cases they don't check anything at all.  This patch series tries
to improve the situation.

I stumbled upon this when I mistyped the remote name in git remote rm,
and got a cryptic error message, and thought the other cases might be
worth fixing as well.

There is one such check left in get_remote_ref_states, but I'm not
quite sure what to do about that one.  That function gets called in
git remote show/set-head/prune, where it might make sense for the user
to provide a url, or a local repository, at least in the git remote
show case.

I think we have the following options there:

 (1) just remove the check, as nobody seems to have noticed until now,
     and the check doesn't actually do anything (get_remote() is never
     called with NULL, so it will never return NULL).  In this case
     git dies when a non-existent remote is encountered, e.g. git
     remote show nonexistent existent will die immediately, while git
     remote show existent nonexistent will show info about the
     existing remote, and die afterwards.
     
 (2) add an option not to die in the transport function, and let the
     caller of get_remote_ref_states handle the error i.e. show the
     error and keep going with the next remote.

 (3) anything I might be missing?

Thomas Gummerer (4):
  remote: use skip_prefix
  remote: simplify remote_is_configured()
  remote: actually check if remote exits
  remote: use remote_is_configured() for add and rename

 builtin/fetch.c   |  5 ++---
 builtin/remote.c  | 23 ++++++++++-------------
 remote.c          | 22 +++++-----------------
 remote.h          |  4 ++--
 t/t5505-remote.sh | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 35 deletions(-)

-- 
2.7.1.410.g6faf27b
