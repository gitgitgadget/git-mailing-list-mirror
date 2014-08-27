From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Thu, 28 Aug 2014 00:13:52 +0200
Message-ID: <CAPuZ2NHTz2Qu3oorRVTHSb9E-gC_d1kNniVmtUPtpAqPVrUDtA@mail.gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
	<20140825194430.GI30953@peff.net>
	<CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
	<CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
	<20140826122008.GC29180@peff.net>
	<xmqqmwarjiq7.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NGTQoKnSfeN2zte5=fqswN5PcfAULdFy9WnGWPtc2Zskg@mail.gmail.com>
	<xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFzHjUSfi1H0RFvOuWdRptwxv-gsUOAJv0Uh5BFLWmnRA@mail.gmail.com>
	<xmqq61hdd4e9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMlTZ-0006NZ-An
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 00:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935965AbaH0WNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 18:13:53 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:56494 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaH0WNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 18:13:52 -0400
Received: by mail-ig0-f179.google.com with SMTP id r2so197603igi.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f+lxbcAIISlly078CqLhlJ4a1EwGZAjF/CXfAiTrnfY=;
        b=d5dQfyOz71gJworDW2+AX1SvB5CTKmfkuTuPynHXbhbykb5tsskkrm28V+9KSxq43f
         kq2TKRfXLcVOyptTKdIJJkEkZPAxAwudJOcSvMx+HaIQpxsSPd9lmPPJD0MTPgV6J6ag
         vrMt15FrJ0LXhXltK3ejrvRLivfS5AoYDKtq0+oJ5+fxGW32VFn0rucPKXfNEvZlV2Nh
         jw4rvTn/9+HhQ5ygf0CriJRQA+/vGKcl0IHKQekHW9z1JDcfNrf7Qd7jTg4y9FcEBTGe
         ADQYRmmj9PfWw6zAJLwu5slFCiwiR6q7q9yLBOGFAPy25PBG9e3Ac2d+EamsPLoexo88
         +vKQ==
X-Received: by 10.66.251.132 with SMTP id zk4mr50457761pac.47.1409177632138;
 Wed, 27 Aug 2014 15:13:52 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Wed, 27 Aug 2014 15:13:52 -0700 (PDT)
In-Reply-To: <xmqq61hdd4e9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256053>

On Wed, Aug 27, 2014 at 11:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I was asking for an answer more from what you know about the code.
> For example, would read_index_unmerged() choke if the index has two
> or more stage #1 (or stage #3) entries for the same path (provided
> that the index is otherwise normal, i.e. no stage #0 entry for that
> path, entries are sorted by pathname order and stages are in an
> order that does not decrease)?

Oh, ok :) Re-reading the code a bit I think that there can be a
potential problem in the add_index_entry_with_check() function. It's
currently implemented to allow an only entry for each stage and each
path, if an entry for a path and a stage is being added, and another
one existed before, the old one is replaced, but just the first one,
so adding an entry to stage #1 in an index with multiple entries at
stage #1 would replace the first occurence, but not the rest, what
could not be expected. The user could maybe expect that all entries
are replaced, or only an specific one.
If an stage #0 entry is added and there are multiple entries for any
of the higher-stage entries there wouldn't be any problem as this
function removes all the higher-stage entries for the same path
without checking the stage. This last case is the one in
read_index_unmerged().
