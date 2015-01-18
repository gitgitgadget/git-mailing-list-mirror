From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Introducing different handling for small/large transactions
Date: Sun, 18 Jan 2015 13:13:15 +0100
Message-ID: <54BBA35B.50101@alum.mit.edu>
References: <1421361371-30221-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 13:13:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCojS-0006WT-Ki
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 13:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbbARMNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 07:13:24 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57963 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143AbbARMNX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2015 07:13:23 -0500
X-AuditID: 12074411-f79fa6d000006b8a-2c-54bba35e06e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.92.27530.E53ABB45; Sun, 18 Jan 2015 07:13:18 -0500 (EST)
Received: from [192.168.69.130] (p5DDB231C.dip0.t-ipconnect.de [93.219.35.28])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t0ICDGrM017449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 18 Jan 2015 07:13:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1421361371-30221-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqBu3eHeIwavjChZdV7qZLDZvbmdx
	YPJYsKnU4/MmuQCmKG6bpMSSsuDM9Dx9uwTujL6/r9kKvspW7Jh8lbWB8Yp4FyMnh4SAicT1
	83eYIWwxiQv31rN1MXJxCAlcZpSY376CGcI5xyTx+uNWNpAqXgFNiRvv2plAbBYBVYnFs34w
	gthsAroSi3qaweKiAkESV1o2M0PUC0qcnPmEBcQWEbCWWHx/O9gcYQE/iemd31lBbCEBJ4l7
	C7vBajgFnCV23f0ONodZQE9ix/VfrBC2vETz1tnMExj5ZyEZOwtJ2SwkZQsYmVcxyiXmlObq
	5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihASk4A7GGSflDjEKcDAq8fDOCN8dIsSaWFZc
	mXuIUZKDSUmUV3USUIgvKT+lMiOxOCO+qDQntfgQowQHs5II77ZSoBxvSmJlVWpRPkxKmoNF
	SZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYKXfRFQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpe
	SmpRYmlJRjwoJuOLgVEJkuIB2ssC0s5bXJCYCxSFaD3FqCglzmsEkhAASWSU5sGNhaWZV4zi
	QF8K8+qBVPEAUxRc9yugwUxAg/Mf7wAZXJKIkJJqYKxtT3kW3L3fNpfhktGvAsV3L8WSPgjo
	bLC8lNa6V6uQy5Dn+x737yx3Tu7IV/HKj53+iUN5hfSO6mUlsUnObjPXhU9ZwGx97XGD2+TK
	i8dt1nIfX/z76vHIF5PMvK0es9s1rjVgPPTPxUOlUT341qpbQl8nK8neTttRcXoH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262597>

On 01/15/2015 11:36 PM, Stefan Beller wrote:
> For everyday use we want git to be fast. Creating one commit should not
> touch the packed refs file. If we do other stuff involving more than
> one ref, we may accept touching the packed refs file and have a process
> which takes slightly longer but can handle more complex requests correctly,
> such as renaming into and from directories (topic/1 -> topic and reverse).
> Renaming is currently not part of the transaction API because of the (D/F)
> problems. This proposed change would enable having renames being part of
> the transactions API.
> 
> A transaction covers creating, deleting and updating a ref and its reflog.
> Renaming would be a deletion followed by creating a new ref atomically.

A rename is a little bit more than a generic delete+create pair; it also
moves the reflog from the old name to the new name. Is your plan to add
an extra "rename" operation to the refs-transactions API, or to
automatically detect delete+create pairs and treat them as renames?

> So for here is my proposal for small transactions:
> (just one ref [and/or reflog] touched):
> 
> In ref_transaction_update:
> 	* create $REF.lock file
> 	* write new content to the lock file
> 
> In ref_transaction_commit
> 	* commit the .lock file to its destination
> 	* in case this is a deletion:
> 		* remove the loose ref
> 		* and repack the packed refs file if necessary

The above describes the current algorithm, but FYI it is not entirely
correct. The deletion of the loose ref might expose an old version of
the reference in the packed-refs file (which might even point at an
object that has been garbage-collected. So the reference has to be
deleted from the packed-refs file before the loose ref version is deleted.

However, it is important that the packed-ref lock be held during the
whole procedure, so that a pack-refs process doesn't rewrite the loose
ref version of the reference into the (now-unlocked) packed-refs file,
causing the reference to survive its supposed deletion. (At least that
was the status a while ago; I don't know if recent changes to pack-refs
might have removed this problem in another way.)

But activating a new packed-refs file while still holding the
packed-refs lock is not supported by our current lockfile API. In fact,
working towards enabling this was one of the reasons for the big
lockfile refactoring that I did a while back. Though I never got as far
as fixing this bug.

> The larger transactions would be handled differently by relying
> on the packed refs file:
> In ref_transaction_update:
> 	* detect if we transition to a large transaction
> 	  (by having more than one entry in transaction->updates)
> 	  if so:
> 		* Pack all currently existing refs into the packed
> 		  refs file, commit the packed refs file and delete
> 		  all loose refs. This will avoid (d/f) conflicts.
> 
> 		* Keep the packed-refs file locked and move the first
> 		  transaction update into the packed-refs.lock file

NB: this requires not just one but two rewrites of the packed-refs file,
sharpening the performance concerns expressed elsewhere in this thread.

But couldn't one of the rewrites be avoided if the transaction doesn't
involve any deletes?

> 	* Any update(delete, create, update) is put into the locked
> 	  packed refs file.
> 	* Additionally we need to obtain the .lock for the loose refs
> 	  file to keep guarantees, though we should close the file
> 	  descriptor as we don't wand to run out of file descriptors.
> 
> In ref_transaction_commit:
> 	* We only need to commit the packed refs file
> 	* Discard all other lock files as the changes get committed as a whole
> 	  by the packed refs file

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
