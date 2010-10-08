From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 03:00:27 -0500
Message-ID: <20101008080027.GC4671@burratino>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
 <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com>
 <20101007202847.GA13234@burratino>
 <4CAEBF2E.8020206@viscovery.net>
 <20101008070511.GA4671@burratino>
 <4CAEC6E6.5000305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 08 10:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47vd-0003S9-HV
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 10:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab0JHIDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 04:03:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49158 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab0JHIDh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 04:03:37 -0400
Received: by iwn6 with SMTP id 6so370365iwn.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZYy9PRWJe8CSgxXoWzqEWe0SxU4gVlFkBoV9U3cCG7M=;
        b=xqYkJbuMsu00NtFmdQvN1Fc0diTLYEXXfH2kOqF/QbVPGy3hvDZAeoAkk0L4C+Dbo/
         UgA7g92jK0FnYwBIMzqHFJE2liJ4Ae9JGC8NvbJHqPAF/XoEKtWBkqSCPnu0moI9XNFk
         G6uwJWu9NKa9rod7yCmMR11S2m0jNF9LCNr50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xV+5GvfWgCoIICIyAOIZ6Mibo9Cgeok7rPxzfX+wejr20JKhrGjC4gg7Dj8CPGaiYS
         9Lhz8spUt0AZmW/hFZBbZDHNYfH8H6Et3h4+tecwW+aihbPxiSnyPOGastvkR3xSu21r
         1UkzfMVZ/rKXYd4BOaVxEaNcxgRVc1LBqVCRw=
Received: by 10.42.1.20 with SMTP id 20mr371885ice.26.1286525016741;
        Fri, 08 Oct 2010 01:03:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id gy41sm3234259ibb.17.2010.10.08.01.03.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 01:03:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CAEC6E6.5000305@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158492>

Some quick answers before I go to sleep.

Johannes Sixt wrote:

> What is the special new thing here? That "" means 'empty string' == 'tree
> at the root'? If so:

Yes.

> 1. Then this is the missing piece in the justification. Then I could buy
> that the observed speed-up is due to the reuse of an existing tree object
> (which avoids parsing it and re-constructing it from its pieces because
> fast-imports syntax didn't allow it otherwise). But it has nothing to do
> with new loose objects (the re-constructed object would be identical to an
> existing one).

If I remember correctly:

Version 1 of the script was similar to filter-branch and used
"git read-tree", "git write-tree", and "git commit-tree" (or something
equivalent).  Reconstructing the trees seemed to be a significant overhead,
leading to:

Version 2, which just called "git commit-tree" (or equivalent) repeatedly.
What this patch allows is

Version 3, which is a bit over 20% faster than version 2 and uses fast-import
to write the new commits directly to pack.

That speed-up could be due to avoiding the repeated fork() + exec() +
git startup cost, or avoiding loose objects, or any number of other
things.  Without this patch, one could write

Theoretical version 1', which uses cat-file --batch to unpack each
tree and uses fast-import to write commits with the same (recreated)
tree directly to pack.  But that would be kind of insane.

> 2. Without this patch, would this syntax create a tree object with a name
> consisting of two double-quotes in the root? Or would it be a syntax
> error?

Syntax error.

> How would one construct such an entry with this patch?

M 040000 <tree id> "\"\""

Thanks again.
