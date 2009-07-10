From: Tom Lanyon <tom@netspot.com.au>
Subject: Re: [RFC] Git Perl bindings, and OO interface
Date: Fri, 10 Jul 2009 11:38:04 +0930
Message-ID: <E6AB02D1-CF72-4611-91B0-DA524081A2EE@netspot.com.au>
References: <200811270258.50898.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Nadim Khemir <nadim@khemir.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 04:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP5qc-0004As-7x
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 04:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbZGJC2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 22:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZGJC2U
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 22:28:20 -0400
Received: from mail.adl-na.netspot.com.au ([203.30.161.27]:57693 "EHLO
	mail.adl-na.netspot.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183AbZGJC2T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 22:28:19 -0400
X-Greylist: delayed 1211 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2009 22:28:19 EDT
Received: from dhcp-248-44.net.adl-na.netspot.com.au (dhcp-248-44.net.adl-na.netspot.com.au [10.229.248.44])
	(Authenticated sender: tom)
	by mail.adl-na.netspot.com.au (Postfix) with ESMTP id CD0E0960615;
	Fri, 10 Jul 2009 11:38:06 +0930 (CST)
In-Reply-To: <200811270258.50898.jnareb@gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123029>

On 27/11/2008, at 12:28 PM, Jakub Narebski wrote:
> 0. One of points of disagreement between Git.pm and new Git::Repo was
>   using Error module for frontend error handling.  While the
>   explanation in http://www.perl.com/pub/a/2002/11/14/exception.html
>   is compelling, it is not standard Perl technique.  Additionally
>   adding "cmd_git_try { CODE } ERRORMSG" syntactic sugar was not very
>   good idea.
>
>   So the first thing I'd like to discuss: to use Error and try/catch,
>   or not in Perl interface (bindings) to Git?  I would really like to
>   hear from Perl experts / Perl hackers here...


Sorry to bring up an old thread - but there was no further discussion  
on this and I've recently run into some grief with Git.pm.

I'm new to Git, but not new to Perl and recently attempted to perform  
some simple operations over Git repositories from a Perl application  
(it needs to clone, push, checkout, merge and that's about it) and  
found the Error.pm style handling of errors unintuitive and annoying.  
It is currently fairly simple to capture errors into the application  
by wrapping git_cmd_try { CODE } ERROR into an eval {} block but this  
really only provides you with the command's exit status and no  
meaningful error messages to display to your users; not to mention  
it's fairly ugly.

A long standing Perl motto is 'There Is More Than One Way To Do It'  
and the use of Error.pm here forces developers down a specific path  
for error handling - some may like this, some may not, but there's not  
a lot they can do about it. I would suggest that the Perl way for  
Git.pm to handle errors is for its methods to return the standard 1 or  
0 for success or failure and perhaps store some meaningful error  
messages in an accessor or variable. The module should also not die()  
if there's an error - leave this up to the users of the module to  
handle errors how they prefer - if it dies, we must wrap the methods  
in eval{} blocks or handle with $SIG{__DIE__}, making for some messy  
and ugly code.

I would love to be able to:

	my $repo = Git->repository( directory => '/some/repo' )
		or die "Unable to load git repo /some/repo: $Git::errstr";

	$repo->command( 'push', [ 'some-remote' ] )
		or die "Unable to push to origin: $Git::errstr";

... or similar, and have $Git::errstr set to something meaningful like  
the "fatal: 'some-remote': unable to chdir or not a git archive"  
returned by git-push. This also leads into some discussion around git  
commands printing to STDERR when there is no error -- example: if  
everything is fine and up to date, I don't need git-push to tell me  
"Everything up-to-date" in STDERR...

Hope this helps.

Regards,
Tom
