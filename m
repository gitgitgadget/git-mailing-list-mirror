From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv3] git-p4: add initial support for RCS keywords
Date: Tue, 21 Feb 2012 07:18:34 -0500
Message-ID: <20120221121834.GB18317@padd.com>
References: <1329258835-17223-1-git-send-email-luke@diamand.org>
 <1329258835-17223-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Scouten <eric@scouten.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Feb 21 13:18:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzog9-0001DT-PR
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 13:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab2BUMSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 07:18:40 -0500
Received: from honk.padd.com ([74.3.171.149]:39568 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab2BUMSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 07:18:39 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 05B4E3A7D;
	Tue, 21 Feb 2012 04:18:39 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D4A8031481; Tue, 21 Feb 2012 07:18:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1329258835-17223-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191152>

luke@diamand.org wrote on Tue, 14 Feb 2012 22:33 +0000:
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
[..]
> +git-p4.attemptRCSCleanup:
> +    If enabled, 'git p4 submit' will attempt to sort cleanup RCS keywords
> +    ($Header$, etc). These would otherwise cause merge conflicts and prevent
> +    the submit going ahead. This option should be considered experimental at
> +    present.

=> "attempt to cleanup"

> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
[..]
> +#
> +# return the raw p4 type of a file (text, text+ko, etc)
> +#
> +def p4_type(file):
> +    files = p4_read_pipe_lines(["files", file])
> +    info = files[0]
> +    m = re.search(r'\(([a-z0-9A-Z+]+)\)\s*$', info)
> +    if m:
> +        ret = m.group(1)
> +        if verbose:
> +            print "%s => %s" % (file, ret)
> +        return ret
> +    else:
> +        die("Could not extract file type from '%s'" % info)

p4 fstat -T headType
gives just the type, no need to parse the info string

> +#
> +# Given a type base and modifier, return a regexp matching
> +# the keywords that can be expanded in the file
> +#
> +def p4_keywords_regexp_for_type(base, type_mods):
> +    if base in ("text", "unicode", "binary"):
> +        if "ko" in type_mods:
> +            return r'\$(Id|Header)[^$]*\$'
> +        elif "k" in type_mods:
> +            return r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$'

Still no ":"?  Won't that match too much?

> +    def patchRCSKeywords(self, file, pattern):

Nice, clean.

>      def p4UserForCommit(self,id):
[..]
> +                for line in read_pipe_lines(diffcmd):
> +                    # read diff lines: for each file reported, if it can have
> +                    # keywords expanded, and the diff contains keywords, then
> +                    # try zapping the p4 file.
> +                    m = re.match(r'^diff --git a/(.*)\s+b/(.*)', line)

I'm still sort of iffy on this.  You have editedFiles, and could
just use that directly.  Grepping through the diff won't give you
any more information.

> +                    if pattern:
> +                        print line

Debugging?  Maybe add a leading comment saying why this line.

> @@ -1585,15 +1685,11 @@ class P4Sync(Command, P4UserMap):
>  
>          # Note that we do not try to de-mangle keywords on utf16 files,
>          # even though in theory somebody may want that.
> -        if type_base in ("text", "unicode", "binary"):
> -            if "ko" in type_mods:
> -                text = ''.join(contents)
> -                text = re.sub(r'\$(Id|Header):[^$]*\$', r'$\1$', text)
> -                contents = [ text ]
> -            elif "k" in type_mods:
> -                text = ''.join(contents)
> -                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', text)
> -                contents = [ text ]
> +        pattern = p4_keywords_regexp_for_type(type_base, type_mods)
> +        if pattern:
> +            text = ''.join(contents)
> +            text = re.sub(pattern, r'$\1$', text)
> +            contents = [ text ]

Nice.  Glad you refactored this.

Fix the colon thing at least, then happy to add my Acked-By.

Sorry for the delay.

		-- Pete
