From: Tzu-Jung Lee <roylee17@gmail.com>
Subject: Re: git-checkout silently throws away the dirty status of index
 without a warning?
Date: Fri, 2 Sep 2011 02:28:54 +0800
Message-ID: <CAEvN+1hA1mUjDc0cQidEBOf5LhJ9LrVbTjyV5qPkUKNM6f7urQ@mail.gmail.com>
References: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
	<7v1uw0xk57.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 20:29:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzC0b-0000F0-Ti
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 20:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab1IAS25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Sep 2011 14:28:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38203 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab1IAS24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 14:28:56 -0400
Received: by bke11 with SMTP id 11so1983170bke.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SwKrfdDJ+fe8q6/k9CAadZcYLLlY1kN1IqQndlMXgdQ=;
        b=cPokdOOX0KZK0wmo3SVk/9e7EAatPHbpgX41koVsoJWpIaP2BadCneuAbsDY4+B1oH
         5wO6awuZB73TiPtD0BUbO+kkfZEqgg9RQ5jtLHClKheO3xwCjbqXpKBc3a0rDL2i6c0c
         oz/bAWOhsxXHbBsx0DsH3bdmWEiDjzgxeA+eE=
Received: by 10.204.138.78 with SMTP id z14mr85645bkt.232.1314901734835; Thu,
 01 Sep 2011 11:28:54 -0700 (PDT)
Received: by 10.204.152.81 with HTTP; Thu, 1 Sep 2011 11:28:54 -0700 (PDT)
In-Reply-To: <7v1uw0xk57.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180560>

On Fri, Sep 2, 2011 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Tzu-Jung Lee <roylee17@gmail.com> writes:
>
>> Is this an intended behavior?
>
> Yes, I think you are talking about the case where "the current index =
does
> not match the current HEAD, but it does match the tree we are switchi=
ng
> to" case. In that case we take the contents of switched-to branch.
>
> It is the last case in the table in this old design document:
>
> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/4641
>

Cool! It's really valuable resource about the internals. Do all the
entries of the matrix still hold true today?
Maybe we can have an updated version put in the manual or other
official documentation.

> bug ignore the terminology (stage#). Read only the body of the table,=
 with
> the understanding that the three entries in each row talk about the s=
tate
> for the same path in the index entry, the tree entry in the current H=
EAD,
> and the tree entry in the switched-to branch. Also the table does not=
 talk
> about the checking performed on the working tree file, but assume tha=
t we
> do not overwrite it when the resulting entry in the index does not ma=
tch
> what you have there.
>
> The reason we allow branch switching in this case, instead of failing=
, is
> so that you can be in a state where you applied the same change (rela=
tive
> to the current branch to the branch you are switching to) lying aroun=
d
> already in your workspace and safely switch to the new branch without
> losing any work (after all, the content matches).

I understand it's a safe behavior in the sense that all the 'content'
are preserved. But the 'work' may still lost in another sense.
Consider the extended scenario. I was in the middle of doing... kind
of 'in-commit-bisection' (btw, how would you call this?).
=46inding out which are the guilty changes in a giant patch that has
large number of changes including binary updates.

(good)   (good)    (bad)
index    HEAD    switchd-to

A1         A1        A2
B2         B1        B2
C2         C1        C2
D2         D1        D2
E1         E1        E2
=2E..

I accidentally switch to the switched-to branch without committing the
intermediate status.
The 'work' was gone, and I had no idea how to bring it back.

> By the way, the first six lines of your original message that describ=
es
> "saving and applying" is not correct.
