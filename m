From: Stefan Beller <sbeller@google.com>
Subject: [RFC] Introducing different handling for small/large transactions
Date: Thu, 15 Jan 2015 14:36:11 -0800
Message-ID: <1421361371-30221-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 23:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBt1h-0007mE-M9
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbbAOWgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:36:25 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43695 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbAOWgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:36:24 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so17656372iec.8
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aPXejQw5HMd32nH7G7nQetbkhxheaL3zvCsWuDBRNPE=;
        b=EtUZAx9YGKmjAi4WJ/eQlnZua0fOVJl7EV4xIxOwSyvfXpoUT7ykbtZyHNvvvxlKqW
         I8+biE0xUA6i4GptL4M0kxF1SWTVf87XgWMduC+ol2EkK7mbTR/lf8E0+qWl+1xwe+8H
         uNJziWyW5taulg7xQm64bvkDj4QB590xMi7/qHvjBzDiCOwGDLTU8HVvWkSYBkxodGTR
         k1quvcW2I8ePqq4AyoNpNvNys7IjLnp2I7tOrGxcVQWomnWxdL2rEpbvY5dl6qyu3VFv
         +9O3DarOj/M/sfuR6Mlaq/yGg6ye5u1+mtf7RTgE/o/RX+A1MAY9aRnxkbQZpAdkaErd
         2B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aPXejQw5HMd32nH7G7nQetbkhxheaL3zvCsWuDBRNPE=;
        b=msuVdOf7WH6iRT42aqI6WBm1gyCBvMd5Y7wFGsSB6FQNENEaVD3WKE+RRFc8u80LdK
         NfDkBIBjjcc9NwhG2UsdhcGQG50/UYnGIGtz3mvo7Vyct3igaVKgTizFXZa8xwo5qvXu
         KFwrpKNazFxraCQ/c5o5bH4l8dVVzauD9t570pAgXFt+YTiERy+oOoOxVvfD+EAeyUDd
         0zuFOQjDCwBBckmyjdAb/SRDh8qGTPNVpZgqoYg94kxFQ1muWvwGdteR48Zp2XrwFtwm
         hk67aO2z6/BETbp8U4mzkqYWDK4Y5wcbFRYfJ4dcB2ASJPlexDirotkIVR4vRiFQTMcY
         NXbQ==
X-Gm-Message-State: ALoCoQkmayrfBDlmLTVQ6saov1ctZulEzoatoXdA42fk+6xusy5JEAkNQKbpJp4az/NL56qxV9ea
X-Received: by 10.43.154.196 with SMTP id lf4mr11799939icc.95.1421361383632;
        Thu, 15 Jan 2015 14:36:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:159a:d413:24c9:471f])
        by mx.google.com with ESMTPSA id qd4sm323153igc.22.2015.01.15.14.36.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 14:36:23 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262515>

For everyday use we want git to be fast. Creating one commit should not
touch the packed refs file. If we do other stuff involving more than
one ref, we may accept touching the packed refs file and have a process
which takes slightly longer but can handle more complex requests correctly,
such as renaming into and from directories (topic/1 -> topic and reverse).
Renaming is currently not part of the transaction API because of the (D/F)
problems. This proposed change would enable having renames being part of
the transactions API.

A transaction covers creating, deleting and updating a ref and its reflog.
Renaming would be a deletion followed by creating a new ref atomically.

So for here is my proposal for small transactions:
(just one ref [and/or reflog] touched):

In ref_transaction_update:
	* create $REF.lock file
	* write new content to the lock file

In ref_transaction_commit
	* commit the .lock file to its destination
	* in case this is a deletion:
		* remove the loose ref
		* and repack the packed refs file if necessary

The larger transactions would be handled differently by relying
on the packed refs file:
In ref_transaction_update:
	* detect if we transition to a large transaction
	  (by having more than one entry in transaction->updates)
	  if so:
		* Pack all currently existing refs into the packed
		  refs file, commit the packed refs file and delete
		  all loose refs. This will avoid (d/f) conflicts.

		* Keep the packed-refs file locked and move the first
		  transaction update into the packed-refs.lock file

	* Any update(delete, create, update) is put into the locked
	  packed refs file.
	* Additionally we need to obtain the .lock for the loose refs
	  file to keep guarantees, though we should close the file
	  descriptor as we don't wand to run out of file descriptors.

In ref_transaction_commit:
	* We only need to commit the packed refs file
	* Discard all other lock files as the changes get committed as a whole
	  by the packed refs file

Any feedback would be welcome!
Thanks,
Stefan
