From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 11:23:49 -0700
Message-ID: <7veius6eve.fsf@alter.siamese.dyndns.org>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	<200905121557.18542.Hugo.Mildenberger@namir.de>
	<81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	<200905121900.00625.Hugo.Mildenberger@namir.de>
	<81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	<20090512172452.GA32594@blimp.localdomain>
	<7vws8l7w0d.fsf@alter.siamese.dyndns.org>
	<81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com>
	<alpine.LNX.2.00.0905131109240.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 13 20:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4J95-0000fp-6n
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbZEMSXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbZEMSXu
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:23:50 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53663 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbZEMSXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:23:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513182350.ZZKP17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 May 2009 14:23:50 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id r6Pq1b0024aMwMQ036PqSA; Wed, 13 May 2009 14:23:50 -0400
X-Authority-Analysis: v=1.0 c=1 a=BJd_Gdj20ywA:10 a=nM9qI384qiQA:10
 a=5ercUPtEAAAA:8 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=f3Rth7jaEZOd8ZyAlL0A:9
 a=SkfBkAC1zXeSKoeV16cA:7 a=HH3B_xRAWXUN0lqVoaory20ACzMA:4 a=JM1vJQTMoX0A:10
 a=qIVjreYYsbEA:10 a=MSl-tDqOz04A:10 a=2LJDhUADsX3VRwLD:21
 a=tJsRPpldgeerO_FB:21
X-CM-Score: 0.00
In-Reply-To: <alpine.LNX.2.00.0905131109240.2147@iabervon.org> (Daniel Barkalow's message of "Wed\, 13 May 2009 11\:18\:40 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 13 May 2009, Alex Riesen wrote:
>
>> 2009/5/13 Junio C Hamano <gitster@pobox.com>:
>> > Alex Riesen <raa.lkml@gmail.com> writes:
>> >
>> >> +             for (i = 0; i < url_len; ++i)
>> >> +                     if ('\n' == url[i])
>> >> +                             fputs("\\n", fp);
>> >> +                     else
>> >> +                             fputc(url[i], fp);
>> >> +             fputc('\n', fp);
>> >
>> > This ad-hoc quoting feels _very_ wrong.  Who is on the reading side and
>> > how does it unquote?
>> 
>> git fmt-merge-msg. It does not unquote. The url is purely informational here.
>> OTOH, the \n shouldn't be in url text at all, so treat it as slightly
>> less annoying
>> warning.
>> 
>> > If it is just informational use only, then it might make more sense to
>> > drop this ugly "quoted \n" silently.  I dunno.
>> 
>> That'd mean to loose the information completely. Which is just as bad
>> as putting the LF in the url in the first place.
>
> Looking back at the original message, it looks like the user included a 
> newline in an argument to clone, and the fetch must have stripped it out 
> (or ignored it in some other fashion), because data was retrieved from a 
> repository that doesn't have a newline in its name. Most likely, the 
> newline should just be prohibited in the URL in the config file in the 
> first place, and we shouldn't be able to get to the point of writing a 
> FETCH_HEAD with that value.

Let me attempt to summarize the situation.

 . FETCH_HEAD is a LF terminated sequence of records; each record
   describes the commit object name, if it is meant to be merged, what URL
   and what ref it came from;

 . "git pull" reads from FETCH_HEAD to decide which commit objects to pass
   to underlying "git merge", and "git fmt-merge-msg" reads from
   FETCH_HEAD to decide what message to produce; and

 . "git fetch" allows a URL with an LF in it and fetches from such a URL
   just fine, but "git pull" barfed because "git fmt-patch" noticed.

Because we copy the LF in the URL straight to FETCH_HEAD, it breaks the
file format.  Alex's proposal is to quote it as "\\n" to avoid it (I
suggested stripping it).  Either change will _fix_ the situation in the
sense that the file format will now be correct, "git pull" will extract
the right set of commits (as it does not look at the URL at all when
deciding which records are used for merge), and "git fmt-merge-msg" will
generate correct set of branches and list of incoming commits without
parse errors, even though the user won't be able to cut and paste the URL
it records in its output either way (if stripped, it will be "information
loss", but even if it were quoted, it won't be usable because nobody
unquotes it).

Given all of the above, I think:

 (1) Alex's patch is a good minimum fix to the issue [*1*].  If unfixed,
     people will be able to fetch from but won't be able to pull from a
     URL with a LF in it.

 (2) Even though it seems that we do _support_ fetching from such a URL,
     it is not a good thing.  People may do all sorts of crazy things, and
     this may be one of these crazy things that we _could_ break the
     backward compatibility to avoid innocent mistakes, by forbidding LF
     in URLs.  Nobody could have been using such a URL in real settings
     because of the issue Alex's patch addresses anyway.

 (3) But forbidding or warning will be done by new code.  Is the cost to
     do such a check (implementation and maintenance of the new code)
     justifiable?  Where do we check and when?

So for now, I'd say I take Alex's patch as-is, and do nothing else.

If somebody has a compelling example that this kind of mistake is common
and is hard to figure out why, we can explicitly forbid certain byte
values in the repository URL as a separate step.


[Footnote]

*1* The output is purely informational, and especially its URL field is
not meant to be used as cut-and-paste source by general public anyway
(e.g. you may pull using git over SSH but general public may not have an
SSH access to the repository).  I actually was tempted, when I did the
initial version of fmt-merge-msg, to shorten an overlong URL with
ellipses, even though I didn't.
