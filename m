From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Thu, 6 Jan 2011 13:36:57 +0700
Message-ID: <AANLkTikXcrZqhCw+2u2HObUZz5QCStY6BCHTTYYfngMN@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
 <loom.20110105T222915-261@post.gmane.org> <AANLkTi=_R53fm5Er0CdtZCFvDpE-Dqt8tMHAubcjOUBb@mail.gmail.com>
 <4D25385B.3010103@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Thu Jan 06 07:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PajTs-0000gX-08
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 07:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab1AFGha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 01:37:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52612 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab1AFGha (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 01:37:30 -0500
Received: by wwa36 with SMTP id 36so17117863wwa.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 22:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=2QnLIZHYPA3Jo4FmusbaD17A/D2/KSM4s/bhQgqxEdo=;
        b=EGj9GgH7q/smc31mpl28lcwB6PsmtnlzDDHXH9PRfBjVFut10OuhJbhYk1UAQzV2TO
         GibfgX8L47+wfQSK+SMUii8zUStygAY77vJCUaB14G8zUcnEBpn8bPrQqXGdDnCQLISY
         Lw0BPxcVu+gpoXtWHDk6K7ywAxQo2jTsEHGVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FgDnbsjYQSCtyvUvXoa3yag4iP/UgzTMmR8pA95hKjQVGvwQmSEVueQCdVXdhS5ddV
         8AnLMHhAgMhDejtGmYTGw/6EHDBFYLg9Nz9Ycasu/Y/qlISftBBhuJVIYedyar4iZtST
         yyLW/BYS378FWVHW9glLjKTbFTBXUqN/2zF/E=
Received: by 10.216.59.143 with SMTP id s15mr282786wec.49.1294295848682; Wed,
 05 Jan 2011 22:37:28 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 5 Jan 2011 22:36:57 -0800 (PST)
In-Reply-To: <4D25385B.3010103@seznam.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164624>

On Thu, Jan 6, 2011 at 10:34 AM, Maaartin-1 <grajcar1@seznam.cz> wrote:
> In theory, I could create many commits per seconds. I could create many
> unique paths per seconds, too. But I don't think it really happens. I do
> know no larger repository than git.git and I don't want to download it
> just to see how many commits, paths, and object it contains, but I'd
> suppose it's less than one million commits, which should be manageable,
> especially when commits get grouped together as I described below.

In pratice, commits are created every day in an active project. Paths
on the other hand are added less often (perhaps except webkit).

I've got some numbers:

 - wine.git has 72k commits, 260k trees, 200k blobs, 12k paths
 - git.git has 24k commits, 39k trees, 24k blobs, 2.7k paths
 - linux-2.6.git has 160k commits, 760k trees, 442k blobs, 46k paths

Large repos are more interesting because small ones can be cloned with
git-clone.

Listing all those commits in linux-2.6.git takes 160k*20=3M (I suppose
compressing is useless because SHA-1 is random). A compressed listing
of those 46k paths takes 200k.

>> And commits depend on other commits so
>> you can't verify a commit until you have got all of its parents. That
>> does apply to file, but then this file chain does not interfere other
>> file chains.
>
> That's true, but the verification is something done locally on the
> client, it consumes no network traffic and no server resources, so I
> consider it to be cheap. I need less than half a minute (using only a
> single core) for verifying of the whole git.git repository (36 MB). This
> is no problem, even when it had to wait until the download finishes. I'm
> sure, the OP of [1] would be happy if he could wait for this.

The point is you need to fetch its parent commits first in order to
verify a commit. Fetching a whole commit is more expensive than a
file. So while you can fetch a few commit bases and request for packs
from those bases in parallel, the cost of initial commit bases will be
high.

> I see I didn't explain it clear enough (or am missing something
> completely). I know why the packs normally used by git can't be used for
> this purpose. Let me retry: Let's assume there's a commit chain
> A-B-C-D-E-F-..., the client has already commit B and requests commit F.
> It may send requests to up to 4 servers, asking for C, D, E, and F,
> respectively. The server being asked for E _creates_ a pack containing
> all the information needed to create E given _all of_ A, B, C, D. As
> base for any blob/whatever in E it may choose any blob contained in any
> of these commits. Of course, it may also choose a blob already packed in
> this pack. It may not choose any other blob, so any client having all
> ancestors of E can use the pack. Different server and/or program
> versions may create different packs for E, but all of them are
> _interchangeable_. Because of this, it makes sense to _store_ it for
> future reuse.

They are interchangeable as a whole, yes. But you cannot fetch half
the pack from server A and the other half from server B. You can try
to recover as many deltas as possible in a broken pack, but how do you
request a server to send the rest of the pack to you?
-- 
Duy
