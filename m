From: Ilya Basin <basinilya@gmail.com>
Subject: git-svn: problem with svn cp trunk/subdir tags/subdir_1.0
Date: Mon, 29 Apr 2013 16:46:45 +0400
Message-ID: <1826029946.20130429164645@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:47:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnTt-0000iM-2f
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab3D2Mqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:46:52 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:52132 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab3D2Mqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:46:51 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so5665210lbf.32
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=eDCONRktI8iYsyBn09XeY9zBKuDVcHg59C9pZM07IBc=;
        b=XVYGCEFnkvJe/bqOVZ9RsLywPc1yvp054EHW4ZyF/C/yX6RqG9zU1caIc85MjXjECX
         lG5g7O3SFCt08gpKrthnlUbrO6YmPT6c+GPEGjLluhHGgh223D73c/nMXkwiO6YsH+dw
         qxiRDfKd8xBln1KVbNE+xX4L5+T3nO89HpaKbHMO8uL2lbGlU+/iemzzL8upCsQY8zIP
         ghH7qAf+Fh49UX30aP5NPs+wnXeG5N6lRHNuNVv6bhGZjR6MK+sViI5QXKId45x9A2jR
         PFIEhon41XSKkSv1cF4oDujUkrBFKSflvi/7IU5JHQNoccc/4Sp5Ww96bJnoBm62zseA
         lLmQ==
X-Received: by 10.112.173.39 with SMTP id bh7mr26710508lbc.62.1367239610035;
        Mon, 29 Apr 2013 05:46:50 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:e800:dcfc:85a:7bae])
        by mx.google.com with ESMTPSA id t6sm9782239lae.3.2013.04.29.05.46.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 05:46:48 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222784>

After fixing --preserve-empty-dirs plus --stdlayout a new problem
arised:
When creating a tag or branch from a subdir, a disjoint branch
is created. Then git-svn re-imports the commits using this dir as
strip path.

Why? I would instead keep the current commit as parent, delete
everything except the subdir and move its contents to root directory.

During this re-import the variable %added_placeholder is not up to
date. Because the branch is disjoint, this variable should be empty in
the beginning, but it's not.
Because of that git-svn tries to delete non-existent .gitignore files
and dies.

I think, if a disjoint branch is created, %added_placeholder should be
pushed and cleared. A new set of paths starting with "trunk/" will be
added to it during re-import.
When re-import is done, we should translate the paths to
"tags/subdir_1.0/" and merge with the original %added_placeholder.
