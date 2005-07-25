From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Sun, 24 Jul 2005 23:41:40 -0700 (PDT)
Message-ID: <20050725064140.95259.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 08:46:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwwjQ-00062T-Fu
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 08:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVGYGps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 02:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVGYGnu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 02:43:50 -0400
Received: from web26304.mail.ukl.yahoo.com ([217.146.176.15]:50063 "HELO
	web26304.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261604AbVGYGlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 02:41:50 -0400
Received: (qmail 95261 invoked by uid 60001); 25 Jul 2005 06:41:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KP92tbvVi2Aoxvlbkqot4usCIXQF4N476y4Pd9bcTLav6HJEXc9cb2kv+2Dsjzgla/FEZJrzCBuW5pIpgAVkiRBcQ4sGKiqVJRGvXDKIP4g04z9X2r3XeBY4wAP9ES+ccchPw7wj8Qd0cm9ZxFQRTUWWeCjM0h3iHSvOzZcNstw=  ;
Received: from [151.42.103.53] by web26304.mail.ukl.yahoo.com via HTTP; Sun, 24 Jul 2005 23:41:40 PDT
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:


>The list of patterns that is in effect at a given time is
>built and ordered in the following way:
>
> * --exclude=<pattern> and lines read from --exclude-from=<file>
>   come at the beginning of the list of patterns, in the order
>   given on the command line.  Patterns that come from the file
>   specified with --exclude-from are ordered in the same order
>   as they appear in the file.
>
> * When --exclude-per-directory=<name> is specified, upon
>   entering a directory that has such a file, its contents are
>   appended at the end of the current "list of patterns".  They
>   are popped off when leaving the directory.
>

Are really necessary to have both --exclude-from=<file> and 
--exclude-per-directory=<name> ?

Peraphs, if the file name of excluded list is the same for each directory, 
e.g. .gitignore or something similar, instead of --exclude-per-directory
we can use a concept of file validity 'scope' and just use --exclude-from=<file>.
If entering in a directory <file> is found its contents are appended and 
removed when leaving directory. A bad analogy can be with the use of 
recursive Makefile.

>
>A pattern specified on the command line with --exclude or read
>from the file specified with --exclude-from is relative to the
>top of the directory tree.  A pattern read from a file specified
>by --exclude-per-directory is relative to the directory that the
>pattern file appears in.
>

If we use the 'scope' logic we can just prepend path when adding entries
and serach with with FNM_PATHNAME flag.

> - if it does not contain a slash '/', it is a shell glob
>   pattern and used to match against the filename without
>   leading directories (i.e. the same way as the current
>   implementation).
>
> - otherwise, it is a shell glob pattern, suitable for
>   consumption by fnmatch(3) with FNM_PATHNAME flag.  I.e. a
>   slash in the pattern must match a slash in the pathname.
>   "Documentation/*.html" matches "Documentation/git.html" but
>   not "ppc/ppc.html".  As a natural exception, "/*.c" matches
>   "cat-file.c" but not "mozilla-sha1/sha1.c".
>

Same comment as above, if prepending path when adding per 
directory contents we can simplify to always use FNM_PATHNAME flag.

We don't have even to special case base directory global
scope <file> if we use realtive paths so that we prepend its contents 
with ./ and we have what we expect.

I am sorry to not be able to send a patch, better explaining what 
proposed but I am just leaving today and I will be off line
for a couple of weeks.


Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
