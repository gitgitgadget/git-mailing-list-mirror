From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: commit-message attack for extracting sensitive data from
 rewritten Git history
Date: Tue, 9 Apr 2013 19:08:52 +0100
Message-ID: <CAFY1edbor4tE3bgiScBESX_XY3RY_WSKs7_Y3n++u6tru3nepQ@mail.gmail.com>
References: <CAFY1edbNPjs5JGOPRxzB+ie4w=SvR+rUeePhsEnpr0tWtZpeHg@mail.gmail.com>
	<7vehelyqrv.fsf@alter.siamese.dyndns.org>
	<20130408215457.GB11227@sigill.intra.peff.net>
	<5163AF2C.2020107@viscovery.net>
	<20130409170159.GC21972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:08:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcyY-0000hb-BD
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761621Ab3DISIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:08:53 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33500 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760900Ab3DISIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:08:53 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so8598712ieb.8
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RYDvXawCXEHPyItn4KLyBcKgBtpFgfjdoF0hPemLHiw=;
        b=oV1g6ru6toiuVo64b/kzujt+16ETnNGEHPE55UbMmipgbKX92VWsl9kz02iivZ4pl7
         BY6U5cIBZSydsOkX30VVJHnOBav9FUNp1NTf0nBSqs9IT4oh6S1Dd8vdMuYzQQZPDSef
         prKw4biIrUe0YFIVWn9gSjcfGeWazykCFUQ6jksRNax+mvKSxVTnqUQ665tAOcZCoHrg
         qzLfE1yvzjVhCcbw+k1dpCcD/QNO8E4uy88USAdrrCku5sVDkZx60yPVtofAQ+Uw6/VM
         qP1ZFBrD21du+2lIc/xht4+ZiQ+xQ0jxgBM4orPWRUrTA3cJyaR8gcoayhJrQrYnH3na
         P8og==
X-Received: by 10.50.7.69 with SMTP id h5mr11418873iga.69.1365530932688; Tue,
 09 Apr 2013 11:08:52 -0700 (PDT)
Received: by 10.64.170.68 with HTTP; Tue, 9 Apr 2013 11:08:52 -0700 (PDT)
In-Reply-To: <20130409170159.GC21972@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220606>

On 9 April 2013 18:01, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 09, 2013 at 08:03:24AM +0200, Johannes Sixt wrote:
>> If A mentions B (think of cherry-pick -x), then you must ensure that the
>> branch containing B was traversed first.
>
> Yeah, you're right. Multiple passes are necessary to get it
> completely right. And because each pass may change more commit id's, you
> have to recurse to pick up those changes, and keep going until you have
> a pass with no changes.

Just to give some context on how the BFG handles this (without doing
multiple passes):

The BFG makes a design choice (based on it's intended use-case of
annihilating unwanted data) that a specific tree or blob will always
be cleaned in exactly the same way - because when you're trying to get
rid of large blobs or private data, you most likely /don't care/ where
it is, what commit it belongs to, how old it is. The id for a cleaned
tree or blob is always the same no matter where it came from, and so
the BFG maintains a in-memory mapping of 'dirty' to 'clean' object ids
while cleaning a repo - whenever an object (commit, tag, tree, blob)
is cleaned, these values are stored in the map:


  dirty-id -> clean-id
  clean-id -> clean-id

(in terms of memory overhead, this amounts to only ~ 128MB for even
quite a large repo like the linux kernel, so I don't spend much time
worrying about it)


The map memoises the cleaning functions on all objects, so an object
(particularly a tree) never gets cleaned more than once, which is one
of the things that makes the BFG fast.

Having these memoised functions makes cleaning commit messages fairly
easy - the message is grepped for hex strings more than a few
characters in length, and if a matched string resolves uniquely to an
object id in the repo, the clean() method is called on it to get the
cleaned id - which will either return immediately with a previously
calculated result, or if the id came from a different branch, trigger
a cascade of more cleaning, eventually returning the required cleaned
id.

In the case of git-filter-branch, the user has a lot more freedom to
change the tree-structure of commits on a commit-by-commit basis, so
memoising tree-cleaning is out of the question, but I guess it might
be possible to do memoisation of just the commit ids to short-cut the
multiple-pass problem.

- Roberto Tyley
