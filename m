From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 11:13:52 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712121106400.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>  <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>  <alpine.LFD.0.99999.0712102231570.555@xanadu.home>  <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>  <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>  <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>  <alpine.LFD.0.99999.0712110832251.555@xanadu.home>  <alpine.LFD.0.99999.0712110951070.555@xanadu.home>  <alpine.LFD.0.99999.0712111117440.555@xanadu.home>  <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>  <alpine.LFD.0.99999.0712112057390.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org,  Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: gcc-return-142935-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 17:14:43 2007
Return-path: <gcc-return-142935-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2UEM-0006eA-QF
	for gcc@gmane.org; Wed, 12 Dec 2007 17:14:43 +0100
Received: (qmail 25507 invoked by alias); 12 Dec 2007 16:14:23 -0000
Received: (qmail 25498 invoked by uid 22791); 12 Dec 2007 16:14:23 -0000
X-Spam-Check-By: sourceware.org
Received: from relais.videotron.ca (HELO relais.videotron.ca) (24.201.245.36)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 16:14:14 +0000
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca  (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))  with ESMTP id <0JSY000MH2F5AVA0@VL-MH-MR002.ip.videotron.ca> for  gcc@gcc.gnu.org; Wed, 12 Dec 2007 11:13:53 -0500 (EST)
In-reply-to: <alpine.LFD.0.99999.0712112057390.555@xanadu.home>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68062>

On Wed, 12 Dec 2007, Nicolas Pitre wrote:

> I did modify the progress display to show accounted memory that was 
> allocated vs memory that was freed but still not released to the system.  
> At least that gives you an idea of memory allocation and fragmentation 
> with glibc in real time:
> 
> diff --git a/progress.c b/progress.c
> index d19f80c..46ac9ef 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <malloc.h>
>  #include "git-compat-util.h"
>  #include "progress.h"
>  
> @@ -94,10 +95,12 @@ static int display(struct progress *progress, unsigned n, const char *done)
>  	if (progress->total) {
>  		unsigned percent = n * 100 / progress->total;
>  		if (percent != progress->last_percent || progress_update) {
> +			struct mallinfo m = mallinfo();
>  			progress->last_percent = percent;
> -			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
> -				progress->title, percent, n,
> -				progress->total, tp, eol);
> +			fprintf(stderr, "%s: %3u%% (%u/%u) %u/%uMB%s%s",
> +				progress->title, percent, n, progress->total,
> +				m.uordblks >> 18, m.fordblks >> 18,
> +				tp, eol);

Note: I didn't know what unit of memory those blocks represents, so the 
shift is most probably wrong.


Nicolas
