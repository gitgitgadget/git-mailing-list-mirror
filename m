From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Mon, 12 May 2014 07:20:59 +0530
Message-ID: <53702903.20904@gmail.com>
References: <536E2C19.3000202@gmail.com>	<xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com>	<536ECC93.1070102@gmail.com> <1399772049733.13154@student.bi.no>	<536EDC1C.5040101@gmail.com> <1399777917522.41294@student.bi.no>	<536F08C5.3010705@gmail.com> <xmqqbnv4ur7t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Storm-Olsen\, Marius" <Marius.Storm-Olsen@student.bi.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 03:51:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjfOi-0007RY-NQ
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 03:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437AbaELBvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 21:51:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38164 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbaELBvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 21:51:05 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so7268455pad.32
        for <git@vger.kernel.org>; Sun, 11 May 2014 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6zuka9Bflk62Drr2IKHLIeKYKDhB00CuYVotUsLP9v4=;
        b=CfrFlJd5+kuCb2lBGZF/8stPr2mP/WxVUAi0vqidiXFWQB1cCi6Oznamf4rGqwt9/j
         oEpR63q9JKDljvsASOwXThOYNG4EZbxzebJ5ssjgLqYweHUln378jQ55V/UhJDSeMs2x
         6sAZ1YfgzV+b4dPtM9yFPgHLUR+JTB4RPHFMlsBLLj8nEVosVzo6eXItICUt/Sj+F6Ri
         C42egKU66L6J1s/nNhj2CytOBaBpMwZD+CniWMGrFQb0XQyX/v1YMY6oaQG9ATboCe7b
         mVGvLsRR4pSo0FMNeWvH+aDU0/cazZXDUWvKTqYJ1hM6npRgTJPNRgdPw27xbXuRt2RX
         GQfA==
X-Received: by 10.66.66.135 with SMTP id f7mr49920087pat.22.1399859464747;
        Sun, 11 May 2014 18:51:04 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.214.74])
        by mx.google.com with ESMTPSA id fk4sm41829840pab.23.2014.05.11.18.51.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 11 May 2014 18:51:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqbnv4ur7t.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248686>

On 05/11/2014 11:34 PM, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> But what I was looking for was validation from git.git folks of the idea
>> of replicating what "git clone -l" does, for an *existing* repo.
>>
>> For example, I'm assuming that bringing in only the objects -- without
>> any of the refs pointing to them, making them all dangling objects --
>> will still allow the optimisation to occur (i.e., git will still say "oh
>> yeah I have these objects, even if they're dangling so I won't ask for
>> them from the pusher" and not "oh these are dangling objects; so I don't
>> recognise them from this perspective -- you'll have to send me those
>> again").
>
> So here is an educated guess by a git.git folk.  I haven't read the
> codepath for some time, so I may be missing some details:
>
>   - The set of objects sent over the wire in "push" direction is
>     determined by the receiving end listing what it has to the
>     sending end, and then the sending end excluding what the
>     receiving end told that it already has.
>
>   - The receiving end tells the sending end what it has by showing
>     the names of its refs and their values.
>
> Having otherwise dangling objects in your object store alone will
> not make them reachable from the refs shown to the sending end.  But
> there is another trick the receiving end employes.
>
>   - The receiving end also includes the refs and their values that
>     appear in the repository it borrows objects from its alternate
>     repositories, when it tells what objects it already has to the
>     sending end.
>
> So what you "assumed" is not entirely correct---bringing in only the
> objects will not give you any optimization.
>
> But because we infer from the location of the object store
> (i.e. "objects" directory) where the refs that point at these
> borrowed objects exist (i.e. in "../refs" relative to that "objects"
> directory) in order to make sure that we do not have to say "oh
> these are dangling but we know their history is not broken", we
> still get the same optimisation.

Thanks!

Everything makes sense.  However, I'm not using the alternates
mechanism.

Since gitolite has the advantage of allowing me to do something before
and something after the git-receive-pack, I'm fetching all the refs into
a temporary namespace before, and deleting all of them after.  So, just
for the duration of the push, the refs do exist, and optimisation (of
network traffic) therefore happens.

In addition, since I check that the user has read access to the lender
repo (and don't do this optimisation if he does not), there is -- by
definition -- no security issue, in the sense that he cannot get
anything from the lender repo that he could not have got directly.

Thanks for all your help again, especially the very clear explanation!

regards
sitaram
