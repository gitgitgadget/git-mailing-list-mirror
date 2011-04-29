From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: normalize hostname for password lookup
Date: Fri, 29 Apr 2011 09:33:38 -0700
Message-ID: <7v4o5hxbj1.fsf@alter.siamese.dyndns.org>
References: <ipckgd$krd$2@dough.gmane.org> <m2sjt1xpfj.fsf@igel.home>
 <m2oc3pxkyo.fsf_-_@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcin =?utf-8?Q?Wi=C5=9Bnicki?= <mwisnicki@gmail.com>,
	git@vger.kernel.org, Guy Rouillier <guyr@burntmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:34:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqdj-00019e-M9
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760062Ab1D2Qdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:33:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759837Ab1D2Qdy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:33:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E3D75216;
	Fri, 29 Apr 2011 12:35:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5jIq7y7UfJXoh8b6xMhzDKiPdLk=; b=MaBL1S6bchcG7yp3lUzo
	M7ub7IL0W0BjCDHx7BEZ3GQdQCsj5jZEKtkh3KWeh79z9WQLD3l2xZvuWC8zP59C
	NUCXb7AWcSen3RQv99LwBJQx7U7zZkMYprmULTYY7UzTBZY2BMaWF9TcPgmwx0q/
	L3p1QbQlMs1TI23rTYTNZyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=P2+ENPT/i+9uA1Q1mB1TRtQvMV4A1vO9AEd+Z8Xytcz5JW
	ACOHGQcXX60Z+t0G3Db31gPIZi7Jq1ToLZt61JSCwyWeE2sNXWD48GFLPjHfXfEt
	JqQC42P3+h9Lrc6cDn/QWiY4MYWQ5yDTec3oB80GURZY/1L7+eewnVaP7Mkec=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0DA95212;
	Fri, 29 Apr 2011 12:35:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 80379520B; Fri, 29 Apr 2011
 12:35:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE7BE85A-727E-11E0-9A02-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172469>

Andreas Schwab <schwab@linux-m68k.org> writes:

> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index bbf327f..046fe32 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -249,6 +249,8 @@ sub conn {
>  
>  		# if username is not explicit in CVSROOT, then use current user, as cvs would
>  		$user=(getlogin() || $ENV{'LOGNAME'} || $ENV{'USER'} || "anonymous") unless $user;
> +		# Normalize hostname for lookup in .cvspass
> +		$serv = lc $serv;
>  		my $rr2 = "-";
>  		unless ($port) {
>  			$rr2 = ":pserver:$user\@$serv:$repo";
> @@ -263,6 +265,8 @@ sub conn {
>  				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
>  				while (<H>) {
>  					chomp;
> +					# FIXME: entries without version prefix
> +					# may need to be normalized
>  					s/^\/\d+\s+//;
>  					my ($w,$p) = split(/\s/,$_,2);
>  					if ($w eq $rr or $w eq $rr2) {

If I correctly recall what I found out from cvs's changelog while looking at
http://thread.gmane.org/gmane.comp.version-control.git/163979/focus=167178 
I think the versioned entries are already downcased, so the above,
including the "FIXME", looks correct.

As I wrote in another message in that thread, I think this codepath should
be refactored a bit better so that it can handle subtle differences
between versions and implementations of cvs itself, and also these
versioned entries.  A good first step might be to separate out the body of
the innermost loop we see here that process one entry from the cvspass
file into a helper function.

Can you give an eyeball on the update of 077aac1 (Look for password in
both CVS and CVSNT password files., 2011-02-18) posted by Guy Rouillier
today and help testing it, and put this fix on top that?

Thanks.
