From: Andrew Myrick <amyrick@apple.com>
Subject: Re: git-svn: handling merge-base failures
Date: Wed, 23 Dec 2009 12:18:08 -0800
Message-ID: <940F72F6-8FE5-42AE-84A1-8C4A77B57188@apple.com>
References: <931B0483-7628-488E-BB9F-C40346353149@apple.com> <20091223200936.GA13735@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v1130)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:18:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNXez-0002aI-Sf
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 21:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbZLWUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbZLWUSL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 15:18:11 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:63013 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbZLWUSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2009 15:18:10 -0500
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out4.apple.com (Postfix) with ESMTP id E9929838D785;
	Wed, 23 Dec 2009 12:18:08 -0800 (PST)
X-AuditID: 11807136-b7bafae000000e8d-20-4b327b005ae4
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay15.apple.com (Apple SCV relay) with SMTP id D3.B2.03725.00B723B4; Wed, 23 Dec 2009 12:18:08 -0800 (PST)
In-Reply-To: <20091223200936.GA13735@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1130)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135634>


On Dec 23, 2009, at 12:09 PM, Eric Wong wrote:

> Andrew Myrick <amyrick@apple.com> wrote:
>> One of my projects is failing to clone because merge-base is failing
>> on one of the revisions; the branch is a partial branch, so merge-base
>> can't find a common ancestor with trunk.  I'd like to catch the
>> exception that command_oneline should throw when merge-base fails, but
>> my perl is very rusty and I'm struggling to get git-svn.perl to grok
>> the Git::Error::Command class.  What is the appropriate way to import
>> that class?  Or more generally, is there a better solution to handling
>> this error case?
> 
> Hi Andrew,
> 
> Git::Error::Command should be imported with the rest of Git.pm
> 
> It's a special way of doing exceptions in Perl which I don't see much
> point of...  Looking at git-send-email as an example, it does this:
> 
> 	use Error qw(:try);
> 	use Git;
> 
> 	try {
> 		# something that will throw
> 	} catch Git::Error::Command with {
> 		# error handling
> 	}

I looked at git-send-email's example, but I wanted to do a bit more:
	
	try {
		# command_oneline(...);
	} catch Git::Error::Command with {
		$E = shift;
		if ($E->value() == 1) {
			# do something
		} else {
			# do something else
		}
	}
	
This is used in perl/Git.pm, but when I tried it in git-svn.perl, it fails with the error "Can't locate object method 'value' via package 'Git::SVN'".

> 
> A more standard approach in Perl is just:
> 
> 	eval {
> 		# something that will die
> 	};
> 	if ($@) {
> 		# error handling
> 	}
> 

Presumably $@ contains the Git::Error::Command object, which leaves me in the same spot, unfortunately.

> But yes, it is Perl after all and TMTOWTDI :)

Is there ever :)

-Andrew
