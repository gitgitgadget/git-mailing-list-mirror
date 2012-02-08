From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Wed, 08 Feb 2012 11:00:42 +0100
Message-ID: <4F3247CA.1020904@alum.mit.edu>
References: <4F3120D4.1050604@warmcat.com> <7vvcni1r5u.fsf@alter.siamese.dyndns.org> <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	=?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 11:00:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv4Kg-0003UU-KR
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 11:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab2BHKAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 05:00:53 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46038 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2BHKAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 05:00:52 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q18A0hQs026417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Feb 2012 11:00:44 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190227>

On 02/08/2012 08:33 AM, Junio C Hamano wrote:
> To allow parsing the header produced by versions of Git newer than the
> code written to parse it, all commit parsers are expected to skip unknown
> header lines, so that newer types of header lines can be added safely.
> The only three things that are promised are:
> 
>  (1) the header ends with an empty line (just an LF, not "a blank line"),
>  (2) unknown lines can be skipped, and
>  (3) a header "field" begins with the field name, followed by a single SP
>      followed by the value.
> 
> The parser used by StGit, introduced by commit cbe4567 (New StGit core
> infrastructure: repository operations, 2007-12-19), was accidentally a bit
> too loose to lose information, and a bit too strict to raise exception
> when dealing with a line it does not understand.
> 
>  - It used "strip()" to lose whitespaces from both ends, risking a line
>    with only whitespaces to be mistaken as the end of the header.
> 
>  - It used "k, v = line.split(None, 1)", blindly assuming that all header
>    lines (including the ones that the version of StGit may not understand)
>    can safely be split without raising an exception, which is not true if
>    there is no SP on the line.
> 
> This patch changes the parsing logic so that it:
> 
>  (1) detects end of the hedaer correctly by treating only an empty line as
>      such;
>  (2) handles multi-line fields (a header line that begins with a single SP
>      is appended to the previous line after removing that leading SP but
>      retaining the LF between the line and the previous line) correctly;
>  (3) splits a line at the first SP to find the field name, but only does
>      so when there actually is SP on the line; and
>  (4) ignores lines that cannot be understood without barfing.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Earlier I sent a minimum parser fix that ignores multi-line fields, as
>    the fields StGit cares about are all single line.  This patch also
>    teaches multi-line fields to the parser, so that later versions of
>    StGit can parse and use them if they choose to.
> 
>    Python is not my primary language, so please take this with a grain of
>    salt.
> 
>    Thanks.
> 
>  stgit/lib/git.py |   41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/stgit/lib/git.py b/stgit/lib/git.py
> index 56287f6..f19371b 100644
> --- a/stgit/lib/git.py
> +++ b/stgit/lib/git.py
> @@ -390,21 +390,34 @@ class CommitData(Immutable, Repr):
>          @return: A new L{CommitData} object
>          @rtype: L{CommitData}"""
>          cd = cls(parents = [])
> -        lines = list(s.splitlines(True))
> +        raw_lines = list(s.splitlines(True))

str.splitlines() splits lines at any EOL pattern ('\n', '\r\n' or '\r'
alone).  If you want to be sure to split only on '\n', I think the
simplest alternative is

    raw_lines = s.split('\n')

str.split() and str.splitlines() already return lists, so it is not
necessary to wrap the result in list().

But please note that str.split() discards the split characters, and if
the last character in the string is '\n' then the last string in the
result list is the empty string.

> +        lines = []
> +        # Collapse multi-line header lines
> +        for i in xrange(len(raw_lines)):
> +            line = raw_lines[i]

The two previous lines can be written

           for (i, line) in enumerate(raw_lines):

> +            if line == '\n':
> +                cd.set_message(''.join(raw_lines[i+1:]))
> +                break
> +            if line[0] == ' ':
> +                # continuation line
> +                lines[-1] += '\n' + line[1:]

In your original version, lines[-1] would already be LF-terminated, so
this line would create a double-LF in the string.

> +            else:
> +                lines.append(line)
>          for i in xrange(len(lines)):
> -            line = lines[i].strip()
> -            if not line:
> -                return cd.set_message(''.join(lines[i+1:]))
> -            key, value = line.split(None, 1)
> -            if key == 'tree':
> -                cd = cd.set_tree(repository.get_tree(value))
> -            elif key == 'parent':
> -                cd = cd.add_parent(repository.get_commit(value))
> -            elif key == 'author':
> -                cd = cd.set_author(Person.parse(value))
> -            elif key == 'committer':
> -                cd = cd.set_committer(Person.parse(value))
> -        assert False
> +            line = lines[i].rstrip('\n')
> +            ix = line.find(' ')
> +            if 0 <= ix:
> +                key, value = line[0:ix], line[ix+1:]

The above five lines can be written

           for line in lines:
               if ' ' in line:
                   key, value = line.rstrip('\n').split(' ', 1)

or (if the lack of a space should be treated more like an exception)

           for line in lines:
               try:
                   key, value = line.rstrip('\n').split(' ', 1)
               except ValueError:
                   continue

> +                if key == 'tree':
> +                    cd = cd.set_tree(repository.get_tree(value))
> +                elif key == 'parent':
> +                    cd = cd.add_parent(repository.get_commit(value))
> +                elif key == 'author':
> +                    cd = cd.set_author(Person.parse(value))
> +                elif key == 'committer':
> +                    cd = cd.set_committer(Person.parse(value))

All in all, I would recommend something like (untested):

        @return: A new L{CommitData} object
        @rtype: L{CommitData}"""
        cd = cls(parents = [])
        lines = []
        raw_lines = s.split('\n')
        # Collapse multi-line header lines
        for i, line in enumerate(raw_lines):
            if not line:
                cd.set_message('\n'.join(raw_lines[i+1:]))
                break
            if line.startswith(' '):
                # continuation line
                lines[-1] += '\n' + line[1:]
            else:
                lines.append(line)

        for line in lines:
            if ' ' in line:
                key, value = line.split(' ', 1)
                if key == 'tree':
                    cd = cd.set_tree(repository.get_tree(value))
                elif key == 'parent':
                    cd = cd.add_parent(repository.get_commit(value))
                elif key == 'author':
                    cd = cd.set_author(Person.parse(value))
                elif key == 'committer':
                    cd = cd.set_committer(Person.parse(value))
        return cd

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
