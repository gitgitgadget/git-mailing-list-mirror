From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 6 Dec 2007 08:19:24 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712060803430.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>   <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>  <Pine.LNX.4.64.0712061201580.27959@racer.site> <1196955059.13633.3.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,         Daniel Berlin <dberlin@dberlin.org>,         David Miller <davem@davemloft.net>, ismail@pardus.org.tr,         gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>,         Junio C Hamano <gitster@pobox.com>
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: gcc-return-142749-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 17:20:08 2007
Return-path: <gcc-return-142749-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0JSD-0004YY-NZ
	for gcc@gmane.org; Thu, 06 Dec 2007 17:20:02 +0100
Received: (qmail 7722 invoked by alias); 6 Dec 2007 16:19:43 -0000
Received: (qmail 7711 invoked by uid 22791); 6 Dec 2007 16:19:42 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 16:19:36 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6GJRuT017675 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Thu, 6 Dec 2007 08:19:28 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6GJOhR000879; 	Thu, 6 Dec 2007 08:19:24 -0800
In-Reply-To: <1196955059.13633.3.camel@brick>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67301>



On Thu, 6 Dec 2007, Harvey Harrison wrote:
> 
> 7:41:25elapsed 86%CPU

Heh. And this is why you want to do it exactly *once*, and then just 
export the end result for others ;)

> -r--r--r-- 1 hharrison hharrison 324094684 2007-12-06 07:26 pack-1d46ca030c3d6d6b95ad316deb922be06b167a3d.pack

But yeah, especially if you allow longer delta chains, the end result can 
be much smaller (and what makes the one-time repack more expensive is the 
window size, not the delta chain - you could make the delta chains longer 
with no cost overhead at packing time)

HOWEVER. 

The longer delta chains do make it potentially much more expensive to then 
use old history. So there's a trade-off. And quite frankly, a delta depth 
of 250 is likely going to cause overflows in the delta cache (which is 
only 256 entries in size *and* it's a hash, so it's going to start having 
hash conflicts long before hitting the 250 depth limit).

So when I said "--depth=250 --window=250", I chose those numbers more as 
an example of extremely aggressive packing, and I'm not at all sure that 
the end result is necessarily wonderfully usable. It's going to save disk 
space (and network bandwidth - the delta's will be re-used for the network 
protocol too!), but there are definitely downsides too, and using long 
delta chains may simply not be worth it in practice.

(And some of it might just want to have git tuning, ie if people think 
that long deltas are worth it, we could easily just expand on the delta 
hash, at the cost of some more memory used!)

That said, the good news is that working with *new* history will not be 
affected negatively, and if you want to be _really_ sneaky, there are ways 
to say "create a pack that contains the history up to a version one year 
ago, and be very aggressive about those old versions that we still want to 
have around, but do a separate pack for newer stuff using less aggressive 
parameters"

So this is something that can be tweaked, although we don't really have 
any really nice interfaces for stuff like that (ie the git delta cache 
size is hardcoded in the sources and cannot be set in the config file, and 
the "pack old history more aggressively" involves some manual scripting 
and knowing how "git pack-objects" works rather than any nice simple 
command line switch).

So the thing to take away from this is:
 - git is certainly flexible as hell
 - .. but to get the full power you may need to tweak things
 - .. happily you really only need to have one person to do the tweaking, 
   and the tweaked end results will be available to others that do not 
   need to know/care.

And whether the difference between 320MB and 500MB is worth any really 
involved tweaking (considering the potential downsides), I really don't 
know. Only testing will tell.

			Linus
