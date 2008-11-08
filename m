From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now noticibly faster on windows.
Date: Fri, 7 Nov 2008 21:19:49 -0800
Message-ID: <ee77f5c20811072119y65738f54o7e6792fb405c142c@mail.gmail.com>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
	 <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Chapman" <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Sat Nov 08 06:21:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KygG1-0001ls-H7
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 06:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbYKHFTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 00:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYKHFTv
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 00:19:51 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:9400 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbYKHFTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 00:19:51 -0500
Received: by ey-out-2122.google.com with SMTP id 6so673454eyi.37
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 21:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FUHs79pCEbz+5d3tvh5I5cRHVfW8JQZRukhLHbayZuM=;
        b=aDv53QCanx657mCkwLpPH0vQxA8yXemv8mmpPl1D9qFvAxSwe+PYb4E28MWSvMC5ya
         xqK3RFaTcJ2GT7Hf/WSt8tL6GrYx9vg/KzV4+5be37LwaBuoiDZcCXe0CXbaLhtfdJvO
         mDycw0y03rLO0op0RFB2K29Vd1HAH4+2Brb4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GO+TTSfFyXN3gQG2ie3hGt5G/oO0L6kyqnJLHW3mOl3VJoyOoLlBfmCyntNCdEqcBh
         tcFiAdG+DcoPEM64Y59qxqn170CEL2s6adXirqrFEAIsqpqHiTUUAhumByse4OsF/TBw
         xcZgWdE5lqMOSY6sacCk2X4SzdPQNKAMndUJw=
Received: by 10.210.91.17 with SMTP id o17mr4805476ebb.117.1226121589248;
        Fri, 07 Nov 2008 21:19:49 -0800 (PST)
Received: by 10.210.51.7 with HTTP; Fri, 7 Nov 2008 21:19:49 -0800 (PST)
In-Reply-To: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100380>

On Fri, Nov 7, 2008 at 7:22 PM, John Chapman <thestar@fussycoder.id.au> wrote:

> +_gitConfig = {}
>  def gitConfig(key):
> -    return read_pipe("git config %s" % key, ignore_error=True).strip()
> +    if not _gitConfig.has_key(key):
> +        _gitConfig[key] = read_pipe("git config %s" % key, ignore_error=True).strip()
> +    return _gitConfig[key]

If this is truly a noticeable bottleneck on Windows, something like
the following might be even better:  (completely untested!)

_gitConfig = None
def gitConfig(key):
  if _gitConfig is None:
    lines = read_pipe("git config -l", ignore_error=True).readlines():
    _gitConfig = dict([l.strip().split('=', 1) for l in lines])
  return _gitConfig.get(key, None)



Dave.
