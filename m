From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 15:45:07 -0400
Message-ID: <32541b130805011245j76421635me55947cf7869f31f@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
	 <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
	 <20080501153457.GB11469@sigill.intra.peff.net>
	 <32541b130805010850q165fe1d6me05e670ca93b0892@mail.gmail.com>
	 <20080501164829.GA11636@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 21:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrejA-0006Dy-9i
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761228AbYEATpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 15:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758293AbYEATpL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:45:11 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:16925 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbYEATpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 15:45:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so849287fkq.5
        for <git@vger.kernel.org>; Thu, 01 May 2008 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Sd+mH6cFPgNnlg2p6FTyFA2sxM/mI2QiO6s7j7OZ+kc=;
        b=R2CQvcHnkVgVOKYCXHJHmas/6x9a02v1pDLWKtAAHsFLrqfycusg9rRy+uxeXi6sth0SJ5BsBXgZDghzxCxpJiblX7WAvxTx1UruryoBq4H911zy6d+N1T85e7KFewr56m+Zw19E44R5Yffu3kLryrR+x7WLAt7bxBKa2Lix7y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qQWDcY4iDL9VAPCQD9QfOBDc//5kDxBcyzeAEoZmB71kr4FgUn/dqmoaPwn82UBHNhJ01qHnxYTQpnqDxzl1CVgBxqdaiFG9FrmrAGD1VTUOXe4ylanlwPwhTgAPSe3h0TvO9kw3J7nYfvgVoPJv5uQoLqHPxjzDKW/87nGGEC4=
Received: by 10.82.115.8 with SMTP id n8mr268024buc.21.1209671107866;
        Thu, 01 May 2008 12:45:07 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Thu, 1 May 2008 12:45:07 -0700 (PDT)
In-Reply-To: <20080501164829.GA11636@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80937>

On Thu, May 1, 2008 at 12:48 PM, Jeff King <peff@peff.net> wrote:
>  I don't see it. I think the steps are exactly the same as in your
>  example. Consider:
>
>   1. You have some files in src/
>   2. All of the files from src/ get moved away
>   3. You merge in somebody else's work which adds a file in src/, but
>      their work is based on a commit which predates 2.
>
>  The question is: if they had seen 2., would they have put the file into
>  src/, or into the new location? I think the answer depends on the
>  semantics of the file. If it is semantically an addition to the source
>  code that got moved, then yes. If it is a _replacement_ for the
>  source code that got moved, then no.

I promised I would shut up, and I apparently didn't.  Sorry :)

I think this case isn't so hard.  Basically, a merge involves three
commits; the merge-base, my branch, and your branch.

In your example above, we compare the merge-base to the new version;
in that case, the new file is in an *existing* directory which
definitely corresponds to src/ in #1, because the the new version has
never even heard about src/ being deleted.  Thus, the file must be
intended to be part of the original src/, wherever it may now be.

In contrast, if the merge-base already had src/ being renamed, and
someone put something into src/, we'd know that they're putting it
into a fundamentally different directory than the moved src/.

Exactly how you track the "identity" of a directory without breaking
things down by individual commit sounds a little complicated, but it
feels to me like it should be possible.

I suspect this is a generalization of the earlier discussion (a few
months ago) that I read in the archive about git's handling of empty
directories.  Right now git does weird things with directory
creation/deletion because directories are not first-class citizens.

Anyway, as with the empty directory stuff, if I occasionally have to
mkdir/rmdir a couple things and rename a few files after doing a
merge, I'm not going to cry too much.  It sure beats explicitly
tracking renames and then having an oops-I-forgot-to-explicitly-track
rename throw a monkey wrench into my merges, which svn has saddled me
with lots of times.

Have fun,

Avery
