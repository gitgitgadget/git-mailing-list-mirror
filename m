From: Roland Kaufmann <rlndkfmn+git@gmail.com>
Subject: Re: [PATCH] Display change history as a diff between two dirs
Date: Mon, 31 Oct 2011 10:21:16 +0100
Message-ID: <4EAE688C.8010502@gmail.com>
References: <4EAC6765.4030003@gmail.com> <7vty6rrow8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 10:20:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKo33-0006f9-3W
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 10:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316Ab1JaJUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 05:20:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55772 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab1JaJUr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 05:20:47 -0400
Received: by bkbzt4 with SMTP id zt4so1917570bkb.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8bPaAwCzvk5Y5D2lagGFhgiDC5oSAp2cZB/ql0e6yOM=;
        b=Y92R2BTBvY676hKM9xTLeTCE8/0pgAXl/l8FAXJuGHLX7bEMwN8fiPXucktdME6WQa
         /thHWBhWlfdK3Ic0SuG6MuGHwiryzTYu4KTB/UTzqmhMfksNEJF+cghmFxHNgeFLLdYh
         5+nTSmiDCLZ51i1WYZRlnL43sFf7R1gMOOLi8=
Received: by 10.204.14.208 with SMTP id h16mr10275610bka.2.1320052845741;
        Mon, 31 Oct 2011 02:20:45 -0700 (PDT)
Received: from [192.168.1.7] (33.72.34.95.customer.cdi.no. [95.34.72.33])
        by mx.google.com with ESMTPS id w8sm16380785bks.11.2011.10.31.02.20.43
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 02:20:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vty6rrow8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184500>

On 2011-10-30 07:09, Junio C Hamano wrote:
> I do not think any of our scripted Porcelains use "set -e"; rather
> they try to catch errors and produce messages that are more
> appropriate for specific error sites.

git-dirdiff being a wrapper script, I reasoned that the underlaying
command would already have printed a sufficient error message, so what
was left was just to exit. But you're right in that some of the commands
will not give sufficient context. I'll put in some more detailed error
handling.

> I do not think any of our scripted Porcelains use "mktemp"
> especially "mktemp -d". How portable is it?

Even if it is not part of Posix, I reckon since it is a part of the
coreutils, it is available in most GNU userlands, inclusive GnuWin32.
I don't have any live BSD systems available, but based on the man pages
it seems to be available there too, albeit with some different options.

--tmpdir seems to be more of a problem in than respect than -d. I'll see
if I can find a set of options that are digestable to most platforms.

I think it is unfortunate to use the current directory as scratch space;
it can be a network disk, or even read-only. mktemp can in contrast make
a directory in a place which is not spilled to disk.

> It is not clear to me why you need to grab the list of paths in toc
> and iterate over them one by one. IOW, why isn't this sufficient?

This design decision was probably appropriate in an earlier iteration,
but as you point out, it is indeed superfluous now! I apologize for not
realizing that myself.

> suspect is true), we would probably want to make it an option to
> "git diff" itself, and not a separate git subcommand like "dirdiff".
> I can see

Although being an able *user* of Git, I am not (yet) familiar enough
with the codebase to have a patch ready for `git diff` itself. It would
certainly require more rigorous testing.

> "git diff" (and possibly even things like "git log -p") populating
> two temporary directories (your old/ and new/) and running a custom
> program specified by GIT_EXTERNAL_TREEDIFF environment variable,
> instead of doing

Would it be better to have yet another configuration available for this 
option instead of reusing the existing infrastructure for `git difftool`?

> It also is not clear what could be used in "$@". Obviously you would
>  not want things like "-U20" and "--stat" fed to the first "list of
> paths" phase, but there may be some options you may want to give to
> the inner "external diff" thing.

Ideally, it should work the same way as `git difftool`.

> For example, how well does this approach work with -M/-C (I do not
> think it would do anything useful, but I haven't thought things
> through).  It would be nice if we gave the hint to the external

As of now, files that are moved will turn up a different places in the
tree without any annotations, and off the top of my head I don't see any
obvious way to propagate such hints. If the diff tool is sophisticated
can probably use the same heuristics as Git currently does, but I am
unaware of any that is able to do that yet.

> I wouldn't mind carrying a polished version of this in contrib/ for
> a cycle or two in order to let people try it out and get kinks out of
>  its design.

I would appreciate that! I'll submit a reworked proposal taking you
comments into account. It may take a few days due to unrelated
engagements, though.

-- 
   Roland.
