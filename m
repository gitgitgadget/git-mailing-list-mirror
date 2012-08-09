From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Thu, 9 Aug 2012 09:28:42 +0700
Message-ID: <CACsJy8DqwgzrbXXU+ea2QWJ_oujcJe4_ZVmR_-Sy02Gnk1Hetg@mail.gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com> <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
 <CACsJy8CepAQr4r-c_hzwgT2-_bpFV-=VmOsFaBcDZqBpG52reQ@mail.gmail.com>
 <7v7gtaups3.fsf@alter.siamese.dyndns.org> <CACsJy8DfJJpwidfUQFDeqM=5uPpGF6rZ6C1pS0H6mSNHUqOkbg@mail.gmail.com>
 <7vvcgttkeu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 04:29:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzIUy-0002kX-B6
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 04:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2HIC3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 22:29:15 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63562 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2HIC3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 22:29:14 -0400
Received: by ghrr11 with SMTP id r11so1539197ghr.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PrKVKcBjKr5rwAmbnsBr8vFTTxKSV8ImpjaGoZ2W7KA=;
        b=vL2/Mg1PHL/mWQEjT61Mkmb89dcsrujIpLw3OH9UEqHYaL+KbNOK3tyni+s3SgPFe1
         1YdXA0lg10t7suRdF46uTzOqXYg7fbXQT9Jn5D0yiyatsY9OHs5Bu59iBo+iySREOb8u
         TeLK+wcXiY7+UicaVJlO3m02VhjmEL3opCclpznOphby2aJZI6QIffmt5lwHYwzAv9uw
         tQe/K9cQ+PlX8O96HmML8hGMuBz+9HwtmPBO10kz52l525MavLzDh1UQCTvjJ0R1GBNi
         yg2I1W0/HvX1VJ6CNMzu/FI2E75ZqIIbiU+Q+7q3ILeiKGRbe86LjuByZVWPDJEhG6ii
         ySLg==
Received: by 10.50.220.194 with SMTP id py2mr843054igc.15.1344479353423; Wed,
 08 Aug 2012 19:29:13 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Wed, 8 Aug 2012 19:28:42 -0700 (PDT)
In-Reply-To: <7vvcgttkeu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203144>

On Wed, Aug 8, 2012 at 11:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The current code that access nth entry from the index->cache[nth]
> would need to be updated to use an accessor function, whether the
> "nth" comes from index_name_pos() or from the for-loop that iterates
> over the entire index.  For the latter, you would need to give the
> users a function that returns a cursor into the in-core index to
> allow iterating over it.
>
> When you use an in-core representation that is not a flat array, the
> type of "nth", which is essentially a cursor, may have to change to
> something that is richer than a simple integer, in order to give the
> implementation of the in-core index a more efficient way to access
> the entry than traversing the leaves of the tree depth first, and
> you would need to update index_name_pos() to return such a "cursor".
> That design and development cost is part of updating the in-core
> data structure. In the end result, the runtime cost to manipulate an
> index entry that the cursor refers to should be minimum, as that
> would be the cost paid by all the users of the API anyway, even if
> we _were_ starting from an ideal world where there weren't any flat
> in-core index in the first place.

Interesting. So you hide the entire tree walk behind the cursor
concept. And we can make pathspec filter as part of cursor
initialization. Index iteration code this way looks really neat
(compared to how we do traverse sha-1 trees nowadays). The hard part
is updating the index while iterating (or avodiing running into such a
situation). Maybe C++ STL has done it already with std::map::iterator.
I fear that by hiding the trees, we might miss some optimization
opportunities. But I haven't figured it all out yet so I may be wrong.
-- 
Duy
