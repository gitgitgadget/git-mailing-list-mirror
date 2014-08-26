From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Tue, 26 Aug 2014 14:08:35 +0200
Message-ID: <CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
	<20140825194430.GI30953@peff.net>
	<CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:09:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMFYH-0002Jy-Dy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 14:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931AbaHZMIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 08:08:37 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:53646 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901AbaHZMIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:08:36 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so22420823pdb.27
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ecq1vGm4CTwdyGo7gpuo4/oha9HqNOmqlHAngSSa/54=;
        b=sziW2vc8l5tKnqNdIRv2kk4zZ+kZ3F+GySSDKHVVMicY8Nna/ZPV0jHGP0r9tEq/Ny
         hD98bQXsW2XUL0hvK2NCJU/SeFgVVUTZZWwp7Fpo31D9+jdBgHOkHmsRVAgiq8nMCgWa
         TCFouwYCkbwTH8IZAoDDKWzz+EpWQGL23eNMqjO3LEHjakRZprwWEEQpk1blulkgy/F5
         cxybK67Vv/OofqA20dch9EWgS1tlJvwMZZWib7nQIMI8JhWwo+4/hVy2VEn6Xx72Wino
         tqhrDZqsdS411NjKoaab6NaVwTbi7Fw7ZtJoN4xyqMie6RfNeshLTvz86VIGwVlVwSxi
         pRFg==
X-Received: by 10.70.134.205 with SMTP id pm13mr36539373pdb.80.1409054915754;
 Tue, 26 Aug 2014 05:08:35 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Tue, 26 Aug 2014 05:08:35 -0700 (PDT)
In-Reply-To: <CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255891>

On Mon, Aug 25, 2014 at 10:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Aug 25, 2014 at 12:44 PM, Jeff King <peff@peff.net> wrote:
>> For my own curiosity, how do you get into this situation, and what does
>> it mean to have multiple stage#1 entries for the same path? What would
>> "git cat-file :1:path" output?
>
> That is how we natively (read: not with the funky "virtual" stuff
> merge-recursive does) express a merge with multiple merge bases.
> You also should be able to read this in the way how "git merge" invokes
> merge strategies (one or more bases, double-dash and then current
> HEAD and the other branches). I think there are some tests in 3way
> merge tests that checks what should happen when our HEAD matches
> one of the stage #1 while their branch matches a different one of the
> stage #1, too.

I'm a bit lost with this, conceptually it doesn't seem to be any
problem with having multiple merge bases, but I don't manage to
reproduce it.
With "natively" do you mean some internal state that is never written
into the index? If this were the case then there wouldn't be any
problem with the restriction when reading the index file.

I have also tried to reproduce it by directly calling
git-merge-recursive and the most I have got is what it seemed to be
like a conflict in the stage #1:

$ git ls-files -s
100644 1036ba5101378f06aa10c5fa249b67e14f83166b 1 conflict
100644 2638c45f8e7bc5b56f70e92390153572811782c3 2 conflict
100644 178481050188cf00d7d9cd5a11e43ab8fab9294f 3 conflict

$ git cat-file blob 1036ba5101378f06aa10c5fa249b67e14f83166b
<<<<<<< Temporary merge branch 1
G
=======
E
F
>>>>>>> Temporary merge branch 2

And after thinking a bit more about it, I don't see a way to have two
stage #1 entries for the same path with git commands only. It seems
that all entries are added through the add_index_entry_with_check()
function (except maybe the added to the cached tree extension), and
this function replaces existing entries if they have the same name and
stage.
Also, all tests pass with the patch, without allowing two entries for
the same stage.

So I'm afraid that I don't fully understand this case :/
