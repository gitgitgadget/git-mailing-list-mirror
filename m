From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH v3] submodule: Allow tracking of the newest revision of a branch in a submodule
Date: Fri, 12 Dec 2008 01:31:31 +0100
Message-ID: <8c5c35580812111631k54657bdcme8f048c77b6765eb@mail.gmail.com>
References: <1229009982-2701-1-git-send-email-git@fabian-franz.de>
	 <7vbpvicuk2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Fabian Franz" <git@fabian-franz.de>, git@vger.kernel.org,
	j.sixt@viscovery.net
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 01:32:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAvxa-0003Za-Kq
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 01:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbYLLAbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 19:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbYLLAbc
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 19:31:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:27933 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbYLLAbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 19:31:32 -0500
Received: by wa-out-1112.google.com with SMTP id v27so568193wah.21
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 16:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VskJ8smo85m+ISKD5sZoNz6w3G6DTzi2kqzaK4F0BWk=;
        b=lY5WNpqG7ZTKo/20UCn0G2r31JbYlabvTmdcBjjZiuBY0sCBVfuxgM1XuII3QzrZ+l
         qIOb5vTR9nqUfiHqGpDWNxbnTbkp3aVZvv7bYLU37/xhn3BAd9RbRjouk4UJtqWpUkPw
         QCfgEK5CfxeDihAhEK3Ic3yrrBO41hEhOu1UE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u8QYcJw5tRT1vhK7z8rfnsgpSzjTqfnlkEGb5IMEYuL29l5PbRfjkwumEOK5udTA1C
         ghPsJTqcuaVC14lickbN47i71zrkU4993QSYrlqPA9Th4/TUreKm7806QRTGphf3Hlvl
         dd9CBr2ICB22j9P/450FAKDBiQWZfSAMEt1gI=
Received: by 10.114.81.1 with SMTP id e1mr2261912wab.212.1229041891111;
        Thu, 11 Dec 2008 16:31:31 -0800 (PST)
Received: by 10.114.170.20 with HTTP; Thu, 11 Dec 2008 16:31:31 -0800 (PST)
In-Reply-To: <7vbpvicuk2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102851>

On Thu, Dec 11, 2008 at 21:42, Junio C Hamano <gitster@pobox.com> wrote:
> I wonder if you can just set "assume unchanged" bit for the subproject
> gitlink in the index to achieve the same goal.

Using assume-unchanged works, in the sense that the modification to
the submodule is not detected in the containing repo. But running `git
submodule update` will checkout the sha1 recorded in HEAD, and I
suspect Fabian wants something like the hypothetical command `git
submodule update -b [branch]` which could do `(cd sub && git fetch &&
git reset --hard origin/$branch)`.


>
> Or is there more to it?
>

Something like this (probably mangled) patch is needed for 'submodule
status' to behave sensibly when the assume-unchanged bit is turned on
for a submodule path.


diff --git a/git-submodule.sh b/git-submodule.sh
index 2f47e06..375dfbf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -588,21 +588,21 @@ cmd_status()
        do
                name=$(module_name "$path") || exit
                url=$(git config submodule."$name".url)
+               orgsha1=$(git ls-tree HEAD "$path" | cut -d ' ' -f 3 | cut -f 1)
                if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
                then
                        say "-$sha1 $path"
                        continue;
                fi
+               if test -z "$cached"
+               then
+                       sha1=$(unset GIT_DIR; cd "$path" && git
rev-parse --verify HEAD)
+               fi
                set_name_rev "$path" "$sha1"
-               if git diff-files --quiet -- "$path"
+               if test "$sha1" = "$orgsha1"
                then
                        say " $sha1 $path$revname"
                else
-                       if test -z "$cached"
-                       then
-                               sha1=$(unset GIT_DIR; cd "$path" &&
git rev-parse --verify HEAD)
-                               set_name_rev "$path" "$sha1"
-                       fi
                        say "+$sha1 $path$revname"
                fi
        done
