From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 17:44:33 -0500
Message-ID: <9e4733910712061444i64c115e2y94f6212dd7a4ddda@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <alpine.LFD.0.99999.0712060915590.555@xanadu.home> 	 <20071206173946.GA10845@sigill.intra.peff.net> 	 <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org> 	 <9e4733910712061055p353775d8wd0321bc9c81297b7@mail.gmail.com> 	 <alpine.LFD.0.99999.0712061403000.555@xanadu.home> 	 <9e4733910712061339n3aef023r22e5b73aac120c8a@mail.gmail.com> 	 <alpine.LFD.0.99999.0712061645120.555@xanadu.home> 	 <9e4733910712061422w139273c0gf3cfb04c6ba8c509@mail.gmail.com> 	 <alpine.LFD.0.99999.0712061726240.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,  	"Jeff King" <peff@peff.net>, "Daniel Berlin" <dberlin@dberlin.org>,  	"Harvey Harrison" <harvey.harrison@gmail.com>,  	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,  	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: gcc-return-142779-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 23:45:04 2007
Return-path: <gcc-return-142779-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0PSm-0003dJ-VT
	for gcc@gmane.org; Thu, 06 Dec 2007 23:45:01 +0100
Received: (qmail 8684 invoked by alias); 6 Dec 2007 22:44:42 -0000
Received: (qmail 8669 invoked by uid 22791); 6 Dec 2007 22:44:41 -0000
X-Spam-Check-By: sourceware.org
Received: from ro-out-1112.google.com (HELO ro-out-1112.google.com) (72.14.202.176)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 22:44:36 +0000
Received: by ro-out-1112.google.com with SMTP id o35so6816162rog         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 14:44:34 -0800 (PST)
Received: by 10.114.177.1 with SMTP id z1mr1299315wae.1196981073658;         Thu, 06 Dec 2007 14:44:33 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 14:44:33 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712061726240.555@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67351>

On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> > > Well, that's possible with a window 25 times larger than the default.
> >
> > Why did it never use more than three cores?
>
> You have 648366 objects total, and only 647457 of them are subject to
> delta compression.
>
> With a window size of 250 and a default thread segment of window * 1000
> that means only 3 segments will be distributed to threads, hence only 3
> threads with work to do.

One little tweak and the clock time drops from 9.5 to 6 minutes. The
tweak makes all four cores work.

jonsmirl@terra:/home/apps/git$ git diff
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4f44658..e0dd12e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1645,7 +1645,7 @@ static void ll_find_deltas(struct object_entry
**list, unsigned list_size,
        }

        /* this should be auto-tuned somehow */
-       chunk_size = window * 1000;
+       chunk_size = window * 50;

        do {
                unsigned sublist_size = chunk_size;


jonsmirl@terra:/home/linux/.git$ time git repack -a -d -f --depth=250
--window=250
Counting objects: 648366, done.
Compressing objects: 100% (647457/647457), done.
Writing objects: 100% (648366/648366), done.
Total 648366 (delta 539043), reused 0 (delta 0)

real    6m2.109s
user    20m0.491s
sys     0m4.608s
jonsmirl@terra:/home/linux/.git$



>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
