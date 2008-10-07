From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] error out if path is invalid
Date: Tue, 7 Oct 2008 04:22:21 +0400
Message-ID: <20081007002221.GS21650@dpotapov.dyndns.org>
References: <20081005004036.GO21650@dpotapov.dyndns.org> <1223172881-4948-1-git-send-email-dpotapov@gmail.com> <1223172881-4948-2-git-send-email-dpotapov@gmail.com> <48E9B7FE.2000503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 02:23:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn0Ml-0003oU-Mq
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 02:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbYJGAW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 20:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYJGAW3
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 20:22:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:17271 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbYJGAW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 20:22:28 -0400
Received: by ey-out-2122.google.com with SMTP id 6so945122eyi.37
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 17:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GZgdhInFok+Ur5YnJhgUhEfYLRP0CcWiHPvksbcW7jk=;
        b=FoRjwXfBLaxvmvXWbCl6VVO3YJlPvazVY6ZBKaqsHWGg0pBYLJLrKVCs/+51LJDi/t
         /OTaNzb7y9ENQRSK7oy4idI+xVTqRW2txAoDr6zmA2iO3LYWNiNas+IfgquKp5xKkFI5
         bYtsBqj1C6cCxt4oSLYbPwVkmLry+drHI6GsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UxNmSZlICC8nNvBJsOECF8bFoLlcXgKRGEZhfdzhHpH6fh5cBwKTEBQG6jozrvhIIT
         NJoqL9xnVdqURgLfVqB2HGbpdT9aG7oHGgQyiYksDwkjl6Llu5SLIadEMk/0TnMkereL
         MFFeFlKPVqQbTn2JndSnBc+bAD8YFfgnrBC4c=
Received: by 10.103.223.9 with SMTP id a9mr3136983mur.87.1223338945829;
        Mon, 06 Oct 2008 17:22:25 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id w5sm18438791mue.10.2008.10.06.17.22.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 17:22:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48E9B7FE.2000503@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97646>

On Mon, Oct 06, 2008 at 09:02:22AM +0200, Johannes Sixt wrote:
> Dmitry Potapov schrieb:
> >  	if (!verify_path(path))
> > -		return -1;
> > +		return error("Invalid path '%s'", path);
> 
> Look at this change. Didn't the code error out before, too?

It is certainly did not here. As to its caller, it depends. In fact,
there are two chunks like that in my patch, so I am not sure to which
one you refer here. If we speak about add_cacheinfo() then though the
function did not error out, its caller died with one of the following
messages:
  git update-index: unable to update some-file-name
or
  git update-index: --cacheinfo cannot add some-file-name

However, if we speak about add_index_entry_with_check then the caller
will not produce any error. The git would exit successfully (it still
does) and there was no error message as if everything was fine.

Perhaps, the exit code should be corrected too, but if the git just dies
when add_index_entry() fails it may cause that having one invalid path
will prevent to check out other files, which does not seem to be the
right thing to do.

As to correction to correction to make_cache_entry then after my
previous patch, it started to error out:

  make_cache_entry failed for path 'some-file-name'

before that it silently segfaulted.

> Same in the
> other cases. Hence, your patch subject does not describe the patch.

Should I include the above explanation in the commit message or do you
have any objection to having the above error message in cases where the
caller already produce some message when it dies?


Dmitry
