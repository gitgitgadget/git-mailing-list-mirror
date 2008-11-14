From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Edit recipient addresses with the --compose flag
Date: Thu, 13 Nov 2008 19:31:39 -0800
Message-ID: <7v7i77f0f8.fsf@gitster.siamese.dyndns.org>
References: <1226544602-1839-1-git-send-email-ian.hilt@gmx.com>
 <7vskpwia91.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0811132013530.6125@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 04:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0pR6-0001hG-ER
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 04:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbYKNDcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 22:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYKNDcL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 22:32:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYKNDcK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 22:32:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B89A57D161;
	Thu, 13 Nov 2008 22:32:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 256FF7D15F; Thu,
 13 Nov 2008 22:31:45 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811132013530.6125@sys-0.hiltweb.site> (Ian
 Hilt's message of "Thu, 13 Nov 2008 21:10:43 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0699318-B1FC-11DD-A370-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100948>

Ian Hilt <ian.hilt@gmx.com> writes:

> On Wed, 12 Nov 2008, Junio C Hamano wrote:
>> Ian Hilt <ian.hilt@gmx.com> writes:
>> 
>> > Sometimes specifying the recipient addresses can be tedious on the
>> > command-line.  This commit allows the user to edit the recipient
>> > addresses in their editor of choice.
>> >
>> > Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
>> > ---
>> > Here's an updated commit with improved regex's from Junio and Francis.
>> 
>> This heavily depends on Pierre's patch, so I am CC'ing him for comments.
>> Until his series settles down, I cannot apply this anyway.
>
> I didn't realize this was such a bad time to submit this patch.

It is not a bad time.  I just won't be able to apply it right away, but
people (like Pierre) who are interested in send-email enhancement can help
improving your patch by reviewing.

>> Why does the user must keep "Cc:" in order for this new code to pick up
>> the list of recipients?  ...
>> 
>>     cc              =       "Cc:" address-list CRLF
>>     bcc             =       "Bcc:" (address-list / [CFWS]) CRLF
>>     address-list    =       (address *("," address)) / obs-addr-list
>
> I think you're mistaken here.  It is entirely possible to delete the Cc
> and Bcc lines with no ill effect.

You have this piece of code

>> > +	if ($c_file =~ /^To:\s*(\S.+?)\s*\nCc:/ism) {
>> > +		@tmp_to = get_recipients($1);
>> > +	}

to pick up the "To: " addressees.  If your user deletes Cc: line, would
that regexp still capture them in @tmp_to?  How?

> determine if $cc is equal to ''.  If it's not, then it will use it.

Ah, somehow I thought C2 you are writing into (message.final) was used as
the final payload, but you are right.  The foreach () loop at the toplevel
reads them and interprets them.

>> I think the parsing code you introduced simply suck.  Why isn't it done as
>> a part of the main loop to read the same file that already exists?
>
> Multiline recipient fields.

So you were trying to handle folded headers after all, I see.

But if you were to go that route, I think you are much better off doing so
by enabling the header folding for all the header lines in the while (<C>)
loop that currently reads one line at a time.

I however hove to wonder why we are not using any canned e-mail header
parser for this part of the code.  Surely there must be a widely used one
that everybody who writes Perl uses???
