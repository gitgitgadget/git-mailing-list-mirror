From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Tue, 08 Aug 2006 00:15:05 +0200
Organization: At home
Message-ID: <eb8e12$2aa$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org> <7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 08 00:15:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GADNm-0005PF-0h
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 00:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWHGWPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 18:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWHGWPa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 18:15:30 -0400
Received: from main.gmane.org ([80.91.229.2]:5347 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932138AbWHGWP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 18:15:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GADNT-0005Lf-Hc
	for git@vger.kernel.org; Tue, 08 Aug 2006 00:15:15 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 00:15:15 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 00:15:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25046>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes: 

>> What is also important is the fast that git_read_* functions are fast,
>> with exception of git_read_info_refs...
> 
> Hmph.  readdir-refs is quite bad for future compatibility, so is
> read_hash.

Fast = doesn't call git commands, so no delay for fork+exec.

> If you want _fast_ then make the implementation fast (or leave
> room to make it fast later); encoding the fastness assumption in
> the name IS WRONG.

Matthias Lederhofer has noticed that parsing all the tags in "summary" and
"tags" views, while we use only epoch/timestamp information to sort them
and discard most of parsed input, is bottleneck due to the fact that
usually number of tags is linear with history (version tags) and the fact
that for each tag is one invocation of git (one fork, two execs).

> For example, sub git_get_hash (not git_read_hash) can stay as
> (potentially buggy wrt symrefs) "reading from .git/refs/$thing"
> or could even be fixed to read from git-rev-parse (which is the
> kosher way).  If it turns out to be a bottleneck, it could be
> rewritten using Git.xs.  The same thing for read_refs which I
> think should be doing ls-remote on the repository if it wants to
> be kosher.

True. So _read_ based on actually reading the files is out.
git_get_hash_by_ref, git_get_HEAD_hash (or just git_get_ref, git_get_head)
return single scalar value; git_read_info_refs and git_read_refs return
reference to hash or array, while git_read_projects returns array.

So the new guidelines would be:
* git_get_ prefix for subroutines related to git repository
  and returning single scalar (single value).
* git_read_ prefix for subroutines related to git repository, reading some
  files or multiline output, and returning hash reference, or list
  reference, or list.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
