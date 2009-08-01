From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: How to embed a hash, tag or branch name?
Date: Sat, 01 Aug 2009 14:38:13 +0200
Message-ID: <4A743735.9020806@dirk.my1.cc>
References: <20090731081723.GE29909@nalle> <m3ljm5ryar.fsf@localhost.localdomain> <20090731095238.GG29909@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Sat Aug 01 14:42:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXDue-0003PJ-Un
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 14:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbZHAMmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 08:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbZHAMmE
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 08:42:04 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:41519 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZHAMmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 08:42:03 -0400
Received: from [84.176.93.19] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MXDpa-0002Ci-8P; Sat, 01 Aug 2009 14:36:58 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <20090731095238.GG29909@nalle>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124619>

Am 31.07.2009 11:52 schrieb Mikko Rapeli:
> On Fri, Jul 31, 2009 at 02:27:50AM -0700, Jakub Narebski wrote:
>> You can embed SHA-1 of a _file contents_ (blob) using '$Id: $' keyword
>> with `ident` attribute - see gitattributes manpage.
> 
> Great, thanks!
> 
>> The correct solution of embedding version number is to do it at 
>> _build time_, using e.g. script similar to GIT-VERSION-GEN used by
>> Git itself and by Linux kernel.  It helps if you tag your releases.
> 

Hi Mikko,

I don't know whether you want to use the "ident" command on your final
binary. With Git, that's pointless, as all source files will have the
same $Id$. So it's perfectly sufficient to have only ONE file enriched
with Git's SHA1.

Suggestion: During build time, compile (and link in) a file (e.g.
version.c) with "-DVERSION=\"$(git describe)\"". My version.c looks like
this:

----------------------------------
char const * version()
{
     return VERSION;
}
----------------------------------

The function then returns sth. like "foo12004-26-gc6c9273", which means
that you're 26 commits ahead of the annotated tag "foo12004" and your
commit has SHA1 "c6c9273". Then make your application somehow return
that version string when asked (or deliver a version.txt together with
it). This way you know that your binary was built using commit
"c6c9273". You can further refine the VERSION by adding a "-dirty" if
the working tree was dirty at build time. Then you'll know that your
binary was based on c6c9273 "with some changes".

Make sure that version.c is the ONLY file that compiles with that
-DVERSION switch. Otherwise all files get re-compiled when $(git
describe) changes. That's not what you want.

     HTH, Dirk
