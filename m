From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFD: a compressed view of branching history - struts, joins and roots
Date: Sat, 10 Apr 2010 10:00:58 +1000
Message-ID: <v2x2cfc40321004091700o9a00e3bei22f0b953839efe00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 02:01:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0O8W-0005Qy-SK
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 02:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab0DJABA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 20:01:00 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64502 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab0DJAA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 20:00:59 -0400
Received: by qyk9 with SMTP id 9so1996808qyk.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=KapcMv99mSrbfmK9u2N0l2keYWXB5yzi1jFg8UMa8f4=;
        b=Wat2cZ9QHsipdfkOn0sbayK3FRjugp6mI6WMVSj70DHgJhG7DZv2dZdI1mOL5CNtNY
         80iJ1qHQngx4JRjSpRKSAq3PvXI6rufu/ulsO1MOGlK1m9tOER4x0cBTL0qmsfwgvAVw
         J7bGmWu+DVy0okPRfoWmZZkZjrEAz0fTbWMXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vIl2jB/a9dVBF/sE8z+gygLh0sCQ55VUFIXESMngyFEsjlsG2h9riy5b9O7ULgD7kE
         a+geG1GDuXKBfdXYct5OxKbgjwfHQnumBZT02/jg+8qSHjuhmvSDtGUhaoqELx3eubwc
         HWghFN8MMutZfDCGPU5X2yqQKTx2T/ooAY9s4=
Received: by 10.229.185.136 with HTTP; Fri, 9 Apr 2010 17:00:58 -0700 (PDT)
Received: by 10.229.251.69 with SMTP id mr5mr942240qcb.91.1270857658163; Fri, 
	09 Apr 2010 17:00:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144491>

For some purposes (such as the merge linearisation algorithm I have
described previously), it would be handy to have a compressed view of
the branching structure of a git commit history.

I'd like to discuss the idea here and solicit feedback on the design
of rev-list options that would generate  such a compressed
representation.

The basic idea is to compress the representation of sequences of
commits that have exactly one parent and one child into an equivalent
"strut" that names the base fork or root of the strut and the parent
and parent-index of the tip of the strut.

So, for example, consider this graph:

Z--A---B---C--D--E--F--K--L--M
     \           / \           /
     H--G--F  J-------/
   /
X

The struts and joins representation of this graph would be:

tip M
join F
strut F..M^1
join C
strut C..F^1
strut C..F^2
join A
strut A..C^1
strut A..H^1
join H
strut H..C^2
root Z
strut Z..A^1
root X
strut X..H^2

root Z and root X define the boundary of the slice, but are not
elements of the slice
strut F..M^1  contains K and  L but not F or M.
strut A..H^1 is zero-length

Aside from a use in my merge history linearisation algorithm, I can
imagine this might be useful for driving an algorithm that exported a
set of patch series with git format-patch for the purposes of
reconstructing the merge history in some other place.

The list of tips, joins and roots is relatively easily obtained with a
few judicious uses of git rev-list, but unless I am mistaken producing
a list of struts is more involved.

So, here is a proposal for some options to git rev-list that might
produce the above representations:

--struts

    Reduces the specified set to a set of set specifications of the
form {fork}..{merge}^{parent} where each such specification specifies
a linear history of commits which exactly one parent and exactly one
child

--joins

   Reduces the specified set to a subset of commits each of which has
at least two parents or at least two children. [ By definition a
commit with exactly one parent and one child is a member of a strut ]

--roots

   Produces the set of commits that are not in the specified set of
commits but are directly reachable from the specified set of commits

--tips

   Produces the subset of commits in the specified set that have zero children.

Would anyone care to comment on this proposal, particularly the
suggested option names?

jon.
