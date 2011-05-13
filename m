From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Fri, 13 May 2011 12:13:23 -0400
Message-ID: <BANLkTikDafbCnsXPoidnMBAE0qtd9aC4oQ@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
 <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com> <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com>
 <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com> <BANLkTimE2GkkhcFZtNrYZASWp0LDhUx=GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org, Shuang He <shuang.he@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 18:13:54 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKuzw-0003BK-W2
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 18:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759542Ab1EMQNp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 12:13:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36318 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab1EMQNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 12:13:44 -0400
Received: by pwi15 with SMTP id 15so1235565pwi.19
        for <multiple recipients>; Fri, 13 May 2011 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IHntclJ/XJ/cfgxp4NQ/8MNQIEQuSE68HfR7npfZmZ0=;
        b=d70UgdPiK/xrXCXjjLBVeKtxgJfW3JbpDGMI4GPpYStqSkN2venGQCemTT1gWHRWoU
         UteMgnggtHici9mh7D7eshd79qYFxXNPCMwgklxO4SHCa7aTN5gWxQHt6eyVHCGpfjwH
         FTlz98ib3RWWijauEUQhFpwvyIB1HDx2LGkrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=rCYkKDTfEqiKDPgXcJ3TeAHMm3eE0w+7h4bUcFZx6C937kqaPHJkg/7ufLloYGy8oi
         8xXSSC5DgKDLJ74JW6kIyghSsj2Hzg7/5f9WPEfJ2W2KNyRwSSpbMGR7IbKEFdAynO1g
         aZp0qZxEqdGbdHdceir9gdvn43eAW1OgjrZnY=
Received: by 10.68.23.6 with SMTP id i6mr2526873pbf.314.1305303223382; Fri, 13
 May 2011 09:13:43 -0700 (PDT)
Received: by 10.68.41.197 with HTTP; Fri, 13 May 2011 09:13:23 -0700 (PDT)
In-Reply-To: <BANLkTimE2GkkhcFZtNrYZASWp0LDhUx=GQ@mail.gmail.com>
X-Google-Sender-Auth: lDEBlXagh6MUQKH7Sm4wIpGou1M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173545>

On Fri, May 13, 2011 at 12:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, May 13, 2011 at 7:56 AM, Andrew Lutomirski <luto@mit.edu> wro=
te:
>>
>> So what I really want is a fancy version of git bisect that makes no
>> assumptions about the relationship of good and bad commits in the
>> graph and just finds me a commit that is bad but for which all paren=
ts
>> are good or vice versa.
>
> Ehh. That's the "non-fancy" way of testing, I'm afraid: if you cannot
> make assumption about the relationship between good and bad commits,
> then you have to test _every_ commit.
>
> So yes, bisection has its problems. But they really do come from the
> fact that it's very efficient. When you have (on average) about ten
> thousand commits between releases, you have to make assumptions about
> the relationships. But once you do that, the efficiency also results
> in a certain fragility.
>
> Think of it as a compression method: it generates the smallest
> possible set of test points for you. But it's a "lossy" compression -
> you don't test everything. And it's extreme: it boils down 10k commit
> events to about 13 bisection events. If anything goes wrong (like the
> bug not being entirely repeatable, or the bug comes and goes), it wil=
l
> give the wrong answer.
>
> The good news is that _usually_ it works really well. And when the
> choice is between "works really well for 10k commits but can have
> problems" and "you need to test all 10k commits", the "can have
> problems" part turns out to be a pretty small downside ;)

In conclusion, I found the problem.  It's a clusterfuck and I think
there's no way that any bisection tool under any sane assumptions
could have found it.  Patch coming in a couple seconds b/c I think it
needs to go in to 2.6.39.

--Andy

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>
