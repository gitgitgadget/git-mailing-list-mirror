From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: import utf16 file properly
Date: Wed, 14 Sep 2011 08:55:36 +0100
Message-ID: <4E705DF8.1040508@diamand.org>
References: <CANeU7QndA0yv1OzU3vta5B8r8nCRdBSqTy0Rboc_bbpst+1pcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Chris Li <git@chrisli.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 09:55:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3kJw-0004XO-PH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 09:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab1INHzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 03:55:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37137 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab1INHzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 03:55:41 -0400
Received: by wwf22 with SMTP id 22so1857879wwf.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 00:55:40 -0700 (PDT)
Received: by 10.227.154.140 with SMTP id o12mr4473662wbw.104.1315986940214;
        Wed, 14 Sep 2011 00:55:40 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id o16sm3124529wba.12.2011.09.14.00.55.37
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 00:55:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
In-Reply-To: <CANeU7QndA0yv1OzU3vta5B8r8nCRdBSqTy0Rboc_bbpst+1pcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181342>

On 13/09/11 22:33, Chris Li wrote:
> The current git-p4 does not handle utf16 files properly.
> The "p4 print" command, when output to stdout, converts the
> utf16 file into utf8. That effectively imported the utf16 file
> as utf8 for git. In other words, git-p4 import a different
> file compare to file check out by perforce. This breakes my
> windows build in the company project.
>
> The fix is simple, just ask perforce to print the depot
> file into a real file. This way perforce will not performe
> the utf16 to utf8 conversion. Git can import the exact same
> file as perforce checkout.

Does this change do the right thing with RCS keywords in UTF16 files?

If p4CmdList() fails, e.g. due to running out of diskspace, will this 
just happily import a truncated/corrupt file?

(And I could be wrong about this, but does you patch have newline 
damage? It didn't seem to apply for me).

Regards!
Luke

> ---
>   contrib/fast-import/git-p4 |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 6b9de9e..5fb1ac7 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1239,6 +1239,11 @@ class P4Sync(Command, P4UserMap):
>               contents = map(lambda text:
> re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text), contents)
>           elif file['type'] in ('text+k', 'ktext', 'kxtext',
> 'unicode+k', 'binary+k'):
>               contents = map(lambda text:
> re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$',r'$\1$',
> text), contents)
> +        elif file['type'] == 'utf16':
> +             tmpFile = tempfile.NamedTemporaryFile()
> +             p4CmdList("print -o %s %s"%(tmpFile.name, file['depotFile']))
> +             contents = [ open(tmpFile.name).read() ]
> +             tmpFile.close()
>
>           self.gitStream.write("M %s inline %s\n" % (mode, relPath))
>
