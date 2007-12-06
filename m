From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 16:39:02 -0500
Message-ID: <9e4733910712061339n3aef023r22e5b73aac120c8a@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <1196918132.10408.85.camel@brick> 	 <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> 	 <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com> 	 <20071206071503.GA19504@coredump.intra.peff.net> 	 <alpine.LFD.0.99999.0712060915590.555@xanadu.home> 	 <20071206173946.GA10845@sigill.intra.peff.net> 	 <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org> 	 <9e4733910712061055p353775d8wd0321bc9c81297b7@mail.gmail.com> 	 <alpine.LFD.0.99999.0712061403000.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,  	"Jeff King" <peff@peff.net>, "Daniel Berlin" <dberlin@dberlin.org>,  	"Harvey Harrison" <harvey.harrison@gmail.com>,  	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,  	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: gcc-return-142772-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 22:39:31 2007
Return-path: <gcc-return-142772-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0ORO-0000bZ-Ga
	for gcc@gmane.org; Thu, 06 Dec 2007 22:39:31 +0100
Received: (qmail 13302 invoked by alias); 6 Dec 2007 21:39:12 -0000
Received: (qmail 13288 invoked by uid 22791); 6 Dec 2007 21:39:11 -0000
X-Spam-Check-By: sourceware.org
Received: from wa-out-1112.google.com (HELO wa-out-1112.google.com) (209.85.146.182)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 21:39:05 +0000
Received: by wa-out-1112.google.com with SMTP id m16so845093waf         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 13:39:03 -0800 (PST)
Received: by 10.114.75.1 with SMTP id x1mr2065444waa.1196977142807;         Thu, 06 Dec 2007 13:39:02 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 13:39:02 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712061403000.555@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67341>

On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> > When I lasted looked at the code, the problem was in evenly dividing
> > the work. I was using a four core machine and most of the time one
> > core would end up with 3-5x the work of the lightest loaded core.
> > Setting pack.threads up to 20 fixed the problem. With a high number of
> > threads I was able to get a 4hr pack to finished in something like
> > 1:15.
>
> But as far as I know you didn't try my latest incarnation which has been
> available in Git's master branch for a few months already.

I've deleted all my giant packs. Using the kernel pack:
4GB Q6600

Using the current thread pack code I get these results.

The interesting case is the last one. I set it to 15 threads and
monitored with 'top'.
For 0-60% compression I was at 300% CPU, 60-74% was 200% CPU and
74-100% was 100% CPU. It never used all for cores. The only other
things running were top and my desktop. This is the same load
balancing problem I observed earlier. Much more clock time was spent
in the 2/1 core phases than the 3 core one.

Threaded, threads = 5

jonsmirl@terra:/home/linux$ time git repack -a -d -f
Counting objects: 648366, done.
Compressing objects: 100% (647457/647457), done.
Writing objects: 100% (648366/648366), done.
Total 648366 (delta 528994), reused 0 (delta 0)

real    1m31.395s
user    2m59.239s
sys     0m3.048s
jonsmirl@terra:/home/linux$

12 seconds counting
53 seconds compressing
38 seconds writing

Without threads,

jonsmirl@terra:/home/linux$ time git repack -a -d -f
warning: no threads support, ignoring pack.threads
Counting objects: 648366, done.
Compressing objects: 100% (647457/647457), done.
Writing objects: 100% (648366/648366), done.
Total 648366 (delta 528999), reused 0 (delta 0)

real    2m54.849s
user    2m51.267s
sys     0m1.412s
jonsmirl@terra:/home/linux$

Threaded, threads = 5

jonsmirl@terra:/home/linux$ time git repack -a -d -f --depth=250 --window=250
Counting objects: 648366, done.
Compressing objects: 100% (647457/647457), done.
Writing objects: 100% (648366/648366), done.
Total 648366 (delta 539080), reused 0 (delta 0)

real    9m18.032s
user    19m7.484s
sys     0m3.880s
jonsmirl@terra:/home/linux$

jonsmirl@terra:/home/linux/.git/objects/pack$ ls -l
total 182156
-r--r--r-- 1 jonsmirl jonsmirl  15561848 2007-12-06 16:15
pack-f1f8637d2c68eb1c964ec7c1877196c0c7513412.idx
-r--r--r-- 1 jonsmirl jonsmirl 170768761 2007-12-06 16:15
pack-f1f8637d2c68eb1c964ec7c1877196c0c7513412.pack
jonsmirl@terra:/home/linux/.git/objects/pack$

Non-threaded:

jonsmirl@terra:/home/linux$ time git repack -a -d -f --depth=250 --window=250
warning: no threads support, ignoring pack.threads
Counting objects: 648366, done.
Compressing objects: 100% (647457/647457), done.
Writing objects: 100% (648366/648366), done.
Total 648366 (delta 539080), reused 0 (delta 0)

real    18m51.183s
user    18m46.538s
sys     0m1.604s
jonsmirl@terra:/home/linux$


jonsmirl@terra:/home/linux/.git/objects/pack$ ls -l
total 182156
-r--r--r-- 1 jonsmirl jonsmirl  15561848 2007-12-06 15:33
pack-f1f8637d2c68eb1c964ec7c1877196c0c7513412.idx
-r--r--r-- 1 jonsmirl jonsmirl 170768761 2007-12-06 15:33
pack-f1f8637d2c68eb1c964ec7c1877196c0c7513412.pack
jonsmirl@terra:/home/linux/.git/objects/pack$

Threaded, threads = 15

jonsmirl@terra:/home/linux$ time git repack -a -d -f --depth=250 --window=250
Counting objects: 648366, done.
Compressing objects: 100% (647457/647457), done.
Writing objects: 100% (648366/648366), done.
Total 648366 (delta 539080), reused 0 (delta 0)

real    9m18.325s
user    19m14.340s
sys     0m3.996s
jonsmirl@terra:/home/linux$

-- 
Jon Smirl
jonsmirl@gmail.com
