From: "Andy C" <andychup@gmail.com>
Subject: Re: Linear time/space rename logic for *inexact* case
Date: Mon, 22 Oct 2007 03:09:37 -0700
Message-ID: <596909b30710220309l1a28e646r9fd47f967dc32574@mail.gmail.com>
References: <596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 12:10:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjuEL-0007hr-Hn
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbXJVKJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXJVKJl
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:09:41 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:64404 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbXJVKJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:09:40 -0400
Received: by py-out-1112.google.com with SMTP id u77so2339712pyb
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/Y6mPLcvZBZ6JPcd3laR7DsIfG/xp9H6md/MnH7jUuc=;
        b=MVavZUKBZVYxM7awBMxOR5CGR1MKX+HVWrCMYR2j8PUtNy2Oh31FWm81g9R7sKPAoZda8i1+eOup38Qd7g3mFR1WtUrxhPU2lAivsYossBRruiqJFHC1BrShQzittIRuoMLjsfKJCWHRX7qQT4QECgnrWnON5HPD5C2PG/laDt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k67nG+Yri0FKSCZ0x25hE7HY7YZzmcsILm1P2jY1lK49o4TYGzlKzqP08ZJCexb16yzpvXSUtsPytWhJuCaQLAr9Gn3oEQoYoT400UZ1pzwAwDmQG3W/UTDzCOiRHasQVn/bHgjJi1EkHYhYsADV9qOnr9Tx+69R3FTnP68re9g=
Received: by 10.35.33.5 with SMTP id l5mr1931272pyj.1193047777173;
        Mon, 22 Oct 2007 03:09:37 -0700 (PDT)
Received: by 10.35.91.3 with HTTP; Mon, 22 Oct 2007 03:09:37 -0700 (PDT)
In-Reply-To: <596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61977>

On 10/22/07, Andy C <andychup@gmail.com> wrote:
> So the algorithm is:

I think I can make this a lot clearer than I did, while glossing over
some details and the line_threshold parameter.

1) Make a "left index" and a "right index" out of the 2 sets of files,
{ line => [list of docs] }.

2) Remove any lines that appear in more than one doc from the left
index.  Do the same for the right index.  (this corresponds to
line_threshold=1 case)

3) For all lines, if the line appears in *both* the left index and the
right index, increment the count of the (row=doc from left set,
column=doc from right set) entry in the similarity matrix by 1.  The
matrix is represented by a hash of 2-tuples => counts.

After this is done for all lines, then the matrix is sparsely filled
with the count of common lines between every pair of files in the 2
sets.  The vast majority of cells in the matrix are implicitly 0 and
thus consume neither memory nor CPU with the hash table representation
of matrix.

4) Then you can use this to compute similarity scores.

Hopefully that is more clear... though I guess it might not be obvious
that it works for the problem that git has.  I am fairly sure it does,
but the demo should allow us to evaluate that.

Andy
