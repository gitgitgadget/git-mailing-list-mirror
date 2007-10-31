From: "Andy C" <andychup@gmail.com>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 17:27:10 -0700
Message-ID: <596909b30710301727o72770d51jfa519d858203480f@mail.gmail.com>
References: <20071030042118.GA14729@sigill.intra.peff.net>
	 <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org>
	 <20071030134355.GA21342@coredump.intra.peff.net>
	 <alpine.LFD.0.999.0710300818390.30120@woody.linux-foundation.org>
	 <20071030202014.GA22733@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In1Qc-0005YZ-Ui
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbXJaA1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbXJaA1M
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:27:12 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:12155 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbXJaA1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:27:12 -0400
Received: by el-out-1112.google.com with SMTP id j27so564187elf
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4KKS853ypklQEedoDoBbMPSlKiZhP5XUQXyC3mct8MY=;
        b=PXPxKNMdO1HXbE8tK5/G7hkuJ4T6QSUu/k2TX7VtVTMhbrh/+78HzY8VQ3h43E8/by0qGVl+kIIrfexKX+dyvZoUpsPYXXXlViPj5JtL3847KXMH9O7UmBVVhEtE66grrz/O+tC0x2LB7euUxgZ3i5a8esUFREiCoKER/JBZ5R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KkUodNNc7+nDJ3+mBVdqA/HtcA0YZF2d6Z1DFUU7EnBFRMmXIxWv4o8RRehuecvjlS4/FuP9V0jxM3hbtUATDwryHSCCOHubzytrITL1FP+AonTfh2FsJ6X/UrrJAEzt33MaPDRSfPUnEeJu9EizxTmJtablGzjx5dWSLb+SZ8s=
Received: by 10.142.154.20 with SMTP id b20mr985974wfe.1193790430226;
        Tue, 30 Oct 2007 17:27:10 -0700 (PDT)
Received: by 10.142.203.3 with HTTP; Tue, 30 Oct 2007 17:27:10 -0700 (PDT)
In-Reply-To: <20071030202014.GA22733@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62769>

On 10/30/07, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 30, 2007 at 08:38:24AM -0700, Linus Torvalds wrote:
>
> > > with the old and new code. Pairs like Documentation/git-add-script.txt
> > > -> Documentation/git-add.txt are not found, because the file is composed
> > > almost entirely of boilerplate.
> >
> > Ok, that does imply to me that we cannot just drop boilerplate text,
> > because the fact is, lots of files contain boilerplate, but people still
> > think they are "similar".
>
> Well, the problem is that instead of just "dropping" boilerplate text,
> we fail to count it as a similarity, but it still counts towards the
> file size. It may be that just dropping it totally is the right thing
> (in which case those renames _will_ turn up, because they will be filled
> with identical non-boilerplate goodness).

Right, in the demo I make an extra pass after the inverted indexing
step to prune the index -- which means eliminating the common lines
*entirely* from the index (so they don't get attributed to a random
file) *and* decrementing all the file sizes by 1.  That way the
similarity scores shouldn't get skewed.

And as you mentioned we could bump the threshold from 1 to some other
small integer.  Intuitively I guess you could say it is common to copy
a file to 2 places or 3 places, and you don't want all the lines to
get thrown out because of that.  But usually you don't copy a file to
10 or 50 places.

Andy
