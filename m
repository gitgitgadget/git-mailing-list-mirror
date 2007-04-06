From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 08/13] prevent try_delta from using objects not in pack
Date: Thu, 5 Apr 2007 20:47:50 -0700
Message-ID: <56b7f5510704052047r30166e53kffbdd8bf71885264@mail.gmail.com>
References: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
	 <alpine.LFD.0.98.0704052100420.28181@xanadu.home>
	 <56b7f5510704051928l5d1f5a02yccc8e57c222e5f64@mail.gmail.com>
	 <alpine.LFD.0.98.0704052320560.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 05:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZfQZ-0002MB-1B
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 05:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbXDFDrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 23:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXDFDrw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 23:47:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:52831 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbXDFDrv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 23:47:51 -0400
Received: by wx-out-0506.google.com with SMTP id h31so812815wxd
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 20:47:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Noi7lonCS9a1qyxz57+htGCBseC4YY7F5Akqh4x6yItImOfIGoXiEajn7q5+A+poCcEcic6AzgRU8KQO/8IoPqaZAnGvNwXS7q7c0syG7j+iNjZgg1y1gpa6NaWtBLGvNyisvmXkgHlk5yo97qUTST4GktScl5O2f+f9jwkd7J0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LMXZjru3txQeXRGJeRPKYP1Jz7hBkt8Z5J8cjQGLfNxifUywXCdFgBEIQw5ObneNfgHZhZZq5ugoOJx0ZSh45FL36QWFZyCN+nhsZaqvFxdWj8gizhzC10eimLuBBlWGOMPPbKBgptiV4EWJRLb7Zw/QkC9WmaLdT9+vbNcyc90=
Received: by 10.114.47.1 with SMTP id u1mr1075758wau.1175831270059;
        Thu, 05 Apr 2007 20:47:50 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 20:47:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704052320560.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43899>

On 4/5/07, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 5 Apr 2007, Dana How wrote:
> > On 4/5/07, Nicolas Pitre <nico@cam.org> wrote:
> > > What is the purpose of this patch?
> > >
> > > The try_delta() function is called with all objects before any object is
> > > written to a pack to find out how to deltify objects upfront.
> >
> > I set no_write for 2 different reasons in the patchset.
> > (1) When the blob is too big (--blob-limit) and will never be written.
> > (2) When the blob has been written to a previous, finished pack.
> >
> > You're correct that this patch will never see condition (2).
>
> Given that I proposed another way for big blobs in my previous email,
> then (1) should not be needed either.
>
> > I think my repository statistics are a little unusual.
> > Perhaps I'm getting ahead of myself here,
> > but I also wanted to experiment with writing all blobs to one set
> > of packs,  and all trees, commits, and tags to another set
> > (but probably just one small pack).
> > I would use no_write for that and it would matter here.
>
> Again you should simply _not_ add objects you don't want to the list
> instead of adding them and marking them as unwanted.

Agreed, the marking just required less code change at the time.
I would like not to have to add nr_skipped and nr_actual.

Currently we have get_object_list -> traverse_commit_list ->
show_{commit,object} -> add_object_entry ,  which is all
called way before get_object_details -> check_object -> sha1_object_info .
Can I safely move the sha1_object_info calll earlier into
add_object_entry so I will know the size for pruning?

In your other email you mention memory consumption due to object_entry.
This structure could benefit somewhat from some attention beyond removing
my no_write.(e.g. int->short for .depth and .delta_limit; int->enum
for .preferred_base).  Perhaps for later.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
