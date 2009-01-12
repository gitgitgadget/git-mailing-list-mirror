From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/3] replace_object: add mechanism to replace objects found in "refs/replace/"
Date: Mon, 12 Jan 2009 10:50:23 +0100
Message-ID: <200901121050.24548.jnareb@gmail.com>
References: <20090107084341.1554d8cd.chriscool@tuxfamily.org> <m3tz87yvh4.fsf@localhost.localdomain> <1231727868.6716.155.camel@vaio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Ansell <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:52:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJSw-0003Ds-CE
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbZALJue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbZALJud
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:50:33 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:49520 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZALJub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:50:31 -0500
Received: by ewy10 with SMTP id 10so11398993ewy.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lqr2yMt29VBK04spndtkUGflrME7HYHBHeJUP77C2SU=;
        b=AF8tdgE2ktigDm7FeSRb8B561OK6CB0uH0wcJVTBFvG9LPVzyLm0tYg5CiSCSYCrbG
         KQGV5zENPylg07GPGqGVVzBjp5Op5AgVm+mggJ1iXP3rRybqyO7kniXzxK2FNbCck2H1
         P5RaKnCVf2LkGqoqsOE4/Al1bO8FAloc2t72g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uJaqVsDhLfahdnKJ3b76LUhhSJ1BUXc9hd6oT9lR25H6CIndb8vdwSmmtgE8L8w+B+
         ejeoYg297KnLG7E+u4h+mvEWxk9eAWOc7mK88QrIw2KI0AB14DYMLtq3JRG/TLYyhPYQ
         xkVHQpeWDYwct0q9sq8UowADvfu6ZTUWBjGq8=
Received: by 10.210.16.10 with SMTP id 10mr20614362ebp.144.1231753829419;
        Mon, 12 Jan 2009 01:50:29 -0800 (PST)
Received: from ?192.168.1.11? (abwj90.neoplus.adsl.tpnet.pl [83.8.233.90])
        by mx.google.com with ESMTPS id f3sm54148660nfh.34.2009.01.12.01.50.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 01:50:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1231727868.6716.155.camel@vaio>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105316>

On Mon, 12 Jan 2009, Tim 'mithro' Ansell wrote:

> > I just had an idea: we can use this mechanism to better manage large
> > binary files in Git, by using replacements for _blobs_.
> > 
> > We want to be able to have two flavours of repository: one with large
> > blobs (media files usually), and one without.  We can use stubs in the
> > place of large binary files in 'no-megablobs' flavor, and add contents
> > of those files via refs/replace/* for _blobs_ in 'with-megablobs'
> > flavour.  We can control which objects we want to have, and which
> > objects to transfer.
> > 
> > What do you think about this (abuse of) an idea?
> 
> I'm not sure I understand. I don't really care much about the
> implementation details if it's transparent to the user :)
> 
> I have not really had much time to pursue my idea of getting sha1_file
> to read download blob on an as-needed basis (work has been hectic).

Actually this idea is a bit different from lazy / on demand downloading
of large blobs.


In "on demand loading" solution you have sha-1 of _full_ blob in a tree,
but git knows that not having it is not a fatal error (somehow), and you
can ask git to download it. This is as far as I understand the solution
you proposed and partially implemented.

In "replacement blobs" solution, the (ab)use of object replacement
mechanism meant originally for easier bisect, you have sha-1 of _stub_
object in a tree.  If you want full (large) blob, you add replacement
in refs/replace/*, replacing stub blob object (must be unique; it can
for example contain some header + sha-1 of full object) with full
object.  If you want to have large object, you need to transfer 
refs/replace/*.  This solution means that user needs to be aware of
this mechanism, or have some wrapper (script) around it.


Different solution, and a bit different behavior wrt getting large
object for the user.

-- 
Jakub Narebski
Poland
