From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: import determinism
Date: Thu, 11 Nov 2010 05:28:00 +0100
Message-ID: <4CDB70D0.6000405@alum.mit.edu>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com> <m2lj54u9uj.fsf@igel.home> <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com> <m2d3qgu50c.fsf@igel.home> <20101109134337.GA19430@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 05:28:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGOlj-0001fp-UC
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 05:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464Ab0KKE2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 23:28:04 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:49290 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340Ab0KKE2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 23:28:03 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BECA85.dip.t-dialin.net [84.190.202.133])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id oAB4S0q0022910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 11 Nov 2010 05:28:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.15) Gecko/20101027 Lightning/1.0b1 Thunderbird/3.0.10
In-Reply-To: <20101109134337.GA19430@nibiru.local>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161206>

On 11/07/2010 09:25 PM, Enrico Weigelt wrote:
> I'm curious on how deterministic the imports (git-cvsimport and
> git-svn) are. Suppose I close the same cvs repo twice (assuming
> no write access in between), are the resulting object SHA-1's
> the same ?

On 11/09/2010 02:43 PM, Enrico Weigelt wrote:
> The point behind this is: I'm running a growing number of cvs2git
> mirrors and dont want to do full backups of them.

If you are using cvs2git, why are you asking about git-cvsimport and
git-svn?

No tool that imports from CVS or Subversion can make a blanket guarantee
about consistency across conversions because both CVS and SVN allow
retroactive changes to the project history.  For example:

* Both CVS and SVN allow commit messages and other metadata of old
commits to be changed

* CVS allows files to be added retroactively to tags and branches with
no timestamp indicating that the file was not part of the original tag.

* CVS allows old revisions to be "obsoleted" (i.e., expunged from history).

* In CVS it is common practice for people to muck about directly in the
repository, for example renaming *,v files.

So (in the general case) there is no way to guarantee that two
independent conversions will have consistent results for the overlapping
parts of their history.  And even incremental conversions will
necessarily have to decide between converting the current state of the
repository accurately and converting in a way that is consistent with
earlier conversions.

In practice, especially if you are willing to constrain what the CVS
users are allowed to do, the overlapping parts of two conversions should
usually be identical or at least very similar (with older history more
likely to be identical).  Perhaps an rsync-style backup would be smart
enough to copy only the changed part of the history without excluding
the possibility that there are retroactive changes between subsequent
conversions.

If you run two cvs2git conversions on *exactly* the same CVS repository,
then the results *should* be identical.  I have tried always to process
data in a defined order rather than, say, in filesystem or
hashmap-determined order.  But AFAIK this property has not been tested
and could easily be buggy if I overlooked some source of indeterminism
somewhere in the cvs2git code.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
