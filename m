From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] describe: make '--always' fallback work after
 '--exact-match' failed
Date: Fri, 21 Aug 2015 13:40:39 +0200
Message-ID: <20150821134039.Horde.wW7OPRQO28gZidreZRgP7g2@webmail.informatik.kit.edu>
References: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
 <xmqqegix7qjk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 13:40:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSkgo-0007OS-O5
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 13:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbbHULku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 07:40:50 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37516 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752680AbbHULkt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 07:40:49 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZSkgg-00044D-Mi; Fri, 21 Aug 2015 13:40:46 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZSkgZ-00056i-6l; Fri, 21 Aug 2015 13:40:39 +0200
Received: from x4db19803.dyn.telefonica.de (x4db19803.dyn.telefonica.de
 [77.177.152.3]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 21 Aug 2015 13:40:39 +0200
In-Reply-To: <xmqqegix7qjk.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1440157246.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276284>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> 'git describe [...] --always' should always show the unique abbrevia=
ted
>> object name as a fallback when the given commit cannot be described =
with
>> the given set of options, see da2478dbb0 (describe --always: fall ba=
ck
>> to showing an abbreviated object name, 2008-03-02).
>>
>> However, this is not the case when the combination '--exact-match
>> --always' is given and the commit cannot be described, because in su=
ch
>> cases 'git describe' errors out, as if '--always' were not given at =
all.
>>
>> Respect '--always' and print the unique abbreviated object name inst=
ead
>> of erroring out when the commit cannot be described with '--exact-ma=
tch
>> --always'.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>
> Well, that can be argued both ways.  Your patch introduces a
> regression, as "--exact-match" is an instruction to error out when
> no tag exactly matches, and you deliberately break that.

This patch doesn't break '--exact-match', in fact doesn't modify it at =
all
when it's on its own or combined with other options, but it makes
'--exact-match --always' finally work.

'git describe' errors out by default if it can't describe the given
commit.  So if a user wants an exact match or an error otherwise, then =
he
should not give '--always' at all, because that's the instruction to no=
t
error out but give the abbreviated object name instead.

Why should '--exact-match' be any different from the other options that
tell 'git describe' what to use for the description?  Why should
'--always' not work with '--exact-match', when it works in the other
cases?

Consider '--contains': it should find a tag that comes after the given
commit or error out if such a tag doesn't exist.  Now, in current git.g=
it:

   $ git describe --contains master
   fatal: cannot describe 'ff86faf2fa02bc21933c9e1dcc75c8d81b3e104a'
   $ git describe --contains --always master
   ff86faf2fa

Or the default behavior without any options: it should find a tag
reachable from the given commit or error out, but what if we pass in a
commit before the first tag?  It recommends '--always':

   $ git describe e83c516
   fatal: No tags can describe 'e83c5163316f89bfbde7d9ab23ca2e25604af29=
0'.
   Try --always, or create some tags.
   $ git describe --always e83c516
   e83c516331


> My knee-jerk reaction is that the most sensible way forward is to
> make --exact-match and --always mutually incompatible.

That would be wrong, it's perfectly valid to ask for an exactly matchin=
g
tag or, if there is no such tag, the abbreviated object name as a
fallback.
