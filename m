From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Sat, 16 May 2009 09:14:49 +0200
Message-ID: <4A0E67E9.3020208@op5.se>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>	<op.utwdsutn1e62zd@merlin.emma.line.org>	<7v8wl01iev.fsf@alter.siamese.dyndns.org>	<op.utwyczlf1e62zd@merlin.emma.line.org>	<20090514182249.GA11919@sigill.intra.peff.net>	<op.utxydvnu1e62zd@merlin.emma.line.org>	<20090515020206.GA12451@coredump.intra.peff.net>	<op.uty0pjb51e62zd@balu> <m34ovmlcve.fsf@localhost.localdomain>	<4A0D8211.5010806@viscovery.net>	<81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>	<4A0D9696.1040805@op5.se> <7v3ab6uuw4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 09:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5E6o-0001Ts-5D
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 09:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbZEPHOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 03:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbZEPHOx
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 03:14:53 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43866 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbZEPHOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 03:14:52 -0400
Received: by fxm2 with SMTP id 2so2297522fxm.37
        for <git@vger.kernel.org>; Sat, 16 May 2009 00:14:51 -0700 (PDT)
Received: by 10.86.65.9 with SMTP id n9mr4513951fga.47.1242458091908;
        Sat, 16 May 2009 00:14:51 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id e11sm704532fga.26.2009.05.16.00.14.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 00:14:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7v3ab6uuw4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119339>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Is it? Does it really make sense to have a tag named "foo" point to a tag object
>> that in turn points to a tag object without a tag ref? I mean, if you're signing
>> a tag, it makes sense to want to keep the original tag around so people can
>> reference it. If you want to *replace* a tag, it doesn't make sense to create
>> this chain which, iiuc, goes something like this:
>>
>>   tag ref -> tag object -> tag object without ref -> something
>>
>> Honestly, I can see how this turned out to be confusing, as you end up with a
>> tag object without a tag, but a new tag in its place. Not to mention that the
>> new tag won't be push-able without --force in case the old tag was pushed earlier.
> 
> Suppose the gpg key used to sign v1.6.3 somehow gets compromised, and I
> come up with a new gpg key.  I could reassure people that the commit the
> old v1.6.3 tagged is genuine if I re-tag with the new key like this:
> 
> 	git tag -f v1.6.3 v1.6.3^{commit}
> 
> But what should I do if I would want to reassure people that both the old
> v1.6.3 was tagged by _me_ (with the old key that later was compromised)
> and that the commit that old tag tags is genuine?
> 

Add a tag with a new name, pointing to the original tag. Try doing what
Matthias did and then run "git show $tagname". It won't show the original
tag at all, so people have to resort to low-level commands in order to
see it, but it will still exist as an object.

The main point though is that re-creating a ref with different content
adds major headaches when distributing it. People who have the old tag
and fetches from a new repo won't get the new tag stored in a ref. If
the object is transferred, it will be garbage-collected.

So let's examine the scenario you described, with your gpg key being
compromised.

You re-create all your tag refs with same-name tags that point to the
old tags.
Joe Dev fetches from you, but your tags do not get stored as refs.
Joe Dev publishes a repo somewhere with a bunch of topic-branches and
requests you merge from those repositories.
You fetch from Joe.

Now we have two opposite problems.
If tags aren't updated when Joe Dev fetches from you, his refs will
not match yours when you fetch from him, and anyone cloning from him
even after the re-sign will never get the new tags at all.
If tag refs *do* get updated when fetching from a repo when we already
have another tag ref with the same name, you fetching from Joe Dev
could undo all your re-created tags and make the new tag-objects
garbage-collectable. This assumes Joe Dev published his repo before
fetching your new tags though.

Perhaps I'm missing something. It's 9AM here and I woke up ten minutes
ago, but it seems to me that what will happen and what should happen
is not entirely clear when one creates tag refs that already exist and
are published.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
