From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Tue, 01 Dec 2009 12:50:13 +0100
Message-ID: <4B1502F5.1060100@alum.mit.edu>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 12:50:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFRFW-0004kN-Er
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 12:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbZLALuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 06:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbZLALuN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 06:50:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46342 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbZLALuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 06:50:12 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id nB1BoDtS020059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Dec 2009 12:50:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134198>

Bernhard R. Link wrote:
> Example 1:
> 
> Let's assume you maintain such a regularily-rebased branch that you
> want to be able to publish (or pull from other repositories for example
> on your laptop):
> 
> o=m=o=o=master
>    \
>     a=b=c=d=e=feature
> 
> with this patch you can do "git rebase -eqt master" and get:
> 
>               a'=b'=c'=d'=e'=feature'=eqt
>              /                       /
> o=m=o=o=master--------              /
>    \                  \            /
>     a=b=c=d=e=feature--merge-------

Actually, there is more information that can be retained about this
rebase operation.  Your scheme records the fact that (a+b+c+d+e+merge)
== (o+o+a'+b'+c'+d'+e'), which is certainly true.  But in the process of
rebasing, the user has (implicitly or explicitly) resolved conflicts in
transforming each of the patches a -> a', b -> b', etc.  In fact, the
patch a' is itself a merge between a and master; b' is a merge between b
and a'; etc.  If you record each of these merges individually, the
result looks like this:

o=m=o=o=master
   \      \
    \      a'=b'=c'=d'=e'=feature'
     \    /  /  /  /  /
      ---a==b==c==d==e==feature

There are advantages to retaining all of this history:

* It faithfully represents intermediate steps of the rebase.

* There is no need for special "merge" and "eqt" merge commits affecting
an arbitrary group of feature patches; each of the rebased patches is
treated identically.

* There is a direct ancestry connection from the "new version" to the
"old version" of each patch; for example, it is easy to see that c' is a
new version of c and to compute the corresponding interdiffs.

* There are situations where the additional info can help git choose
better merge bases in the case of merge/rebases across three or more
repositories.  For example, somebody who is developing a subfeature
based on the feature branch can merge/rebase changes from both feature
and master without causing utter chaos.

The "historical" version of the feature branch should be omitted from
most git output as you have suggested, but this would be best
implemented by marking the "historical" ancestor with some extra flag in
each merge commit.

> Example 2:
> 
> Let's assume you have a feature branch like
> 
> o=master
>    \
>     a=b=c=d=e=f
> 
> Assume you just commited "f" which fixes a bug introduced by "b". [...]
> 
> So with this patches you can do "git rebase -i --eqt" and squash f into b
> and get:
> 
> o=master
>    \
>     a=b=c=d=e=f---
>      \            \
>       b+f=c'=d'=e'=eqt

This case can also record additional information:

o=master
   \
    a=b===c==d=e=f
       \   \  \   \
        b+f=c'=d'==e'

Here the new DAG cannot represent *all* ancestry information (namely,
that b+f, c', and d' also include the original patch f), but it does
accurately reflect useful information such as that c' includes c and
that e' includes e and f.

I wrote some blog entries about rebasing-with-history that might be
interesting [1-3].

Michael

[1]
http://softwareswirl.blogspot.com/2009/04/truce-in-merge-vs-rebase-war.html
[2]
http://softwareswirl.blogspot.com/2009/08/upstream-rebase-just-works-if-history.html
[3]
http://softwareswirl.blogspot.com/2009/08/rebase-with-history-implementation.html
