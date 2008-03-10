From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remotes order in "git remote update"
Date: Mon, 10 Mar 2008 12:21:42 -0700
Message-ID: <7v3aqyjsft.fsf@gitster.siamese.dyndns.org>
References: <2008-03-09-11-22-34+trackit+sam@rfc1149.net>
 <7vbq5op4gt.fsf@gitster.siamese.dyndns.org>
 <2008-03-09-12-21-35+trackit+sam@rfc1149.net>
 <alpine.LSU.1.00.0803092148480.3975@racer.site>
 <2008-03-10-09-17-33+trackit+sam@rfc1149.net>
 <alpine.LSU.1.00.0803101212220.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYna0-0004xQ-Ct
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 20:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYCJTVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 15:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbYCJTVz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 15:21:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYCJTVy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 15:21:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 51C1E1FA0;
	Mon, 10 Mar 2008 15:21:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7CB021CFE; Mon, 10 Mar 2008 15:21:49 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803101212220.3975@racer.site> (Johannes
 Schindelin's message of "Mon, 10 Mar 2008 12:13:43 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76751>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 10 Mar 2008, Samuel Tardieu wrote:
>
>> On  9/03, Johannes Schindelin wrote:
>> 
>> | Well, technically this is a regression.
>> | 
>> | If you really want to order your remotes, why not add something like
>> | 
>> | [remotes]
>> | 	default = my-first-remote my-second-remote [...]
>> | 
>> | to the config?  That is what the (recently fixed in builtin-remote) 
>> | remote groups are for...
>> 
>> I could do that, but it means that if I add a new remote, it won't enter 
>> the default group by itself since I defined it explicitely. I think 
>> respecting the order given in the .git/config file when not using a 
>> group doesn't hurt and may help.
>
> Well, since the builtin remote does that, I do not see a reason to change 
> it ;-)  However, I do not see a reason to guarantee that, either.

I think it is a reasonable expectation that, if you have these in the
configuration file (not limited to "remotes" but for a random "a"):

	[a "foo"]
        	x = "frotz"
                x = "xyzzy"
	[a "bar"]
        	x = "nitfol"
                x = "rezrov"

something that _iterates_ over a.*.* would see them in the order of
appearance (foo.frotz, foo.xyzzy, bar.nitfol and then bar.rezrov).

If you need both iterable and also quick lookup (e.g. when there can be
thousands of "foo" and "bar" for a particular "a" and it is common to ask
for "a.$name.x" for random $name), the config reader for "a" needs to
have an implementation that is better than just a naive linear list.
Maybe it can use a hashed table whose entry records the appearance order
in the configuration file, expecting that a look-up is far more common
operation than enumeration, and when somebody asks you to enumerate, you
can create a sorted list on-demand and iterate on that.  The
implementation would be different depending on the expected usage pattern,
but I do not see much to gain for us by reserving the right to enumerate
things in a random order.
