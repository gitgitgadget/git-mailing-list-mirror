From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 20:20:23 +0100
Organization: gmx
Message-ID: <4050d800c45aa32eda029a52f3556dcc@www.dscho.org>
References: <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
 <315bf23981813799d16fdd9b533444f3@www.dscho.org>
 <20150123122317.GA12517@peff.net>
 <6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
 <20150123133033.GA27692@peff.net>
 <xmqqwq4dqskp.fsf@gitster.dls.corp.google.com>
 <20150123183737.GA32191@peff.net>
 <321a67762d18795b743b242618950849@www.dscho.org>
 <20150123185558.GC32191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 20:20:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEjmV-0007BK-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 20:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbAWTUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 14:20:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:51784 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbbAWTUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 14:20:31 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MHoC5-1YIIgH4BCP-003eG5; Fri, 23 Jan 2015 20:20:25
 +0100
In-Reply-To: <20150123185558.GC32191@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:ZvAfsIx7mVUqDjbDM8OqXoF1Mnggyu6PwlciTjDB9x9WomsNm2U
 L0xB9Hhe/OdWFALcUbhQ083c2limh2HE2pZb3W0BSiVbghso4kmTKtCFtlwbmi+YmIt6osA
 2YX32rgaV5xfeAZWSs5VHabzaT69si5hgsm+AxK4B20KRqu0I1mWo2H1xTEjACr+6Ne9jMM
 InElgN8ok1mKZSyQS0qKA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262947>

Hi Peff,

On 2015-01-23 19:55, Jeff King wrote:
> On Fri, Jan 23, 2015 at 07:46:36PM +0100, Johannes Schindelin wrote:
> 
>> > ? And then you can spell that first part as assert(), which I suspect
>> > (but did not test) may shut up clang's warnings.
>>
>> To be quite honest, I assumed that Git's source code was
>> assert()-free. But I was wrong! So I'll go with that solution; it is
>> by far the nicest one IMHO.
> 
> OK, here it is as a patch on top of js/fsck-opt. Please feel free to
> squash rather than leaving it separate.
> 
> I tested with clang-3.6, and it seems to make the warning go away.
> 
> -- >8 --
> Subject: [PATCH] fsck_msg_severity: range-check enum with assert()
> 
> An enum is passed into the function, which we use to index a
> fixed-size array. We double-check that the enum is within
> range as a defensive measure. However, there are two
> problems with this:
> 
>   1. If it's not in range, we then use it to index another
>      array of the same size. Which will have the same problem.
>      We should probably die instead, as this condition
>      should not ever happen.
> 
>   2. The bottom end of our range check is tautological
>      according to clang, which generates a warning. Clang is
>      not _wrong_, but the point is that we are trying to be
>      defensive against something that should never happen
>      (i.e., somebody abusing the enum).
> 
> We can solve both by switching to a separate assert().
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fsck.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck.c b/fsck.c
> index 15cb8bd..53c0849 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -107,7 +107,9 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
>  {
>  	int severity;
>  
> -	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> +	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
> +
> +	if (options->msg_severity)
>  		severity = options->msg_severity[msg_id];
>  	else {
>  		severity = msg_id_info[msg_id].severity;

I also ended up with that solution!

Thanks!
Dscho
