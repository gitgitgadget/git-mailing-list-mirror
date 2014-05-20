From: Mitchel Humpherys <mitch.special@gmail.com>
Subject: Why is --graph --max-count=n so much slower than --graph HEAD~n..?
Date: Tue, 20 May 2014 15:17:01 -0700
Message-ID: <vnkwd2f8ayea.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jonas@bernoul.li
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 00:17:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmsLL-0000rY-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 00:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaETWRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 18:17:00 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45945 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaETWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 18:16:58 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so732448pad.13
        for <git@vger.kernel.org>; Tue, 20 May 2014 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=eiB0NyY2GjK9iE4l/byYGnpalNSV5nyxOkreyd4j/SI=;
        b=NHnhhhtYZxA0t4PirjQHkPvSe3iQzvsQFWXZ5VhL8g+vWjkmEEmq/YO09Uh6Hiz4MQ
         GEx4uljxL3S5qP4/POnWHOuBa97m35C6T9iPFXocTU6pW8RPD/vAz+Fz2NtO8obc5LT5
         IraInWnjohd3C8Cny9Lp2GwqYU3KEsizCO6Tq3aKw4x12YxnxD7fyopgQrgz4v/5r6MX
         EhZl5QZhx1qxdEkJ6N4+JAuFmCw+dUqZDuTEzGMDsouMcxEsj6Ns5/a8pUplHKlv8gXo
         d1BRAVJ8C8+sc41RTpWpzYhN6Ggbu6gcGE9UpHsL8hSvZx+UqgDdTUesVp5RZ3qmyNTh
         +jsg==
X-Received: by 10.66.161.33 with SMTP id xp1mr4275430pab.74.1400624218123;
        Tue, 20 May 2014 15:16:58 -0700 (PDT)
Received: from mitchelh-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by mx.google.com with ESMTPSA id xk3sm4783802pbb.65.2014.05.20.15.16.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 15:16:54 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249754>

I've noticed that --max-count doesn't seem to speed up `git log --graph'
computation time. Here are some numbers using the linux kernel
repository:

    | command                          | time* |
    |----------------------------------+-------|
    | git log --graph --max-count=5000 | 4.11s |
    | git log --graph --max-count=1000 | 4.05s |
    | git log --graph --max-count=500  | 3.95s |
    | git log --graph --max-count=50   | 3.95s |
    | git log --graph --max-count=10   | 3.97s |
    | git log --graph --max-count=1    | 3.96s |

However, specifying a manual revision range results in a much more
dramatic speedup as `n' decreases:

    | command                          | time* |
    |----------------------------------+-------|
    | git log --graph HEAD~5000..      | 6.69s |
    | git log --graph HEAD~1000..      | 1.89s |
    | git log --graph HEAD~500..       | 0.03s |
    | git log --graph HEAD~50..        | 0.02s |
    | git log --graph HEAD~10..        | 0.02s |
    | git log --graph HEAD~1..         | 0.00s |

* All times are "steady state" measurements after warming up the disk
  cache by running the command a few times.

I see that the manual revision range doesn't seem to go back as far in
history when I diff the output of the two commands. However, if I add
`--max-count=50' to the `HEAD~50..' command I get the exact same commits
but with fewer "dangling" lines at the bottom of the graph in the
`HEAD~50..' approach.

Anyone care to provide any insight about what's going on here? Is this
expected behavior? Is there any low-hanging fruit for optimizing
--max-count --graph?

-- 
Mitch
