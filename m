From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sun, 8 Jul 2007 03:00:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080248320.4093@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 04:07:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7MBS-0000Xp-UA
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 04:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbXGHCHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 22:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbXGHCHW
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 22:07:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:44624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754723AbXGHCHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 22:07:21 -0400
Received: (qmail invoked by alias); 08 Jul 2007 02:07:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 08 Jul 2007 04:07:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EXkFBl96EFjYhOVEAIaAxl74/VnEsCQEPrfuOxA
	MflxCb8RUb2REB
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51854>

Hi,

On Sat, 7 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -643,6 +643,20 @@ int threeway_merge(struct cache_entry **stages,
> >  	index = stages[0];
> >  	head = stages[o->head_idx];
> >  
> > +	/*
> > +	 * Special case: do not care about a dir/file conflict, when
> > +	 * the entries have not been touched.
> > +	 * IOW if the ancestors are identical to the remote, and the
> > +	 * index is the same as head, just take head.
> > +	 */
> 
> Suppose paths "A" and "A/B" are involved, and you resolved with
> this logic to have "A" as a blob (so your HEAD does not have
> "A/B").  If the remote adds "A/B", what prevents the resulting
> index to have both "A" and "A/B" resolved at stage #0?

Hmm.

> A logic to do "if it is unchanged on one and changed in another,
> take changed one" already exists in later part of the code; your
> patch just circumvents D/F checks built into threeway_merge for
> this one case, and only because this one case happens to have
> reported.  It doesn't feel right.

Well, for me the code in threeway_merge does not feel right. There is a 
table in technical/trivial-merge.txt (which I not fully understand, since 
nowhere in the table, there is a mention of the index, and nowhere is 
explained what "ALT" is supposed to mean), but threeway_merge only 
references the numbers. The code is not obvious to me.

I spent some hours staring on, and trying to make sense of it. Alas, I am 
an idiot or something, since my brain feels like a mashed potato, and I 
still do not understand the code. For example, it is not apparent to me 
why the variable "head" should be set to NULL, when it was the 
df_conflict_entry.

So yeah, this patch was marked as "PATCH", but the subject line is not 
long enough for the proper prefix, which would have started like 
"[This PATCH works for me, and I do not know how to make it better, since 
I do not understand the code in threeway_merge(), and that does not make 
me happy, but that is the way things are, and maybe someone more 
intelligent than me recognizes what is meant by my little patch, and can 
fix it up, ...]".

> IOW, don't make unpack-trees to make policy decisions on final 
> resolution, unless it is operating under aggressive rule (where the 
> caller explicitly allows it to make more than the "trivial" decisions).  
> The caller (in this case, merge-recursive) should see A at stage #2 with 
> A/B at stages #1 and #3 and decide what to do.

Okay, so you're saying that merge-recursive should use the aggressive 
strategy?

Ciao,
Dscho
