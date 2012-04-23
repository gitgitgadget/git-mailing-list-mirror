From: Gang Hu <ganghu@cs.columbia.edu>
Subject: Potential problem in git-add may corrupt the index file
Date: Mon, 23 Apr 2012 19:30:05 -0400
Message-ID: <CAEJt7hYYJh5dT1Tk99Oze6Hg4QaOqX5ERi0faWjyifQ6dr-pWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junfeng Yang <junfeng@cs.columbia.edu>,
	Heming Cui <heming@cs.columbia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 01:30:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMSiF-0001wt-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 01:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab2DWXa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 19:30:27 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:45433 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab2DWXa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 19:30:26 -0400
Received: by dadz8 with SMTP id z8so97966dad.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=aUK8Z2918/ClEzG2R8hIlOYw58IgHLsA53FN0wMjdHE=;
        b=Ttuz+r9q5NTW30XZOcUFrdTuSdTHv9YUn6tcu5Hus+YGGTZXnS2vEAzMIJxbqgixos
         9iCdkYlznf4c2WDsYmCqZQbFffkhODpj59XHEw14IQoP/j4+aU4KBEcz7GN5OfnxPZiB
         GJO24BfT8ckp6Ch6NTYzztwEo5DkQFe1soicNeeLQCVKLhvSc526pUxSD0TMt69PRCLd
         bS6mJtFoC0O3FGr7ursF2pUL+5IYV8CDRp2nf/CEzmAy8CTvSgDOHHaX0IFAZtahDsfm
         nTIJFXPeEZSLsWtz8o++H5efXbyJY31uNbLIfCJn2pZAHiD4gM6xOk1YKLDmjSMmZ4i+
         TzLA==
Received: by 10.68.216.38 with SMTP id on6mr5197319pbc.85.1335223825895; Mon,
 23 Apr 2012 16:30:25 -0700 (PDT)
Received: by 10.68.40.5 with HTTP; Mon, 23 Apr 2012 16:30:05 -0700 (PDT)
X-Google-Sender-Auth: ZiAxeYK0YFOFBlY6s7_aEehhrUI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196170>

Hi,

We are developing a tool to find bugs, and it flagged a potential
problem in git-add.

We are checking git 1.7.9.4, and this problem still exists in the
latest release, git 1.7.10.
At the end of cmd_add() in builtin/add.c, there is a call to
write_cache(), followed by commit_locked_index().

474:            if (write_cache(newfd, active_cache, active_nr) ||
475:                commit_locked_index(&lock_file))

In write_cache(), the program wrote to the locked index file, and in
commit_locked_index(), it did an atomic rename
to rename the locked index file to the real index file.
However, the locked index file is not synced to the disk before
being renamed to the real index file. This may
cause data loss, which has been pointed out in this post:

http://stackoverflow.com/questions/7433057/is-rename-without-fsync-safe

If a crash happens after the rename(), the data may have not been
completely flushed into the index file, so the user may face an empty
or corrupted index file.
Although the user may just recreate the index file, he would need to
add the files to be committed again, which may be inconvenient and disturbing.

To fix this problem, we may just do a fsync() before renaming the
file. We can add this to close_lock_file() in lockfile.c:
223: int close_lock_file(struct lock_file *lk)
224: {
225:        int fd = lk->fd;
226:        lk->fd = -1;
          // we may add
          // fsync(fd);
          // here
227:        return close(fd);
228:}

Is this a real problem? Any clarification or confirmation is
appreciated. Thank you.

-- 
Cheers,
Gang
