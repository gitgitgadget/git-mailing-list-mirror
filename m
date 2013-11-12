From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v2] remote-bzr: support the new 'force' option
Date: Tue, 12 Nov 2013 15:01:18 -0600
Message-ID: <5282971e8103_3b98795e78fd@nysa.notmuch>
References: <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
 <1384239808-19065-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, srabbelier@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgLDO-0005ri-2b
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab3KLVJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:09:33 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:63042 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab3KLVJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:09:32 -0500
Received: by mail-oa0-f53.google.com with SMTP id k1so2259802oag.26
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=con81/JiYXHAYCXCLs2VqWY/QLHqOWgL0Uk2qm023Pk=;
        b=Y99egpRV8/cJxoFLhwd22PO0+c24urGn3jsnP3clOace9293a/2NIQVSHtVshK5UdH
         3yemuPSmPdf/220X35L1grl14jUKSdGJd59Fc6KXsJt43wUfwaz00AhI4KS4889E118x
         zLMUKn+oO4uaIo/Ptty9AMUgdEQSDz+pKyjr/ZIfkUHwck+UAsjhDX0w4vaZZrnbkoAu
         8KOFJJQWYJS9v5Td9iROjWDTNswx5LnNomRVGFBUNx6slFupc6ND2pBSe4zYnVCexUiN
         Pspf+qZlPPwf81ymWS2o596F6uGAtHJBkSWQ57G215BxeEeR1EpgGuJIzqpqDy5ksG4X
         Teug==
X-Received: by 10.182.92.231 with SMTP id cp7mr3805561obb.82.1384290571545;
        Tue, 12 Nov 2013 13:09:31 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm35424301obb.11.2013.11.12.13.09.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:09:30 -0800 (PST)
In-Reply-To: <1384239808-19065-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237756>

Richard Hansen wrote:
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
> 
> This is a reroll of:
>   http://article.gmane.org/gmane.comp.version-control.git/237607
> based on feedback from Felipe:
>   http://article.gmane.org/gmane.comp.version-control.git/237615
> 
> This patch is an optional extension to Felipe's "transport-helper:
> updates" patch series:
>   http://thread.gmane.org/gmane.comp.version-control.git/237663
> and it requires those changes to work.
> 
>  contrib/remote-helpers/git-remote-bzr | 32 +++++++++++++++++++++++++++++++-
>  contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index 7e34532..2f481e9 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -42,6 +42,7 @@ import json
>  import re
>  import StringIO
>  import atexit, shutil, hashlib, urlparse, subprocess
> +import types

No need for this any more.

>  NAME_RE = re.compile('^([^<>]+)')
>  AUTHOR_RE = re.compile('^([^<>]+?)? ?[<>]([^<>]*)(?:$|>)')
> @@ -684,7 +685,8 @@ def do_export(parser):
>                  peer = bzrlib.branch.Branch.open(peers[name],
>                                                   possible_transports=transports)
>                  try:
> -                    peer.bzrdir.push_branch(branch, revision_id=revid)
> +                    peer.bzrdir.push_branch(branch, revision_id=revid,
> +                                            overwrite=force)
>                  except bzrlib.errors.DivergedBranches:
>                      print "error %s non-fast forward" % ref
>                      continue
> @@ -718,8 +720,32 @@ def do_capabilities(parser):
>          print "*import-marks %s" % path
>      print "*export-marks %s" % path
>  
> +    print "option"
>      print
>  
> +class InvalidOptionValue(Exception):
> +    pass
> +
> +def get_bool_option(val):
> +    if val == 'true':
> +        return True
> +    elif val == 'false':
> +        return False
> +    else:
> +        raise InvalidOptionValue()
> +
> +def do_option(parser):
> +    global force
> +    (opt, val) = parser[1:3]

I prefer:

  opt, val = parser[1:3]

But not a big deal.

Otherwise the patch looks OK to me.

-- 
Felipe Contreras
