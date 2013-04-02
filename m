From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Bug in filter-branch -d option, new files are dumped into parent
Date: Tue, 02 Apr 2013 14:32:21 +0200
Message-ID: <1364905941.19800.24.camel@mas>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 14:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN0OV-0007Cr-8i
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 14:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759702Ab3DBMc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 08:32:27 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:58102 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913Ab3DBMc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 08:32:26 -0400
Received: by mail-bk0-f45.google.com with SMTP id j10so185925bkw.18
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:content-type:x-mailer
         :mime-version:content-transfer-encoding;
        bh=8UP/RfQ6jUp91s0lZmOEpgcl1+uLL6BeGb8F7WYRv/Y=;
        b=vjOzdYniZLXC2Ll/MNHF9K5uRY/K5sBPYJjG/FjOoRH/wUNYW18c1N2CIoCWu/7oTn
         MAVX/Iyji24h83R5yrBoJvbNTQaJqv4khVPgzYH/2iimdXsF1uJGi7sVXFps+NIKcHFg
         VjfmGiKJrzRk6/DwYkW5yTSaFogQvWTV7COenxL0PiEf9GlX9qWMKPzOEnQZPFDbKxKX
         8fHLRONv3LbobTeAtQLALjdL8w85ooWSzkC9hAydC14a/MWwhHZKAeZD8NgNFVMI/ktx
         hkVf2GulRY4DK+8BSwdIlJ7I4VerK95QShGCBS96BU49a5d2wcFxdUm3KNULICIs5cNq
         r+ow==
X-Received: by 10.204.170.202 with SMTP id e10mr3928512bkz.41.1364905944859;
        Tue, 02 Apr 2013 05:32:24 -0700 (PDT)
Received: from [192.168.1.2] (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id r17sm581473bkw.21.2013.04.02.05.32.22
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 05:32:23 -0700 (PDT)
X-Mailer: Evolution 3.6.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219768>

Hi,
I think I have stumbled on a bug in the -d option of git filter-branch.

It seems like in the final stage of filter-branch, regardless of where
-d is set, it will make updates to the "working directory" as being the
parent of the -d directory, and the actual working directory is left as
it were before the filtering.

For example if using -d /tmp/git-rewrite, the new checkout files are
dumped into /tmp.

A simple test scenario:

###
mkdir test
cd test
git init

echo foo >foo
git add foo
git commit -m"foo"
echo bar >bar
git add bar
git commit -m"bar"

git checkout -b rewrite
git filter-branch -d /tmp/git-rewrite --tree-filter 'echo baz >baz' --
rewrite
# git status
# shows 'baz' as unstaged-deleted in the working directory
#
# ls /tmp/
# shows the 'baz' file created in the root, above git-rewrite
#
# git log --stat --oneline
# does show expected result though
#
# if you run it again you'll get an error because of the /tmp/baz file
git reset --hard master
git filter-branch -f -d /tmp/git-rewrite --tree-filter 'echo baz >baz'
-- rewrite
# Rewrite afac18542ac3d432b647866f5ac6918b81b3bb78 (2/2)
# Ref 'refs/heads/rewrite' was rewritten
# error: Untracked working tree file 'baz' would be overwritten by
merge.
#
# At this point, 'baz' is instead staged-deleted in the working
directory
###

-- 
Martin Erik Werner <martinerikwerner@gmail.com>
