From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [RFC] Configuring (future) committags support in gitweb, especially
 bug linking
Date: Thu, 19 Feb 2009 09:08:05 -0800
Message-ID: <499D91F5.6010605@oak.homeunix.org>
References: <200811082007.55045.jnareb@gmail.com> <200811082335.49505.jnareb@gmail.com> <499AD871.8000808@oak.homeunix.org> <200902180438.55081.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Francis Galiegue <fg@one2team.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 18:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaCP8-0007Mf-SW
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 18:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbZBSRIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 12:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZBSRIO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 12:08:14 -0500
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:21619 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752903AbZBSRIN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 12:08:13 -0500
Received: (qmail 89539 invoked from network); 19 Feb 2009 17:08:12 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp116.sbc.mail.sp1.yahoo.com with SMTP; 19 Feb 2009 17:08:11 -0000
X-YMail-OSG: ej3PAQQVM1kq80dUvFRqKVdJuvJGUWcbyzXJmA0ALMw2SghaUk81mEoo_PmrQBPns_5GMBeuXCfig7pPG27qYjb5bXfAwD1S8VSYpMMsYmyoEj51n22N5gsZHqqABQwQ1XxLp5ORhTDoXjoKRMBSBKFwiw_aUpJul_XQ0z_UO_ZA4CFanfWaXG6yoeM-
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LaCNc-0007yK-6r; Thu, 19 Feb 2009 09:08:08 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <200902180438.55081.jnareb@gmail.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110718>

Jakub Narebski wrote:
> On Tue, 17 Feb 2009, Marcel M. Cary wrote:
>
>> I'm interested in cross-linking bug references in commit messages to
>> a bug tracking system.  I started tinkering a couple weeks ago and am
>> finally understanding that committags encompass this functionality.
>> (From the subject line I first understood "tags" to mean git tags
>> rather than commit message munging.)
>
> What would you name this feature, then?

Heh, I'm not sure.  It's like a filter in the unix pipeline sense, but
"commit message filter" sounds to me like some messages might be
rejected.  Most of the drivers markup static text with HTML tags, but
not all of them.  Maybe "commit message embellishment".

Perhaps a more important question is: will people find the feature once
it's implemented?  I think that won't be a problem provided that it's
listed in the gitweb docs like the other configs.

>> Is the committags idea still under active development?
>
> Well, it is in my todo list, rather further on...

Is any code for it published in a repository anywhere?  I see a branch
jn/gitweb-committag merged into master that looks relevant, but it only
has the sha1 regex improvement.

>> Two regexes would make it easier to configure a driver without
>> needing look-ahead and look-behind assertions.  For example, if you
>> want to match non-negative integers but only in the context of a
>> Resolves-bug header:
>>
>>     Resolves-bug: 1234, 1235
>
> [...]
>> I got the two-regex idea from a spec I ran across while evaluating
>> Subversion:
>>
>>
http://guest:@tortoisesvn.tigris.org/svn/tortoisesvn/trunk/doc/issuetrackers.txt
>
> You don't need multiple regexps for that, and in above example it is
> used _single_ regexp; only with more than one catching group.

I'm not sure what exactly you propose.  In the second example in the
bugtraq spec, there are two regexes.  Maybe you mean something like
this, but it breaks with three bugs:

    $ perl -MData::Dumper -wne '
        m/^Resolves-bug: (\d+)(?:, (\d+))*/;
        print Dumper([$1, $2, $3, $4]);
    '
    Resolves-bug: 123
    $VAR1 = [
          '123',
          undef,
          undef,
          undef
        ];
    Resolves-bug: 123, 124
    $VAR1 = [
          '123',
          '124',
          undef,
          undef
        ];
    Resolves-bug: 123, 124, 125
    $VAR1 = [
          '123',
          '125',
          undef,
          undef
        ];

Maybe something like this?  But it's limited to an arbitrary number of
bug matches.  Maybe it's good enough for pratical purposes, but it's
prone to unexpected breakage when the user exceeds the threshold of, in
this case, four bugs.

    /^Resolves-bug: (\d+)(?:, (\d+))?(?:, (\d+))?(?:, (\d+))?/


Marcel
