From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v5 12/10] remote-bzr: support the new 'force' option
Date: Mon, 11 Nov 2013 05:51:24 -0600
Message-ID: <5280c4bc4354a_36a51059e74ea@nysa.notmuch>
References: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
 <1384146656-11811-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, srabbelier@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 13:17:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfqQV-0006gm-D5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 13:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab3KKMRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 07:17:04 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:40744 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab3KKMRB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 07:17:01 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so970740oag.39
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 04:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=XQXYuSDU8E5rMN8tYGb7r/6z5mDIHRBJ1wnuASlUEsY=;
        b=lrpBGc0SMuovqpHPHRBxFLkVz/xUCLrcdhUtkHThU6Rp1v6SbS6j60ltk1uRDes9NP
         QCULBVf9feKmYj1ArW7ZhxEuB38a/En9J+UJLUh3iOD3okl58tuORkv3zXtBQf+ehPjc
         Q97YAq7N4Lat/OVdKffL+WbiY6E5DkY/zI6XeJNSVAItjD1f6f28qDdGIje6RQ2fDDgI
         dhEAyGi9LZGKqb/VhSvpvV5tSCRs4rZmF6fbhYPMCxytCuXnB043zuAdtzdI4NOaZBlE
         bTAk1Wdd3NxyHb++uUEwZnmEsNf/x4P9TJfmFUZ2Rs8yqEG6N8GHY/KKLwT2t1UebDiO
         8Vqw==
X-Received: by 10.60.52.1 with SMTP id p1mr18086812oeo.41.1384172220760;
        Mon, 11 Nov 2013 04:17:00 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm25939321obb.0.2013.11.11.04.16.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 04:16:59 -0800 (PST)
In-Reply-To: <1384146656-11811-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237615>

Richard Hansen wrote:
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 34 +++++++++++++++++++++++++++++++++-
>  contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index 7e34532..ba693d1 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -42,6 +42,7 @@ import json
>  import re
>  import StringIO
>  import atexit, shutil, hashlib, urlparse, subprocess
> +import types
>  
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
> @@ -718,8 +720,34 @@ def do_capabilities(parser):
>          print "*import-marks %s" % path
>      print "*export-marks %s" % path
>  
> +    print "option"
>      print
>  
> +class InvalidOptionValue(Exception):
> +    pass
> +
> +def do_option(parser):
> +    (opt, val) = parser[1:3]
> +    handler = globals().get('do_option_' + opt)
> +    if handler and type(handler) == types.FunctionType:
> +        try:
> +            handler(val)
> +        except InvalidOptionValue:
> +            print "error '%s' is not a valid value for option '%s'" % (val, opt)
> +    else:
> +        print "unsupported"
> +
> +def do_bool_option(val):
> +    if val == 'true': ret = True
> +    elif val == 'false': ret = False
> +    else: raise InvalidOptionValue()
> +    print "ok"
> +    return ret
> +
> +def do_option_force(val):
> +    global force
> +    force = do_bool_option(val)
> +

While this organization has merit, I think it's overkill for a single option,
or just a couple of them. If in the future we add more, we might revisit this,
for the moment something like this would suffice:

    class InvalidOptionValue(Exception):
	pass

    def get_bool_option(val):
	if val == 'true':
	    return True
	elif val == 'false':
	    return False
	else:
	    raise InvalidOptionValue()

    def do_option(parser):
	global force
	_, key, value = parser.line.split(' ')
	try:
	    if key == 'force':
		force = get_bool_option(value)
		print 'ok'
	    else:
		print 'unsupported'
	except InvalidOptionValue:
	    print "error '%s' is not a valid value for option '%s'" % (value, key)

Cheers.

-- 
Felipe Contreras
