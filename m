From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Wed, 24 Oct 2012 14:12:18 -0400
Message-ID: <CABURp0rpPqeTJMYXmgMG2CmU=SzzvCMeX46rnMVB0EeB_LXPiA@mail.gmail.com>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
 <CABURp0pqg7XC6makK2OcundMabV9AtcBNGNK6Q0TMZfJbt3anw@mail.gmail.com> <20121022225546.GO23101@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "W. Trevor King" <wking@tremily.us>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 20:12:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR5Rj-0004RD-LX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 20:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065Ab2JXSMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 14:12:40 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33212 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161061Ab2JXSMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 14:12:39 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so499671lag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=hE4vk7rVUmz2kEe9onwK/ch23+WLewe4/QR4aFOO3xg=;
        b=FZVNVfuvPOG8V0Abz1gTx+jIHxvP5h8QT0X+nZMvE3RXjSEpCEXSidLuIXzWk92uSO
         oFnOOd2vP0LdfkAy+fyi4AlDeActvtHUJPcrYhOIfw/rrXRuys/0k4UBfoNueKyWx/hJ
         FbW/XAcP/3p6FkBSZt8ZE6XQZc73h+jxVUyLOSWZwHybPvED+cQMPzj0EsAGSz2LPFzo
         LoWA2Qzma/+hy5jkl9OOt2MiFnwOPYeRgjkFOuZoLC+25Xds2fL4diQ5TlAKhyMQuz1y
         IgomDOlz93NXefNVahBwasImSMK54pawlvq+Q5rXOMz3ucD0FYIcWbE8eMzQNmUArDnZ
         CoJA==
Received: by 10.152.105.135 with SMTP id gm7mr15255011lab.22.1351102358266;
 Wed, 24 Oct 2012 11:12:38 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Wed, 24 Oct 2012 11:12:18 -0700 (PDT)
In-Reply-To: <20121022225546.GO23101@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208315>

On Mon, Oct 22, 2012 at 6:55 PM, W. Trevor King <wking@tremily.us> wrote:
> On a tangentially related note, it would be nice to set environment
> variables for each of the settings in submodule.$name during a foreach
> call.  Then you could use
>
>   git submodule foreach 'git checkout $branch && git pull'
>
> Perhaps you'd want to blacklist/whitelist or downcase settings names
> to avoid things like
>
>   [submodule "foo"]
>         PATH = /my/rootkit/
>
> but the update line is much cleaner.

This is ugly as can be, but it works in my meagre testing.  It defines
"submodule_path=/my/rootkit/" for the above bit of .gitmodules.  That
is, it adds definitions for 'submodule_<var-name>' for each <var-name>
in .gitmodules in submodule.$name.<var-name>, but <var-name> is
lowercased and defanged (everything that's not already [a-z0-9] is
replaced with underscore).  For example,

  git submodule foreach 'echo $submodule_url'

--- >8 ---
diff --git c/git-submodule.sh i/git-submodule.sh
index 6dd2338..79b3467 100755
--- c/git-submodule.sh
+++ i/git-submodule.sh
@@ -416,7 +416,15 @@ cmd_foreach()
                                prefix="$prefix$sm_path/"
                                clear_local_git_env
                                # we make $path available to scripts ...
                                path=$sm_path
+
+                               # make all submodule variables
available to scripts
+                               eval $(git config -f .gitmodules
--get-regexp "^submodule\.${name}\..*" |
+                               sed -e "s|^submodule\.${name}\.||" |
+                               while read VAR_NAME VAR_VALUE ; do
+                                       VAR_NAME=$(printf '%s'
"$VAR_NAME" | tr A-Z a-z | sed -e 's/^[^a-z]/_/' -e 's/[^a-z0-9]/_/g')
+                                       printf 'submodule_%s=%s;\n'
"$VAR_NAME" "'$VAR_VALUE'"
+                               done)
                                cd "$sm_path" &&
                                eval "$@" &&
                                if test -n "$recursive"
