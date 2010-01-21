From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] Test t5560: Fix test when run with dash
Date: Thu, 21 Jan 2010 17:15:42 +0100
Message-ID: <4B587DAE.9030208@alum.mit.edu>
References: <7vfx69hyd5.fsf@alter.siamese.dyndns.org> <4B5027B8.2090507@viscovery.net> <7vljfzz0yd.fsf@alter.siamese.dyndns.org> <201001152017.00121.j6t@kdbg.org> <7v4ommoo4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXziI-00020E-Nv
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab0AUQQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591Ab0AUQQj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:16:39 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:48648 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab0AUQQi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:16:38 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.128] (p4FC1C873.dip.t-dialin.net [79.193.200.115])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0LGFq6A007764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Jan 2010 17:15:54 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <7v4ommoo4p.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137663>

Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>>> Yesterday, I saw rebase--interactive has a few codepaths where "output"
>>> shell function was used with the single-shot export; perhaps they need to
>>> also be fixed.
>> I knew these spots, and they were discussed when that code was introduced. 
>> Before I sent out the mail you were responding to, I tried various ways to 
>> show the failure in rebase--interactive, but it didn't fail...
> 
> It may be the case that the single-shot-ness of these GIT_AUTHOR_NAME
> exports do not matter at all in that program, even though the original
> versions may have been written carefully not to leak the value suitable
> for the current commit to later rounds.
> 
> I think the recent updates from Michael actually depends on the
> distinction not to matter.  For example, do_with_author() in 7756ecf
> (rebase -i: Extract function do_with_author, 2010-01-14) invokes "$@"
> that could be a shell function.

I have to say that I am a little bit over my head here.  I didn't try to
follow the complete data path of the GIT_AUTHOR_* shell variables, nor
do I know exactly what git commands they affect.  I just tried to
locally refactor the code based on my mistaken assumption that shell
functions are treated much like external commands WRT export of shell
variables.

The use of the GIT_AUTHOR_* variables in git-rebase--interactive.sh were
and are a bit peculiar anyway, since the variables are already set
before do_with_author() is invoked, and the values are left to hang
around afterwards.  The do_with_author() function only tries to export
these already-set variables.

So I suppose that the simplest solution is to export these variables
explicitly in do_with_author(), something like this (similar to the
third code block that was replaced by the do_with_author() function):

do_with_author() {
	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
	"$@"
}

But to ensure that this is a correct solution would require verification
that these now-exported variables don't cause unwanted side-effects
during any other external command invocations.  Alternatively, I suppose
that the variables could be exported within a subshell that also invokes
the "$@" command; this subshell could even source the $AUTHOR_SCRIPT
file if it were thought advantageous not to set the GIT_AUTHOR_*
variables in the git-rebase--interactive.sh script at all.

Help would be most appreciated; I probably won't have time to work on
this myself for a week or two.

Michael
