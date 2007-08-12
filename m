From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [PATCH] submodule update - don't run git-fetch if sha1 available
Date: Sun, 12 Aug 2007 02:03:17 +0200
Message-ID: <e7bda7770708111703u40f89c1fx17bfac4b9aed9d2e@mail.gmail.com>
References: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
	 <7vfy2pn9eb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 02:03:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK0vX-0003Uv-GN
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 02:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247AbXHLADT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 20:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759420AbXHLADT
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 20:03:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:26851 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772AbXHLADS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 20:03:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1360586wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 17:03:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qnKzHjh7rm5D2IODg9iI2INhRwZdsDTq0wCPdnARWpuxroVmenDvO7LbEQisKPM1Xxgniiw1nHJJO7AmP1YbeiDmmIpXgRl+QQYKXdW/ZcnyoXhLHmJeCSNdgKxdDuCX8H/qHSYIAhljUwxhUz8P9t0NHNEqWeFnkub8hlyp9XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FgstX3w9ryAtyGNrplQk1sOuBtk023GDKDHv4mIyjaksKwnn9oZm7KhmPdMCkGmoExeKOQ8okvUHkn/+6+BhEp/OVXgcQjQclO+4yR7kPrYZt8MHerbSDVIJYaJMiWifNLCnHodeMw3rNabmlF0V5nzI5qImNeYQPG5hMA9KkHk=
Received: by 10.115.76.1 with SMTP id d1mr3917173wal.1186876997873;
        Sat, 11 Aug 2007 17:03:17 -0700 (PDT)
Received: by 10.114.47.7 with HTTP; Sat, 11 Aug 2007 17:03:17 -0700 (PDT)
In-Reply-To: <7vfy2pn9eb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55651>

On 8/11/07, Junio C Hamano <gitster@pobox.com> wrote:

> This is wrong.  Existence of the commit object alone does not
> mean the necessary tree and blob objects to check out that
> commit, let alone all the history that leads to the commit,
> exist in the repository (think of a commit walker fetch that was
> interrupted in the middle).  You need to make sure that the
> commit exists *AND* is reachable from one of the refs.

That made sense. Good point. Consider this case:

$ git clone <superproject>
$ git submodule init
$ git submodule update
$ cd <submodule>
$ git checkout master
$ cd ..
$ git status
Modified <submodule>
$ git submodule update

Do we know in this state that the ref can be reached from a reference?
Say you've managed to do this:

$ cd <submodule>
$ git checkout master
$ work.. commit .. work ..commit
$ cd ..
$ git add <submodule>
$ git commit
$ cd <submodule>
$ git reset --hard HEAD~2

Is it okay to fail the supermodule update in this state? Obviously
we've thrown away things for a purpose.

//Torgil
