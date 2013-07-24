From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 10:52:12 +0200
Message-ID: <CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Joern Hees <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Wed Jul 24 10:52:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1uo1-0006YH-3p
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 10:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab3GXIwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 04:52:15 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:55501 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab3GXIwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 04:52:13 -0400
Received: by mail-qc0-f182.google.com with SMTP id e10so82650qcy.13
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+ZU076VbWZdFExpqX5jDaewYLAMJIbfb9564CeVrXz4=;
        b=GOqxo79UOQ1u5T8TrZVZGIT77E5GYDzJ9u+WFiILceCtZdvzhnz8uv9ynINPQ7tzhg
         /p0mwbQkeXIN01HmHDx/5BPSgiZLCEjODklP2NbEHTVQLyg6gnsDuyQlJ8aVU31O7PCP
         X9QFZjMknycLxY2MQSuLNimN4KE4eAEq/Zu1izWg6WzhS4256s9OGxUZEg12Wh3WUMAB
         El6vyVxuyjhDTPAeSDECfgaOGuDjbCO74sVu0Z2ZZP3N2BH4mXbI1I6fhOYVGVPeZ6Ik
         uuzFAj8hgApxKcMJydxJ1ixUPdsYuq9ucLpf+Wk6TDoDftItlp0jVKh9yEqPTloO1gZH
         nXrw==
X-Received: by 10.224.182.79 with SMTP id cb15mr44093371qab.48.1374655932618;
 Wed, 24 Jul 2013 01:52:12 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Wed, 24 Jul 2013 01:52:12 -0700 (PDT)
In-Reply-To: <1374615616-4730-1-git-send-email-dev@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231089>

On Tue, Jul 23, 2013 at 11:40 PM, Joern Hees <dev@joernhees.de> wrote:
> 6796d49 introduced a bug by making shared_path == ".git/hg' which
> will most likely exist already, causing a new remote never to be
> cloned and subsequently causing hg.share to fail with error msg:
> "mercurial.error.RepoError: repository .git/hg not found"

Indeed, no clone is performed if the .git/hg dir already exists.
I think it assumes that it's already done.
That will certainly lead to the failure you are reporting.

Also, the directory can be created to store marks for a local repository.
remote-hg won't require nor do a local clone in .git/hg for local repositories.

It should also be noted that once .git/hg is not empty, it will no
longer be possible to create a mercurial repository in there (it will
die with "destination '.git/hg'  is not empty")

I think the best way would be to create the shared repository in
.git/hg/$share, with $share being a path that can't be a remote name
(so that it doesn't conflict with remote directories),
and then apply the following patch (copied in gmail)

diff --git a/contrib/remote-helpers/git-remote-hg
b/contrib/remote-helpers/git-remote-hg
index 0194c67..21c8091 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -390,7 +390,7 @@ def get_repo(url, alias):
         if not os.path.exists(dirname):
             os.makedirs(dirname)
     else:
-        shared_path = os.path.join(gitdir, 'hg')
+        shared_path = os.path.join(gitdir, 'hg', $share)
         if not os.path.exists(shared_path):
             try:
                 hg.clone(myui, {}, url, shared_path, update=False, pull=True)

That way, the share can be created even if .git/hg already exists
(because of a previous import, before the shared machinery existed, or
because you already have a local remote).

> Changing gitdir to dirname causes shared_path ==
> .git/hg/<remote_name>/hg. The call to hg.share with local_path ==
> .git/hg/<remote_name>/clone works again.

I think that will be a problem, because then the shared_path will no
longer be shared, will it ?
