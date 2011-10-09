From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A Basic Git Question About File Tracking [ANSWERED]
Date: Sun, 9 Oct 2011 11:37:33 +0200
Message-ID: <201110091137.34788.jnareb@gmail.com>
References: <j6dlhf$dp3$1@dough.gmane.org> <m3ipnz0xri.fsf@localhost.localdomain> <4E910A14.7040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-4"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 11:38:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCppY-0004Lo-Uy
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 11:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab1JIJht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 05:37:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63178 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab1JIJhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 05:37:48 -0400
Received: by bkbzt4 with SMTP id zt4so7021113bkb.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=BAKLqxaDfMr7Y0woMxqq+YTXpKdL6kIFZRnWJHJ8EB4=;
        b=P6unlSAspp7QBRhnHOxa9hzCy/wFuf+oiDHCfKFLUUq72jFm4F9WMWheAoUIC9qcaN
         Vmj0m4Ddhe+G6/b8Cs6I1W4cPP4N6fpOIh7rD/lyYhzzuOY2eCAPGBgTemvhdUP51L5X
         NwYSOhHxkhKBddeC/mcRYCTeZXpVzcoXH4zYM=
Received: by 10.223.5.3 with SMTP id 3mr23885236fat.4.1318153066762;
        Sun, 09 Oct 2011 02:37:46 -0700 (PDT)
Received: from [192.168.1.13] (abws83.neoplus.adsl.tpnet.pl. [83.8.242.83])
        by mx.google.com with ESMTPS id y8sm24041460faj.10.2011.10.09.02.37.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 02:37:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E910A14.7040801@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183194>

On Sun, 9 Oct 2011, Jon Forrest wrote:
> On 10/8/2011 6:17 PM, Jakub Narebski wrote:
> 
> > You seem to be under [false] impression that git commit is about
> > _changes_ / _changeset_.
> 
> This is correct. The Pro Git book says:
> 
> "You stage these modified files and then commit
> all your staged changes"
> 
> Plus, even "git status" tells me
> 
> $ git status
> # On branch master
> # Changes to be committed:

Well, that is because the two representations: delta / changeset
("differential") representation and snapshot ("integral") representation
are related, and [in practice] one can be transformed into the other.

Sometimes it is better to think about commit as representing changeset
from parent commit, sometimes it is better to think of a commit as of
snapshot of a state of project.

But under the hood git model is snapshot-based.

> But I see my error. Below is what I hope is a clear
> explanation of what I didn't understand. It presumes
> that the reader understands the git objects model.
> Please let me know if anything is incorrect.
> ----------
> When you "git add" a file two things happen:
> 
> 1) The file is copied to the git objects tree.

Actually it is file _contents_ that is copied to git object _store_.

> This location where the file is copied depends
> on the hash of the file's content.

I'd say that this is unnecessary implementation detail of "loose"
object format.  I would say that _identifier_ of added object is
based on its contents.

> 
> 2) An entry for the file is added to the git index.
> This entry includes the same hash that was mentioned
> in #1.

Yes.
 
> A tracked file has an entry in the git index file.

Yes.

> A copy of the file also exists in the objects tree.

A copy of a _contents_ of a file at specific point of time
exists in object _store_ (not necessary object tree, as it
can be packed).
 
> When you run 'git status', git computes the hash of
> every file in your working directory and looks
> up each file in the index. If the file isn't found
> then the file is shown as untracked.

Sidenote: git stores in the index also stats of a file (modification
time etc.) so it is possible to avoid recomputing the hash of every 
file.
 
> When you do a commit, the hash values of everything
> in the index are copied into a tree object. The hash
> value of the tree object is then placed in a commit object.

True, though I would probably state it a bit differently.

> No copies of tracked files in the working directory are
> made at commit time. This is because the files were already
> copied into the objects tree when 'git add' was run.
> This is one reason why git commits are so fast.

Well, there is also "git commit -a", but it is true that git
copies into object store only those tracked files that changed.

Also I think that the main reason that git commits are fast is
that they are local operation, and not over the network as in the
case of centralized version control systems.
 
-- 
Jakub Narebski
Poland
