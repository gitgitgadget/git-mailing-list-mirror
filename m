From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFD] annnotating a pair of commit objects?
Date: Fri, 5 Apr 2013 21:36:13 +0200
Message-ID: <CALWbr2xOt-tRy1iPJft28O1-fDVo1=DZhEZX6Me3Mt4pZjMyFw@mail.gmail.com>
References: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
	<50E5568A.5060909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWNk-0001b9-3n
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162648Ab3DETgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 15:36:17 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:43033 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162615Ab3DETgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 15:36:15 -0400
Received: by mail-qc0-f169.google.com with SMTP id t2so234539qcq.28
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AqqFu3DXkakS3TmbWIvzSnmywO0KPaCAOMCmGFpAfLs=;
        b=vCi3s72MDCuCw/3EmeblBWjkFrS/w+EUx/tJWVwZa5pJT/QNaSXEdboGLxLVBYYatV
         6JKpzVmiK4NxHp6Sy1Xx4J+LUbM9GB9Zg2JBH3H+kyGItTpxY9K8jG2afcg9i9tPokyU
         oSmC9C0KG3NHeCWx1cj7HzXN+X8NHSQd9v6a9ST84/0qkIL+829SNe+WUz3emaugpbmp
         mYi2pX6XVZieRPrQONcDtc/b1elgxI9WQFFwepHOLe+gelb6/NGcO1+DL5EC4Mq3C8cY
         CgpoVbHTbyVJUdVKqJ1rvnayfWKm5zTkNxHE5v6zq1OdDjpnrU4wtyngkMHvAbg5pw8X
         rrAQ==
X-Received: by 10.49.61.226 with SMTP id t2mr11044256qer.40.1365190574043;
 Fri, 05 Apr 2013 12:36:14 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Fri, 5 Apr 2013 12:36:13 -0700 (PDT)
In-Reply-To: <50E5568A.5060909@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220188>

On Thu, Jan 3, 2013 at 10:59 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 01/03/2013 08:03 AM, Junio C Hamano wrote:
>> I'd like a datastore that maps a pair of commit object names to
>> another object name, such that:
>>
>>  * When looking at two commits A and B, efficiently query all data
>>    associated with a pair of commits <X,Y> where X is contained in
>>    the range A..B and not in B..A, and Y is contained in the range
>>    B..A and not in A..B.
>>
>>  * When <X,Y> is registered in the datastore, and X is rewritten to
>>    X' and/or Y is rewritten to Y', the mapping is updated so that it
>>    can be queried with <X',Y'> as a new key, similar to the way a
>>    notes tree that maps object X can be updated to map object X'
>>    when such a rewrite happens.
>>
>> The intended use case is to "go beyond rerere".  Given a history of
>> this shape:
>>
>>     o---o---o---I      mainline
>>    /
>>   O---o---X---o---A    topic A
>>    \
>>     o---Y---o---o---B  topic B

I would indeed also be interested in such a feature for my day-to-day
work where we use a workflow similar to git.git's.

> When doing this merge, I think your goal is equivalent to discovering
> that M includes part of the merge of J and B, and adding M as an
> (implicit or explicit) third parent to the merge:
>
>      o---o---o---I---J-------K  mainline
>     /               /    .  /
>    O---o---X---o---A    .  /    topic A
>     \       \          .  /
>      \       M.........  /
>       \     /           /
>        o---Y---o---o---B        topic B
>
> How could M be stored?  Assuming that these type of premerge merges are
> sparse, then Jeff's analysis seems good.  Concretely, one could simply
> store pointers to M from both X and Y; e.g.,
>
> * Add a note to X with the information "when merging this commit with Y,
> use premerge M"
>
> * Add a note to Y with the information "when merging this commit with X,
> use premerge M"
>
> Then, when merging, create the set J..B, scan all of the commits on B..J
> for these "premerge" notes (O(|B..J|)), and for each one, look in the
> set J..B to see if it is present.  The effort should scale like
>
>     O( |J..B| + |B..J| * lg(|J..B|) )
>
> where, of course J and B could be exchanged for either aesthetic or
> performance reasons.  (One would also need a mechanism for preventing M
> from being garbage-collected.)

I like the idea of using notes and a kind of "pre-merge". The proposal
seems decent to me.

Michael, have you started implementing such a thing ? If you did, I
would love to help as much as I can.
If you didn't, I would like to start implementing this feature (I
think I now have some time to do so).
Maybe that would require some kind of mentoring though. It could be a
nice opportunity for the community to improve that too as a fake
"gsoc" (no google, no summer, no student)
