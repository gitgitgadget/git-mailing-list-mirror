From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
 submodules
Date: Sun, 18 Jan 2009 19:02:16 -0800
Message-ID: <7v7i4st2vb.fsf@gitster.siamese.dyndns.org>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
 <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOkQl-0001vf-7i
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbZASDCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757319AbZASDCZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:02:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991AbZASDCY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:02:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 203791CD1E;
	Sun, 18 Jan 2009 22:02:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 64F0E1CD09; Sun,
 18 Jan 2009 22:02:18 -0500 (EST)
In-Reply-To: <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
 (Lars Hjemli's message of "Sun, 18 Jan 2009 18:45:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97F4EC3C-E5D5-11DD-AD25-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106308>

Lars Hjemli <hjemli@gmail.com> writes:

> On Sun, Jan 18, 2009 at 16:48, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> ...
>> Seems you want to fall back to look in the superproject's object database.
>> But I think that is wrong, as I have a superproject with many platform
>> dependent submodules, only one of which is checked out, and for
>> convenience, the submodules all live in the superproject's repository.
>
> Actually, I want this to work for bare repositories by specifying the
> submodule odbs in the alternates file. So if the current submodule odb
> wasn't found my plan was to check if the commit object was accessible
> anyways but don't die() if it wasn't.

The current submodule design is "do not recurse into them by default
without being told" throughout the Porcelain.  We can think of various
ways for the users to tell which submodules are of interest and which are
uninteresting.

The most general solution would be to give a list of submodules you are
interested in recursing into from the command line, something like:

    $ git command --with-submodule=path1 --with-submodule=path2...

That approach would work equally "well" with a bare repository or with a
non-bare repository, but if you have N submodules, you need to give up to
N extra options, which may be cumbersome (meaning, "works equally well"
above actually may mean "works equally awkwardly").  One way to solve
awkwardness may be to support a mechanism that allows you to use
configuration variables to name a group of submodules.

In addition to such configuration variables, you already have one default
group of submodules, defined by the way you set up your work tree, when
your superproject does have a work tree.  Some submodules have
repositories cloned in the work tree, while some don't, and the ones
without clones can be defined as "uninteresting ones" (to the work tree
owner) that are outside the default group.  For many work tree oriented
operations, it may even make sense to allow that group to be used with a
single "git command --with-submodule" (i.e. when you do not say which
submodule you mean, that can default to "cloned" group).

I do not know "has an entry in the superproject's alternate list that
points to its object store" is a good basis to define another default
group useful especially in a bare repository setting; you seem to be
suggesting that, and you might be correct.

For "git archive", however, I suspect the "default group based on work
tree checkout state" may make the least sense.  "git archive HEAD" is
expected to give a reproducible dump of the state recorded by the HEAD
commit no matter who runs it in what repository, and I think there should
be a conscious and explicit instruction from the end user that says "Here
is a dump from this commit in the superproject, *BUT* it was made together
with contents from this and that submodule".  Command line options that
list "this and that submodule" is explicit enough, and a configured
nickname given to a known group of submodules from the command line may be
so as well, but the group based on the checkout state feels a bit too
implicit and magical to my taste.  The group based on the "has an entry in
superproject's alternates" criterion is not much better in this regard,
methinks.

Another worrysome thing about "git archive" is that it marks the resulting
archive with the commit object name the tarball was taken from.  If you
allow recursing into an arbitrary subset of submodule, a project with N
submodules can produce 2^N different varieties of archive, all marked with
the same commit object name from the superproject.  That might be a bit
too confusing.
