From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Reduce the number of connects when fetching
Date: Mon, 05 Nov 2007 21:03:32 -0800
Message-ID: <7vir4gj78b.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711041614390.7357@iabervon.org>
	<7v1wb4kuoc.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711052150340.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 06:04:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpGbY-0008LR-Sl
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 06:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbXKFFDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 00:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756368AbXKFFDo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 00:03:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60150 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbXKFFDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 00:03:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4CFD02F0;
	Tue,  6 Nov 2007 00:04:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C73978F8EC;
	Tue,  6 Nov 2007 00:04:01 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711052150340.7357@iabervon.org> (Daniel
	Barkalow's message of "Mon, 5 Nov 2007 22:04:49 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63625>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 5 Nov 2007, Junio C Hamano wrote:
>
>> The upload-pack protocol goes "S: here are what I have, C: I
>> want these, C: I have these, S: ok, continue, C: I have these,
>> S: ok, continue, C: I have these, S: ok, I've heard enough, C:
>> done, S: packfile is here", so after packfile generation starts
>> there is nothing further the downloader can say.
>> 
>> Otherwise you would be able to do the tag following using the
>> same connection, but that is unfortunately not a case.
>
> It would be nice if this could continue...

You would need a protocol extension for this, as the protocol
defines all the remainder after the have-ack exchange to be
intended for unpack-objects, not just the data for a single pack
that immediately follows the exchange.  Mysteriously,
unpack-objects even has code to write out the remainder after
the pack data.

The protocol extension would probably need to depend on the
existence of sideband.  Make the sending side signal the end of
the pack data over the sideband after sending a pack, and then
both sides can go back to the "C: I want these too, S: Ok, here
it is" exchange.  You may optionally want to do another have-ack
exchange here, but for the purpose of tag following I suspect
there is no need for that.
