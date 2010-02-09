From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Notes are independent: proposal for new notes implementation
Date: Tue, 9 Feb 2010 21:05:23 +0100
Message-ID: <201002092105.25636.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 21:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NewL4-00037W-1E
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 21:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0BIUFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 15:05:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:3648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab0BIUF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 15:05:29 -0500
Received: by fg-out-1718.google.com with SMTP id 16so59367fgg.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JMKABpqoJBvtjpXaXEBhFdI2GFEnPawehUy2iHihk6s=;
        b=kRYGCjbh4p3Qq65ckgIViRtcxNW/jhcYxjjOWITrZBPrbnU0ollXNOVINcVmF7pnhc
         hrE2h3PPRyVEx+KK71JjEubBSYGZN9gFGB2mQk6scqJOwuxpyL2s8VvHBlQIcnZhfftV
         WAimM90CGFZWwrWi4eiWNXYqCaFv7Aiih4oBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=gzmrE+RCM6KjRTUMZEFBcbJ1KeM5ltSdmHsykkI0RjHridphYaXR6YktC4zBZ+v9Xh
         p0vcPcMS1YHxjUVxwvuzYBlVmS7SHwwcTQkPrkCdKyla31RDsjx2/0dHqBHhfZn+g3bB
         +Eqlma7MUYlDtoR2/eos0G+uU4LqnGZNJDX40=
Received: by 10.87.73.15 with SMTP id a15mr1104199fgl.50.1265745927579;
        Tue, 09 Feb 2010 12:05:27 -0800 (PST)
Received: from ?192.168.1.13? (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id l19sm7644105fgb.10.2010.02.09.12.05.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 12:05:26 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139438>

Junio have noticed in one of threads about notes implementation in
git[*1*] that current notes implementation has (conceptual) problems:

[1] "Re: A generalization of git notes from blobs to trees - git metadata?"
    Message-ID: <7v8wb4aj4m.fsf@alter.siamese.dyndns.org>
    http://permalink.gmane.org/gmane.comp.version-control.git/139252

    (its one of threads that IIRC started with implementing hand-rolled
    support for notes in gitweb by Giuseppe Bilotta)

Junio C Hamano <gitster@pobox.com> writes:
JH>
JH> It's [current notes implementation] like "keeping track of /etc" (or
JH> "your home directory").  It is a misguided thing to do because you
JH> are throwing in records of the states of totally unrelated things
JH> into a single history (e.g. "Why does it matter I added new user 
JH> frotz to /etc/passwd before I futzed with my sendmail configuration?
JH> ---It shouldn't matter; there shouldn't be ancestry relationships
JH> between these two changes").  I somehow feel that keeping track of
JH> the "growth of the bag of annotations to any and all commits" in a
JH> single history may be making the same mistake.

The proposed solution was to use custom merge strategy for notes.  But
what if the answer was to change implementation, decoupling history of
notes from each other, and keeping history of each note separate.

Let's simplify situation, and talk for now about single notes namespace
(refs/notes/commits), no fanout scheme, and plain blob notes.


In CURRENT notes implementation the notes ref (e.g. refs/notes/commits)
point to a commit object: the tip of history of all notes.  This commit
stores information about last change to any note; it's commit message is
"Annotate <SHA-1>".  It's tree contains mapping between notes and
annotated object: notes are stored as leafs in the tree, and their
pathnames are (representing) objects they are annotating.

This means for example that if in repository A somebody annotated
commits foo and bar creating notes in this order, and in repository B
somebody annotated bar and foo (creating notes in reverse order), then
merging those changes would require generating merge commit even if
those notes are identical.

 
 tree:                         <-- Annotate bar <-- refs/notes/commits
 <foo note SHA-1> <foo SHA-1>           |
 <bar note SHA-1> <bar SHA-1>           | (parent)
                                        |
                                        v
 tree:                         <-- Annotate foo
 <foo note SHA-1> <foo SHA-1>      (no parent)


The PROPOSED solution (with admittedly larger overhead) is to have notes
history stored in submodule-like fashion.  The notes ref would point to
the tree object.  In this tree each leaf would point to a *commit*
representing tip of history for a given note (like for submodules).
Each commit would contain tree, which would map note to annotated object
(it is extra level of indirection, needed because commit cannot point to
blob directly... unless multiple notes for the same commit in tree
structure got implemented, or tree annotations got implemented.)

This way history of each note is in kind of a separate branch, and notes
refs point to tree object representing branch hierarchy.

Merge conflict would appear only if notes for the same object would have
different contents or/and different history.

                  tree:                         <-- refs/notes/commits
    /------------ <foo hist SHA-1> <foo SHA-1> 
    |         /-- <bar hist SHA-1> <bar SHA-1> 
    |         |
    |         v
    |     Annotate bar --> tree:
    |     (no parent)      <bar note SHA-1> <bar SHA-1>
    v
  Annotate foo ----------> tree
  (no parent)              <foo note SHA-1> <foo SHA-1>

One thing that would need to be addressed is converting from older notes
implementation, but this should be doable.  The problem would be in
supporting both implementations in one repository; it might be not
possible.  Also this would break compatibility: older git versions
supporting notes wouldn't be able, I guess, to access new (proposed)
format.

There are probably numerous issues with proposed implementation, beside
breaking backward compatibility...


P.S. This shows why git tools (such as gitweb) should not access notes
directly, but use git-notes, %N / %N(<ref>) format specifier, and proposed
<object>^@{} / object^@{<ref>} or <object>^{notes} / <object>^{notes:<ref>}

-- 
Jakub Narebski
Poland
