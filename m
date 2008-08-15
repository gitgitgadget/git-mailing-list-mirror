From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: [PATCH] Git.pm: Make File::Spec and File::Temp requirement lazy
Date: Fri, 15 Aug 2008 15:31:25 -0400
Message-ID: <3e8340490808151231p700ca76fub16700708f2942bb@mail.gmail.com>
References: <20080814065800.GA16918@untitled>
	 <1218813032-18203-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Marcus Griep" <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 21:32:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU52E-0002UJ-OM
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 21:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758090AbYHOTb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 15:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758073AbYHOTb1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 15:31:27 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:34317 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757254AbYHOTb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 15:31:26 -0400
Received: by gxk9 with SMTP id 9so3547538gxk.13
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L5S2+6juM7HXgOnia8/3YgNzoZ/Pwxb8JCAVDKK5Js4=;
        b=ET7AWrVw4YYmqI3XMnXN1E+VSsXhQZcw2LGQheIdQ6E48axKGdBIpWXQfTZ4APvLds
         m1yHc9KdZhDszY6NXKmfL/N3I7m6LyAc5XJ6bkfwHlbpmTU0heStpnZZoTiaqfe1PmuL
         nlS5JFhnaeLxTFmjDa1Jx/DPrRJiO/z7C3uCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bXWdGmExvQcb5+mb+kB7ecOmcprEBbUyJUn5CDQDDsAX6K51AhAyJAcjkr63Xtm1PF
         7qdfMjz73QnXVaN36yhGzBJdCikJKHYxA+bTbwrJwkrgGGNEsc3jk4rtZv5K/nHqyu03
         hHIyw7L15+xECQYNfnhPWJwqjcT5+0XJ5if7Y=
Received: by 10.150.57.17 with SMTP id f17mr4449257yba.59.1218828685274;
        Fri, 15 Aug 2008 12:31:25 -0700 (PDT)
Received: by 10.65.234.13 with HTTP; Fri, 15 Aug 2008 12:31:25 -0700 (PDT)
In-Reply-To: <1218813032-18203-1-git-send-email-marcus@griep.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92511>

On Fri, Aug 15, 2008 at 11:10 AM, Marcus Griep <marcus@griep.us> wrote:
> This will ensure that the API at large is accessible to nearly
> all Perl versions, while only the temp file caching API is tied to
> the File::Temp and File::Spec modules being available.
>
> Signed-off-by: Marcus Griep <marcus@griep.us>
> ---
>
>  Eric Wong wrote:
>  > What about just lazy requiring inside _temp_cache() so it
>  > won't get loaded by folks that don't need it? (completely untested):
>  >
>  >              eval { require File::Temp };
>  >              if ($@) {
>  >                      throw Error::Simple("couldn't require File::Temp: $@");
>  >              }
>  >              eval { require File::Spec };
>  >              if ($@) {
>  >                      throw Error::Simple("couldn't require File::Spec: $@");
>  >              }
>  >
>  > It'll also remove the minor performance hit CGI/gitweb users got since
>  > we won't load these extra modules during startup.
>
>  This recommendation is implemented with this patch, but in such a way that only
>  the first test will be used, and that result cached.  That way we aren't doing
>  a compile _every_ time we want a temporary file, just the first time.

perl's 'require' will only attempt to load a module the first time it
is used; subsequent attempts will result in a quick no-op, so there's
no need to further cache. Unless you mean to cache a negative result?
In which case, the require should be quite fast, as it'll quickly get
a 'file not found' error without needing to do any compilation.
