From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Sun, 28 Sep 2014 13:36:23 +0200 (CEST)
Message-ID: <20140928.133623.1635797151132857721.chriscool@tuxfamily.org>
References: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0kfSBhSwu5Mb46XEHqYCE0SEsZd_3c0Sm4WzEc-NNc7w@mail.gmail.com>
	<CAPc5daUTKU1JepLuyVC1Nk6LG4AZ2TA5SEYLsTSPbPKkauzNyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, mst@redhat.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 13:36:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYCmN-0006wb-1H
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 13:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaI1Lg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2014 07:36:28 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:38949 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbaI1Lg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2014 07:36:27 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id AA0975B;
	Sun, 28 Sep 2014 13:36:25 +0200 (CEST)
In-Reply-To: <CAPc5daUTKU1JepLuyVC1Nk6LG4AZ2TA5SEYLsTSPbPKkauzNyQ@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257595>

From: Junio C Hamano <gitster@pobox.com>
> On Thu, Sep 25, 2014 at 3:04 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>> To an existing message ends with Michael's Signed-off-by:, if his
>>> "git am --trailer arts" is called to add these three and then a
>>> Signed-off-by: from him, should it add an extra S-o-b (because his
>>> existing S-o-b will no longer be the last one after adding Acked and
>>> others), or should it refrain from doing so?  Can you express both
>>> preferences?
>>
>> The default for "trailer.where" is "end", and for "trailer.ifexists"
>> it is "addIfDifferentNeighbor".
>> That means that by default it will add the four new trailers at the end.
>>
>> If either "trailer.ifexists" or "trailer.S-o-b.ifexists" is set to
>> "addIfDifferent", then only the first 3 new trailers will be added at
>> the end. So yes you can express both preferences.
> 
> Suppose that the original ends with Sob, and Michael's "am" invokes
> interpret-trailers with Acked/Reviewed/Tested/Sob in this order. The first
> three are set to addifDifferent and Sob is set to addIfDifferentNeighbor,
> which would be the traditional and sensible default.
> 
> Now, how is addIfDifferentNeighbor interpreted? Adding the new Sob
> with this single request to add these four is done on a message that
> has the same Sob at the end (i.e. Neighbor). Does _you_ adding of
> Acked/Reviewed/Tested invalidate the Neighbor-ness and you add the
> Sob anew?

The trailers are processed in the order they appear on the command
line. And when a trailer is processed, the input message it "sees" is
the result from the processing of all the previous trailers on the
command line. It is not any more the original input message.

So after Acked/Reviewed/Tested have been added, when the S-o-b at the
end of the command line is processed, it "sees" an input message that
has the Tested trailer at the end. That's why with
addIfDifferentNeighbor the S-o-b will still be added at the end.

> If that is what happens, it is not a workable workaround to set Sob to
> addIfDifferent only for this invocation.

Setting S-o-b to addIfDifferent for this invocation would not add the
S-o-b at the end, because another S-o-b still exists in the input
message "seen" when the last S-o-b is processed.

> Alternatively, if Neighbor-ness is evaluated first before you add A/R/T
> in response to this request, then you'd refrain from adding a duplicate
> Sob. It wasn't quite clear from your description what your design was,
> and your explanation above is not still clear, at least to me.

I hope it is clearer now. Maybe I should add something in the doc to
better explain how it works.

Thanks,
Christian.
