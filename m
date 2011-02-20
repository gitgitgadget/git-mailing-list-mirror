From: Jakub Narebski <jnareb@gmail.com>
Subject: [1.8.0] perl/Git.pm: moving away from using Error.pm module
Date: Sun, 20 Feb 2011 23:46:33 +0100
Message-ID: <201102202346.36410.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Alex Riesen <raa.lkml@gmail.com>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 20 23:46:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrI3J-0000A9-LF
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 23:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab1BTWqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 17:46:49 -0500
Received: from mail-bw0-f52.google.com ([209.85.214.52]:60956 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab1BTWqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 17:46:48 -0500
Received: by bwz4 with SMTP id 4so5134511bwz.11
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 14:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:mime-version
         :content-disposition:cc:content-type:content-transfer-encoding
         :message-id;
        bh=RJ/XQ449JqKAVuD2x607ko+Hq8iusY4vfMvAIf8A8G0=;
        b=wPCM1BbRrrDIdft9GtzFz8i1Ce8kE3VRg0aUg/DR96ZVimTpAeF2FC/kNIqaV7zBU9
         Arw4pj87U47H4mxfRiR7Q1GNcZpD83FLFOR7y6HObForLjpCLRCUyhmV8wVHUxR4PBQB
         h5TBifFu9bwomqUxdyxEzGQs0qU8R7PrcJy1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition:cc
         :content-type:content-transfer-encoding:message-id;
        b=OVOnyBu6o9ozQQsXjQIragf0GVC81PfnPNYeqb+27LSA0ZSF1rqhYPSwEOgWVW1gdk
         I6XQczp/BlAYCO8z9vgIhYKoD/hC0IS+UghV0pnKJICHt+25YQRlIwr6SPPzPnjCXA2s
         M5ykXu2b5BvB5uAcyy0UDvIHjQkv7mr6kpbkE=
Received: by 10.204.77.196 with SMTP id h4mr671211bkk.89.1298242006449;
        Sun, 20 Feb 2011 14:46:46 -0800 (PST)
Received: from [192.168.1.13] (abvz77.neoplus.adsl.tpnet.pl [83.8.223.77])
        by mx.google.com with ESMTPS id u23sm3312009bkw.21.2011.02.20.14.46.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 14:46:45 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167435>

Proposal:

Replace use of Error.pm module in Git.pm with either Exception::Class
based error class, or using 'carp'/'croak' from Carp, or both by adding 
an option to set error handler in 'Git' class (like e.g. in 'CHI' 
module on CPAN).

While at it, if we are to require some extra non-core module, instead
of using 'private-<module>.pm', use more standard 'inc/' directory
(i.e. 'inc/<module>.pm').

Also get rid of git_cmd_try - encourage to use TryCatch or Try::Tiny
instead, or even 'eval { ... }' as a way to catch thrown exceptions.


Rationale:

An extract from the Error.pm documentation: 

  Using the "Error" module is *no longer recommended* due to the
  black-magical nature of its syntactic sugar, which often tends to
  break. Its maintainers have stopped actively writing code that uses
  it, and discourage people from doing so.

"SEE ALSO" section therein mentions the following possible replacements:

  See Exception::Class for a different module providing Object-Oriented
  exception handling, along with a convenient syntax for declaring
  hierarchies for them. It doesn't provide Error's syntactic sugar of
  `try { ... }, catch { ... }`, etc. which may be a good thing or a bad
  thing based on what you want. (Because Error's syntactic sugar tends
  to break.)

  Error::Exception aims to combine Error and Exception::Class "with
  correct stringification".

  TryCatch and Try::Tiny are similar in concept to Error.pm only
  providing a syntax that hopefully breaks less.

Unfortunately, neither of those modules is in core (well, neither is 
Error.pm).


Risks:

Out of git commands and helpers implemented in Perl and using Git.pm
module, only git-svn.perl uses 'try_git_cmd' directly.  git-send-email
uses 'eval { ... }' to catch exceptions thrown by ->repository() 
constructor; perhaps other scripts do the same.  There is some risk of 
breaking git with this change...

Third party modules and scripts might have also depend on Git.pm using 
Error.pm... though I wonder how many of Perl scripts use Git instead of 
for example Git::Wrapper or other git-related Perl module from CPAN.


Migration plan:

I don't really have migration plan yet, because  I amnot sure what 
solution  should be implemented.

1. One possible solution would be to just replace Error with 
Exception::Class (or Git::Exception based in this class), and leave 
everything else as close to current state as possible.  Removing 
try_git_cmd would be second step...

2. Another solution would be to use 'on_error' to set error handler,
with support for 'die'/'croak', Error and Exception::Class based 
exceptions, with default to 'croak'.  In this case we wouldn't need any 
extra module, but testing structural exceptions would be harder.
We would have to replace try_git_cmd with eval, or Try::Tiny.

3. Yet another would be to leave Git module as it is now, and create
new modules: Git::Cmd, Git::Repo, Git::Config etc.

-- 
Jakub Narebski
Poland
