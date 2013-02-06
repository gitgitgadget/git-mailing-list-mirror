From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 17:41:01 +0100
Message-ID: <vpqobfxwg2q.fsf@grenoble-inp.fr>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr> <876225o5mj.fsf@lifelogs.com>
	<vpqmwvhxyuj.fsf@grenoble-inp.fr> <87sj59mo2y.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3844-00079s-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 17:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab3BFQlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 11:41:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43900 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532Ab3BFQlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 11:41:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r16GexjV001171
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 17:40:59 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U383R-00041J-Gv; Wed, 06 Feb 2013 17:41:01 +0100
In-Reply-To: <87sj59mo2y.fsf@lifelogs.com> (Ted Zlatanov's message of "Wed, 06
	Feb 2013 10:58:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Feb 2013 17:41:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16GexjV001171
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360773662.49668@Jm8BZx+aeilD72Pi1xeDtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215597>

Ted Zlatanov <tzz@lifelogs.com> writes:

> None of these are a big deal, and Michal said he's working on libifying
> this anyhow:
>
> - making 'fill' a special operation is weird

Well, 'fill' is the only operation that mutates the credential structure
(i.e. the only one for which "git credential" emits an output to be
parsed), so you don't have much choice.

> - anchor the key regex to beginning of line (not strictly necessary)

Right. The greedyness of * ensures correction, but I like explicit
anchors ^...$ too.

> - sort the output tokens (after 'url' is extracted) so the output is consistent and testable

Why not, if you want to use the output of credential_write in tests. But
credential_write is essentially used to talk to "git credential", so the
important information is the content of the hash before credential_write
and after credential_read. They are unordered, but consistent and
testable.

>>> Maybe this can be merged with the netrc credential helper's
>>> read_credential_data_from_stdin() and print_credential_data()?
>
> MM> I don't know about the netrc credential helper, but I guess that's
> MM> another layer. The git-remote-mediawiki code is the code to call the
> MM> credential C API, that in turn may (or may not) call a credential
> MM> helper.
>
> Yup.  But what you call "read" and "write" are, to the credential
> helper, "write" and "read" but it's the same protocol :)  So maybe the
> names should be changed to reflect that, e.g. "query" and "response."

I don't think that would be a better naming. Maybe "serialize" and
"parse" would be better, but "query" would sound like it establishes the
connection and possibly reads the response to me.

> MM> One thing to be careful about: git-remote-mediawiki is currently a
> MM> standalone script, so it can be installed with a plain "cp
> MM> git-remote-mediawiki $somewhere/".  One consequence of libification
> MM> is that it adds a dependency on the library (e.g. Git.pm). We should
> MM> be carefull to keep it easy for the user to install it (e.g. some
> MM> kind of "make install", or update the doc).
>
> I don't know--it's up to the `git-remote-mediawiki' maintainers...

That is, me ;-).

> But I think anywhere you have Git, you also have Git.pm, right?

Yes, but you have to find out where it is installed. Git's Makefile
hardcodes the path to Git.pm at build time, inserting one line in the
perl script:

use lib (split(/:/, $ENV{GITPERLLIB} || "$INSTLIBDIR"));

The same needs to be done for git-remote-mediawiki. As much as possible,
I'd rather avoid copy-pasting from Git's Makefile, so this means
extracting the perl part of Git's Makefile and make it available in
contrib/.

I'll try a patch in this direction.

> Maybe? But then you also have to look at whether Git.pm has the
> functionality you need...

If git-remote-mediawiki is installed from Git's source, I think it's OK
to assume that Git.pm will be up to date, but that would be even better
if we can issue a clean error message when the functions to be called do
not exist.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
