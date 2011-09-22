From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 10:28:30 +0200
Message-ID: <4E7AF1AE.5030005@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu> <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 10:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6ee9-0006ZC-Rl
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 10:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab1IVI2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 04:28:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43712 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1IVI2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 04:28:34 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8M8SU7K013147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 22 Sep 2011 10:28:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181888>

On 09/21/2011 10:17 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> I was thinking of using git attributes to configure a server-side
>> "update" hook that does some basic sanity checking before accepting a
>> push.  I thought I could do something like
>>
>> ~/.gitattributes:
>>     *.c whitespace
>>
>> ~/crappy-vendor-code/.gitattributes:
>>     # This code doesn't conform to our standards; disable check:
>>     *.c -whitespace
>>
>> This would allow fine-grained specification of which checks are applied
>> to which files, and ensure that the hook configuration is kept
>> synchronized with changes to the content.
>
> The words "server side" automatically mean that there should be no working
> tree, and where there is no working tree there should be no index, so the
> direction should not make any difference.  The attributes that are used to
> help whitespace checks should come from project.git/info/attributes in
> such a case [*1*].

Thanks for the reply and for explaining how the index can(not) be used
for this purpose.  But what you propose is not flexible enough for me.
I would like the checking configuration to be *versioned* along with the
code.  For example, suppose my project decides to enforce a rule that
all Python code needs to be indented with spaces.  It might be that not
all of our old code adheres to this rule, and that we only want to clean
up the code in master.  I would like to be able to

1. Implement a new "check-space-indent" option in our update hook, which
is applied to any file that has the "check-space-indent" attribute.  At
first, no files have this attribute, so the new test has no effect.

2. Start cleaning up code in master.  Each time a subdirectory tree is
cleaned up, add a line like

    *.py check-space-indent

in a .gitattributes file at the root of the subdirectory tree.  While
this procedure proceeds incrementally, git ensures that code that has
been cleaned up stays cleaned up.

3. When all code is cleaned up, add the above line to the top-level
.gitattributes file in the master branch.  But if there are some parts
of the code that we don't want to clean up (for example, code acquired
from elsewhere that uses different coding standards), we can turn off
the check for that subdirectory tree.

Note that during this whole process all code passes the update hook,
because we can configure it to ignore problems in code that hasn't been
cleaned up yet.  And even at the end of the procedure, it is still
possible to commit to older branches where tabs are still used for
indentation because they don't use the new attribute.

For this to be possible, I would need to determine the git attributes to
apply to a particular file in a particular commit; something like

    git check-attr check-space-indent $SHA1:path/to/file

This does not seem to be possible today without writing my own code to
crawl and parse the gitattributes files from a particular commit.

>  (1) grab the new commits introduced to the project using rev-list, and
>      invoke "git show --check" on each and every one of them; or

Where does "git show --check" read its gitattributes (i.e.,
"whitespace") from?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
