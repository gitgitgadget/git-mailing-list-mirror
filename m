From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] How to show merge commits in gitweb?
Date: Sun, 27 May 2007 01:10:37 +0200
Message-ID: <200705270110.37493.jnareb@gmail.com>
References: <200705171239.24300.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 01:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs5KR-0001Xu-RT
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbXEZXFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbXEZXFi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:05:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:40763 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbXEZXFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:05:37 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1381563ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 16:05:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g8tHmAoFHkdfArHRzAVNroVQIx200V/5mKlCI5hocZC1dN709+DuFJ/MMQ1ScN9RyEy6T+Ae/3sKxjqWKJ6W8bEaYeINudEmydr4cqJNgLbJP4YkYKp932/TWhkEijoC4cfdEukzfEnX9svZzGaEj4L5EPIrrTU4khh52qL8XGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fJSjYboG5qEjMoDZryPvyqcCPQ203+dszPzeeUWswZ1p9qr7D4N2c5t5omm4XXCd8Kxd5MEN/vYTXJEKvMCbcX+f3LeHGbSkpjkfIgjLKks1n8gt9UtxSQDu5phAA2C1InF9zWA6SVCglsFQaDfgScs5ySuxTyXl9ap9svEiifM=
Received: by 10.67.105.19 with SMTP id h19mr4007643ugm.1180220735049;
        Sat, 26 May 2007 16:05:35 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm20539447muf.2007.05.26.16.05.31;
        Sat, 26 May 2007 16:05:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200705171239.24300.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48503>

I have asked questions cited below (with no answer as of yet) because
I needed to have terminology right when describing merge commits diff
in gitweb.

People asked that 'commitdiff' view in gitweb used compact combined 
(--cc) and not more verbose combined (-c) format for merges. The 
problem lies in the fact that due to chunk simplification for `--cc'
some patches might be dropped completely from the patchset part, while 
respective line is still present in the difftree/raw format part; the 
difftree/raw part is the same for `-c' and for `--cc'. Because difftree 
(whatchanged-like) has inner (anchor) links to respective patch (part 
of patchset) there is problem what to do for lines which have no 
corresponding patch (because it got simplified).

git-diff-tree(1):
  [...]
  --cc::
        This flag changes the way a merge commit patch is displayed,
        in a similar way to the '-c' option. It implies the '-c'
        and '-p' options and further compresses the patch output
        by omitting hunks that show differences from only one
        parent, or show the same change from all but one parent
        for an Octopus merge.  When this optimization makes all
        hunks disappear, the commit itself and the commit log
        message is not shown, just like in any other "empty diff" case.


One solution is for gitweb to add fake missing patches, with the message 
(in the place of patch body, or in extended diff header) that the diff 
is empty: for example "Clean merge"... although empty `--cc' patch does 
not need to mean clean merge, see below.

Other solution would be to change raw output format for "diff --cc",
or change difftree body output, which would need parsing patchset first.


P.S. By the way, should gitweb output `-c' diff if `--cc' patchset 
output is empty, and to "show from which parent file came from" based 
on `-m' output if `-c' output is empty (on tree-level / trivial 
merges)?


On Thu, 17 May 2007, Jakub Narebski wrote:

> What is the definition of a trivial merge? Is it tree-level merge, for 
> which git-diff -c output would be empty?

Trivial merge means that changes occured only on one branch, and we take 
result from this branch; see Documentation/technical/trivial-merge.txt
Tree-level merge means that the result is taken from one of the parents.

I think that while trivial merge is tree-level merge, they do not 
necessary mean the same: the result of merge using 'theirs' strategy is 
tree-level merge, but not trivial merge. The same in the case of 
conflicts resolved to the version from one of the parents.

"git diff -c" output is empty for tree-level merge.

> What is the definition of clean merge? Is it merge without conflicts? 
> How to name merge for which git-diff --cc output is empty: simple
> merge  perhaps? I think it does not need to be clean merge in the "no 
> conflicts" meaning.

IMHO clean merge is a merge in which there can be file-level conflicts, 
but they resolve cleanly. Clean merge is I think a merge in which 
change in a chunk comes always from one of the parents (we can have non 
tree-level merge only for merging two branches, not for an octopus), 
but not all merges which have "git diff --cc" output empty are clean 
merges.

BTW. the fact that merge resolves cleanly, without need for manual 
intervention, depends in git also on what do you have in rr-cache 
(recorded resolutions).

> What is the definition of evil merge? Is it merge for which merge
> commit  is different from all the parents? How to name merge for which 
> git-diff --cc output is non empty, then?

 evil merge::
	An evil merge is a merge that introduces changes that
	do not appear in any parent.

But not only evil merges can have "git diff --cc" output non-empty.


Summary: merges for which "git diff -c" is empty are tree-level merges, 
usually trivial merges; merges for which "git diff --cc" is empty are 
simple merges, usually clean merges.


Please correct me if I'm wrong. TIA.

-- 
Jakub Narebski
Poland
