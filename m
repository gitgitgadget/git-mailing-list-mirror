From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] git-svn: fix empty dir tracking in branches
Date: Tue, 30 Apr 2013 23:25:02 -0400
Message-ID: <CAPig+cT4657Amv2E5yj3K3cv-FYXSSm=-=CE_apXomp4QvSiEw@mail.gmail.com>
References: <51800471.6905700a.65c8.00b9@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 05:25:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXNfK-0005Un-BP
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 05:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761340Ab3EADZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 23:25:06 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44299 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758801Ab3EADZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 23:25:04 -0400
Received: by mail-lb0-f174.google.com with SMTP id t11so1158004lbd.19
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 20:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=0mlKt63MWZ+CLkpv4XXh9Bk1Bk+5iMUwr5LuF2kKPso=;
        b=aFVLdKOa8TjD8/IECXedZQWSjWP9Ngu3HnK8vD2rBHxi4rs6/mNDB6aGyrhKeEfndF
         f5k9jnP+K98F1fFO7w642zNC3KxibxsionBOf4wEIt8bmuzlWJWDAE25dZUobaBUXa0I
         2+EbVaPvuQ0qd66h+wDKNvS52AXy3X5VFG+7pX+xOhCY0Z/+VE6uQbBSNTC0yUWqlK3I
         XcpVrI2rrk+v8uUw8ay8KRubEskXUYNiqCUZY0QG1rCysjc2kHWds46vnInpuaSc9Y9Q
         s/Lk2x9bbT+HUr+mQsAoREZMo1sbk5j0cV9xR/G2TdLirKsMlc7TpCEkEnwmCBuf4hJH
         Ftbw==
X-Received: by 10.112.173.39 with SMTP id bh7mr561165lbc.62.1367378702729;
 Tue, 30 Apr 2013 20:25:02 -0700 (PDT)
Received: by 10.114.174.135 with HTTP; Tue, 30 Apr 2013 20:25:02 -0700 (PDT)
In-Reply-To: <51800471.6905700a.65c8.00b9@mx.google.com>
X-Google-Sender-Auth: qDvp1fJllYTY-Gct4NrfuHMqtGI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223068>

On Tue, Apr 30, 2013 at 1:38 PM, Ilya Basin <basinilya@gmail.com> wrote:
>   - When creating a tag or branch from a subdir, a disjoint branch is
>     created. Then git-svn re-imports the commits using this dir as strip
>     path.
>
>     During this re-import the variable %added_placeholder is not up to
>     date. Because the branch is disjoint, this variable should be empty
>     in the beginning, but it's not. Because of that git-svn tries to
>     delete non-existent .gitignore files and dies.
>
>   - When creating a tag or branch from a subdir, the strip path is e.g.
>     "trunk/module", but change_dir_prop() can be called with just
>     "trunk". This breaks tracking of placeholder files, because it
>     relise on the hash {dir_prop}, filled in change_dir_prop().

s/relise/relies/

>
>   - When creating a normal tag or branch, git-svn creates a normal
>     branch without reimport, but the placeholder files in the new
>     branch are not added to %added_placeholder.
>
> This patch does 3 things:
>
>   - It makes git-svn store paths in %added_placeholder already
>     translated from "trunk/subdir/" to "tags/subdir_1.0/" during
>     reimport.
>
>   - When strip path is "trunk/subdir", don't add "trunk" to {dir_prop}
>     in change_dir_prop().
>
>   - When a normal branch is created, it takes entries in
>     %added_placeholder belonging to the source branch, translates them
>     to target branch and adds them to %added_placeholder.
