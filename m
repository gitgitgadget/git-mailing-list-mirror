From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-archimport log entries more consistent
Date: Wed, 29 Aug 2007 21:10:57 -0700
Message-ID: <7vir6xacha.fsf@gitster.siamese.dyndns.org>
References: <617indss2f.fsf@fencepost.gnu.org>
	<7vmyw9af3q.fsf@gitster.siamese.dyndns.org>
	<fc339e4a0708292019s3d4f6914h4f9efe6f1172c380@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Miles Bader" <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 06:11:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQbNA-0000qB-N1
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 06:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXH3ELK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 00:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbXH3ELI
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 00:11:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbXH3ELH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 00:11:07 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9DEE61296BC;
	Thu, 30 Aug 2007 00:11:25 -0400 (EDT)
In-Reply-To: <fc339e4a0708292019s3d4f6914h4f9efe6f1172c380@mail.gmail.com>
	(Miles Bader's message of "Thu, 30 Aug 2007 12:19:00 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56998>

"Miles Bader" <miles@gnu.org> writes:

> On 8/30/07, Junio C Hamano <gitster@pobox.com> wrote:
>> > This patch makes git-archimport generate one blank line as a separator in all
>> > cases.
>>
>> I would not have any problem with what the result of this patch
>> would record in the commits, if it was what it did from the very
>> beginning.  But this is a change in behaviour; I'd like to know
>> if people who use archimport _rely_ on the current behaviour...
>
> Good point, though it seems pretty unlikely -- the most notable thing
> about the old behavior was that the results were inconsistent... :-)

I think the "consistency" is debatable.  If somebody was parsing
them mechanically, the original code did:

     print WRITER $ps->{summary},"\n\n";
-    print WRITER $ps->{message},"\n";
     print WRITER 'git-archimport-id: ',$ps->{id},"\n";

which means the program can read the last line to get id, go
back to find "\n\n" and treat the one before it as summary, and
take the rest which could be empty as message.  That's also
consistent.

After your change, 

     print WRITER $ps->{summary},"\n\n";
+    print WRITER $ps->{message},"\n\n" if ($ps->{message} ne "");
     print WRITER 'git-archimport-id: ',$ps->{id},"\n";

the last line is id, go back to find "\n\n" and use the one
before it as summary, and take the rest as message but (1) if
the message is not empty, it is followed by "\n\n" so the last
"\n" needs to be stripped, (2) otherwise it is not.

I do not think anybody would doubt that the updated one is nicer
to the eye.  That's why I said it would have been nicer if the
message was formatted like that from the beginning.  But I do
not think you can claim it is _more_ consistent.  It just
formats under a rule different from the original.  The issue is
if the "nicer-to-the-eye" outweighs potential breakage the
reformatting can cause to existing parsers, if any.

That's why I wanted to know if people _rely_ on the current
behaviour, because I was hoping that everybody would answer "yes
nicer-to-the-eye is more important and there is no drawback".
