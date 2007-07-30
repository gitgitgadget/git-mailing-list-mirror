From: Robert Ewald <robert.ewald@nov.com>
Subject: Re: (Resend)[PATCH] git-svn: Translate invalid characters in refname
Date: Mon, 30 Jul 2007 15:33:11 +0200
Organization: Nobody is responsible but me
Message-ID: <f8kpan$t6c$1@sea.gmane.org>
References: <f8k9q5$927$1@sea.gmane.org> <7v6442kxvu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 15:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFVNO-0007S0-57
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 15:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760450AbXG3Ndd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 09:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759060AbXG3Ndc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 09:33:32 -0400
Received: from main.gmane.org ([80.91.229.2]:33868 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756359AbXG3Ndb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 09:33:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFVNE-0007aQ-LU
	for git@vger.kernel.org; Mon, 30 Jul 2007 15:33:24 +0200
Received: from static-213.88.188.4.addr.tdcsong.se ([213.88.188.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 15:33:24 +0200
Received: from robert.ewald by static-213.88.188.4.addr.tdcsong.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 15:33:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: static-213.88.188.4.addr.tdcsong.se
User-Agent: KNode/0.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54231>

Junio C Hamano wrote:

> Robert Ewald <robert.ewald@nov.com> writes:
> 
>> +sub refname {
>> +        my ($refname) = "refs/remotes/$_[0]->{ref_id}" ;
>> +
>> +        # It cannot end with a slash /, we'll throw up on this because
>> +        # SVN can't have directories with a slash in their name, either:
>> +        if ($refname =~ m{/$}) {
>> +                die "ref: '$refname' ends with a trailing slash, this is ",
>> +                    "not permitted by git nor Subversion\n";
>> +        }
>> +
>> +        # It cannot have ASCII control character space, tilde ~, caret ^,
>> +        # colon :, question-mark ?, asterisk *, space, or open bracket [
>> +        # anywhere.
>> +        #
>> +        # Additionally, % must be escaped because it is used for escaping
>> +        # and we want our escaped refname to be reversible
>> +        $refname =~ s{([ \%~\^:\?\*\[\t])}{uc sprintf('%%%02x',ord($1))}eg;
> 
> uc of sprintf()?  You meant "%%%02X"?

You are right. Being a total Perl noob I just took Eric's suggestion from an
earlier post without really understanding everything.

> Other than that, looks sane to me.  I presume that SVN branches
> whose name would be mangled with this patch would not have been
> successfully imported with older git-svn anyway, so this won't
> introduce any regressions?

Now that you mention it, I am not entirely sure. We introduce the % which is
mangled as well. It wasn't mangled before.

I now could think of a case that someone has a git-svn branch with a % in the
name checked out.

When updates are fetched a new branch head would be created. It wouldn't 
destroy anything, but a script might break. On the other hand, the script needs
to be updated anyway. So I am not sure if % should be handled separately.

> Eric?
Yes, Eric, please comment.

-- 
Robert Ewald
