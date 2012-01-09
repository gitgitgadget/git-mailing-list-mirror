From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Mark and protect local commits?
Date: Mon, 09 Jan 2012 10:55:32 +0100
Message-ID: <4F0AB994.4030702@alum.mit.edu>
References: <jee8ii$6ft$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "norbert.nemec" <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Mon Jan 09 10:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkBx6-00048J-ME
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 10:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab2AIJzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 04:55:35 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60361 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab2AIJzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 04:55:35 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q099tWV0015664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 Jan 2012 10:55:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <jee8ii$6ft$1@dough.gmane.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188165>

On 01/09/2012 09:29 AM, norbert.nemec wrote:
> I have often wished that there were ways to
> 
> a) protect certain commits from leaving the local repository
> 
> b) mark commits that have already left the local repository
> 
> 
> To be more specific:
> 
> a) Sometimes, I try out certain experimental features and want to make
> sure they don't accidentally end up out in the wild. If there were a
> flag to explicitly mark them "private", any non-local operation (push,
> pull, etc) on these commits could create an error message.

In Subversion we solved this problem by having a local convention that
the central server forbids the commit of any files containing the magic
string "@@@".  This was enforced by a (server-side) pre-commit hook.
This allows developers to mark local hacks (e.g., debugging printfs)
with a comment containing the magic string, and Subversion would help
prevent them from committing that code accidentally.  This feature is
popular with developers.

One subtlety is that you don't want to enforce the file-contents check
on *every* file because the magic string could appear by chance in some
kind of binary file.  We used svn properties to tell the system on which
files to enforce the constraints.

When we started using git-svn, we added a second (server-side) check:
that the magic string is not allowed in the commit message.  That way,
debugging commits can be made to the local git-svn-managed git
repository but prevented from being "pushed" to Subversion.

We have implemented something similar for git on the client side, using
.gitattributes for its configuration.  But this is not quite the same.
When using pure git, there are cases when you want local commits that
contain the forbidden string, but to prevent those commits from being
pushed.  For this, a server-side pre-update hook would be needed.  This,
in turn, has the technical problem that until recently .gitattributes
were effectively unusable on the server.  So we haven't yet implemented
the analogous server-side hooks.

An alternative would be to have some kind of "pre-push" hook which could
carry out similar checks on the client.  This would allow individuals to
implement their own policy without requiring the central project to have
a pre-commit hook.  I don't believe that there is currently any such hook.

> b) For history-rewriting operations, it is important to know which
> commits are out in the wild and which are not. In a "push"-setup working
> copy, git should be able to keep track of this. Any newly created commit
> would be marked as "unpublished" and the mark would be removed when the
> commit is pushed. Any history-rewriting would be prevented on published
> commits.

This would be convenient, too.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
