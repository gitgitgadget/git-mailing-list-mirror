From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] cvsserver: change generation of CVS author names
Date: Sun, 4 Jan 2009 12:13:15 +0100
Message-ID: <20090104111245.GA7732@lars.home.noschinski.de>
References: <1230910814-32307-1-git-send-email-fabian.emmes@rwth-aachen.de> <1230910814-32307-2-git-send-email-fabian.emmes@rwth-aachen.de> <7vwsdc3ulg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Fabian Emmes <fabian.emmes@rwth-aachen.de>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 12:14:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJQwb-0007QA-Jb
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 12:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZADLN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 06:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbZADLN1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 06:13:27 -0500
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:48716 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZADLNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 06:13:25 -0500
Received: from [87.78.124.200] (helo=vertikal.home.noschinski.de)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LJQuy-0005Ad-De; Sun, 04 Jan 2009 12:13:16 +0100
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LJQux-0002P9-L7; Sun, 04 Jan 2009 12:13:15 +0100
Content-Disposition: inline
In-Reply-To: <7vwsdc3ulg.fsf@gitster.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104505>

* Junio C Hamano <gitster@pobox.com> [09-01-03 23:36]:
>Fabian Emmes <fabian.emmes@rwth-aachen.de> writes:
>
>> CVS username is generated from local part email address.
>> We take the whole local part but restrict the character set to the
>> Portable Filename Character Set, which is used for Unix login names
>> according to Single Unix Specification v3.
>>
>> Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
>> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
>
>Stating "we should have done this from day one" is one thing (even though
>"because some standard says so" is not particularly a good justification
>without "and matches the way people use CVS in the real world in practice"
>appended to it).

Documentation about valid cvs/rcs usernames is a bit scarce. When we
wrote the patch, we did not find much more information than "the cvs
username is supposed to be the login name". In my limited CVS
experience, I never saw CVS user names which were not (unix) login
names.

After this mail, I looked to the RCS source code (see checkidentifier()
in rcslex.c) which tells us that anything (encoded in ISO-8859-1)
consisting of IDCHAR, LETTER, Letter, DIGIT and PERIOD, containing at
least one IDCHAR, LETTER or Letter is a valid username (for the
character classes, see
http://avalon.hoffentlich.net/~cebewee/rcs-charmap.txt) The most
important character _not_ allowed in an user name is the @ sign, so we
cannot use the full mail address.

So our patch generates a valid username for any "sane" local part. In a
few corner cases like "!#$%&'*+-/=?^_`.{|}~@example.com" our patch
generates a result worse than the original - an empty username. This
is probably something we should fix.

Obviously, the short names generated are not necessarily unique, which
can be irritating, but is not a problem from a technical point of view.
Improving this would probably require to store a map of mail addresses
to cvs user names.

>"We should suddenly change the behaviour" is quite a different thing and
>it depends on what follows that sentence if the change is justifiable.  We
>do not want to hear "...; screw the existing repositories if they have
>nonconforming names.".  It is Ok if it is "...; existing repositories will
>be affected, but the damage is limited to very minor set of operations,
>namely X, Y and Z".
>
>In other words, is there any backward compatibility issue when a
>repository that has served existing CVS users and checkouts with older
>version switches to the patched one?  If there is one, is that grave
>enough that we should care?

Obviously the reported user names change. To the best of my knowledge
(but I'm just a barely experienced CVS user) those names are not stored
anywhere on the client and are regenerated by git-cvsserver for every
request, so even old repositories get the new names for all commits.

   - Lars.
