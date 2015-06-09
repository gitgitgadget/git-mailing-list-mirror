From: Stefan Beller <sbeller@google.com>
Subject: git lock files (Was: GIT for Microsoft Access projects)
Date: Tue,  9 Jun 2015 10:19:43 -0700
Message-ID: <1433870383-7631-1-git-send-email-sbeller@google.com>
References: <5576F02B.4040002@gmail.com>
Cc: kostix+git@007spb.ru, hackerp@suddenlink.net, sitaramc@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 19:20:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2NBt-0005kJ-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 19:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbbFIRTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 13:19:53 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38550 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbbFIRTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 13:19:51 -0400
Received: by igblz2 with SMTP id lz2so16364567igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z+fqoycqaiMlqqWY8VKn73Bx1Qm4fDO0kT4GvQBjUAg=;
        b=Ex7fxKy15vfQxJ8paEWv+vzsnDTYutqV9qrNIFyncmxWxxG0bFo+nVDwZrUCSQ/0cD
         nxSoRjCSHUqoyh1aXdiue3ZV2dHoCCN9eN/cqHyhKUB4PJiOGtQM88EH47NaVphInsz6
         50/8OiIqTWYA1jF7i1/gs0kYThwxP4rQoZHvOLR+tdrCOT5Qb97yJQelfdISEE28JnMn
         zGXTupDi1MCVQZswAk8mufAiN8T3TAbuuEzYvKCYqnmE+nscLU7fSQz2NXBqvS41Ax7K
         4XO5d0IoGQvjyXpYUN8U9kINGrsWvqkiX485Yc0iqOV3K+BIJWm6q4/13M2dDrGdtp7o
         bjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z+fqoycqaiMlqqWY8VKn73Bx1Qm4fDO0kT4GvQBjUAg=;
        b=SNaKprWuBlzgExiR+UoPL16nFiKafWM9/69E8bOh2MfLpQXGB+rl0zUTHehEE4OMtU
         eL7Pnv65eTK/8XJ7vPpFD9QkvDvG6vFsdVlngxLycAavrDnt6GJr9mP4qs56D5hVZTPU
         4uKmCEHCPCA/cgA0+deDldPKLiPUbvZ7T86byMMjAH0BUCPE2Vl7p2m/CBiOpFYwlOWJ
         V7he19YUH35Roz9WgaYKVFwqIk/5VP8GO9UaQOxb0HdyDqItVbxNIR5M3a9ha8edcyYa
         OyQYhSW+ALzziacvI1f5KbKM+q6wNG1OiSh2uywwQNw5iuPDNl/lqv2nhEYXwWwo1/hZ
         n56Q==
X-Gm-Message-State: ALoCoQk56DoiXszYBcoSwS9QOxuptiGqewa1fMUtQIcrHUpxlo3O2IFZGqJhjxKsmIqjmWEgR/Av
X-Received: by 10.107.154.70 with SMTP id c67mr28068582ioe.22.1433870390639;
        Tue, 09 Jun 2015 10:19:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a403:701b:1bfd:ce5a])
        by mx.google.com with ESMTPSA id r4sm1526751igh.9.2015.06.09.10.19.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 10:19:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <5576F02B.4040002@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271203>

Just because Git allows distributed workflows, doesn't mean we
should only focus on being distributed IMHO.

The question for content not being mergable easily pops up all
the time. (Game/Graphics designers, documents, all this binary
stuff, where there is no good merge driver).

I could imagine a "git lock" command which looks like this:

    git config lock.centralServer origin
    git config lock.defaultBranch master

    git lock add [branch]  [--] <path/to/file>
    git lock remove [branch] [--] <path/to/file>
    git lock ls [<branch>]

And the way this is implemented is roughly (unoptimized, just showing
how you would achieve this with todays command set):

    git fetch --depth=1 $(git config --get lock.centralServer) refs/locks/$(git config --get lock.defaultBranch)
    git checkout refs/locks/$(git config --get lock.centralServer)/$(git config --get lock.defaultBranch)
    switch(option) {
    case add:
        if exist <path/to/file>
            return -1
        else
            echo $(git config --get user.name) $(date) > <path/to/file>
            git add <path/to/file> && git commit "add new lock"
        fi
    case remove:
        if exist <path/to/file>
            # todo: check if the same user locked it before
            rm  <path/to/file>
        else
            return -1
        fi
    case ls:
        ls -R .
    }
    git push $(git config --get lock.centralServer) refs/locks/$(git config --get lock.defaultBranch)
    git <restore working tree, branch>

That said you could just manipulate the git objects directly, no need
to check out to the working dir.

The server would only need to allow pushes to a refs/locks directory and be done.
the client side would need to have a plumbing command, so you could easily integrate
a git locking to your application if you don't want to provide a merge driver.

Thanks,
Stefan
