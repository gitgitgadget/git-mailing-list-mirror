From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 13:04:35 -0500
Message-ID: <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <20071205.202047.58135920.davem@davemloft.net> 	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	 <20071205.204848.227521641.davem@davemloft.net> 	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Miller" <davem@davemloft.net>, ismail@pardus.org.tr, gcc@gcc.gnu.org,  	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: gcc-return-142753-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 19:06:10 2007
Return-path: <gcc-return-142753-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0L6M-0001vN-2I
	for gcc@gmane.org; Thu, 06 Dec 2007 19:05:44 +0100
Received: (qmail 5599 invoked by alias); 6 Dec 2007 18:05:03 -0000
Received: (qmail 5517 invoked by uid 22791); 6 Dec 2007 18:04:48 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.176)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 18:04:39 +0000
Received: by py-out-1112.google.com with SMTP id a29so1016981pyi         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 10:04:37 -0800 (PST)
Received: by 10.142.232.20 with SMTP id e20mr1791098wfh.1196964275958;         Thu, 06 Dec 2007 10:04:35 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Thu, 6 Dec 2007 10:04:35 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
Content-Disposition: inline
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67310>

On 12/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 6 Dec 2007, Daniel Berlin wrote:
> >
> > Actually, it turns out that git-gc --aggressive does this dumb thing
> > to pack files sometimes regardless of whether you converted from an
> > SVN repo or not.
>
> Absolutely. git --aggressive is mostly dumb. It's really only useful for
> the case of "I know I have a *really* bad pack, and I want to throw away
> all the bad packing decisions I have done".
>
> To explain this, it's worth explaining (you are probably aware of it, but
> let me go through the basics anyway) how git delta-chains work, and how
> they are so different from most other systems.
>
I worked on Monotone and other systems that use object stores. for a
little while :)
In particular, I believe GIT's original object store was based on
Monotone, IIRC.

> In other SCM's, a delta-chain is generally fixed. It might be "forwards"
> or "backwards", and it might evolve a bit as you work with the repository,
> but generally it's a chain of changes to a single file represented as some
> kind of single SCM entity. In CVS, it's obviously the *,v file, and a lot
> of other systems do rather similar things.

>
> Git also does delta-chains, but it does them a lot more "loosely". There
> is no fixed entity. Delta's are generated against any random other version
> that git deems to be a good delta candidate (with various fairly
> successful heursitics), and there are absolutely no hard grouping rules.

Sure. SVN actually supports this (surprisingly), it just never happens
to choose delta bases that aren't related by ancestry.  (IE it would
have absolutely no problem with you using random other parts of the
repository as delta bases, and i've played with it before).

I actually advocated we move towards an object store model, as
ancestry can be a  crappy way of approximating similarity when you
have a lot of branches.

> So the equivalent of "git gc --aggressive" - but done *properly* - is to
> do (overnight) something like
>
>         git repack -a -d --depth=250 --window=250
>
I gave this a try overnight, and it definitely helps a lot.
Thanks!

> And then it's going to take forever and a day (ie a "do it overnight"
> thing). But the end result is that everybody downstream from that
> repository will get much better packs, without having to spend any effort
> on it themselves.
>

If your forever and a day is spent figuring out which deltas to use,
you can reduce this significantly.
If it is spent writing out the data, it's much harder. :)
