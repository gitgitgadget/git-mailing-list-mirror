X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: StGIT repository not clonable?
Date: Sun, 12 Nov 2006 16:36:40 +0100
Message-ID: <20061112153640.GD7201@pasky.or.cz>
References: <200611110359.kAB3ul02013227@laptop13.inf.utfsm.cl> <20061111123634.GD11224@diana.vm.bytemark.co.uk> <b0943d9e0611111359t994d688w9bc6aae8e9183fd3@mail.gmail.com> <ej5jt1$9tf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 15:37:02 +0000 (UTC)
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ej5jt1$9tf$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31261>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjHO8-00011K-GL for gcvg-git@gmane.org; Sun, 12 Nov
 2006 16:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932928AbWKLPgn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 10:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932931AbWKLPgn
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 10:36:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:13448 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932928AbWKLPgm (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 10:36:42 -0500
Received: (qmail 12800 invoked by uid 2001); 12 Nov 2006 16:36:40 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sat, Nov 11, 2006 at 11:48:04PM CET, Jakub Narebski wrote:
> Catalin Marinas wrote:
> 
> > IIRC, there was some advise in some GIT document
> > or e-mail saying that you shouldn't pack if the export is over a dumb
> > protocol. That's good for people pulling regularly but bad for
> > cloning.
> 
> By the way, does dumb protocols download _whole_ packs only? Or do they
> download parts of packs (curl can do that, I think)?

curl can, but it might very easily get even much more expensive than
downloading the whole patch unless your latency is very small and
bandwidth very tight, which would be quite a unusual situation.

It's true that repacking can hurt dumb protocols - if you repack often,
dumb clients will have to re-fetch the single whole patck with all the
stuff they already have plus the few additional objects they are
missing.

But at least packing once can be a huge improvement and won't hurt the
dumb clients since their problem is with incremental fetches.
Furthermore, if you do just repack, not repack -a, the cost for dumb
protocols is quite small (though it's not optimal packing strategy):

It is not unlikely at all that if you have set of unpacked objects A,
client fetches that, then you create set of objects B and then repack,
creating pack(A \cup B), this pack will still be much smaller than the
set of objects B (even if |A| >> |B|) so it's more beneficial even for
the dumb clients to refetch the A objects contained in the pack, instead
of fetching just the unpacked B objects.

By the way, in case of glibc-cvs the pack sice is 104M, and after
importing new CVS changes after few days, the repository size doubled to
200M.  git-repack -a -d brought that _back_ to 104M!

Packs are a funny thing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
