From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd number of elements in anonymous hash
Date: Thu, 10 Jan 2008 13:45:50 -0800
Message-ID: <7vmyrd5p81.fsf@gitster.siamese.dyndns.org>
References: <200801081738.56624.devurandom@gmx.net>
	<200801101813.45938.devurandom@gmx.net>
	<7v63y178a3.fsf@gitster.siamese.dyndns.org>
	<200801102213.04082.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:46:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5ER-0005S8-33
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYAJVqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYAJVqF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:46:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYAJVqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:46:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 94B9A23E6;
	Thu, 10 Jan 2008 16:46:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B18A023E5;
	Thu, 10 Jan 2008 16:45:57 -0500 (EST)
In-Reply-To: <200801102213.04082.devurandom@gmx.net> (Dennis Schridde's
	message of "Thu, 10 Jan 2008 22:13:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70098>

Dennis Schridde <devurandom@gmx.net> writes:

> Am Donnerstag, 10. Januar 2008 21:08:52 schrieb Junio C Hamano:
>> Dennis Schridde <devurandom@gmx.net> writes:
>> >> [svn-remote "svn"]
>> >>     reposRoot = file:///var/svn/warzone2100
>> >>     uuid = 4a71c877-e1ca-e34f-864e-861f7616d084
>> >>     branches-maxRev = 14
>> >>     tags-maxRev = 14
>> >>     svnsync-uuid = 4a71c877-e1ca-e34f-864e-861f7616d084\n
>> >>     svnsync-url = http://svn.gna.org/svn/warzone
>> >> [svn-remote "tags/1.10a.12"]
>> >>     reposRoot = file:///var/svn/warzone2100
>> >>     uuid = 4a71c877-e1ca-e34f-864e-861f7616d084
>> >> ---
>> >
>> > The rest of the file is rather boring. The "svn" remote is not changed
>> > (besides having higher revisions) and the other remotes look exactly like
>> > the "tags/1.10a.12" one.
>> >
>> > Somehow I think that the \n at the end of the svnsync-uuid shouldn't be
>> > there... It could be that this is the same linebreak which prevents
>> > people from relocating (svn switch --relocate) from
>> > svn://svn.gna.org/svn/warzone to http://svn.gna.org/svn/warzone, so that
>> > would be a Gna bug.
>> > However git-svn shouldn't throw any warnings (or even (make perl) crash?)
>> > on such occasions, either...
>> >
>> > I now got it to run through without a segfault, by compiling an unstriped
>> > perl binary with debug symbols (Gentoo: FEATURES=nostrip CFLAGS="...
>> > -g"). Maybe this is a bug in GCC or something...
>> >
>> > The "Odd number of elements in anonymous hash" still stays, though.
>>
>> The code in question is:
>>
>> 	my $svnsync;
>> 	# see if we have it in our config, first:
>> 	eval {
>> 		my $section = "svn-remote.$self->{repo_id}";
>> 		$svnsync = {
>> 		  url => tmp_config('--get', "$section.svnsync-url"),
>> 		  uuid => tmp_config('--get', "$section.svnsync-uuid"),
>> 		}
>> 	};
>>
>> I think the "Odd number" is an indication that one of the
>> tmp_config() calls is returning an even number of elements (so
>> the hash whose ref will be stored in $svnsync ends up having an
>> odd number of elements), and that is why I initially asked you
>> about "more than one" svnsync-url.  0 is also an even number,
>> and it could be that it is not finding any.
>>
>> How about doing something ugly like this _just for diagnosis_?
>>
>> 	my $svnsync;
>> 	# see if we have it in our config, first:
>> 	eval {
>> 		my $section = "svn-remote.$self->{repo_id}";
>> 		my @u = tmp_config('--get', "$section.svnsync-url");
>> 		my @v = tmp_config('--get', "$section.svnsync-uuid");
>> 		if (@u != 1 || @v != 1) {
>>                 	print STDERR "Oops: <$section> $#u <@u> $#v <@v>\n";
>> 		}
>> 		$svnsync = {
>> 		  url => @u,
>> 		  uuid => @v,
>> 		}
>> 	};
> I've created /usr/bin/git-svndbg and changed that part, like you proposed.
> I now get this output. (As it continues to run, there are probably more 
> occassions of the Oops.)
> ---
> Oops: <svn-remote.svn> 0 <http://svn.gna.org/svn/warzone> 1 
> <4a71c877-e1ca-e34f-864e-861f7616d084 >
> Odd number of elements in anonymous hash at /usr/bin/git-svndbg line 1768.
> r13 = ee6d5a48dd5cf1a96ed5217d638f372d2c173d89 (tags/1.10a)
> ---

Exactly.  The trailing newline is taken as a record separator by
tmp_config subroutine.
