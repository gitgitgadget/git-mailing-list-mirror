From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git-submodule path computation bug with recursive submodules
Date: Thu, 5 Jul 2012 10:18:59 -0400
Message-ID: <CABURp0qtbSsiRX9sJ1F5WS3wtKq32hpV=3pGmM6Ysn=9Nvw_nQ@mail.gmail.com>
References: <0B4C40CC-862E-4B15-9A4F-903DC8DBBAEC@play-bow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Bob Halley <halley@play-bow.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 16:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smmty-00035Q-0z
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 16:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2GEOTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 10:19:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43433 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab2GEOTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 10:19:20 -0400
Received: by yhmm54 with SMTP id m54so8210297yhm.19
        for <git@vger.kernel.org>; Thu, 05 Jul 2012 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QxCT/6qedbtJ4QH6tQQO7DJRM93OEsd2KX2cGHF8LjE=;
        b=xuFF9y0Mj3uA8PNT4Njg8twNm49UU9KyofPSc4zCjjrrGvTbFyZWA3+pmQzPTd60Fm
         MN+lTEhrK2YQp6p2bQFAatqsCj6VBvcchxVZPc6Vs9QHHjjiQXDik0QPqxtdpK5QwqjM
         Way3qGVx8X4Nwpqq4NReFBHD5yPM+U3Hoew2NdVoIdHISK+rWkDBCrcG3wgPhKl6ZXLe
         W0YMJp+TCKA70oZlLS6Vzms3FFTO60jOWB7FxZZ4FcqaD/q9OVsvpsC91kfCf9+lBdyC
         Pj+CtuxxsUuidUdDKXRfEB357hdMC6pfDUhS/IpWq3nKGyQuBGrPWzctVsfJZV/q8+o9
         laXw==
Received: by 10.236.46.74 with SMTP id q50mr30891116yhb.30.1341497959843; Thu,
 05 Jul 2012 07:19:19 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Thu, 5 Jul 2012 07:18:59 -0700 (PDT)
In-Reply-To: <0B4C40CC-862E-4B15-9A4F-903DC8DBBAEC@play-bow.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201046>

On Thu, Jul 5, 2012 at 8:09 AM, Bob Halley <halley@play-bow.org> wrote:
>
> The git-submodule command has problems in some cases when there is a symlink
> in the path returned by pwd.
>
> I've created a repository at http://www.play-bow.org/repos/product to
> demonstrate the issue.
>
> $ git --version
> git version 1.7.11.1.116.g8228a23
>
> I copied and built the head of the master branch today.
>
> First we need a symlink.  I discovered this problem because I had a symlink
> in / to a directory under my home directory for typing convenience.
>
> $ ls -al /bug
> lrwxr-xr-x  1 root  admin  17  5 Jul 12:26 /bug@ -> /Users/halley/bug
>
> $ cd /bug
> $ pwd
> /bug
>
> Note that pwd does not resolve the symlink (though pwd -P would on many
> platforms)
>
> $ pwd -P
> /Users/halley/bug/product
>
> $ git clone http://www.play-bow.org/repos/product
> Cloning into 'product'...
>
> I'm purposely not using 'clone --recursive' as the bug doesn't appear if you
> do that.
>
> $ cd product/
> $ ls
> file1   file2   foo/
>
> Let's get those submodules...
>
> $ git submodule update --init --recursive
> Submodule 'foo' (http://www.play-bow.org/repos/foo) registered for path 'foo'
> Cloning into 'foo'...
> Submodule path 'foo': checked out '2b02e1eb2e34961d807cfc5fc7e477e0ca844600'
> Submodule 'bar' (http://www.play-bow.org/repos/bar) registered for path 'bar'
> Cloning into 'bar'...
> fatal: Not a git repository: ../../../../Users/halley/bug/product/.git/modules/foo/modules/bar
> Failed to recurse into submodule path 'foo'
>
> The first level of submodule clones successfully, but submodule 'foo'
> contains submodule 'bar', and cloning it fails.

It fails for me too, running zsh and stock Linux.

Seems to originate here.

Commit: 69c3051780d6cacfe242563296160634dc667a90:
Author: Jens Lehmann <Jens.Lehmann@web.de>
Date:   Sun Mar 4 22:15:36 2012 +0100

    submodules: refactor computation of relative gitdir path

Phil
