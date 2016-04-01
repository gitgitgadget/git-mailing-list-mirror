From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] clone: respect configured fetch respecs during
 initial fetch
Date: Fri, 01 Apr 2016 02:30:29 +0200
Message-ID: <20160401023029.Horde.xfy5_x25TYi5be_HbswgxWI@webmail.informatik.kit.edu>
References: <20160307153304.GA23010@sigill.intra.peff.net>
 <1459349623-16443-1-git-send-email-szeder@ira.uka.de>
 <xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 02:30:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1almzC-0005jb-7Q
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940AbcDAAaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 20:30:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49909 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753695AbcDAAap convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:30:45 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1almyx-0005Ni-GS; Fri, 01 Apr 2016 02:30:35 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1almyr-00080J-6o; Fri, 01 Apr 2016 02:30:29 +0200
Received: from x4db0ec79.dyn.telefonica.de (x4db0ec79.dyn.telefonica.de
 [77.176.236.121]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 01 Apr 2016 02:30:29 +0200
In-Reply-To: <xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1459470635.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290495>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> Conceptually 'git clone' should behave as if the following commands
>> were run:
>>
>>   git init
>>   git config ... # set default configuration and origin remote
>>   git fetch
>>   git checkout   # unless '--bare' is given
>>
>> However, that initial 'git fetch' behaves differently from any
>> subsequent fetches, because it takes only the default fetch refspec
>> into account and ignores all other fetch refspecs that might have
>> been explicitly specified on the command line (e.g. 'git -c
>> remote.origin.fetch=3D<refspec> clone' or 'git clone -c ...').
>
> Is it really 'git fetch' behaves differently?

Certainly.

> What is missing in the above description is your expected behaviour
> of "git -c var=3Dval clone", and without it we cannot tell if your
> expectation is sane to begin with.

These 'git -c var=3Dval cmd' one-shot configuration parameters exist
during the lifespan of the command.  Therefore, in case of 'git -c
var=3Dval clone' they should exist while all the commands in our
mental model are executed.  IOW, those commands should behave as if
these configuration parameters were specified for them, see below.

> Is the expectation like this?
>
>     git init
>     git config ... # set default configuration and origin remote
>     git config var val # update with what "-c var=3Dval" told us
>     git fetch
>     git checkout   # unless '--bare' is given
>
> or is it something else?

=46or 'git -c var=3Dval clone':

   git -c var=3Dval init
   git -c var=3Dval config ... # though this probably doesn't really
                             # matter, as it is about writing the
                             # configuration, and it gets the
                             # to-be-written variables and values
                             # in the "..." part anyway
   git -c var=3Dval fetch
   git -c var=3Dval checkout

Being one-shot configuration parameters, they shouldn't be written
to the new repository's config file.

'git clone -c var=3Dval' is designed to be different:

   - it does write var=3Dval into the new repository's config file

   - it specifies that var.val "takes effect immediately after the
     repository is initialized, but before the remote history is
     fetched or any files checked out".

Additionally, there may be relevant config variables defined in the
global and system-wide config files, which of course should be
respected by all these commands.

And it all works just fine as described above, even the initial fetch
respects most of the config variables, wherever specified, except for
fetch refspecs which are completely ignored.

> Is "-c var=3Dval" adding to the config variables set by default, or i=
s
> it replacing them?  Does the choice depend on the nature of
> individual variables, and if so what is the criteria?

It's up to the individual command how it treats a particular config
variable: single-valued variables like 'fetch.fsckObjects' should
override (they already do), multi-valued variables like fetch refspecs
should be added.
Running as part of 'git clone' shouldn't matter at all.

This patch only affects how fetch refspecs are handled, the effects of
other config variables are unchanged.

> Are all "-c var=3Dval" update the configuration of the resulting
> repository?  Or are certain "var"s treated as special and placed in
> the config but not other "var"s?  If the latter, what makes these
> certain "var"s special?

In this regard it doesn't matter what 'val=3Dvar' is.  What matters is
how the configuration parameter is specified (i.e. 'git -c var=3Dval
clone' vs. 'git clone -c var=3Dval').

This patch doesn't change anything in this regard.
