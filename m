From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd number of elements in anonymous hash
Date: Thu, 10 Jan 2008 12:08:52 -0800
Message-ID: <7v63y178a3.fsf@gitster.siamese.dyndns.org>
References: <200801081738.56624.devurandom@gmx.net>
	<20080110083846.GA15047@soma> <200801101204.58300.devurandom@gmx.net>
	<200801101813.45938.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 21:09:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD3iW-0002yW-5G
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 21:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYAJUJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 15:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbYAJUJE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 15:09:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYAJUJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 15:09:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F45B4335;
	Thu, 10 Jan 2008 15:08:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C2804334;
	Thu, 10 Jan 2008 15:08:54 -0500 (EST)
In-Reply-To: <200801101813.45938.devurandom@gmx.net> (Dennis Schridde's
	message of "Thu, 10 Jan 2008 18:13:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70081>

Dennis Schridde <devurandom@gmx.net> writes:

>> [svn-remote "svn"]
>>     reposRoot = file:///var/svn/warzone2100
>>     uuid = 4a71c877-e1ca-e34f-864e-861f7616d084
>>     branches-maxRev = 14
>>     tags-maxRev = 14
>>     svnsync-uuid = 4a71c877-e1ca-e34f-864e-861f7616d084\n
>>     svnsync-url = http://svn.gna.org/svn/warzone
>> [svn-remote "tags/1.10a.12"]
>>     reposRoot = file:///var/svn/warzone2100
>>     uuid = 4a71c877-e1ca-e34f-864e-861f7616d084
>> ---
> The rest of the file is rather boring. The "svn" remote is not changed 
> (besides having higher revisions) and the other remotes look exactly like 
> the "tags/1.10a.12" one.
>
> Somehow I think that the \n at the end of the svnsync-uuid shouldn't be 
> there... It could be that this is the same linebreak which prevents people 
> from relocating (svn switch --relocate) from svn://svn.gna.org/svn/warzone to 
> http://svn.gna.org/svn/warzone, so that would be a Gna bug.
> However git-svn shouldn't throw any warnings (or even (make perl) crash?) on 
> such occasions, either...
>
> I now got it to run through without a segfault, by compiling an unstriped perl 
> binary with debug symbols (Gentoo: FEATURES=nostrip CFLAGS="... -g").
> Maybe this is a bug in GCC or something...
>
> The "Odd number of elements in anonymous hash" still stays, though.

The code in question is:

	my $svnsync;
	# see if we have it in our config, first:
	eval {
		my $section = "svn-remote.$self->{repo_id}";
		$svnsync = {
		  url => tmp_config('--get', "$section.svnsync-url"),
		  uuid => tmp_config('--get', "$section.svnsync-uuid"),
		}
	};

I think the "Odd number" is an indication that one of the
tmp_config() calls is returning an even number of elements (so
the hash whose ref will be stored in $svnsync ends up having an
odd number of elements), and that is why I initially asked you
about "more than one" svnsync-url.  0 is also an even number,
and it could be that it is not finding any.

How about doing something ugly like this _just for diagnosis_?

	my $svnsync;
	# see if we have it in our config, first:
	eval {
		my $section = "svn-remote.$self->{repo_id}";
		my @u = tmp_config('--get', "$section.svnsync-url");
		my @v = tmp_config('--get', "$section.svnsync-uuid");
		if (@u != 1 || @v != 1) {
                	print STDERR "Oops: <$section> $#u <@u> $#v <@v>\n";
		}
		$svnsync = {
		  url => @u,
		  uuid => @v,
		}
	};
