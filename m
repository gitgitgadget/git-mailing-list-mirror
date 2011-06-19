From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 10/20] git-remote-testgit: fix error handling
Date: Sun, 19 Jun 2011 17:58:10 -0500
Message-ID: <20110619225810.GG23893@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-11-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:58:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQwi-0008Uk-DU
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab1FSW6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:58:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34182 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab1FSW6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:58:18 -0400
Received: by iwn6 with SMTP id 6so736438iwn.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iBt0Bck9woabflMi6mhuAIQPEisFUf8JlJUojM9E7cA=;
        b=ZwbjAkFwtEqMGBlXA9MEDY3A3dtoj6d2aDMpTQG/rdbgvWHz0tsiGBoF1g3EuQY+MG
         QZ4YuNuDFyvgUZn0IwYk7p4o+yHwd/lye1NoXkr63Pv/+SJlqBYcXdQKwQMxpuatETb/
         5Okuc6gR1XX2nzA8pERS/+a/ZGi0xNEJGviBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nvslfx2oXryDV/oFppXDu/cI7Na01lYUZFhRaqsNKr8Fo65icOKjU07VoJpwE+udbU
         LIGyziEkP1Zgq3acj29l4+rH/1NAJxx/IUu2WN7DZb4MUJ/q7y2TWZE8eglC6IdiEAHC
         WIWcUbt+/y61k0G3Nvem1fPCcHZay3D9Xq344=
Received: by 10.42.161.66 with SMTP id s2mr4888104icx.110.1308524298055;
        Sun, 19 Jun 2011 15:58:18 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id in11sm2788493ibb.5.2011.06.19.15.58.14
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 15:58:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308496725-22329-11-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176039>

Hi,

Sverre Rabbelier wrote:

> If fast-export did not complete successfully the error handling code
> itself would error out.

That sounds like a problem indeed.  What error message does it produce?

> This was broken in commit 23b093ee0 (Brandon Casey, Wed Jun 9 2010,
> Remove python 2.5'isms). Revert that commit an introduce our own copy
> of check_call in util.py instead.

The "an" should probably be "and".  More importantly, it's probably
worth mentioning that this is only a partial revert or rephrasing some
other way.

Have you checked if this still works with python 2.4?  Cc-ing Brandon
in case he has advice.

[...]
> +++ b/git_remote_helpers/git/exporter.py
[...]
> @@ -53,6 +55,4 @@ class GitExporter(object):
>  
>          args = ["sed", "s_refs/heads/_" + self.repo.prefix + "_g"]
>  
> -        child = subprocess.Popen(args, stdin=p1.stdout)
> -        if child.wait() != 0:
> -            raise CalledProcessError
> +        check_call(args, stdin=p1.stdout)
[...]
> +++ b/git_remote_helpers/util.py
> @@ -128,6 +128,38 @@ def run_command (args, cwd = None, shell = False, add_env = None,
>      return (exit_code, output, errors)
>  
>  
> +# from python2.7:subprocess.py
> +def call(*popenargs, **kwargs):
[...]
> +    return subprocess.Popen(*popenargs, **kwargs).wait()
> +
> +
> +# from python2.7:subprocess.py
> +def check_call(*popenargs, **kwargs):
[...]
> +    retcode = call(*popenargs, **kwargs)
> +    if retcode:
> +        cmd = kwargs.get("args")
> +        if cmd is None:
> +            cmd = popenargs[0]
> +        raise subprocess.CalledProcessError(retcode, cmd)
> +    return 0

So IIUC the existing code is not providing arguments to the
CalledProcessError constructor, and your patch fixes that.  Good.

Based on <http://pydoc.org/2.4.1/subprocess.html>, Python 2.4 doesn't
seem to have a CalledProcessError type.  Maybe these code paths
weren't being exercised before.

Regards,
Jonathan
