From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Fri, 28 Mar 2014 08:02:56 +0100 (CET)
Message-ID: <20140328.080256.175940793917277461.chriscool@tuxfamily.org>
References: <xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
	<xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
	<20140327223406.GA32434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Mar 28 08:03:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTQp3-00065c-Gx
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 08:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbaC1HDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 03:03:21 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:42342 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751340AbaC1HDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 03:03:21 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id ECEFB66;
	Fri, 28 Mar 2014 08:02:57 +0100 (CET)
In-Reply-To: <20140327223406.GA32434@sigill.intra.peff.net>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245365>

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Thu, 27 Mar 2014 18:34:06 -0400

> On Thu, Mar 27, 2014 at 03:16:48PM -0700, Junio C Hamano wrote:
> 
>> > I wasn't looking at the caller (and I haven't).  I agree that, if
>> > you have to compare case-insensitive user input against known set of
>> > tokens, using strcasecmp() would be saner than making a downcased
>> > copy and the set of known tokens.  I do not know however you want to
>> > compare in a case-insensitive way in your application, though.
>>
>> It appears that one place this "lowercase" is used is to allow
>> rAnDOm casing in the configuration file, e.g.
>> 
>> 	[trailer "Signed-off-by"]
>> 		where = AfTEr
>> 
>> which I find is totally unnecessary.  Do we churn code to accept
>> such a nonsense input in other places?
> 
> I think we are very inconsistent.
> 
> All bool config values allow "tRuE". Ones that take "auto" often use
> strcasecmp (e.g., diff.*.binary). "blame.date" and "help.format" choose
> from a fixed set of tokens, but use strcmp.
> 
> Command line parameters are of course case-sensitive, and tokens used by
> them usually are, too (e.g., the date formats for "blame.date" or also
> the same ones taken by "--date=").
> 
> In general I do not see any reason _not_ to use strcasecmp for config
> values that are matching a fixed set. It's friendlier to the user, the
> extra CPU time is negligible, and the code is no harder to read than a
> strcmp.

I agree with this. I think it would be better to just use strcasecmp()
for all the config values matching a fixed set. It is just much easier
to explain to users how things work this way.

Even if no one ever complained about this on the mailing list, many
users complain that Git is very inconsistent.

> Just looking at the callers in patch 04/12, I think it would be
> better just used strcasecmp instead of making a lowercase copy. Not
> because the copy is wasteful (it is, but it almost certainly doesn't
> matter here), but because avoiding the copy is shorter and easier to
> follow (you don't have to wonder about memory ownership).

Yeah, that's also why I am not very happy to have to change things in
this area.

Thanks,
Christian.
