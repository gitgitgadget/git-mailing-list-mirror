From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH, 2nd version] git-archimport: allow remapping branch names
Date: Wed, 07 Mar 2007 10:06:56 +0100
Message-ID: <45EE80B0.8010403@lu.unisi.ch>
References: <eslrcr$9rc$1@sea.gmane.org>	<7vodn5iiew.fsf@assigned-by-dhcp.cox.net>	<45EE7442.6030308@lu.unisi.ch> <7vlki9h1mg.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 10:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOs7A-0003dZ-Ax
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 10:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030788AbXCGJHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 04:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbXCGJHI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 04:07:08 -0500
Received: from server.usilu.net ([195.176.178.200]:32616 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030788AbXCGJHF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 04:07:05 -0500
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Mar 2007 10:07:02 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vlki9h1mg.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 07 Mar 2007 09:07:02.0410 (UTC) FILETIME=[F8380EA0:01C76097]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41659>


> Just to make sure.  Was it tested with AND WITHOUT the new colon
> feature?  I am asking how likely is there a regression.

Yes.  But my Arch repositories do not have colons in the name (I mean I tested on real-world repositories and not weird ones created exactly to make the patch fail).

>> -my %arch_branches = map { $_ => 1 } @ARGV;
>> +my %arch_branches = map { my $branch = $_; $branch =~ s/:.*//; $branch => 1 } @ARGV;

In fact, I was too headlong on your suggestion.  I should have noticed that this substitution must be changed to

$branch =~ s/:[^:]*$//

I just realized, however, that branches with colons in the names would have failed before my patch too, because git would have failed creating a branch with a colon in it.  So this is not a regression, strictly speaking.

> Strictly speaking (-e "$git_dir/refs/heads/$branch") test would
> not work if the repository was pack-ref'ed with --all option.
> Run "git show-ref -q --verify refs/heads/$branch" and check its
> exit status, or run it without -q and read its output.

Unfortunately this is pervasive in git-archimport.  I can fix it, but I think it belongs in a separate patch.

> With the original code, a tag "t--a/g" was mapped to "t--a,g" in
> the else clause, but the new code yields git_branchname("t--a/g")
> followed by '--' followed by "g", which would evaluate to I do
> not know what exactly, but I am sure it would not evaluate to
> "t--a,g".  Would it be a non-issue?  As archimport seems to support
> incremental import, I suspect it might upset existing users.

In this case, this input will always be of the form t--a/g--REVISION.

So the old one would change to t--a,g--REVISION; the new one would
strip to t--a/g and convert it to t--a,g (using git_default_branchname)
and file tack --REVISION at the end again.

I will shortly send an updated patch

Paolo
