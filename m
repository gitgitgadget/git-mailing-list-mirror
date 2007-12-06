From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 13:55:55 -0500
Message-ID: <9e4733910712061055p353775d8wd0321bc9c81297b7@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <20071205.204848.227521641.davem@davemloft.net> 	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	 <1196918132.10408.85.camel@brick> 	 <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> 	 <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com> 	 <20071206071503.GA19504@coredump.intra.peff.net> 	 <alpine.LFD.0.99999.0712060915590.555@xanadu.home> 	 <20071206173946.GA10845@sigill.intra.peff.net> 	 <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Nicolas Pitre" <nico@cam.org>,  	"Daniel Berlin" <dberlin@dberlin.org>,  	"Harvey Harrison" <harvey.harrison@gmail.com>,  	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,  	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: gcc-return-142759-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 19:56:34 2007
Return-path: <gcc-return-142759-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0Ltf-0007Dd-Df
	for gcc@gmane.org; Thu, 06 Dec 2007 19:56:31 +0100
Received: (qmail 10784 invoked by alias); 6 Dec 2007 18:56:13 -0000
Received: (qmail 10772 invoked by uid 22791); 6 Dec 2007 18:56:12 -0000
X-Spam-Check-By: sourceware.org
Received: from wa-out-1112.google.com (HELO wa-out-1112.google.com) (209.85.146.183)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 18:56:01 +0000
Received: by wa-out-1112.google.com with SMTP id m16so740570waf         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 10:55:58 -0800 (PST)
Received: by 10.114.95.1 with SMTP id s1mr862250wab.1196967355495;         Thu, 06 Dec 2007 10:55:55 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 10:55:55 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
Content-Disposition: inline
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67319>

On 12/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 6 Dec 2007, Jeff King wrote:
> >
> > What is really disappointing is that we saved only about 20% of the
> > time. I didn't sit around watching the stages, but my guess is that we
> > spent a long time in the single threaded "writing objects" stage with a
> > thrashing delta cache.
>
> I don't think you spent all that much time writing the objects. That part
> isn't very intensive, it's mostly about the IO.
>
> I suspect you may simply be dominated by memory-throughput issues. The
> delta matching doesn't cache all that well, and using two or more cores
> isn't going to help all that much if they are largely waiting for memory
> (and quite possibly also perhaps fighting each other for a shared cache?
> Is this a Core 2 with the shared L2?)

When I lasted looked at the code, the problem was in evenly dividing
the work. I was using a four core machine and most of the time one
core would end up with 3-5x the work of the lightest loaded core.
Setting pack.threads up to 20 fixed the problem. With a high number of
threads I was able to get a 4hr pack to finished in something like
1:15.

A scheme where each core could work a minute without communicating to
the other cores would be best. It would also be more efficient if the
cores could avoid having sync points between them.

-- 
Jon Smirl
jonsmirl@gmail.com
