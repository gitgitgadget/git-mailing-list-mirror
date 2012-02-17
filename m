From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 17 Feb 2012 19:42:14 +0100
Message-ID: <4F3E9F86.3070802@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu> <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 19:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RySlP-0003jk-1K
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 19:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab2BQSma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 13:42:30 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:43514 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2BQSma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 13:42:30 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1HIgFou018148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 Feb 2012 19:42:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190969>

On 09/21/2011 10:17 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> I was thinking of using git attributes to configure a server-side
>> "update" hook that does some basic sanity checking before accepting a
>> push.  I thought I could do something like
>> [...]
>> I see that there is an (undocumented) API involving
>> git_attr_set_direction() that seems to let gitattributes to be read out
>> of the index instead of the working tree.  But I am still confused:
> 
> The words "server side" automatically mean that there should be no working
> tree, and where there is no working tree there should be no index, so the
> direction should not make any difference.  The attributes that are used to
> help whitespace checks should come from project.git/info/attributes in
> such a case [*...*].

I was just alerted by Scott Chacon's blog [1] to the fact that one can
set GIT_INDEX_FILE to an arbitrary filename, thereby causing the index
to be read/written from that file instead of $GIT_DIR/index.  It
occurred to me that this feature, along with the addition of "git
check-attr --cached" in 1.7.8, can be used to give server-side access to
the gitattributes for an arbitrary commit:

    GIT_INDEX_FILE="$(tempfile)"
    export GIT_INDEX_FILE
    git read-tree $COMMIT
    git check-attr --cached attr -- pathname
    ...
    rm "$GIT_INDEX_FILE"

Empirically it seems to work (and it is surprisingly fast).  The use of
a temporary file prevents simultaneous accesses to the repository from
stepping on each other.  This looks like a clean solution to my problem.
 Or is there some hidden pitfall in this approach?

Michael

[1] http://progit.org/2010/04/11/environment.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
