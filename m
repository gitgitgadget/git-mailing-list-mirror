From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/7] Fix path bugs in submodule commands executed from sub dir [WAS: submodule--helper clone: lose the extra prefix option]
Date: Mon, 28 Mar 2016 16:28:16 -0700
Message-ID: <1459207703-1635-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 01:28:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgaJ-0004rF-62
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbcC1X22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:28 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35093 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbcC1X20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:26 -0400
Received: by mail-pf0-f169.google.com with SMTP id n5so148366855pfn.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kXL+VwKzG1NXGiZKbSy+py30qPREF6ttX1P3vF3oYL0=;
        b=JTeFDFMo+2HdatKSpuUuwblcICsUHNafIEUUzwxEnkYRkFcJrASCTBpjc1G3ew+HNr
         Tz4ydh+/SJfpORhQRVYojXgSxBNvP448f33EeAo8sSlsoD69Kal511DVTZHRsFkfcBXs
         4Uwfdo2ULKEDzxSsSppZB3sjQKAVzi3MJHc98WZxP62/OP0qw+64ix3GDTPtkKErlb+V
         FA3sEolqeV6BYWaBsY/IBhEzB2sgOPCYf1NFnQm511VdNeKN161/Eto5XCEuh1KV3wuQ
         b5t6hdDSKK5E7jFln2zYEUVRkBSVYfUR1kM3xXKQQwKD8UGh+HWCjM4/Kxnd9Z+Fa4Iw
         NthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kXL+VwKzG1NXGiZKbSy+py30qPREF6ttX1P3vF3oYL0=;
        b=QkvroxDCGN8XRcYy32pu7Yk2ZIpLRDj548zHhkeTvRIDsMuXFqhlBnNRl7GZO6tMOW
         tYhqVWww/g+AYtOSg+Jns50DAPSKbbIW773stHUAJwI76PF7X6tM618YpMUWIxtTw/W7
         SvkzEOlK6Zu+5HBwwa9/TQiijBQ3zdi9rOSfdlQ7/YcO41ugGTfJAvS/0lGgah7nMOZF
         xENS/8D2VMfW1fC6/Ea4TlY/fULw6TIemSci6ViQc6GvLo/PCyRA8ryCEDU56No7EfDL
         PUWttr10oubCu+9iuWckIUoTeoQv8dwQr9G5n38Le0FZNQd3VSQbr2UlYk16tGshgK+O
         jrwg==
X-Gm-Message-State: AD7BkJKk5fe73bH2Cxo9J79wtmSZBX68Lb8qaeEmvVGW4nWDkckAVobsBZ0Z4uNx6d06GEA2
X-Received: by 10.98.80.206 with SMTP id g75mr46902486pfj.127.1459207705953;
        Mon, 28 Mar 2016 16:28:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id 16sm38170935pfk.28.2016.03.28.16.28.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:25 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290087>

Junio wrote:
> I suspect that the fix in your 1&2 may be demonstratable without
> forcing an early failure by switching to "git -C". 

So for now I present test coverage and their minimal fixes.
This series follows a "tick-tock" pattern except for patch5,
which I wrote quickly as I was annoying by the bells and whistles.
I expect test code to be dumb, not tricking ourselves by "smart" code there.

The "tick" patches introduce failing tests. They need to fail to demonstrate
the bugs exist, which are fixed in the "tock" patches, which are doing
nothing fancy but just a one or two line correction of the path handling
code.

This applies to 2.8.

As this is taking a completely different turn than I expected in 
"[PATCHv3 0/5] submodule helper: cleanup prefix passing", I made this
a new series. (It also doesn't do cleanup any more, but just fixes bugs.)


Thanks,
Stefan

Stefan Beller (7):
  submodule foreach: test path handling in recursive submodules
  submodule foreach: correct path computation in recursive submodules
  submodule update --init: test path handling in recursive submodules
  submodule update --init: correct path handling in recursive submodules
  t7407: make expectation as clear as possible
  submodule status: test path handling in recursive submodules
  submodule status: fix path handling in recursive submodules

 git-submodule.sh             |  9 ++++++---
 t/t7406-submodule-update.sh  | 33 +++++++++++++++++++++++++++++++
 t/t7407-submodule-foreach.sh | 47 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.8.0.rc4.23.gd22361a.dirty
