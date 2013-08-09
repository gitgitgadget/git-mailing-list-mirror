From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] optimize git-contacts
Date: Fri,  9 Aug 2013 17:39:53 -0400
Message-ID: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 23:40:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uQ3-0005dt-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031234Ab3HIVkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:40:16 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54537 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031211Ab3HIVkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:40:15 -0400
Received: by mail-ie0-f174.google.com with SMTP id w15so5071138iea.33
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=TulSgOoQMGc8+qOlNzMcAKIe8KnMinwAeppH85/HZ/U=;
        b=TQ2p/tzcUlAGnq+cNRV9a7RHzG0ejUDFU13iPOVOUA5MMk71LOwRPbZrMOYvA35RWp
         KhNtMdzA5Wk6HdLQwaN0Hy5quj+aH3ChhspbLl2KHfgYCrhnfSvX7mxwpYWGAS8VZvqI
         Sp0XDjgfD6N3jgXE1gq+WRbDUiSCfGZNKIhUQd3BApK9G+46/S9JEDXCaMVZwmLTV196
         0i9VBhC2rCFwLWnwUFRxf29bA3xZ8wO9AXy0NzOJRnbK21fhHO9lk9hexFh4gNbBc6gA
         Zvw76hzJuVxkz1JD9CGv3JtGKt37jmNU2PuDioCAmraFEKQ33uUgYHmdC56H4C0/l22L
         0RWQ==
X-Received: by 10.50.26.103 with SMTP id k7mr3322096igg.8.1376084415440;
        Fri, 09 Aug 2013 14:40:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id q4sm6156131igp.6.2013.08.09.14.40.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 14:40:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232034>

This patch series aims to make contrib/git-contacts faster by reducing
the number of expensive git-blame invocations it makes. It does so by
taking advantage of git-blame's new ability to accept multiple -L ranges
in a single invocation [1] (es/blame-L-twice in 'next').

Some numbers, given a randomly chosen range of commits:

  (before)
  % time git-contacts 25fba78d36be6297^..23c339c0f262aad2 >/dev/null
  real  0m6.142s
  user  0m5.429s
  sys   0m0.356s

  (after)
  % time git-contacts 25fba78d36be6297^..23c339c0f262aad2 >/dev/null
  real  0m2.285s
  user  0m2.093s
  sys   0m0.165s

[1]: http://thread.gmane.org/gmane.comp.version-control.git/231739

Eric Sunshine (3):
  contacts: validate hunk length earlier
  contacts: gather all blame sources prior to invoking git-blame
  contacts: reduce git-blame invocations

 contrib/contacts/git-contacts | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
1.8.4.rc2.460.ga591f4a
