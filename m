From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: quote double-dash in "<commit> --
 <filename>" for AsciiDoc
Date: Tue, 28 Jun 2011 23:15:07 -0500
Message-ID: <20110629041432.GA28690@elie>
References: <20110628171748.GA11485@elie>
 <7vaad1tzve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 06:15:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbmBQ-0005AC-MC
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 06:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984Ab1F2EPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 00:15:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38081 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab1F2EPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 00:15:18 -0400
Received: by iwn6 with SMTP id 6so713461iwn.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4PD6+nEB/jgE52Hy5m9pgXYmf/6dC/DYtEWzTjJJyUk=;
        b=G2rum5/Tn3GmJ3RZ9DbgDpw1HodgpySSkKllJnC9/4/S9a2c6LsLKXkomjs4S8BEJq
         LspTtL/M6SyBA3jb/wcgel8mvcuAC4atxXVBVW/y5D1xzDMwSzN5za8QMOz1rJ1t+qoj
         Vu5ftSxmy9XBFV3P8q6bItgNuFJr8R5mXb7hM=
Received: by 10.42.132.70 with SMTP id c6mr330825ict.349.1309320917180;
        Tue, 28 Jun 2011 21:15:17 -0700 (PDT)
Received: from elie (adsl-69-209-66-254.dsl.chcgil.ameritech.net [69.209.66.254])
        by mx.google.com with ESMTPS id v15sm416504ibh.11.2011.06.28.21.15.13
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 21:15:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaad1tzve.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176433>

Hi,

Junio C Hamano wrote:

> This looks very bad:
> 
>     $ cd $git/share/man
>     $ grep -l '(em ' */*.?
>
> even though we do want em-dash for some hits in the above output.

True.  Based on a glance at /usr/share/man, the patch misses:

 git-submodule.1: "git submodule sync -- A"
 various: git web--browse, git-mergetool--lib, git sh-i18n--envsubst
 rev-list options: history `A--P`

> And
> even worse, there seem to be exceptions to this rule, like ...
>
>> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
>> index ac10cfbb..a516d577 100644
>> --- a/Documentation/git-revert.txt
>> +++ b/Documentation/git-revert.txt
>> @@ -23,7 +23,7 @@ throw away all uncommitted changes in your working directory, you
>>  should see linkgit:git-reset[1], particularly the '--hard' option.  If

Sloppy of me.  For reference, here's the rule from asciidoc.conf.

	# -- Spaced and unspaced em dashes (entity reference &mdash;).
	# Space on both sides is translated to thin space characters.
	(^-- )=&#8212;&#8201;
	(\n-- )|( -- )|( --\n)=&#8201;&#8212;&#8201;
	(\w)--(\w)=\1&#8212;\2
	\\--(?!-)=--

So:

 - "\--" always represents two dashes, unless followed by another
   minus sign.  There is no obvious technical reason to prefer {litdd}
   over \-- or vice versa.

 - options like "--hard" are safe nowadays (though it's equally safe
   to escape them as "\--hard").  Likewise, the trailing "--" in
   "foo--" is left unmolested.

 - before version 8.3.0[*], no unescaped "--" was safe for HTML output.
   They all would be converted to em dashes.

Will prepare a new patch that takes care of the missed spots using \--
except in cases like "git web{litdd}browse", to roughly follow the
existing style.  If someone wants to change those to "git web\--browse"
with a patch on top, I won't mind.

Thanks, both.

Regards,
Jonathan

[*] Quick history:

 - asciidoc 8.4.1
 - [98be31f1] line 1 (^-- ) is added ("Emdash replacement recognized at
   start of block")
 - asciidoc 8.3.5
 - asciidoc 8.3.0
 - [6e71157d] line 3 ((\w)--(\w)) is introduced.  It replaces the
   previous regex (\n|[^-\s\\])--([^-\s]|\n), which had been guarded by
   "ifndef::doctype-manpage" to mitigate the effect of false positives.
 - [46fbb7b7] The overeager pattern ([^\n \\])--([^-\s])=\1&#8212;\2
   guarded by "ifdef::doctype-manpage" is removed, since it has too
   many false positives ("Allow unescaped -- option prefixes in man
   pages (was not working in all situations)")
 - [12032332] Patterns start to capture surrounding whitespace so it
   can be converted to thin space.  In this spirit, the second line
   ((\n-- )|( -- )| --\n)) is introduced, the pattern
   (^|[^-\\])--($|[^-]) guarded by "ifndef::doctype-manpage" changes
   to (\n|[^-\s\\])--([^-\s]|\n), and the pattern (^|\s*[^\S\\])--($|\s+)
   guarded by "ifdef::doctype-manpage" changes to ([^\n \\])--([^-\s]).
 - asciidoc 8.2.7
 - asciidoc 8.2.4
 - asciidoc migrates from svn to mercurial (i.e., beginning of
   history).

Pre-history (from CHANGELOG.txt):

 - asciidoc 7.0.0: "Manpage command names containing dashes (in the
   manpage NAME section) were misinterpreted as the spaced dash
   command name/purpose separator.  Bug report and patch supplied by
   David Greaves"
 - asciidoc 6.0.3: "Spaced and unspaced em dashes are now recognized
   (previously only spaced em dashes were recognized)."
 - asciidoc 5.0.6: "A replacement has been added to `asciidoc.conf` to
   replace inline double dashes with the `&mdash;` entity."
