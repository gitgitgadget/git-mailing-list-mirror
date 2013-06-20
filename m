From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [BUG?] remote prune origin interacts badly with clone --mirror and
 multiple remotes
Date: Thu, 20 Jun 2013 23:23:44 +0200
Message-ID: <1371763424.17896.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 23:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpmKg-0007D3-31
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 23:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269Ab3FTVXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 17:23:48 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48461 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150Ab3FTVXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 17:23:47 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so14359wib.4
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 14:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:x-mailer:mime-version
         :content-transfer-encoding:x-gm-message-state;
        bh=IUsKKpcEQs2rHq7oTrTX/v43OjQVyB8wtCwzWLx8ZDw=;
        b=jJg87tH6/WAr19B1GnRIJQBGxdFxcZkg+/e8f8tQpeT/UuyEkzeKEBh1srBFjPkKZy
         Vly+qgWSBIGiSo7aO8ZbzUhPwSyaNQ8r1dh9j5Zn290WzHnMOoC06eKddHjcg5BhOIB8
         AyJtD0hSp9RhIaR/tdoqfGqb077b2zMk5DJr+6wPGFrtfkVHgvIsKiZBLLSNmi7XsfI5
         Kb1by2Ikz9aOQLxFkE9A+hb94VUEhqsNvS2Wn1XLtuy5viwyk7PtMLxwKPaZPE/Pyr45
         ENVefoNWddHKA58b4cYg+Gq85ukbg3jz4RfNXslnrp/C9m6F93q4Os+Ba4UMByxGE2zW
         DhIA==
X-Received: by 10.194.108.73 with SMTP id hi9mr2008565wjb.85.1371763426216;
        Thu, 20 Jun 2013 14:23:46 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id xn20sm3190793wib.5.2013.06.20.14.23.45
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 14:23:45 -0700 (PDT)
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQkvpgpDcOiB5QKGk/2+FSNlhfeF+jfee7KCOkzml5WLqMUTDML60sM5R+j33igK0awn+9uq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228542>

[git version: next as of yesterday afternoon]

If I clone a repo with git clone --mirror, and add other remotes later,
'git remote prune origin' deletes all branches and tags of the other
remotes.

Easily repeatable example:

[core]
	repositoryformatversion = 0
	filemode = true
	bare = true
	logallrefupdates = false
[remote "origin"]
	url = git://github.com/git/git.git
	fetch = +refs/*:refs/*
	mirror = true
[remote "peff"]
	url = git://github.com/peff/git.git
	fetch = +refs/heads/*:refs/remotes/peff/*

'git remote prune origin' will delete all peff's branches in this case.
I'm guessing the wildcards refs/* and refs/remotes/peff/* interact badly
in some place, and I'm trying to understand builtin/remote.c to see if I
can fix it, but haven't gotten very far yet.

git fetch --prune origin and git remote update --prune also show this
behaviour.

git remote prune peff does not delete non-peff branches in this
scenario, further strengthening my belief that the refs/* and
refs/remotes/peff/* wildcards interact badly with prune.

Or is this considered normal behaviour and is what I'm trying to do
simply unsupported? In that case a warning would be welcome when adding
remotes to a --mirror'ed repository.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
