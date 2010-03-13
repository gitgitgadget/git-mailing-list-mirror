From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sat, 13 Mar 2010 01:10:33 -0800
Message-ID: <7v4okkegdy.fsf@alter.siamese.dyndns.org>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
 <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
 <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
 <7v8w9whd3g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 10:11:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqNNB-0008Kv-Tm
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 10:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291Ab0CMJKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 04:10:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065Ab0CMJKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 04:10:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5535A1687;
	Sat, 13 Mar 2010 04:10:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OTwQdPTz/j/trcR4qa3oSiq0x/E=; b=AylYrkPrGsgBGSpGRQ3DMZt
	aWV02rrhgkvBnCWKiNLTMSPfVeVWEhsBBxRNLz6BGAOVV9icsHwYiLuBOf/JWJVY
	8gc45zAaY6pRo4m0SFEYxsIB2Pt1MFodTp2kUDV747SigH50sX1UHHXegb6u4xjL
	K+8wAopsWUBlveN2kdss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PiJ9ELq375db49mSNxxKP+AeNmkMaIy1rMl0zPLrXHa7g4CXN
	FJT3VlO55DHs3SvCU58xLOF9i0vTBrCRVSq2vqL/gzVRBKFZvQ19PxOEDV3r+rja
	eTw0nWvy7uzdt6qJdwPCXnMVKQtQ9Tk9LojOHeD+V/WhHr1ZmWot6LZmXw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FB9BA1686;
	Sat, 13 Mar 2010 04:10:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC753A1685; Sat, 13 Mar
 2010 04:10:34 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 49E69BA4-2E80-11DF-A4CE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142093>

Junio C Hamano <gitster@pobox.com> writes:

> As I already said, I do not think "mostly common paths" case should be
> encouraged to begin with.  As far as I know (and you can guess by now that
> I know reasonably well about git), you do not gain anything by not having
> the ancestry link between '?' and 'B', except that it would make conflict
> resolution at '*' extremely difficult.  There is only downside without any
> upside in "mostly common paths" disjoint merge.

There is one case "mostly common paths" disjoint history can be useful.

Imagine you have a hitherto proprietary software project and want to go
open source.  Perhaps your intention is to have an open source version and
an enhanced commercial version.  The project contains some third-party
vendor software outside your control, and you have replaced them with open
source equivalents or disabled features that depend on them.

Your history may look like this:

      o---o---A oss-base
     /
 ---o---o---o---o master

where master is the primary version you will continue shipping to your
paying customers, with proprietary third-party components and features
that depend on them.  Commits on oss-base were your work to prepare the
tree into a releasable shape, removing these proprietary stuff along with
some features.

But you cannot publish oss-base (commit A) to the public.  "git log" will
show all the history that leads to it, with all the third-party stuff you
do not have license to distribute in the source form.  The older parts of
the history may even have site password at customer installation you have
committed by mistake and eradicated long time ago.

If you run this three command sequence (in this message, I am assuming
that you keep the index and the working tree files intact in an updated
implementation of --orphan, which is different from the suggestion to
support "no common paths" case I mentioned in the previous message):

    $ git checkout --orphan oss oss-base
    $ git checkout oss-base
    $ git merge -s ours oss

you will get a history of this shape:

                X oss
                 \
      o---o---A---B oss-base
     /
 ---o---o---o---o master

with commits X, A and B all recording an identical tree.  The oss branch
(commit X) is now safe to publish.

Once you have done this, further you can:

    $ git checkout master
    $ git merge oss-base

which gives you a history of this shape:

                X oss
                 \
      o---o---A---B oss-base
     /             \
 ---o---o---o---o---Y master

This merge Y has to be done carefully.  It inherently has to be an evil
merge because oss-base wants to replace some proprietary stuff with open
source counterparts while you may want to keep using the proprietary ones
you have support contract for in your paying customer release you will
make from the master branch.  So at Y, you will most likely be reverting
some work you did on oss-base branch since it forked from master.

After setting it up, this arrangement allows you to:

 - accept changes from public, and/or build changes for public, to advance
   "community version" on the oss branch on top of X;

 - from time to time, merge oss to oss-base;

 - from time to time, merge oss-base to master.

and the histories will continue like this:

                X---C---C---C---C oss
                 \           \
      o---o---A---B-----------* oss-base
     /             \           \ 
 ---o---o---o---o---Y---P---P---*---P---P master

with community commits C (either contributed from the public or you
developed yourself and gave to the community) on oss branch, with
proprietary commits P that record your own proprietary work on master
branch.  Note that oss-base branch is not used to produce nor record any
commit on its own---it is merely to ease the merging from oss and master
by providing X-B link to serve as a convenient common ancestor to make
later merges easier.

Note also that it would be the most convenient if you kept both the index
and the working tree intact, if "checkout --orphan" is to be used as an
ingredient for this workflow.  It _might_ actually make sense not to make
the "git checkout --orphan" an independent feature that can be randomly
abused or misused, but package the three-command sequence to create the
A-B-X open triangle above into a separate command, i.e.

    $ git branch --orphan oss

would create a new branch "oss" with its own root commit X that records
the same tree as the current HEAD A, and immediately merge X back into A
to produce B, again recording the same tree, and advance the current HEAD
to point at B, like so:

                                             X oss
                                              \
    ---o---A HEAD       -->         ---o---A---B HEAD
