From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 10:42:11 +0000
Message-ID: <200701151042.12753.andyparkins@gmail.com>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 20:05:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2Q-0000SJ-7k
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:30 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9d-0003eK-DB
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbXAOKmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbXAOKmS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:42:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:55467 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbXAOKmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:42:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1313354uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 02:42:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ebuigXKbU8xOZYjOZ2yDN+Hs2iMFZluCfo0PxnEhsr1iEPuvdQ+W/7L02TZdloCog+1QdoMzws+DLMAaAOY9JrgU4OV3A0TQB0KAFyt6jrgxHQ5OCvgnVlvCJxsN4vnph97xBsLojCNl6dycYZG7Yn5hchPGPeNjzWw9qxuUPmE=
Received: by 10.66.216.20 with SMTP id o20mr5183850ugg.1168857736207;
        Mon, 15 Jan 2007 02:42:16 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 50sm5429920ugb.2007.01.15.02.42.15;
        Mon, 15 Jan 2007 02:42:15 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <20070115101529.GB12257@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36858>

On Monday 2007 January 15 10:15, Shawn O. Pearce wrote:

> You could sign the content of the raw commit and include the signature
> in the payload, much like we do with tags.  E.g.:

That looks good to me.

> But that's horribly ugly and probably vast overkill.  Plus the only
> way to really verify each commit is to have the complete database of
> PGP public keys handy.  A commit-msg hook could probably implement
> the signing.

Not such overkill.  I wasn't thinking of verifying every commit ever made 
every time the repository changes.  I was thinking more of a situation when a 
particular commit is identified as being troublesome (like introducing a 
backdoor), and the person listed as comitter denies all knowledge.  At that 
point one would verify the signature.

As an added extra, the host of the central repository could have a list 
of "allowed keys" so that only correctly signed commits would be allowed into 
the repository.

As an example of why this would be useful: let's say we have a developer 
committing to a maintainer repository who then merges those changes into 
mainline and pushes up to the central repository (like what happens with 
Linux).  The commits to the central repository are made using the ssh login 
of the maintainer, but they are adding commits by someone else.  What if that 
someone else isn't allowed to commit to the central?  With signed commits the 
option is available to exclude them.

I don't think the argument that Matthias offered ("You just explained why no 
one should pull from people he does not trust.") is a good one.  One might 
not want trust to be transitive.  Just because I trust you, doesn't not mean 
that I trust those who you trust.  The path of getting commits in via a 
trusted person, perhaps even via multiple levels of transitive trust might 
not be something that is wanted in every project.  Having signed commits 
would at least give the option.

> What I'm actually doing in one particular environment is checking
> the committer string against a database of known committer strings
> associated with the current UNIX uid.  My update hook[*1*] performs
> a `git log --pretty=raw $3 --not --all` query to determine any
> commits which are coming in as part of this push and which are not
> already referenced by an existing head or tag in this repository.
> For each of those the committer line *must* match one stored in
> the allowed-committers file for the current user, as these are
> brand new commits being introduced to the repository.

This addresses the problem somewhat.  However, the problem I'm talking about 
is where a commit identity has been faked by someone committing to a 
secondary (or tertiary) level repository.  While you are ensuring that the 
current user is allowed to commit on behalf of someone else to your 
repository, you haven't protected anything, because they could simply fake 
their ID to one of the "allowed" set and your test will pass.

> performing the checking.  And since every commit signs the entire
> chain of commits which came before it, we're in effect implicitly

While true, on a big project, with changes mainly in different areas, the fact 
that I committed a/file1.c after you committed b/file2.c doesn't mean I've 
signed off on your b/file2.c changes being non-malicious.

This is all just paranoia obviously.  It's nothing that is in the remotest bit 
urgent, or perhaps even practical.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
